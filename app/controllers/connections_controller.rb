class ConnectionsController < ApplicationController
  def index
  end

  def connect
    person1 = params[:person1]
    person2 = params[:person2]

    render :json => Oj.dump([person1, 'interim@enron.com', person2])
  end
end
