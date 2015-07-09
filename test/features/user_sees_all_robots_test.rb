require_relative '../test_helper'

class UserSeesAllRobotsTest < FeatureTest
  def test_home_page_displays_welcome_message
    visit("/")
    within("#greeting") do
      assert page.has_content?("Welcome to Robot World")
    end
  end

  def test_user_can_fill_form
    skip
    visit("/")
    assert_equal "/", current_path

    click_link("New Robot")
    assert_equal "/tasks/new", current_path

    fill_in("task-title", with: "pizza")
    fill_in("task-description", with: "longer pizza")
    click_button("submit")

    assert page.has_content?("pizza")
  end

  def test_user_sees_index_of_tasks
  end
end
