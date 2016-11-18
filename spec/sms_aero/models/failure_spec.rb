require "spec_helper"

RSpec.describe SmsAero::Failure do
  let(:source) { { result: "accepted", reason: "whatever", foo: "bar" } }

  subject { described_class[source] }
  it { is_expected.to eq result: "accepted", reason: "whatever" }
  its(:success?) { is_expected.to eq false }

  context "without result:" do
    before { source.delete :result }
    its(:result) { is_expected.to eq "rejected" }
  end

  context "without reason:" do
    before { source.delete :reason }
    its(:reason) { is_expected.to be_nil }
  end
end
