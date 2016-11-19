RSpec.describe SmsAero, "#check_senders" do
  let(:settings) { { user: "LOGIN", password: "PASSWORD" } }
  let(:client)   { described_class.new(settings) }
  let(:params)   { { sign: "baz", foo: "bar" } }
  let(:answer)   { { data: %w(peter paul) } }

  before  { stub_request(:any, //).to_return(body: answer.to_json) }
  subject { client.check_senders(params) }

  context "using ssl via POST:" do
    let(:url) do
      "https://gate.smsaero.ru/senders?" \
      "answer=json&" \
      "password=319f4d26e3c536b5dd871bb2c52e3178&" \
      "sign=baz&" \
      "user=LOGIN"
    end

    it "sends a request" do
      subject
      expect(a_request(:post, url)).to have_been_made
    end

    it "returns success" do
      expect(subject).to be_kind_of SmsAero::Answer
      expect(subject.data).to eq %w(peter paul)
    end
  end

  context "via GET:" do
    let(:url) do
      "https://gate.smsaero.ru/senders?" \
      "answer=json&" \
      "password=319f4d26e3c536b5dd871bb2c52e3178&" \
      "sign=baz&" \
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
      "http://gate.smsaero.ru/senders?" \
      "answer=json&" \
      "password=319f4d26e3c536b5dd871bb2c52e3178&" \
      "sign=baz&" \
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
      expect { subject }.to raise_error(KeyError)
    end
  end

  context "when server reported an error:" do
    let(:answer) { { result: "rejected", reason: "wrong request" } }

    it "returns success" do
      expect(subject).to be_kind_of SmsAero::Answer
      expect(subject.result).to eq "rejected"
      expect(subject.reason).to eq "wrong request"
    end
  end
end
