require 'spec_helper'

describe ReversibleCryptography do
  it 'has a version number' do
    expect(ReversibleCryptography::VERSION).not_to be nil
  end

  shared_examples "raises error on empty input" do
    context "When string is empty" do
      let(:str) { nil }
      let(:password) { "password" }
      it { expect{ subject }.to raise_error(ReversibleCryptography::EmptyInputString) }
    end

    context "When password is empty" do
      let(:str) { "string" }
      let(:password) { nil }
      it { expect{ subject }.to raise_error(ReversibleCryptography::EmptyPassword) }
    end
  end

  describe ReversibleCryptography::Message do
    describe ".encrypt" do
      subject { described_class.encrypt(str, password) }

      let(:str) { "hogehoge" }
      let(:password) { "password" }

      it { should match(/^md5:([0-9a-f]+):salt:([0-9-]+):aes-256-cfb:(.+)/) }

      it_behaves_like "raises error on empty input"
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
        it { expect { subject }.to raise_error(ReversibleCryptography::InvalidPassword) }
      end

      context "When input string is invalid format" do
        let(:str) { "deadbeef" }
        let(:password) { "hogefuga" }

        it { expect { subject }.to raise_error(ReversibleCryptography::InvalidFormat) }
      end

      it_behaves_like "raises error on empty input"
    end
  end
end
