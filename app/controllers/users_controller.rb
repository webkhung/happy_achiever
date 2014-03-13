class UsersController <  Devise::RegistrationsController

  before_filter :find_resource, only: %w(show destroy email)

  def show
  end

  def destroy
    authorize!(:destroy, @user)
    @user.make_archived! unless @user.is_archived?
    redirect_to root_path, alert: "#{@user.display_name} is archived."
  end

  def find_resource
    if params.has_key?(:id)
      @user = User.find(params[:id])
    else
      redirect_to root_path, alert: "Invalid user id"
    end
  end

  def email
    UserMailer.report_email(@user).deliver
    redirect_to :back
  end

end
