require "spec_helper"

RSpec.describe SmsAero::Sms do
  let(:source) { { text: "Hi" } }

  subject { described_class[source] }
  it { is_expected.to eq text: "Hi", type: 2 }

  context "with digital channel" do
    before { source[:digital] = true }
    it { is_expected.to eq text: "Hi", digital: 1 }
  end

  context "with valid channel" do
    before { source[:type] = 3 }
    it { is_expected.to eq text: "Hi", type: 3 }
  end

  context "with invalid channel" do
    before { source[:type] = 13 }

    it "raises exception" do
      expect { subject }.to raise_error TypeError
    end
  end

  context "with valid date" do
    before { source[:date] = "2200-01-13" }
    it { is_expected.to eq text: "Hi", type: 2, date: 7_259_144_400 }
  end

  context "with old date" do
    before { source[:date] = "2000-01-13" }

    it "raises exception" do
      expect { subject }.to raise_error TypeError
    end
  end
end
