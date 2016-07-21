class Users::SignUp
  include Virtus.model

  attribute :params, Hash

  attribute :user, User

  def call
    @user = User.new params
    @user.save && post_sign_up_actions
  end

  private

  def post_sign_up_actions
    @user.generate_account_verification_data
    AccountVerificationsMailer.send_verification_instructions(@user).deliver_later
    true
  end

end
