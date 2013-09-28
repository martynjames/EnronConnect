module ConnectionsHelper
  def all_user_options
  	options_for_select all_emails
  end

  def all_emails
  	[['martyn@hopper.com', 'martyn@hopper.com'], ['pxu@carbonite.com', 'pxu@carbonite.com']]
  end
  
end
