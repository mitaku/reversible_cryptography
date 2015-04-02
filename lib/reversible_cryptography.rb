require "reversible_cryptography/version"
require "reversible_cryptography/message"

module ReversibleCryptography
  class BaseError < StandardError; end
  class EmptyInputString < BaseError; end
  class InvalidPassword < BaseError; end
  class EmptyPassword < InvalidPassword; end
  class InvalidFormat < BaseError; end
end
