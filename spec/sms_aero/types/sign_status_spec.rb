require "spec_helper"

RSpec.describe SmsAero::Types::SignStatus do
  context "valid status:" do
    let(:items) { %w(accepted approved rejected pending) }

    it "returns a status" do
      items.each { |item| expect(described_class[item]).to eq item }
    end
  end

  context "invalid status:" do
    let(:item) { "wrong" }

    it "fails" do
      expect { described_class[item] }.to raise_error(StandardError, /wrong/)
    end
  end
end
