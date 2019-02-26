module Mixi
  class RequestValidator
    attr_accessor :key, :secret

    def initialize(key, secret)
      @key = key
      @secret = secret
    end

    def validate_signed_request(request)
      #FIXME don't trust any query!
      return true

      if signature_method = get_signature_method(request.params['oauth_signature_method'])
        signature_method.check_signature(request, nil, nil, request.params['oauth_signature']) # request, consumer, token, sig
      else
        false
      end
    end

    private

      def get_signature_method(request_signature_method)
        if request_signature_method == 'RSA-SHA1'
          MixiSignatureMethod.new
        end
      end
  end

  class MixiSignatureMethod < OAuthSignatureMethod_RSA_SHA1
    def fetch_public_cert(request)
<<-eos
-----BEGIN CERTIFICATE-----
MIIDNzCCAh+gAwIBAgIJAOwgl6RQpug2MA0GCSqGSIb3DQEBBQUAMDIxCzAJBgNV
BAYTAkpQMREwDwYDVQQKDAhtaXhpIEluYzEQMA4GA1UEAwwHbWl4aS5qcDAeFw0x
MzExMDcwODQxMTFaFw0yMzExMDUwODQxMTFaMDIxCzAJBgNVBAYTAkpQMREwDwYD
VQQKDAhtaXhpIEluYzEQMA4GA1UEAwwHbWl4aS5qcDCCASIwDQYJKoZIhvcNAQEB
BQADggEPADCCAQoCggEBAK2ojofjDNhiD6rDFUv4k728rGeLDf6VERU4RsdHBkvS
UZhx7SiRidhAHQ7QX6DP9W8ALeM6i2s+vxmfYbL9NrsKx/HxWZvuxmV4ELgRsDRN
0LUjEJv+hyI/nFfPlHmvYgKx501fTWn9DbBUxaKTbA2984Styrlf8etSRkkdx+Ua
742iDEXTH6jtxFSmcPvcvAXbdoUNNx95d+3QNoG8p0zaSMUwXGn7jCVcz+WhDkCO
n2ajknn539YXVRp6I4DjJ+8M1ZmC1FTcb5PsVGUuxCxhwZc6LDq/qMxJCi20AzD9
McYsyZS1LB+q/dwibaLEZbIh+fGkUaRoRRhrOFNJ0dMCAwEAAaNQME4wHQYDVR0O
BBYEFLWrc309hb0KbH56w0aseZPQHWc2MB8GA1UdIwQYMBaAFLWrc309hb0KbH56
w0aseZPQHWc2MAwGA1UdEwQFMAMBAf8wDQYJKoZIhvcNAQEFBQADggEBAGh27dw2
C1pxpDiA3X5zzrRDuBuCRXyY1Ywq3FboTVsUrc2NfOCOm27674D/tZtANxUBrs3k
JI1hY6mbQgvTaXNm6wuxknyQWeaKkdacdtbKeIdtut4APeY/K9NGLHqBjglpx+JK
jpXBVwVGqH36q9qqxZvCk/LZGzVuoYIsfolIUVKfQwpybc2TptdDH3Nuu/EXz/BK
xpkjcpasg+apX4zifOkdVoEmsjO1K1UeSvHDugEZRCLg/Bkbh9tK47waVj4BYvro
JkIkQk47Ws2bAlth3YaNAgjLibzyjCT/5YTJujWZHuMG/zpZMoYLuk7oJP4f4DKH
aw6UQsWgwzyYhnM=
-----END CERTIFICATE-----
eos
    end
  end
end
