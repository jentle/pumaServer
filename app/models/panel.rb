class Panel < ActiveRecord::Base
has_many :outputs
belongs_to :device
end
