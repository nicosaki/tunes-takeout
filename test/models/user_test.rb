require 'test_helper'

class UserTest < ActiveSupport::TestCase

  describe "API" do
    before do
      @suggestions = TunesTakeout.search(1)
    end

    it "has the right data type for an array of suggestions", :vcr do
      assert_instance_of Array, @suggestions
    end

    it "isn't an empty array of suggestions", :vcr do
      refute @suggestions.empty?
    end

    it "has a hash in the suggestion array element", :vcr do
      assert_instance_of Hash, @suggestions[1]
    end
  end


  def setup
    # @known = OmniAuth.config.mock_auth[:spotify_known]
    @known = { "provider" => 'spotify', "info" => { "id" => "known_user", "display_name" => "known user" } }
    @unknown = OmniAuth.config.mock_auth[:spotify_unknown]
    @unknown_with_uid = OmniAuth.config.mock_auth[:spotify_uid]
  end

  test "can find an existing user given an oauth spotify hash" do
    assert_equal users(:known_user), User.find_or_create_from_omniauth(@known)
  end

  test "can make a new user given the oauth spotify hash of an unknown user" do
    assert_difference 'User.count', 1 do
      @user = User.find_or_create_from_omniauth @unknown
    end
  end

  test "uses oauth data to set user name, provider and uid for new users" do
    user = User.find_or_create_from_omniauth @unknown

    assert_equal @unknown['info']['display_name'], user.name
    assert_equal @unknown['provider'], user.provider
    assert_equal @unknown['info']['id'], user.uid
  end

  test "prefers a top-level uid over a nested id when creating an oauth user" do
    user = User.find_or_create_from_omniauth @unknown_with_uid
    assert_equal @unknown_with_uid['uid'], user.uid
  end
end
