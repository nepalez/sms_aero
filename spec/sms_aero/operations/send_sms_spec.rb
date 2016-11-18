RSpec.describe "operations[:send_sms]", "#call" do
  let(:settings)  { { user: "BAZ", password: "QUX" } }
  let(:client)    { SmsAero.new settings }
  let(:operation) { client.operations[:send_sms] }
  let(:params)    { { text: "Hi", to: "+7 (909) 382-84-45" } }
  let(:answer)    { { id: 3898, result: "accepted" } }

  before  { stub_request(:any, //).to_return(body: answer.to_json) }
  subject { operation.call(params) }

  context "using ssl via POST:" do
    let(:host)  { "https://gate.smsaero.ru/send" }
    let(:query) do
      "answer=json&password=QUX&text=Hi&to=79093828445&type=2&user=BAZ"
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
    let(:host)  { "https://gate.smsaero.ru/send" }
    let(:query) do
      "answer=json&password=QUX&text=Hi&to=79093828445&type=2&user=BAZ"
    end

    before { settings[:use_post] = false }

    it "sends a request" do
      subject
      expect(a_request(:get, "#{host}?#{query}")).to have_been_made
    end
  end

  context "not using ssl:" do
    let(:host)  { "http://gate.smsaero.ru/send" }
    let(:query) do
      "answer=json&password=QUX&text=Hi&to=79093828445&type=2&user=BAZ"
    end

    before { settings[:use_ssl] = false }

    it "sends a request" do
      subject
      expect(a_request(:post, "#{host}?#{query}")).to have_been_made
    end
  end

  context "with custom user:" do
    let(:host)  { "https://gate.smsaero.ru/send" }
    let(:query) do
      "answer=json&password=QUX&text=Hi&to=79093828445&type=2&user=USER"
    end

    before { params[:user] = "USER" }

    it "sends a request" do
      subject
      expect(a_request(:post, "#{host}?#{query}")).to have_been_made
    end
  end

  context "with custom password:" do
    let(:host)  { "https://gate.smsaero.ru/send" }
    let(:query) do
      "answer=json&password=PSWD&text=Hi&to=79093828445&type=2&user=BAZ"
    end

    before { params[:password] = "PSWD" }

    it "sends a request" do
      subject
      expect(a_request(:post, "#{host}?#{query}")).to have_been_made
    end
  end

  context "with invalid phone:" do
    before { params[:to] = "1324" }

    it "raises an exception" do
      expect { subject }.to raise_error(TypeError, /1324/)
    end
  end

  context "without a phone:" do
    before { params.delete :to }

    it "raises an exception" do
      expect { subject }.to raise_error(KeyError)
    end
  end

  context "with valid date:" do
    let(:host)  { "https://gate.smsaero.ru/send" }
    let(:query) do
      "answer=json&date=4122133200&password=QUX&text=Hi&to=79093828445&type=2&user=BAZ"
    end

    before { params[:date] = Date.parse("2100-08-17") }

    it "sends a request" do
      subject
      expect(a_request(:post, "#{host}?#{query}")).to have_been_made
    end
  end

  context "with old date:" do
    before { params[:date] = (Date.today - 1) }

    it "raises an exception" do
      expect { subject }.to raise_error(TypeError)
    end
  end

  context "with invalid date:" do
    before { params[:date] = "foo" }

    it "raises an exception" do
      expect { subject }.to raise_error(TypeError, /foo/)
    end
  end

  context "with custom digital:" do
    let(:host)  { "https://gate.smsaero.ru/send" }
    let(:query) do
      "answer=json&digital=1&password=QUX&text=Hi&to=79093828445&user=BAZ"
    end

    before { params[:digital] = true }

    it "sends a request" do
      subject
      expect(a_request(:post, "#{host}?#{query}")).to have_been_made
    end
  end

  context "with valid type:" do
    let(:host)  { "https://gate.smsaero.ru/send" }
    let(:query) do
      "answer=json&password=QUX&text=Hi&to=79093828445&type=3&user=BAZ"
    end

    before { params[:type] = 3 }

    it "sends a request" do
      subject
      expect(a_request(:post, "#{host}?#{query}")).to have_been_made
    end
  end

  context "with invalid type:" do
    before { params[:type] = 11 }

    it "raises an exception" do
      expect { subject }.to raise_error(TypeError, /11/)
    end
  end

  context "with test:" do
    let(:host)  { "https://gate.smsaero.ru/testsend" }
    let(:query) do
      "answer=json&password=QUX&text=Hi&to=79093828445&type=2&user=BAZ"
    end

    before { params[:test] = true }

    it "sends a request" do
      subject
      expect(a_request(:post, "#{host}?#{query}")).to have_been_made
    end
  end
end
