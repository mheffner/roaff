class PlayersController < ApplicationController
  def update
    p = Player.find(params[:id])
    not_found and return unless p

    not_found and return unless params[:picked]

    picked = params[:picked] == "true" ? true : false

    puts "picked: #{picked.inspect}"

    p.setPicked(picked)
    p.save

    puts "p now: #{p.inspect}"

    return "{}"
  end

  # XXX
  def not_found
    render :nothing => true, :status => 400
  end
end
