class VersionsController < ActionController::Base
layout 'application'

before_filter :allow_edits, :only => [:create, :update, :revert]
after_filter :update_statistics, :only => [:create, :update, :revert]

YES = '1'
  def order_by_recent
    @document = Document.find(params[:document_id])
    @versions = @document.versions.order("updated_at DESC")
  end
  def update_statistics
    @statistic = Statistics.find(:first, :conditions => ["document_id = ? and user_id = ?", @document.id, current_user.id])
    @count = @statistic.count
    @stats = @statistic.update_attributes(:count => @count+1)
  end

  def allow_edits
    @document = Document.find(params[:document_id])
    if (@document.shared == false && @document.user_id != current_user.id)
      redirect_to document_versions_path(@document,@document.versions), :alert => "Sorry, this document is only for the private use of the author"
    end
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
      if params[:order_recent]
        @versions = @document.versions.order("updated_at DESC")
      elsif params[:order_by_version]
        @versions = @document.versions.order("number DESC")
      else
        @versions = @document.versions.all
      end
      respond_to do |format|
        format.html { }
        format.js { }
      end
   end

   def show
     @document = Document.find(params[:document_id])
     @version = @document.versions.find(params[:id])
   end

   def edit
     @document = Document.find(params[:document_id])
     @version = @document.versions.find(params[:id])
     respond_to do |format|
       format.html { }
       format.js
     end
   end

   def revert
       @document = Document.find(params[:document_id])
       @version = @document.versions.find(params[:id])
       @revert = @document.versions.create(:number => @document.new_version_number, :content => @version.content, :user_id => current_user.id)

       #Just in case the user wants to save into the current latest version rather than create a new version
       #####
       #@latest_version = @version.find(@document.latest_version)
       #@revert = @latest_version.update_attributes(:content => @version.content)
       #####

        if @revert.save
          redirect_to document_versions_path(@document), :notice => "The latest version has been reverted to Version #{@version.number}"
        else
          redirect_to document_versions_path(@document), :alert => "Revert failed"
        end
   end

   def update
     @document = Document.find(params[:document_id])
     @version = @document.versions.find(params[:id])
     if (@version.content ==  params[:version][:content])
       redirect_to :action => "edit", :alert => "The version could not be updated because the contents are same"
     else
      if params[:dont_save_as_a_new_version] == YES
          if @version.update_attributes(:content => params[:version][:content])
              redirect_to document_versions_path(@document), :notice => "Version #{@version.number} was updated"
            else
              redirect_to :action => "edit", :alert => "Version could not be updated"
            end
    else
      @newversion = @document.versions.create(:number => @version.new_version(@document), :content => params[:version][:content], :user_id => current_user.id)
      if @newversion.save
      redirect_to document_versions_path(@document), :notice => "A new version was created"
      else
          redirect_to :action => "edit", :alert => "Version could not be updated"
        end
      end
    end
   end
end
