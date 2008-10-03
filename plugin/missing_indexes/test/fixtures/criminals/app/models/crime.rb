class Crime < ActiveRecord::Base
  has_many :incidents
  has_many :victims, :through => :incidents
  has_many :criminals, :through => :incidents
end
