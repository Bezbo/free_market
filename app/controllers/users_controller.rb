class UsersController < Clearance::UsersController

  before_filter :cancan_strong_parameters

  load_resource
  authorize_resource only: [:edit, :update, :destroy]

  def index
    @users = User.order("name").search(params[:term])
    @paginated_users = Kaminari.paginate_array(@users).page(params[:page])
  end

  def show
  end

  def new
  end

  def create
    if @user.save
      sign_in @user
      redirect_to @user
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to @user
    else
      render "edit"
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url
  end

  private

  def user_params
    if current_user && current_user.role == "admin"
      params.require(:user).permit(:name, :email, :password, :role)
    else
      params.require(:user).permit(:name, :email, :password)
    end
  end

  def user_from_params
    user_params = params[:user] || Hash.new
    email = user_params.delete(:email)
    password = user_params.delete(:password)
    name = user_params.delete(:name)

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.email = email
      user.password = password
      user.name = name
    end
  end

  def cancan_strong_parameters
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

end
