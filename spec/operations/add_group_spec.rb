RSpec.describe SmsAero, "#add_group" do
  let(:settings) { { user: "LOGIN", password: "PASSWORD" } }
  let(:client)   { described_class.new(settings) }
  let(:params)   { { group:  "foobar" } }
  let(:answer)   { { result: "accepted" } }

  before  { stub_request(:any, //).to_return(body: answer.to_json) }
  subject { client.add_group(params) }

  context "using ssl via POST:" do
    let(:url) do
      "https://gate.smsaero.ru/addgroup?" \
      "answer=json&" \
      "group=foobar&" \
      "password=319f4d26e3c536b5dd871bb2c52e3178&" \
      "user=LOGIN"
    end

    it "sends a request" do
      subject
      expect(a_request(:post, url)).to have_been_made
    end

    it "returns success" do
      expect(subject).to be_kind_of SmsAero::Response
      expect(subject.result).to eq "accepted"
    end
  end

  context "via GET:" do
    let(:url) do
      "https://gate.smsaero.ru/addgroup?" \
      "answer=json&" \
      "group=foobar&" \
      "password=319f4d26e3c536b5dd871bb2c52e3178&" \
      "user=LOGIN"
    end

    before { settings[:use_post] = false }

    it "sends a request" do
      subject
      expect(a_request(:get, url)).to have_been_made
    end
  end

  context "not using ssl:" do
    let(:url) do
      "http://gate.smsaero.ru/addgroup?" \
      "answer=json&" \
      "group=foobar&" \
      "password=319f4d26e3c536b5dd871bb2c52e3178&" \
      "user=LOGIN"
    end

    before { settings[:use_ssl] = false }

    it "returns success" do
      expect(subject).to be_kind_of SmsAero::Response
      expect(subject.result).to eq "accepted"
    end
  end

  context "with invalid group:" do
    before { params[:group] = "" }

    it "raises an exception" do
      expect { subject }.to raise_error(StandardError)
    end
  end

  context "without a group:" do
    before { params.delete :group }

    it "raises an exception" do
      expect { subject }.to raise_error(StandardError, /group/)
    end
  end
end
