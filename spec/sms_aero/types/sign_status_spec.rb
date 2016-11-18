require "spec_helper"

RSpec.describe SmsAero::Types::SignStatus do
  context "valid status:" do
    let(:values) { %w(accepted approved rejected pending) }

    it "returns a status" do
      values.each { |value| expect(described_class[value]).to eq value }
    end
  end

  context "invalid status:" do
    let(:value) { "wrong" }

    it "fails" do
      expect { described_class[value] }.to raise_error(StandardError, /wrong/)
    end
  end
end
