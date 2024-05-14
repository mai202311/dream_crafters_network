class User::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_up_path_for(resource)
    posts_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def ensure_normal_user
    if resource.email == 'guest@example.com'
      redirect_to posts_path, alert: 'ゲストユーザーは削除できません。'
    end
  end
end
