require "spec_helper"

RSpec.describe SmsAero::Channel do
  context "valid code:" do
    let(:codes) { [4, 5, 6, 7, 8] }

    it "returns a code" do
      codes.each { |code| expect(described_class[code]).to eq code.to_s }
    end
  end

  context "invalid code:" do
    let(:code) { 3 }

    it "fails" do
      expect { described_class[code] }.to raise_error(StandardError, /3/)
    end
  end
end
