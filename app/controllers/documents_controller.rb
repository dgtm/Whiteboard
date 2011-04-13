class DocumentsController < ActionController::Base
  layout 'application'
  before_filter :authenticate_user!
  before_filter :get_statistics

  FIRST_VERSION = 1
  YES = '1'

  def get_statistics
    @recent_documents = Array.new
      @favorite_documents = Array.new
      all_documents = Statistics.where("user_id = ?", current_user.id)
      @recent_stats = all_documents.order("updated_at DESC")
        @recent_stats.each do |stat|
          @recent_documents << Document.find(stat.document_id)
        end
      @favorite_stats = all_documents.order("count DESC")
        @favorite_stats.each do |stat|
          @favorite_documents << Document.find(stat.document_id)
        end
  end

  def index
    @my_documents = current_user.documents
    @documents = Document.all
  end

  def search
    @documents = Document.search(params[:options],params[:search],current_user.id)
  end

  def show
    @document = Document.find(params[:id])
    @versions = @document.versions
    # respond_to do |format|
    #       format.html { }
    #       format.js { }
    #     end
  end

  def new
     @document = Document.new
   end

   def create

    if params[:public] == YES
      @shared_status = true
    else
      @shared_status = false
    end

    @document = Document.create(:title => params[:title], :user_id => current_user.id, :shared => @shared_status)
     if @document.save
        @version = @document.versions.create(:content => params[:content], :user_id => current_user.id, :number => FIRST_VERSION)
          if @version.save
             @stats = Statistics.create(:document_id => @document.id, :user_id => current_user.id, :count => 1)
                if @stats.save
                redirect_to documents_path, :notice => "Document Created with version #{FIRST_VERSION} "
                else
                render :action => "new", :alert => 'Document could not be created. Try again.'
                end
          else
              render :action => "new", :alert => 'Document could not be created. Try again.'
          end
       # redirect_to :controller => :versions , :action => :create, :document_id => @document.id, :content => content, :method => :post
     else
       render :action => "new", :alert => 'Document could not be created. Try again.'
     end
   end

end
