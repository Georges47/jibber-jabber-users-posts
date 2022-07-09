class Post < ApplicationRecord
  validates_presence_of :content
  validates_length_of :content, minimum: 1, maximum: 280, allow_blank: false

  belongs_to :user
end
