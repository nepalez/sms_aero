RSpec.describe SmsAero, "#check_balance" do
  let(:settings) { { user: "LOGIN", password: "PASSWORD" } }
  let(:client)   { described_class.new(settings) }
  let(:answer)   { { result: "accepted", balance: "99.5", foo: "bar" } }
  let(:params)   { { foo: "bar" } }

  before  { stub_request(:any, //).to_return(body: answer.to_json) }
  subject { client.check_balance(params) }

  context "using ssl via POST:" do
    let(:url) do
      "https://gate.smsaero.ru/balance?" \
      "answer=json&" \
      "password=319f4d26e3c536b5dd871bb2c52e3178&" \
      "user=LOGIN"
    end

    it "sends a request" do
      subject
      expect(a_request(:post, url)).to have_been_made
    end

    it "returns success" do
      expect(subject).to be_kind_of SmsAero::Response

      expect(subject.result).to  eq "accepted"
      expect(subject.balance).to eq 99.5
    end
  end

  context "via GET:" do
    let(:url) do
      "https://gate.smsaero.ru/balance?" \
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
      "http://gate.smsaero.ru/balance?" \
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

  context "using ssl via POST:" do
    let(:answer) { { result: "rejected" } }

    it "returns result" do
      expect(subject).to be_kind_of SmsAero::Response
      expect(subject.result).to eq "rejected"
    end
  end
end
