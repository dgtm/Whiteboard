class VersionsController < ActionController::Base

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
       render :action => "new", :alert => 'Document could not be created. Try again.'
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
      if params[:current] == true
          p "UPDATE SUCCESS"
          p "UPDATE SUCCESS"
          p "UPDATE SUCCESS"
          p "UPDATE SUCCESS"
          if @version.update_attributes(params[:content])
              redirect_to document_path(@document), :notice => "This version was updated"
            else
              redirect_to :action => "edit", :alert => "Job details could not be updated"
            end

    else
      @newversion = @document.versions.create(:number => @version.new_version(@document), :content => params[:content], :user_id => current_user.id)
    end

   end
end