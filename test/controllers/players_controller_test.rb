require 'test_helper'

class PlayersControllerTest < ActionController::TestCase
  test "should get update" do
    get :update
    assert_response :success
  end

end
