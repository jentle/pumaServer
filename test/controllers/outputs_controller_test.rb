require 'test_helper'

class OutputsControllerTest < ActionController::TestCase
  setup do
    @output = outputs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:outputs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create output" do
    assert_difference('Output.count') do
      post :create, output: { voltage: @output.voltage, watt: @output.watt }
    end

    assert_redirected_to output_path(assigns(:output))
  end

  test "should show output" do
    get :show, id: @output
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @output
    assert_response :success
  end

  test "should update output" do
    patch :update, id: @output, output: { voltage: @output.voltage, watt: @output.watt }
    assert_redirected_to output_path(assigns(:output))
  end

  test "should destroy output" do
    assert_difference('Output.count', -1) do
      delete :destroy, id: @output
    end

    assert_redirected_to outputs_path
  end
end
