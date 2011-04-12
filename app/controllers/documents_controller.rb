class DocumentsController < ActionController::Base

  before_filter :authenticate_user!
  FIRST_VERSION = 1
  def index
    @documents = Document.my_documents(current_user.id)
  end

  def new
     @document = Document.new
   end

   def create
    version_at_create = FIRST_VERSION
    @document = Document.create(:title => params[:title], :user_id => current_user.id, :shared => params[:public])
     if @document.save
        @version = @document.versions.create(:content => params[:content], :user_id => current_user.id, :number => FIRST_VERSION)
          if @version.save
              redirect_to documents_path, :notice => "Document Created with version #{FIRST_VERSION} "
          else
              render :action => "new", :alert => 'Document could not be created. Try again.'
          end
       # redirect_to :controller => :versions , :action => :create, :document_id => @document.id, :content => content, :method => :post
     else
       render :action => "new", :alert => 'Document could not be created. Try again.'
     end
   end

end