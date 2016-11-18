RSpec.describe "operations[:add_phone]", "#call" do
  let(:settings)  { { user: "LOGIN", password: "PASSWORD" } }
  let(:client)    { SmsAero.new settings }
  let(:operation) { client.operations[:add_phone] }
  let(:params)    { { phone:  "+7 (909) 382-84-45" } }
  let(:answer)    { { result: "accepted" } }

  before  { stub_request(:any, //).to_return(body: answer.to_json) }
  subject { operation.call(params) }

  context "using ssl via POST:" do
    let(:host)  { "https://gate.smsaero.ru/addphone" }
    let(:query) { "answer=json&password=PASSWORD&phone=79093828445&user=LOGIN" }

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
    let(:host)  { "https://gate.smsaero.ru/addphone" }
    let(:query) { "answer=json&password=PASSWORD&phone=79093828445&user=LOGIN" }

    before { settings[:use_post] = false }

    it "sends a request" do
      subject
      expect(a_request(:get, "#{host}?#{query}")).to have_been_made
    end
  end

  context "not using ssl:" do
    let(:host)  { "http://gate.smsaero.ru/addphone" }
    let(:query) { "answer=json&password=PASSWORD&phone=79093828445&user=LOGIN" }

    before { settings[:use_ssl] = false }

    it "sends a request" do
      subject
      expect(a_request(:post, "#{host}?#{query}")).to have_been_made
    end
  end

  context "with custom user:" do
    let(:host)  { "https://gate.smsaero.ru/addphone" }
    let(:query) { "answer=json&password=PASSWORD&phone=79093828445&user=USER" }

    before { params[:user] = "USER" }

    it "sends a request" do
      subject
      expect(a_request(:post, "#{host}?#{query}")).to have_been_made
    end
  end

  context "with custom password:" do
    let(:host)  { "https://gate.smsaero.ru/addphone" }
    let(:query) { "answer=json&password=PSWD&phone=79093828445&user=LOGIN" }

    before { params[:password] = "PSWD" }

    it "sends a request" do
      subject
      expect(a_request(:post, "#{host}?#{query}")).to have_been_made
    end
  end

  context "with invalid phone:" do
    before { params[:phone] = "1324" }

    it "raises an exception" do
      expect { subject }.to raise_error(TypeError, /1324/)
    end
  end

  context "without a phone:" do
    before { params.delete :phone }

    it "raises an exception" do
      expect { subject }.to raise_error(KeyError)
    end
  end

  context "with valid fname:" do
    let(:host)  { "https://gate.smsaero.ru/addphone" }
    let(:query) do
      "answer=json&fname=joe&password=PASSWORD&phone=79093828445&user=LOGIN"
    end

    before { params[:fname] = "joe" }

    it "sends a request" do
      subject
      expect(a_request(:post, "#{host}?#{query}")).to have_been_made
    end
  end

  context "with invalid fname:" do
    before { params[:fname] = "" }

    it "raises an exception" do
      expect { subject }.to raise_error(TypeError)
    end
  end

  context "with valid sname:" do
    let(:host)  { "https://gate.smsaero.ru/addphone" }
    let(:query) do
      "answer=json&password=PASSWORD&phone=79093828445&sname=joe&user=LOGIN"
    end

    before { params[:sname] = "joe" }

    it "sends a request" do
      subject
      expect(a_request(:post, "#{host}?#{query}")).to have_been_made
    end
  end

  context "with invalid sname:" do
    before { params[:sname] = "" }

    it "raises an exception" do
      expect { subject }.to raise_error(TypeError)
    end
  end

  context "with valid lname:" do
    let(:host)  { "https://gate.smsaero.ru/addphone" }
    let(:query) do
      "answer=json&lname=smith&password=PASSWORD&phone=79093828445&user=LOGIN"
    end

    before { params[:lname] = "smith" }

    it "sends a request" do
      subject
      expect(a_request(:post, "#{host}?#{query}")).to have_been_made
    end
  end

  context "with invalid lname:" do
    before { params[:lname] = "" }

    it "raises an exception" do
      expect { subject }.to raise_error(TypeError)
    end
  end

  context "with valid param:" do
    let(:host)  { "https://gate.smsaero.ru/addphone" }
    let(:query) do
      "answer=json&param=qux&password=PASSWORD&phone=79093828445&user=LOGIN"
    end

    before { params[:param] = "qux" }

    it "sends a request" do
      subject
      expect(a_request(:post, "#{host}?#{query}")).to have_been_made
    end
  end

  context "with invalid param:" do
    before { params[:param] = "" }

    it "raises an exception" do
      expect { subject }.to raise_error(TypeError)
    end
  end

  context "with valid bday:" do
    let(:host)  { "https://gate.smsaero.ru/addphone" }
    let(:query) do
      "answer=json&bday=1901-08-17&password=PASSWORD&" \
      "phone=79093828445&user=LOGIN"
    end

    before { params[:bday] = Date.parse("1901-08-17") }

    it "sends a request" do
      subject
      expect(a_request(:post, "#{host}?#{query}")).to have_been_made
    end
  end

  context "with invalid bday:" do
    before { params[:bday] = "foo" }

    it "raises an exception" do
      expect { subject }.to raise_error(TypeError, /foo/)
    end
  end
end
