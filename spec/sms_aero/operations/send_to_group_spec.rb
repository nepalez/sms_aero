RSpec.describe SmsAero, "#send_to_group" do
  let(:settings) { { user: "BAZ", password: "QUX" } }
  let(:client)   { described_class.new(settings) }
  let(:params)   { { text: "Hi", from: "Qux" } }
  let(:answer)   { { id: 3898, result: "accepted" } }

  before  { stub_request(:any, //).to_return(body: answer.to_json) }
  subject { client.send_to_group(params) }

  context "using ssl via POST:" do
    let(:url) do
      "https://gate.smsaero.ru/sendtogroup?" \
      "answer=json&" \
      "from=Qux&" \
      "group=all&" \
      "password=9d1e4709d6a41407ab34cf99c7085f79&" \
      "text=Hi&" \
      "type=2&" \
      "user=BAZ"
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
      "https://gate.smsaero.ru/sendtogroup?" \
      "answer=json&" \
      "from=Qux&" \
      "group=all&" \
      "password=9d1e4709d6a41407ab34cf99c7085f79&" \
      "text=Hi&" \
      "type=2&" \
      "user=BAZ"
    end

    before { settings[:use_post] = false }

    it "sends a request" do
      subject
      expect(a_request(:get, url)).to have_been_made
    end
  end

  context "not using ssl:" do
    let(:url) do
      "http://gate.smsaero.ru/sendtogroup?" \
      "answer=json&" \
      "from=Qux&" \
      "group=all&" \
      "password=9d1e4709d6a41407ab34cf99c7085f79&" \
      "text=Hi&" \
      "type=2&" \
      "user=BAZ"
    end

    before { settings[:use_ssl] = false }

    it "sends a request" do
      subject
      expect(a_request(:post, url)).to have_been_made
    end
  end

  context "with custom group:" do
    let(:url) do
      "https://gate.smsaero.ru/sendtogroup?" \
      "answer=json&" \
      "from=Qux&" \
      "group=foo&" \
      "password=9d1e4709d6a41407ab34cf99c7085f79&" \
      "text=Hi&" \
      "type=2&" \
      "user=BAZ"
    end

    before { params[:group] = "foo" }

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

  context "with valid date:" do
    let(:url) do
      "https://gate.smsaero.ru/sendtogroup?" \
      "answer=json&" \
      "from=Qux&" \
      "group=all&" \
      "date=4122144000&" \
      "password=9d1e4709d6a41407ab34cf99c7085f79&" \
      "text=Hi&" \
      "type=2&" \
      "user=BAZ"
    end

    before { params[:date] = DateTime.parse("2100-08-17 00:00:00 UTC") }

    it "sends a request" do
      subject
      expect(a_request(:post, url)).to have_been_made
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

  context "with digital channel:" do
    let(:url) do
      "https://gate.smsaero.ru/sendtogroup?" \
      "answer=json&" \
      "from=Qux&" \
      "group=all&" \
      "digital=1&" \
      "password=9d1e4709d6a41407ab34cf99c7085f79&" \
      "text=Hi&" \
      "user=BAZ"
    end

    before { params[:digital] = true }

    it "sends a request" do
      subject
      expect(a_request(:post, url)).to have_been_made
    end
  end

  context "with valid type:" do
    let(:url) do
      "https://gate.smsaero.ru/sendtogroup?" \
      "answer=json&" \
      "from=Qux&" \
      "group=all&" \
      "password=9d1e4709d6a41407ab34cf99c7085f79&" \
      "text=Hi&" \
      "type=3&" \
      "user=BAZ"
    end

    before { params[:type] = 3 }

    it "sends a request" do
      subject
      expect(a_request(:post, url)).to have_been_made
    end
  end

  context "with invalid type:" do
    before { params[:type] = 11 }

    it "raises an exception" do
      expect { subject }.to raise_error(TypeError, /11/)
    end
  end
end
