require 'mixi/rails/controller/redirects'

module Mixi
  module Rails

    # Rails application controller extension
    module Controller
      def self.included(base)
        base.class_eval do
          include Mixi::Rails::Controller::Redirects

          helper_method :mixi, :current_mixi_user, :mixi_params, :params_without_mixi_data, :mixi_canvas?
        end
      end

      protected

        MIXI_PARAM_NAMES = %w{oauth_body_hash opensocial_owner_id opensocial_viewer_id opensocial_app_id opensocial_app_url
         oauth_consumer_key xoauth_public_key oauth_version oauth_timestamp oauth_signature_method oauth_nonce oauth_signature}

        RAILS_PARAMS = %w{controller action format}

        # Accessor to current application config. Override it in your controller
        # if you need multi-application support or per-request configuration selection.
        def mixi
          Mixi::Config.default
        end

        # Accessor to current Mixi user. Returns instance of Mixi::User
        def current_mixi_user
          @current_mixi_user ||= fetch_current_mixi_user
        end

        # params coming directly from Mixi
        def mixi_params
          params.slice(*MIXI_PARAM_NAMES)
        end

        # A hash of params passed to this action, excluding secure information passed by wizQ
        def params_without_mixi_data
          params.except(*MIXI_PARAM_NAMES)
        end

        # Did the request come from canvas app
        def mixi_canvas?
          params['wizq_player_id'].present? || mixi_params['oauth_consumer_key'].present? || request.env['HTTP_SIGNED_PARAMS'].present?
        end

        def mixi_signed_params
          request.env['HTTP_SIGNED_PARAMS'] || build_signed_params(mixi_params)
        end

        def validate_mixi_payment_request
          mixi.payment_validator.check_signature(request)
        end

      private

        def fetch_current_mixi_user
          Mixi::User.from_mixi_request(mixi, request)
        end

        def build_signed_params(data)
          string = base64_url_encode( MultiJson.encode(data) )
          signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest::SHA256.new, mixi.consumer_secret, string)

          [
            base64_url_encode( [signature].pack("H*")),
            string
          ].join('.')
        end

        # Facebook approach to encrypting params
        def base64_url_encode(str)
          Base64.strict_encode64(str).tr('+/', '-_').tr('=', '')
        end
    end
  end
end
