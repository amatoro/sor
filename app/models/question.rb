# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  title      :string
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Question < ApplicationRecord
  belongs_to :user
  has_many :answers
  has_many :comments, as: :commentable

  validates :title, :content, presence: true
end
