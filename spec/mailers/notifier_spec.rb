require "spec_helper"

describe Notifier do
  describe "workflow_notification" do
    let(:mail) { Notifier.workflow_notification }

    it "renders the headers" do
      mail.subject.should eq("Workflow notification")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
