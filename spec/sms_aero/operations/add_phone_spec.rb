RSpec.describe SmsAero, "#add_phone" do
  let(:settings) { { user: "LOGIN", password: "PASSWORD" } }
  let(:client)   { described_class.new(settings) }
  let(:params)   { { phone:  "+7 (909) 382-84-45" } }
  let(:answer)   { { result: "accepted" } }

  before  { stub_request(:any, //).to_return(body: answer.to_json) }
  subject { client.add_phone(params) }

  context "using ssl via POST:" do
    let(:url) do
      "https://gate.smsaero.ru/addphone?" \
      "answer=json&" \
      "password=319f4d26e3c536b5dd871bb2c52e3178&" \
      "phone=79093828445&" \
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
      "https://gate.smsaero.ru/addphone?" \
      "answer=json&" \
      "password=319f4d26e3c536b5dd871bb2c52e3178&" \
      "phone=79093828445&" \
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
      "http://gate.smsaero.ru/addphone?" \
      "answer=json&" \
      "password=319f4d26e3c536b5dd871bb2c52e3178&" \
      "phone=79093828445&" \
      "user=LOGIN"
    end

    before { settings[:use_ssl] = false }

    it "sends a request" do
      subject
      expect(a_request(:post, url)).to have_been_made
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
    let(:url) do
      "https://gate.smsaero.ru/addphone?" \
      "answer=json&" \
      "fname=joe&" \
      "password=319f4d26e3c536b5dd871bb2c52e3178&" \
      "phone=79093828445&" \
      "user=LOGIN"
    end

    before { params[:fname] = "joe" }

    it "sends a request" do
      subject
      expect(a_request(:post, url)).to have_been_made
    end
  end

  context "with invalid fname:" do
    before { params[:fname] = "" }

    it "raises an exception" do
      expect { subject }.to raise_error(TypeError)
    end
  end

  context "with valid sname:" do
    let(:url) do
      "https://gate.smsaero.ru/addphone?" \
      "answer=json&" \
      "password=319f4d26e3c536b5dd871bb2c52e3178&" \
      "phone=79093828445&" \
      "sname=joe&" \
      "user=LOGIN"
    end

    before { params[:sname] = "joe" }

    it "sends a request" do
      subject
      expect(a_request(:post, url)).to have_been_made
    end
  end

  context "with invalid sname:" do
    before { params[:sname] = "" }

    it "raises an exception" do
      expect { subject }.to raise_error(TypeError)
    end
  end

  context "with valid lname:" do
    let(:url) do
      "https://gate.smsaero.ru/addphone?" \
      "answer=json&" \
      "lname=smith&" \
      "password=319f4d26e3c536b5dd871bb2c52e3178&" \
      "phone=79093828445&" \
      "user=LOGIN"
    end

    before { params[:lname] = "smith" }

    it "sends a request" do
      subject
      expect(a_request(:post, url)).to have_been_made
    end
  end

  context "with invalid lname:" do
    before { params[:lname] = "" }

    it "raises an exception" do
      expect { subject }.to raise_error(TypeError)
    end
  end

  context "with valid group:" do
    let(:url) do
      "https://gate.smsaero.ru/addphone?" \
      "answer=json&" \
      "group=qux&" \
      "password=319f4d26e3c536b5dd871bb2c52e3178&" \
      "phone=79093828445&" \
      "user=LOGIN"
    end

    before { params[:group] = "qux" }

    it "sends a request" do
      subject
      expect(a_request(:post, url)).to have_been_made
    end
  end

  context "with invalid group:" do
    before { params[:group] = "" }

    it "raises an exception" do
      expect { subject }.to raise_error(TypeError)
    end
  end

  context "with valid param:" do
    let(:url) do
      "https://gate.smsaero.ru/addphone?" \
      "answer=json&" \
      "param=qux&" \
      "password=319f4d26e3c536b5dd871bb2c52e3178&" \
      "phone=79093828445&" \
      "user=LOGIN"
    end

    before { params[:param] = "qux" }

    it "sends a request" do
      subject
      expect(a_request(:post, url)).to have_been_made
    end
  end

  context "with invalid param:" do
    before { params[:param] = "" }

    it "raises an exception" do
      expect { subject }.to raise_error(TypeError)
    end
  end

  context "with valid bday:" do
    let(:url) do
      "https://gate.smsaero.ru/addphone?" \
      "answer=json&" \
      "bday=1901-08-17&" \
      "password=319f4d26e3c536b5dd871bb2c52e3178&" \
      "phone=79093828445&" \
      "user=LOGIN"
    end

    before { params[:bday] = Date.parse("1901-08-17") }

    it "sends a request" do
      subject
      expect(a_request(:post, url)).to have_been_made
    end
  end

  context "with invalid bday:" do
    before { params[:bday] = "foo" }

    it "raises an exception" do
      expect { subject }.to raise_error(TypeError, /foo/)
    end
  end
end
