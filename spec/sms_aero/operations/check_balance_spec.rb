RSpec.describe SmsAero, "#check_balance" do
  let(:settings) { { user: "LOGIN", password: "PASSWORD" } }
  let(:client)   { described_class.new(settings) }
  let(:answer)   { { result: "accepted", balance: "99.5", foo: "bar" } }
  let(:params)   { { foo: "bar" } }

  before  { stub_request(:any, //).to_return(body: answer.to_json) }
  subject { client.check_balance(params) }

  context "using ssl via POST:" do
    let(:host)  { "https://gate.smsaero.ru/balance" }
    let(:query) { "answer=json&password=PASSWORD&user=LOGIN" }

    it "sends a request" do
      subject
      expect(a_request(:post, "#{host}?#{query}")).to have_been_made
    end

    it "returns success" do
      expect(subject).to be_kind_of SmsAero::Answer

      expect(subject.result).to  eq "accepted"
      expect(subject.balance).to eq 99.5
    end
  end

  context "via GET:" do
    let(:host)  { "https://gate.smsaero.ru/balance" }
    let(:query) { "answer=json&password=PASSWORD&user=LOGIN" }

    before { settings[:use_post] = false }

    it "sends a request" do
      subject
      expect(a_request(:get, "#{host}?#{query}")).to have_been_made
    end
  end

  context "not using ssl:" do
    let(:host)  { "http://gate.smsaero.ru/balance" }
    let(:query) { "answer=json&password=PASSWORD&user=LOGIN" }

    before { settings[:use_ssl] = false }

    it "sends a request" do
      subject
      expect(a_request(:post, "#{host}?#{query}")).to have_been_made
    end
  end

  context "with custom user:" do
    let(:host)  { "https://gate.smsaero.ru/balance" }
    let(:query) { "answer=json&password=PASSWORD&user=USER" }

    before { params[:user] = "USER" }

    it "sends a request" do
      subject
      expect(a_request(:post, "#{host}?#{query}")).to have_been_made
    end
  end

  context "with custom password:" do
    let(:host)  { "https://gate.smsaero.ru/balance" }
    let(:query) { "answer=json&password=PSWD&user=LOGIN" }

    before { params[:password] = "PSWD" }

    it "sends a request" do
      subject
      expect(a_request(:post, "#{host}?#{query}")).to have_been_made
    end
  end

  context "using ssl via POST:" do
    let(:answer) { { result: "rejected" } }

    it "returns result" do
      expect(subject).to be_kind_of SmsAero::Answer

      expect(subject.result).to  eq "rejected"
      expect(subject).not_to respond_to :balance
    end
  end
end
