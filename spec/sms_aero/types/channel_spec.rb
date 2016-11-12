require "spec_helper"

RSpec.describe SmsAero::Types::Channel do
  context "valid code:" do
    let(:codes) { [1, 2, 3, 4, 6] }

    it "returns a code" do
      codes.each { |code| expect(described_class[code]).to eq code }
    end
  end

  context "invalid code:" do
    let(:code) { 5 }

    it "fails" do
      expect { described_class[code] }.to raise_error(StandardError, /5/)
    end
  end
end
