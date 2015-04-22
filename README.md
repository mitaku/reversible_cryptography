# ReversibleCryptography

Easy-to-use reversible encryption solutions.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'reversible_cryptography'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install reversible_cryptography

## Usage

```ruby
encrypted_message = ReversibleCryptography::Message.encrypt("target_message", "password")
# => "md5:388eeae24576572f946e9043a2118b2d:salt:161-225-182-109-143-90-1-28:aes-256-cfb:DHY6DF3+iFzH36FMbeI="
ReversibleCryptography::Message.encrypt(encrypted_message, "password") == "target_message"
# => true
```

### CLI
Add `reversible_cryptography` command

```shell
$ reversible_cryptography

Commands:
  reversible_cryptography decrypt [TEXT]  # Decrypt text or file
  reversible_cryptography encrypt [TEXT]  # Encrypt text or file
  reversible_cryptography help [COMMAND]  # Describe available commands or one specific command
```

#### Encrypt sample

```shell
$ reversible_cryptography encrypt message
Input password:
md5:78e731027d8fd50ed642340b7c9a63b3:salt:252-235-72-88-180-7-195-229:aes-256-cfb:VH2JxqUU9Q==
```

```shell
cat original.txt
this is secret!

reversible_cryptography encrypt --password=pass --src-file=original.txt --dst-file=encrypted.txt

cat encrypted.txt
md5:f5b013aca1b774be3d3b5f09f76e6cc8:salt:228-129-190-248-134-146-102-97:aes-256-cfb:u+lhtAdW6Re8br0qePqzig==
```

#### Decrypt sample

```shell
reversible_cryptography decrypt md5:78e731027d8fd50ed642340b7c9a63b3:salt:252-235-72-88-180-7-195-229:aes-256-cfb:VH2JxqUU9Q==
Input password:
message
```

```shell
cat encrypted.txt
md5:f5b013aca1b774be3d3b5f09f76e6cc8:salt:228-129-190-248-134-146-102-97:aes-256-cfb:u+lhtAdW6Re8br0qePqzig==

reversible_cryptography decrypt --password=pass --src-file=encrypted.txt --dst-file=decrypted.txt

cat decrypted.txt
this is secret!
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/mitaku/reversible_cryptography/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
