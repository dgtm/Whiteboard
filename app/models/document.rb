class Document < ActiveRecord::Base
  has_many :versions
  belongs_to :user

  validates :title, :presence => true
  # validates :content, :presence =>true
  VERSION_INCREMENT = 1

  scope :my_documents, lambda {|current_user_id| where(:user_id == current_user_id )}

  def new_version_number
    self.versions.maximum(:number) + 1
  end

end
