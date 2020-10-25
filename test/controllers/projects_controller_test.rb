require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  test "should get create_form" do
    get projects_create_form_url
    assert_response :success
  end

  test "should get mine" do
    get projects_mine_url
    assert_response :success
  end

  test "should get index" do
    get projects_index_url
    assert_response :success
  end

  test "should get show" do
    get projects_show_url
    assert_response :success
  end

  test "should get basic_setting_form" do
    get projects_basic_setting_form_url
    assert_response :success
  end

  test "should get tags_setting_form" do
    get projects_tags_setting_form_url
    assert_response :success
  end

  test "should get environment_setting_form" do
    get projects_environment_setting_form_url
    assert_response :success
  end

  test "should get wants_setting_form" do
    get projects_wants_setting_form_url
    assert_response :success
  end

  test "should get publish_setting_form" do
    get projects_publish_setting_form_url
    assert_response :success
  end

  test "should get destroy_form" do
    get projects_destroy_form_url
    assert_response :success
  end

  test "should get join_form" do
    get projects_join_form_url
    assert_response :success
  end

  test "should get join_requests_form" do
    get projects_join_requests_form_url
    assert_response :success
  end

end
