module DocumentsHelper
   def my_docs
     docs = Array.new
     if user_signed_in?
      docs = current_user.documents
    end
    return docs
    end

    def all_docs
      docs = Array.new
      if user_signed_in?
        docs = Document.all
      end
      return docs
    end

    def recent_docs
      @recent_documents = Array.new
      if user_signed_in?
          all_documents = Statistics.where("user_id = ?", current_user.id)
          @recent_stats = all_documents.order("updated_at DESC").first(5)
            @recent_stats.each do |stat|
              @recent_documents << Document.find(stat.document_id)
            end
          end
            return @recent_documents
    end

    def favorite_docs
      @favorite_documents = Array.new
      if user_signed_in?
      all_documents = Statistics.where("user_id = ?", 1)
       @favorite_stats = all_documents.order("count DESC").first(5)
          @favorite_stats.each do |stat|
            @favorite_documents << Document.find(stat.document_id)
          end
        end
          return @favorite_documents
    end
end