require "#{Rails.root}/app/controllers/application_controller.rb"
module Api
    module Auth
        class RegistrationsController < DeviseTokenAuth::RegistrationsController
            private
            def signup_params
                params.permit(:name, :email, :password, :password_confirmation)
            end
            def account_update_params
                params.permit(:name, :email)
            end
        end
    end
end