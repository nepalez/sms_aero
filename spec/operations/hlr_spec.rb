describe SmsAero do
  let(:settings) { { user: "LOGIN", password: "PASSWORD" } }
  let(:client)   { described_class.new(settings) }

  before { stub_request(:any, //).to_return(body: answer.to_json) }

  describe "#hlr" do
    let(:params)   { { phone: "+7(002)034-5678" } }
    let(:answer) { { result: "accepted", id: 123 } }
    let(:url) do
      "https://gate.smsaero.ru/hlr?answer=json&user=LOGIN&" \
        "password=319f4d26e3c536b5dd871bb2c52e3178&phone=70020345678"
    end

    subject { client.hlr params }

    it "sends a request" do
      subject
      expect(a_request(:post, url)).to have_been_made
    end

    it "returns success" do
      expect(subject.result).to eq "accepted"
      expect(subject.id).to eq "123"
    end

    context "with invalid phone" do
      let(:params) { { phone: "123" } }

      it "raises an exception" do
        expect { subject }.to raise_error(StandardError, /123/)
      end
    end

    context "without a phone" do
      let(:params) { {} }

      it "raises an exception" do
        expect { subject }.to raise_error(StandardError)
      end
    end
  end

  describe "#hlr_status" do
    let(:params) { { id: 1 } }
    let(:status) { 1 }
    let(:answer) { { result: "accepted", status: status } }
    let(:url) do
      "https://gate.smsaero.ru/hlrStatus?answer=json&user=LOGIN&" \
        "password=319f4d26e3c536b5dd871bb2c52e3178&id=1"
    end

    subject { client.hlr_status params }

    it "sends a request" do
      subject
      expect(a_request(:post, url)).to have_been_made
    end

    it "returns success" do
      expect(subject.result).to eq "accepted"
    end

    it "converts status to sym" do
      expect(subject.status).to eq :available
    end

    context "other statuses" do
      context "unavailable" do
        let(:status) { 2 }

        it "converts status to sym" do
          expect(subject.status).to eq :unavailable
        end
      end

      context "nonexistent" do
        let(:status) { 3 }

        it "converts status to sym" do
          expect(subject.status).to eq :nonexistent
        end
      end
    end
  end
end
