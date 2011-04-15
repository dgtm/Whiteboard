class Version < ActiveRecord::Base
  belongs_to :document
  belongs_to :user
  validates :content , :presence => true

VERSION_INCREMENT = 1

  def find_latest_version(document)
    Version.where(:document_id => document.id).maximum(:number)
  end

  def new_version(document)
    latest_version = find_latest_version(document)
    new_version = latest_version + VERSION_INCREMENT
    return new_version
  end
end
