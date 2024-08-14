class WalletsController < ApplicationController
  before_action :require_login

  # GET /wallets
  def index
    @wallets = Wallet.where(owner: current_user)

    render json: @wallets
  end

  # GET /wallets/1
  def show
    @wallet = Wallet.find_by(id: params[:id], owner: current_user) # need to handle if not found
    render json: @wallet
  end

  # POST /wallets
  def create
    account_number = AccountNumberGenerator.generate(current_user)
    @wallet = Wallet.new(name: wallet_params[:name], account_number: account_number, owner: current_user)

    if @wallet.save
      render json: @wallet, status: :created, location: @wallet
    else
      render json: @wallet.errors, status: :unprocessable_entity
    end
  end

  def deposit
    begin
      wallet = Wallet.find_by(id: params[:id], owner: current_user)
      raise 'Wallet not found' if wallet.blank?

      wallet.deposit!(deposit_and_withdraw_params[:amount])
      render json: { success: true, message: 'OK' }, status: :ok
    rescue => e
      render json: { success: false, message: e.message }, status: :unprocessable_entity
    end
  end

  def withdraw
    begin
      wallet = Wallet.find_by(id: params[:id], owner: current_user)
      raise 'Wallet not found' if wallet.blank?

      wallet.withdraw!(deposit_and_withdraw_params[:amount])
      render json: { success: true, message: 'OK' }, status: :ok
    rescue => e
      render json: { success: false, message: e.message }, status: :unprocessable_entity
    end
  end

  def transfer
    begin
      wallet = Wallet.find_by(id: params[:id], owner: current_user)
      raise 'Wallet not found' if wallet.blank?

      wallet.transfer!(transfer_params[:amount], transfer_params[:target_account_number])
      render json: { success: true, message: 'OK' }, status: :ok
    rescue => e
      render json: { success: false, message: e.message }, status: :unprocessable_entity
    end
  end

  # # PATCH/PUT /wallets/1
  # def update
  #   if @wallet.update(wallet_params)
  #     render json: @wallet
  #   else
  #     render json: @wallet.errors, status: :unprocessable_entity
  #   end
  # end

  # # DELETE /wallets/1
  # def destroy
  #   @wallet.destroy!
  # end

  private
    # Only allow a list of trusted parameters through.
    def wallet_params
      params.require(:wallet).permit(:name)
    end

    def transfer_params
      params.permit(:target_account_number, :amount)
    end

    def deposit_and_withdraw_params
      params.permit(:amount)
    end
end
