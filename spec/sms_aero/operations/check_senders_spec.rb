RSpec.describe "operations[:check_senders]", "#call" do
  let(:settings)  { { user: "LOGIN", password: "PASSWORD" } }
  let(:client)    { SmsAero.new settings }
  let(:operation) { client.operations[:check_senders] }
  let(:params)    { { sign: "baz", foo: "bar" } }
  let(:answer)    { { data: %w(peter paul) } }

  before  { stub_request(:any, //).to_return(body: answer.to_json) }
  subject { operation.call(params) }

  context "using ssl via POST:" do
    let(:host)  { "https://gate.smsaero.ru/senders" }
    let(:query) { "answer=json&password=PASSWORD&sign=baz&user=LOGIN" }

    it "sends a request" do
      subject
      expect(a_request(:post, "#{host}?#{query}")).to have_been_made
    end

    it "returns success" do
      expect(subject).to be_kind_of SmsAero::Answer
      expect(subject.data).to eq %w(peter paul)
    end
  end

  context "via GET:" do
    let(:host)  { "https://gate.smsaero.ru/senders" }
    let(:query) { "answer=json&password=PASSWORD&sign=baz&user=LOGIN" }

    before { settings[:use_post] = false }

    it "sends a request" do
      subject
      expect(a_request(:get, "#{host}?#{query}")).to have_been_made
    end
  end

  context "not using ssl:" do
    let(:host)  { "http://gate.smsaero.ru/senders" }
    let(:query) { "answer=json&password=PASSWORD&sign=baz&user=LOGIN" }

    before { settings[:use_ssl] = false }

    it "sends a request" do
      subject
      expect(a_request(:post, "#{host}?#{query}")).to have_been_made
    end
  end

  context "with custom user:" do
    let(:host)  { "https://gate.smsaero.ru/senders" }
    let(:query) { "answer=json&password=PASSWORD&sign=baz&user=USER" }

    before { params[:user] = "USER" }

    it "sends a request" do
      subject
      expect(a_request(:post, "#{host}?#{query}")).to have_been_made
    end
  end

  context "with custom password:" do
    let(:host)  { "https://gate.smsaero.ru/senders" }
    let(:query) { "answer=json&password=PSWD&sign=baz&user=LOGIN" }

    before { params[:password] = "PSWD" }

    it "sends a request" do
      subject
      expect(a_request(:post, "#{host}?#{query}")).to have_been_made
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
