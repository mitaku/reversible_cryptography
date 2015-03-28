require "openssl"
require "base64"

module ReversibleCryptography
  class Message
    MODE = "CFB"
    PREFIX = "aes-256-cfb"

    class << self
      def encrypt(str, password)
        enc = OpenSSL::Cipher::AES256.new(MODE)
        enc.encrypt

        salt = OpenSSL::Random.random_bytes(8)
        salt_string = generate_salt_string(salt)

        set_key_and_iv(enc, password, salt)

        result = enc.update(str) + enc.final

        md5 = OpenSSL::Digest.hexdigest("MD5", str)
        ["md5", md5, "salt", salt_string, PREFIX, Base64.encode64(result).chomp].join(":")
      end

      def decrypt(str, password)
        key = str.sub(/^md5:(.+):salt:(.+):#{PREFIX}:/, '')
        md5 = $1
        salt_string = $2

        salt = convert_salt(salt_string)

        dec = OpenSSL::Cipher::AES256.new(MODE)
        dec.decrypt
        set_key_and_iv(dec, password, salt)

        result = dec.update(Base64.decode64(key)) + dec.final
        if OpenSSL::Digest.hexdigest("MD5", result) == md5
          result
        else
          raise StandardError.new("Invalid Password")
        end
      end

      private

      def set_key_and_iv(cipher, password, salt)
        key_iv = OpenSSL::PKCS5.pbkdf2_hmac_sha1(password, salt, 2000, cipher.key_len + cipher.iv_len)
        cipher.key = key_iv[0, cipher.key_len]
        cipher.iv  = key_iv[cipher.key_len, cipher.iv_len]
      end

      def convert_salt(str)
        str.split("-").map(&:to_i).pack("C*")
      end

      def generate_salt_string(salt)
        salt.unpack("C*").join("-")
      end
    end
  end
end
