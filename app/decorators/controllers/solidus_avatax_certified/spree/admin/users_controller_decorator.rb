# frozen_string_literal: true

module Controllers
  module SolidusAvataxCertified
    module Spree
      module Admin
        module UsersControllerDecorator
          def avalara_information
            if request.put? && @user.update(user_params)
              flash.now[:success] = I18n.t('spree.admin.account_updated')
            end

            render :avalara_information
          end

          ::Spree::Admin::UsersController.prepend self
        end
      end
    end
  end
end
