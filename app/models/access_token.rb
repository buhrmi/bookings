class AccessToken < ApplicationRecord
  belongs_to :user

  def self.active
    where(invalidated_at: nil)
  end

  before_create do
    self.token = SecureRandom.hex(32)
  end


end
