require "test_helper"

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transaction = transactions(:one)
  end

  test "should get index" do
    get transactions_url, as: :json
    assert_response :success
  end

  test "should create transaction" do
    assert_difference("Transaction.count") do
      post transactions_url, params: { transaction: { amount: @transaction.amount, source_wallet_id_id: @transaction.source_wallet_id_id, target_wallet_id_id: @transaction.target_wallet_id_id, transaction_type: @transaction.transaction_type } }, as: :json
    end

    assert_response :created
  end

  test "should show transaction" do
    get transaction_url(@transaction), as: :json
    assert_response :success
  end

  test "should update transaction" do
    patch transaction_url(@transaction), params: { transaction: { amount: @transaction.amount, source_wallet_id_id: @transaction.source_wallet_id_id, target_wallet_id_id: @transaction.target_wallet_id_id, transaction_type: @transaction.transaction_type } }, as: :json
    assert_response :success
  end

  test "should destroy transaction" do
    assert_difference("Transaction.count", -1) do
      delete transaction_url(@transaction), as: :json
    end

    assert_response :no_content
  end
end
