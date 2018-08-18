class Pick < ActiveRecord::Base
  MAX_PICKS = 20

  default_scope {order('round ASC')}

  belongs_to :team
  belongs_to :player
end
