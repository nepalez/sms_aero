RSpec.describe SmsAero, "#add_blacklist" do
  let(:settings) { { user: "LOGIN", password: "PASSWORD" } }
  let(:client)   { described_class.new(settings) }
  let(:params)   { { phone: "+7 (018) 132-4388" } }
  let(:answer)   { { result: "accepted" } }

  before  { stub_request(:any, //).to_return(body: answer.to_json) }
  subject { client.add_blacklist(params) }

  context "using ssl via POST:" do
    let(:url) do
      "https://gate.smsaero.ru/addblacklist?" \
      "answer=json&" \
      "password=319f4d26e3c536b5dd871bb2c52e3178&" \
      "phone=70181324388&" \
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
      "https://gate.smsaero.ru/addblacklist?" \
      "answer=json&" \
      "password=319f4d26e3c536b5dd871bb2c52e3178&" \
      "phone=70181324388&" \
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
      "http://gate.smsaero.ru/addblacklist?" \
      "answer=json&" \
      "password=319f4d26e3c536b5dd871bb2c52e3178&" \
      "phone=70181324388&" \
      "user=LOGIN"
    end

    before { settings[:use_ssl] = false }

    it "sends a request via http" do
      subject
      expect(a_request(:post, url)).to have_been_made
    end
  end

  context "with invalid phone:" do
    before { params[:phone] = "foobar23" }

    it "raises an exception" do
      expect { subject }.to raise_error(TypeError, /23/)
    end
  end

  context "without a phone:" do
    before { params.delete :phone }

    it "raises an exception" do
      expect { subject }.to raise_error(KeyError)
    end
  end
end
