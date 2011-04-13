class VersionsController < ActionController::Base

after_filter :update_statistics, :only =>[:create, :update]

YES = '1'

  def update_statistics
    @statistic = Statistics.find(:first, :conditions => ["document_id = ? and user_id = ?", @document.id, current_user.id])
    @count = @statistic.count
    @stats = @statistic.update_attributes(:count => @count+1)
  end

  def new
    @document = Document.find(params[:document_id])
    @version = @document.versions.new
   end

   def create
     @document = Document.find(params[:document_id])

    @version = @document.versions.create(:number => @document.new_version_number, :content => params[:content], :user_id => current_user.id)
     if @version.save
                redirect_to documents_path , :notice => "Content has been added with version x"
            else
                render :action => "new", :alert => 'Content could not be updated. Try again.'
            end
   end


   def index
      @document = Document.find(params[:document_id])
      @versions = @document.versions.all
   end

   def show
     @document = Document.find(params[:document_id])
     @version = @document.versions.find(params[:id])
   end

   def edit
     @document = Document.find(params[:document_id])
     @version = @document.versions.find(params[:id])
   end

   def update
     @document = Document.find(params[:document_id])
     @version = @document.versions.find(params[:id])
     p "WTF?lalalallallahuhuhulalala"
     p params[:version][:content]
      if params[:dont_save_as_a_new_version] == YES

          if @version.update_attributes(params[:version][:content])
              redirect_to document_versions_path(@document), :notice => "This version was updated"
            else
              redirect_to :action => "edit", :alert => "Version could not be updated"
            end
    else
      p "I went to new version creation"
      @newversion = @document.versions.create(:number => @version.new_version(@document), :content => params[:version][:content], :user_id => current_user.id)
      if @newversion.save
      redirect_to document_versions_path(@document), :notice => "A new version was created"
      else
          redirect_to :action => "edit", :alert => "Version could not be updated"
      end
    end

   end
end
