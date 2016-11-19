RSpec.describe SmsAero, "#check_tariff" do
  let(:settings) { { user: "LOGIN", password: "PASSWORD" } }
  let(:client)   { described_class.new(settings) }
  let(:params)   { {} }
  let(:answer) { { result: "accepted", reason: { "Direct channel": "1.75" } } }

  before  { stub_request(:any, //).to_return(body: answer.to_json) }
  subject { client.check_tariff(params) }

  context "using ssl via POST:" do
    let(:url) do
      "https://gate.smsaero.ru/checktarif?" \
      "answer=json&" \
      "password=319f4d26e3c536b5dd871bb2c52e3178&" \
      "user=LOGIN"
    end

    it "sends a request" do
      subject
      expect(a_request(:post, url)).to have_been_made
    end

    it "returns statuses" do
      expect(subject.result).to eq "accepted"
      expect(subject.tariff).to eq direct: 1.75
    end
  end

  context "via GET:" do
    let(:url) do
      "https://gate.smsaero.ru/checktarif?" \
      "answer=json&" \
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
      "http://gate.smsaero.ru/checktarif?" \
      "answer=json&" \
      "password=319f4d26e3c536b5dd871bb2c52e3178&" \
      "user=LOGIN"
    end

    before { settings[:use_ssl] = false }

    it "sends a request" do
      subject
      expect(a_request(:post, url)).to have_been_made
    end
  end
end
