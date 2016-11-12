require "spec_helper"

RSpec.describe SmsAero::Types::Digital do
  subject { described_class[source] }

  context "false:" do
    let(:source) { false }
    it { is_expected.to eq 0 }
  end

  context "true:" do
    let(:source) { true }
    it { is_expected.to eq 1 }
  end
end
