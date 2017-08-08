require "spec_helper"

RSpec.describe SmsAero::Phone do
  subject { described_class[source] }

  context "valid phone:" do
    let(:source) { "+007 (203) 899-899-0" }

    it "returns formatted phone" do
      expect(subject).to eq "72038998990"
    end
  end

  context "invalid phone:" do
    let(:source) { "+0 (111)" }

    it "fails" do
      expect { subject }.to raise_error(StandardError, /111/)
    end
  end
end
