require 'thor'
require 'reversible_cryptography'

module ReversibleCryptography
  class CLI < Thor
    desc "encrypt [TEXT]", "Encrypt text or file"
    option :password, type: :string, aliases: [:p]
    option :src_file, type: :string, aliases: [:s], banner: "PLAIN_TEXT_FILE"
    option :dst_file, type: :string, aliases: [:d], banner: "ENCRYPTED_TEXT_FILE"
    def encrypt(plain_text=nil)
      plain_text = File.read(options[:src_file]) if options[:src_file]
      plain_text ||= ask("Input text:")
      password = options[:password]
      password ||= ask("Input password:", echo: false).tap { puts }

      encrypted_text = ReversibleCryptography::Message.encrypt(plain_text, password)
      if options[:dst_file]
        File.open(options[:dst_file], "wb") do |f|
          f.write(encrypted_text)
        end
      else
        puts encrypted_text
      end
    end

    desc "decrypt [TEXT]", "Decrypt text or file"
    option :password, type: :string, aliases: [:p]
    option :src_file, type: :string, aliases: [:s], banner: "ENCRYPTED_TEXT_FILE"
    option :dst_file, type: :string, aliases: [:d], banner: "PLAIN_TEXT_FILE"
    def decrypt(encrypted_text=nil)
      encrypted_text = File.read(options[:src_file]) if options[:src_file]
      encrypted_text ||= ask("Input text:")
      password = options[:password]
      password ||= ask("Input password:", echo: false).tap { puts }

      plain_text = ReversibleCryptography::Message.decrypt(encrypted_text, password)
      if options[:dst_file]
        File.open(options[:dst_file], "wb") do |f|
          f.write(plain_text)
        end
      else
        puts plain_text
      end
    end
  end
end
