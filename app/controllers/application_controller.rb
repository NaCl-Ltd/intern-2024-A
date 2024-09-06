class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :switch_locale
  private
    # ユーザーのログインを確認する
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url, status: :see_other
      end
    end

    def default_url_options
      { locale: I18n.locale }
    end

    def switch_locale
      locale = params[:locale] || I18n.default_locale
      I18n.locale = locale
    end
end
