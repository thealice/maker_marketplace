class Conversation < ApplicationRecord
    belongs_to :sender, foreign_key: :sender_id, class_name: "User"
    belongs_to :recipient, foreign_key: :recipient_id, class_name: "User"
  
    has_many :messages

    # Users can't start a conversation with themselves
    validates_uniqueness_of :sender_id, scope: :recipient_id

    # Allows us to check whether there is already a conversation between two users
    # so the same two users can have one continuous conversation rather than creating
    # a new one each time.
    scope :between, -> (sender_id, recipient_id) do
      where("(conversations.sender_id = ? AND conversations.recipient_id = ?) OR (conversations.sender_id = ? AND conversations.recipient_id = ?)", sender_id, recipient_id, recipient_id, sender_id)
    end
end
