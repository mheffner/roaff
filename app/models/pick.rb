class Pick < ActiveRecord::Base
  MAX_PICKS = 21

  default_scope {order('round ASC')}

  belongs_to :team
  belongs_to :player
end
