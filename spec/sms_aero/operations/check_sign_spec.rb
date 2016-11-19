RSpec.describe SmsAero, "#check_sign" do
  let(:settings) { { user: "LOGIN", password: "PASSWORD" } }
  let(:client)   { described_class.new(settings) }
  let(:params)   { { sign: "foo" } }
  let(:answer)   { %w(accepted pending) }

  before  { stub_request(:any, //).to_return(body: answer.to_json) }
  subject { client.check_sign(params) }

  context "using ssl via POST:" do
    let(:host)  { "https://gate.smsaero.ru/sign" }
    let(:query) { "answer=json&password=PASSWORD&sign=foo&user=LOGIN" }

    it "sends a request" do
      subject
      expect(a_request(:post, "#{host}?#{query}")).to have_been_made
    end

    it "returns statuses" do
      expect(subject.statuses).to eq %w(accepted pending)
    end
  end

  context "via GET:" do
    let(:host)  { "https://gate.smsaero.ru/sign" }
    let(:query) { "answer=json&password=PASSWORD&sign=foo&user=LOGIN" }

    before { settings[:use_post] = false }

    it "sends a request" do
      subject
      expect(a_request(:get, "#{host}?#{query}")).to have_been_made
    end
  end

  context "not using ssl:" do
    let(:host)  { "http://gate.smsaero.ru/sign" }
    let(:query) { "answer=json&password=PASSWORD&sign=foo&user=LOGIN" }

    before { settings[:use_ssl] = false }

    it "sends a request" do
      subject
      expect(a_request(:post, "#{host}?#{query}")).to have_been_made
    end
  end

  context "with custom user:" do
    let(:host)  { "https://gate.smsaero.ru/sign" }
    let(:query) { "answer=json&password=PASSWORD&sign=foo&user=USER" }

    before { params[:user] = "USER" }

    it "sends a request" do
      subject
      expect(a_request(:post, "#{host}?#{query}")).to have_been_made
    end
  end

  context "with custom password:" do
    let(:host)  { "https://gate.smsaero.ru/sign" }
    let(:query) { "answer=json&password=PSWD&sign=foo&user=LOGIN" }

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
end
