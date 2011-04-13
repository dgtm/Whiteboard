class Document < ActiveRecord::Base
  has_many :versions
  belongs_to :user

  validates :title, :presence => true

  scope :my_documents, lambda {|current_user_id| where(:user_id == current_user_id )}

  VERSION_INCREMENT = 1

  def self.search(option, parameters,current_user_id)
    p "aaaaaaaaaaaaaaaaaa"
    p option
    p parameters
  if option == "my_docs"
    if parameters
      find(:all, :conditions => ['title LIKE ? AND user_id LIKE ?', "%#{parameters}%",current_user_id])
    else
      find(:all, :conditions => ['user_id LIKE ?', current_user_id])
    end
  elsif option == "all"
    if parameters
      find(:all, :conditions => ['title LIKE ?', "%#{parameters}%"])
    else
      find(:all)
    end
  end
  end

  def latest_version
    self.versions.maximum(:number)
  end

  def new_version_number
    self.versions.maximum(:number) + 1
  end

  def shared_status
    if self.shared == true
      share_status = "Public"
    else
      share_status = "Private"
    end
    return share_status
    p "Inside the modellllllllllllllllllllllllllllll"
    p share_status
  end

end
