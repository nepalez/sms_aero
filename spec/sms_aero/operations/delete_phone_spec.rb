RSpec.describe "operations[:delete_phone]", "#call" do
  let(:settings)  { { user: "LOGIN", password: "PASSWORD" } }
  let(:client)    { SmsAero.new settings }
  let(:operation) { client.operations[:delete_phone] }
  let(:params)    { { group:  "foo", phone: "+7(002)034-5678" } }
  let(:answer)    { { result: "accepted" } }

  before  { stub_request(:any, //).to_return(body: answer.to_json) }
  subject { operation.call(params) }

  context "using ssl via POST:" do
    let(:host)  { "https://gate.smsaero.ru/delphone" }
    let(:query) do
      "answer=json&group=foo&password=PASSWORD&phone=70020345678&user=LOGIN"
    end

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
    let(:host)  { "https://gate.smsaero.ru/delphone" }
    let(:query) do
      "answer=json&group=foo&password=PASSWORD&phone=70020345678&user=LOGIN"
    end

    before { settings[:use_post] = false }

    it "sends a request" do
      subject
      expect(a_request(:get, "#{host}?#{query}")).to have_been_made
    end
  end

  context "not using ssl:" do
    let(:host)  { "http://gate.smsaero.ru/delphone" }
    let(:query) do
      "answer=json&group=foo&password=PASSWORD&phone=70020345678&user=LOGIN"
    end

    before { settings[:use_ssl] = false }

    it "sends a request" do
      subject
      expect(a_request(:post, "#{host}?#{query}")).to have_been_made
    end
  end

  context "with custom user:" do
    let(:host)  { "https://gate.smsaero.ru/delphone" }
    let(:query) do
      "answer=json&group=foo&password=PASSWORD&phone=70020345678&user=USER"
    end

    before { params[:user] = "USER" }

    it "sends a request" do
      subject
      expect(a_request(:post, "#{host}?#{query}")).to have_been_made
    end
  end

  context "with custom password:" do
    let(:host)  { "https://gate.smsaero.ru/delphone" }
    let(:query) do
      "answer=json&group=foo&password=PSWD&phone=70020345678&user=LOGIN"
    end

    before { params[:password] = "PSWD" }

    it "sends a request" do
      subject
      expect(a_request(:post, "#{host}?#{query}")).to have_been_made
    end
  end

  context "without a group:" do
    let(:host)  { "https://gate.smsaero.ru/delphone" }
    let(:query) { "answer=json&password=PASSWORD&phone=70020345678&user=LOGIN" }

    before { params.delete :group }

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

  context "with invalid phone:" do
    before { params[:phone] = "234" }

    it "raises an exception" do
      expect { subject }.to raise_error(TypeError, /234/)
    end
  end

  context "without a phone:" do
    before { params.delete :phone }

    it "raises an exception" do
      expect { subject }.to raise_error(KeyError)
    end
  end
end
