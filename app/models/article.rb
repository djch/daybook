class Article < ApplicationRecord
  before_save :set_title_if_blank
  
  has_many :comments, dependent: :destroy

  private
    def set_title_if_blank
      self.title = "Untitled" if self.title.blank?
    end
end
