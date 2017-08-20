class Pick < ActiveRecord::Base
  MAX_PICKS = 17

  default_scope {order('round ASC')}

  belongs_to :team
  belongs_to :player
end
