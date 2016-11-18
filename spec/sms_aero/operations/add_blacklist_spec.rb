RSpec.describe "operations[:add_blacklist]", "#call" do
  let(:settings)  { { user: "LOGIN", password: "PASSWORD" } }
  let(:client)    { SmsAero.new settings }
  let(:operation) { client.operations[:add_blacklist] }
  let(:params)    { { phone: "+7 (018) 132-4388" } }
  let(:answer)    { { result: "accepted" } }

  before  { stub_request(:any, //).to_return(body: answer.to_json) }
  subject { operation.call(params) }

  context "using ssl via POST:" do
    let(:host)  { "https://gate.smsaero.ru/addblacklist" }
    let(:query) { "answer=json&password=PASSWORD&phone=70181324388&user=LOGIN" }

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
    let(:host)  { "https://gate.smsaero.ru/addblacklist" }
    let(:query) { "answer=json&password=PASSWORD&phone=70181324388&user=LOGIN" }

    before { settings[:use_post] = false }

    it "sends a request" do
      subject
      expect(a_request(:get, "#{host}?#{query}")).to have_been_made
    end
  end

  context "not using ssl:" do
    let(:host)  { "http://gate.smsaero.ru/addblacklist" }
    let(:query) { "answer=json&password=PASSWORD&phone=70181324388&user=LOGIN" }

    before { settings[:use_ssl] = false }

    it "sends a request" do
      subject
      expect(a_request(:post, "#{host}?#{query}")).to have_been_made
    end
  end

  context "with custom user:" do
    let(:host)  { "https://gate.smsaero.ru/addblacklist" }
    let(:query) { "answer=json&password=PASSWORD&phone=70181324388&user=USER" }

    before { params[:user] = "USER" }

    it "sends a request" do
      subject
      expect(a_request(:post, "#{host}?#{query}")).to have_been_made
    end
  end

  context "with custom password:" do
    let(:host)  { "https://gate.smsaero.ru/addblacklist" }
    let(:query) { "answer=json&password=PSWD&phone=70181324388&user=LOGIN" }

    before { params[:password] = "PSWD" }

    it "sends a request" do
      subject
      expect(a_request(:post, "#{host}?#{query}")).to have_been_made
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
