require "spec_helper"

RSpec.describe SmsAero::Future do
  subject { described_class[source] }

  context "time in future:" do
    let(:source) { Time.now + 3600 }

    it "returns UNIX time in seconds" do
      expect(subject).to eq source.to_i.to_s
    end
  end

  context "parseable string for time in future:" do
    let(:time)   { Time.now + 3600 }
    let(:source) { time.strftime "%Y-%m-%d %H:%M:%S" }

    it "returns UNIX time in seconds" do
      expect(subject).to eq time.to_i.to_s
    end
  end

  context "time in the past:" do
    let(:source) { Time.now - 3600 }

    it "fails" do
      expect { subject }.to raise_error(StandardError)
    end
  end

  context "not a time:" do
    let(:source) { "foobar" }

    it "fails" do
      expect { subject }.to raise_error(StandardError, /foobar/)
    end
  end
end
