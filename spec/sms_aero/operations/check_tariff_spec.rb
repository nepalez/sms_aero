RSpec.describe "operations[:check_tariff]", "#call" do
  let(:settings)  { { user: "LOGIN", password: "PASSWORD" } }
  let(:client)    { SmsAero.new settings }
  let(:operation) { client.operations[:check_tariff] }
  let(:params)    { {} }
  let(:answer) { { result: "accepted", reason: { "Direct channel": "1.75" } } }

  before  { stub_request(:any, //).to_return(body: answer.to_json) }
  subject { operation.call(params) }

  context "using ssl via POST:" do
    let(:host)  { "https://gate.smsaero.ru/checktarif" }
    let(:query) { "answer=json&password=PASSWORD&user=LOGIN" }

    it "sends a request" do
      subject
      expect(a_request(:post, "#{host}?#{query}")).to have_been_made
    end

    it "returns statuses" do
      expect(subject.result).to eq "accepted"
      expect(subject.tariff).to eq direct: 1.75
    end
  end

  context "via GET:" do
    let(:host)  { "https://gate.smsaero.ru/checktarif" }
    let(:query) { "answer=json&password=PASSWORD&user=LOGIN" }

    before { settings[:use_post] = false }

    it "sends a request" do
      subject
      expect(a_request(:get, "#{host}?#{query}")).to have_been_made
    end
  end

  context "not using ssl:" do
    let(:host)  { "http://gate.smsaero.ru/checktarif" }
    let(:query) { "answer=json&password=PASSWORD&user=LOGIN" }

    before { settings[:use_ssl] = false }

    it "sends a request" do
      subject
      expect(a_request(:post, "#{host}?#{query}")).to have_been_made
    end
  end

  context "with custom user:" do
    let(:host)  { "https://gate.smsaero.ru/checktarif" }
    let(:query) { "answer=json&password=PASSWORD&user=USER" }

    before { params[:user] = "USER" }

    it "sends a request" do
      subject
      expect(a_request(:post, "#{host}?#{query}")).to have_been_made
    end
  end

  context "with custom password:" do
    let(:host)  { "https://gate.smsaero.ru/checktarif" }
    let(:query) { "answer=json&password=PSWD&user=LOGIN" }

    before { params[:password] = "PSWD" }

    it "sends a request" do
      subject
      expect(a_request(:post, "#{host}?#{query}")).to have_been_made
    end
  end
end
