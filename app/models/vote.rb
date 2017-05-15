class Vote < ApplicationRecord
  belongs_to :votable, polymorphic: true
  belongs_to :user

  validates :user, uniqueness: { scope: [:votable_id, :votable_type], message: ": You can only vote once" }
  validate :ensure_not_author

  def ensure_not_author
    errors.add :user, "you cannot up vote your own #{votable_type}"  if votable.user_id == user_id
  end
end
