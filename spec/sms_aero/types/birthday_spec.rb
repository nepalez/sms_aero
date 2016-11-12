require "spec_helper"

RSpec.describe SmsAero::Types::Birthday do
  subject { described_class[source] }

  context "date:" do
    let(:source) { Date.parse "1901-08-17" }
    it { is_expected.to eq "1901-08-17" }
  end

  context "datetime:" do
    let(:source) { DateTime.parse "1901-08-17 10:00:00" }
    it { is_expected.to eq "1901-08-17" }
  end

  context "time:" do
    let(:source) { Time.parse "1901-08-17 10:00:00" }
    it { is_expected.to eq "1901-08-17" }
  end

  context "parceable string:" do
    let(:source) { "1901/08/17" }
    it { is_expected.to eq "1901-08-17" }
  end

  context "imparceable string:" do
    let(:source) { "Foobar" }

    it "fails" do
      expect { subject }.to raise_error(TypeError, /Foobar/)
    end
  end
end
