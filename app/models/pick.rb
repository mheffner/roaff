class Pick < ActiveRecord::Base
  default_scope {order('round ASC')}

  belongs_to :team
  belongs_to :player
end
