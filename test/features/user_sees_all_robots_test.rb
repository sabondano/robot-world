require_relative '../test_helper'

class UserSeesAllRobotsTest < FeatureTest
  def test_home_page_displays_welcome_message
    visit("/")
    within("#greeting") do
      assert page.has_content?("Welcome to Robot World")
    end
  end

  def test_user_can_fill_form
    visit("/")
    assert_equal "/", current_path

    click_link("New Robot")
    assert_equal "/robots/new", current_path

    fill_in("robot-name", with: "pizza")
    fill_in("robot-city", with: "longer pizza")
    click_button("submit")
    assert page.has_content?("pizza")
  end

  def test_user_sees_index_of_robots
     
  end
end
