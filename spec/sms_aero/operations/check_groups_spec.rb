RSpec.describe SmsAero, "#check_groups" do
  let(:settings) { { user: "LOGIN", password: "PASSWORD" } }
  let(:client)   { described_class.new(settings) }
  let(:params)   { { foo: "bar" } }
  let(:answer)   { { result: "accepted", reason: %w(customers employee) } }

  before  { stub_request(:any, //).to_return(body: answer.to_json) }
  subject { client.check_groups(params) }

  context "using ssl via POST:" do
    let(:url) do
      "https://gate.smsaero.ru/checkgroup?" \
      "answer=json&" \
      "password=319f4d26e3c536b5dd871bb2c52e3178&" \
      "user=LOGIN"
    end

    it "sends a request" do
      subject
      expect(a_request(:post, url)).to have_been_made
    end

    it "returns success" do
      expect(subject.result).to eq "accepted"
      expect(subject.channels).to eq %w(customers employee)
    end
  end

  context "via GET:" do
    let(:url) do
      "https://gate.smsaero.ru/checkgroup?" \
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
      "http://gate.smsaero.ru/checkgroup?" \
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
