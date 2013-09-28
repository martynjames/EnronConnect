module ConnectionsHelper
  def all_user_options
    options_for_select all_emails
  end

  def all_emails
  [
    ['elizabeth.linnell@enron.com', 'elizabeth.linnell@enron.com'],
    ['ann.schmidt@enron.com', 'ann.schmidt@enron.com'],
    ['brent.hendry@enron.com', 'brent.hendry@enron.com'],
    ['mark.greenberg@enron.com', 'mark.greenberg@enron.com'],
    ['kenneth.lay@enron.com', 'kenneth.lay@enron.com']
  ]
  end

end
