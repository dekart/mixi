module Mixi
  class RequestValidator
    attr_accessor :key, :secret

    def initialize(key, secret)
      @key = key
      @secret = secret
    end

    def validate_signed_request(request)
      if signature_method = get_signature_method(request.params['oauth_consumer_key'])
        signature_method.check_signature(request, nil, nil, request.params['oauth_signature']) # request, consumer, token, sig
      else
        false
      end
    end

    private

      def get_signature_method(oauth_consumer_key)
        MixiSignatureMethod.new
      end
  end

  class MixiSignatureMethod < OAuthSignatureMethod_RSA_SHA1
    def fetch_public_cert(request)
<<-eos
-----BEGIN CERTIFICATE-----
MIICMDCCAZmgAwIBAgIJAKgXukluiO9rMA0GCSqGSIb3DQEBBQUAMBsxGTAXBgNV
BAMTEG1iZ2EtcGxhdGZvcm0uanAwHhcNMTcwNjMwMTI1MTUxWhcNMjcwNjMwMTI1
MTUxWjAbMRkwFwYDVQQDExBtYmdhLXBsYXRmb3JtLmpwMIGfMA0GCSqGSIb3DQEB
AQUAA4GNADCBiQKBgQDJiPISeGA1qFk3iCX/71yYN7DiHQhkkcEokr0WiOoHXEMH
bq25kb2oMFrUthS3FldzlCJQl6qfYcI2Q48LFoLjaaORkhNuW5WzqvRQSezyRBNS
3Z8LBmlEkqBnwLMA3BQTtgNctMajEzRGxd/1eLg4bQwpjVwzokxBVjNDZNh3dwID
AQABo3wwejAdBgNVHQ4EFgQUDGmQcD11YTlCXrGvuwbeO2g9tR0wSwYDVR0jBEQw
QoAUDGmQcD11YTlCXrGvuwbeO2g9tR2hH6QdMBsxGTAXBgNVBAMTEG1iZ2EtcGxh
dGZvcm0uanCCCQCoF7pJbojvazAMBgNVHRMEBTADAQH/MA0GCSqGSIb3DQEBBQUA
A4GBAAwHUGNvsODKnKfiAs7MuPaQ4YYBjPv0ROwlfnh21i2OsYtmDupl2TIc9VTt
Ms/SVOrA3pQMaK9uzS2tAOTLwJ7/L5T5sNuMtlmseg4ywP+HupBLbxlUNqo5yfOc
jnP0cPWdpYJMGzNXHJWd34P5+G/xL+eBEdoxvfwNa37IcwlV
-----END CERTIFICATE-----
eos
    end
  end
end
