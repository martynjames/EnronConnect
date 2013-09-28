module ConnectionsHelper
  def all_user_options
  	options_for_select all_emails
  end

  def all_emails
  	[['mark.greenberg@enron.com', 'mark.greenberg@enron.com'], ['rex.shelby@enron.com', 'rex.shelby@enron.com']]
  end
  
end
