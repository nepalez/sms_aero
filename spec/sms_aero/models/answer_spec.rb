require "spec_helper"

RSpec.describe SmsAero::Answer do
  let(:source) { { result: "rejected", reason: "whatever", foo: "bar" } }

  subject { described_class[source] }
  it { is_expected.to eq result: "rejected", reason: "whatever" }

  context "without result:" do
    before { source.delete :result }
    its(:result) { is_expected.to eq "accepted" }
  end

  context "without reason:" do
    before { source.delete :reason }
    its(:reason) { is_expected.to be_nil }
  end
end