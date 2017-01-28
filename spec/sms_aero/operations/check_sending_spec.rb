RSpec.describe SmsAero, "#check_sending" do
  let(:settings) { { user: "LOGIN", password: "PASSWORD" } }
  let(:client)   { described_class.new(settings) }
  let(:params)   { { id: "foobar" } }
  let(:answer)   { { result: "accepted" } }

  before  { stub_request(:any, //).to_return(body: answer.to_json) }
  subject { client.check_sending(params) }

  context "using ssl via POST:" do
    let(:url) do
      "https://gate.smsaero.ru/checksending?" \
      "answer=json&" \
      "id=foobar&" \
      "password=319f4d26e3c536b5dd871bb2c52e3178&" \
      "user=LOGIN"
    end

    it "sends a request" do
      subject
      expect(a_request(:post, url)).to have_been_made
    end

    it "returns success" do
      expect(subject).to be_kind_of SmsAero::Answer
      expect(subject.result).to eq "accepted"
    end
  end

  context "via GET:" do
    let(:url) do
      "https://gate.smsaero.ru/checksending?" \
      "answer=json&" \
      "id=foobar&" \
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
      "http://gate.smsaero.ru/checksending?" \
      "answer=json&" \
      "id=foobar&" \
      "password=319f4d26e3c536b5dd871bb2c52e3178&" \
      "user=LOGIN"
    end

    before { settings[:use_ssl] = false }

    it "sends a request" do
      subject
      expect(a_request(:post, url)).to have_been_made
    end
  end

  context "with invalid id:" do
    before { params[:id] = "" }

    it "raises an exception" do
      expect { subject }.to raise_error(TypeError)
    end
  end

  context "without a id:" do
    before { params.delete :id }

    it "raises an exception" do
      expect { subject }.to raise_error(ArgumentError)
    end
  end
end
