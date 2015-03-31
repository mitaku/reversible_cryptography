require 'thor'
require 'reversible_cryptography'

module ReversibleCryptography
  class CLI < Thor
    desc "encrypt [TEXT]", "Encrypt text"
    option :password, type: :string, aliases: [:p]
    def encrypt(plain_text=nil)
      plain_text ||= ask("Input text:")
      password = options[:password]
      password ||= ask("Input password:", echo: false).tap { puts }

      puts ReversibleCryptography::Message.encrypt(plain_text, password)
    end

    desc "decrypt [TEXT]", "Decrypt text"
    option :password, type: :string, aliases: [:p]
    def decrypt(encrypted_text=nil)
      encrypted_text ||= ask("Input text:")
      password = options[:password]
      password ||= ask("Input password:", echo: false).tap { puts }

      puts ReversibleCryptography::Message.decrypt(encrypted_text, password)
    end
  end
end
