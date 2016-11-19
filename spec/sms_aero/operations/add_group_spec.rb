RSpec.describe SmsAero, "#add_group" do
  let(:settings) { { user: "LOGIN", password: "PASSWORD" } }
  let(:client)   { described_class.new(settings) }
  let(:params)   { { group:  "foobar" } }
  let(:answer)   { { result: "accepted" } }

  before  { stub_request(:any, //).to_return(body: answer.to_json) }
  subject { client.add_group(params) }

  context "using ssl via POST:" do
    let(:host)  { "https://gate.smsaero.ru/addgroup" }
    let(:query) { "answer=json&group=foobar&password=PASSWORD&user=LOGIN" }

    it "sends a request" do
      subject
      expect(a_request(:post, "#{host}?#{query}")).to have_been_made
    end

    it "returns success" do
      expect(subject).to be_kind_of SmsAero::Answer
      expect(subject.result).to eq "accepted"
    end
  end

  context "via GET:" do
    let(:host)  { "https://gate.smsaero.ru/addgroup" }
    let(:query) { "answer=json&group=foobar&password=PASSWORD&user=LOGIN" }

    before { settings[:use_post] = false }

    it "sends a request" do
      subject
      expect(a_request(:get, "#{host}?#{query}")).to have_been_made
    end
  end

  context "not using ssl:" do
    let(:host)  { "http://gate.smsaero.ru/addgroup" }
    let(:query) { "answer=json&group=foobar&password=PASSWORD&user=LOGIN" }

    before { settings[:use_ssl] = false }

    it "sends a request" do
      subject
      expect(a_request(:post, "#{host}?#{query}")).to have_been_made
    end
  end

  context "with custom user:" do
    let(:host)  { "https://gate.smsaero.ru/addgroup" }
    let(:query) { "answer=json&group=foobar&password=PASSWORD&user=USER" }

    before { params[:user] = "USER" }

    it "sends a request" do
      subject
      expect(a_request(:post, "#{host}?#{query}")).to have_been_made
    end
  end

  context "with custom password:" do
    let(:host)  { "https://gate.smsaero.ru/addgroup" }
    let(:query) { "answer=json&group=foobar&password=PSWD&user=LOGIN" }

    before { params[:password] = "PSWD" }

    it "sends a request" do
      subject
      expect(a_request(:post, "#{host}?#{query}")).to have_been_made
    end
  end

  context "with invalid group:" do
    before { params[:group] = "" }

    it "raises an exception" do
      expect { subject }.to raise_error(TypeError)
    end
  end

  context "without a group:" do
    before { params.delete :group }

    it "raises an exception" do
      expect { subject }.to raise_error(KeyError)
    end
  end
end
