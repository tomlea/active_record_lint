class Incident < ActiveRecord::Base
  belongs_to :criminal
  belongs_to :victim
  belongs_to :crime
end