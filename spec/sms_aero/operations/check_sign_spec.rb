RSpec.describe SmsAero, "#check_sign" do
  let(:settings) { { user: "LOGIN", password: "PASSWORD" } }
  let(:client)   { described_class.new(settings) }
  let(:params)   { { sign: "foo" } }
  let(:answer)   { %w(accepted pending) }

  before  { stub_request(:any, //).to_return(body: answer.to_json) }
  subject { client.check_sign(params) }

  context "using ssl via POST:" do
    let(:url) do
      "https://gate.smsaero.ru/sign?" \
      "answer=json&" \
      "password=319f4d26e3c536b5dd871bb2c52e3178&" \
      "sign=foo&" \
      "user=LOGIN"
    end

    it "sends a request" do
      subject
      expect(a_request(:post, url)).to have_been_made
    end

    it "returns statuses" do
      expect(subject.statuses).to eq %w(accepted pending)
    end
  end

  context "via GET:" do
    let(:url) do
      "https://gate.smsaero.ru/sign?" \
      "answer=json&" \
      "password=319f4d26e3c536b5dd871bb2c52e3178&" \
      "sign=foo&" \
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
      "http://gate.smsaero.ru/sign?" \
      "answer=json&" \
      "password=319f4d26e3c536b5dd871bb2c52e3178&" \
      "sign=foo&" \
      "user=LOGIN"
    end

    before { settings[:use_ssl] = false }

    it "sends a request" do
      subject
      expect(a_request(:post, url)).to have_been_made
    end
  end

  context "with invalid sign:" do
    before { params[:sign] = "" }

    it "raises an exception" do
      expect { subject }.to raise_error(TypeError)
    end
  end

  context "without a sign:" do
    before { params.delete :sign }

    it "raises an exception" do
      expect { subject }.to raise_error(ArgumentError)
    end
  end
end
