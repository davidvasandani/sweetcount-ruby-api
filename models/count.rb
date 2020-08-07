# file models/speaker.rb
class Count < ActiveRecord::Base
  validates :created_at, presence: true
end