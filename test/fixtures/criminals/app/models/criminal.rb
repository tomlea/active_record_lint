class Criminal < ActiveRecord::Base
  has_many :incidents
  has_many :victims, :through => :incidents
  has_many :crimes, :through => :incidents
end