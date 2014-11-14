class ResultsMailer < ActionMailer::Base
  default from: "from@example.com"

  def sending_results(name)
    attachments["#{name}.json"] = File.read("results/#{name}.json")
    @name = name
    mail to: "testmailover9k@gmail.com", subject: "result of #{name} tournament"
  end
end
