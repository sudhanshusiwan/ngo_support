class OmniauthCallbacksController < ApplicationController
  skip_before_action :authenticate_user!

  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      # redirect_to( new_user_registration_path, alert: "Successfull logged in through Facebook!" ) and return
      # set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end

  # def reportbee
  #   auth = request.env['omniauth.auth']

    # These session variables would have been set in the users#login action.
    # The flow would have reached that action only when doing SSO from the RB app.
    # if session[:rb_session_id].present? || session[:school_subdomain].present?
    #   begin
    #     user_profile = UserProfile.from_omniauth( auth, session[:school_subdomain], session[:rb_session_id] )
    #     # You HAVE to set the following session attribute for devise to correctly detect that the user_profile has signed in.
    #     # In other words, the method "user_profile_signed_in?" does not return true unless the session attribute is set.
    #     session[:current_user_profile_id] = user_profile.id
    #     sign_in(user_profile)
    #     session.delete(:rb_session_id)

    #     redirect_to after_sign_in_path_for(user_profile)
    #   rescue StandardError => e
    #     Rails.logger.debug( e.message )
    #     redirect_to( logout_path(school_subdomain: session[:school_subdomain]), alert: "Error in login: #{e.message}" ) and return
    #   end
    # else    # Active Admin login.
    #   unless auth.extra.is_admin
    #     redirect_to( new_admin_user_session_path, alert: 'Sorry. You need to be an Admin User to view this page' ) and return
    #   end

    #   admin_user = AdminUser.from_omniauth( auth )

    #   if admin_user.persisted?
    #     flash.notice = 'Signed in!'
    #     sign_in_and_redirect admin_user
    #   else
    #     redirect_to( new_admin_user_session_path, alert: "We couldn't sign you in because: " + admin_user.errors.full_messages.to_sentence )
    #   end
    # end
  # end
end
