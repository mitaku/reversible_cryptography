require 'spec_helper'

describe ReversibleCryptography do
  it 'has a version number' do
    expect(ReversibleCryptography::VERSION).not_to be nil
  end

  describe ReversibleCryptography::Message do
    describe ".encrypt" do
      subject { described_class.encrypt(str, password) }

      let(:str) { "hogehoge" }
      let(:password) { "password" }

      it { should match(/^md5:([0-9a-f]+):salt:([0-9-]+):aes-256-cfb:(.+)/) }
    end

    describe ".decrypt" do
      subject { described_class.decrypt(str, password) }

      let(:str) { "md5:329435e5e66be809a656af105f42401e:salt:131-180-207-255-1-203-171-221:aes-256-cfb:foH0M+/g9UI=" }

      context "valid" do
        let(:password) { "piyopiyo" }
        it { should eq "hogehoge" }
      end

      context "invald" do
        let(:password) { "password" }
        it { expect { subject }.to raise_error }
      end
    end
  end
end
