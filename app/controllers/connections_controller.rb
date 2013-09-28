require 'index_access'
require 'hashie/mash'
require 'elasticsearch'

class ConnectionsController < ApplicationController
  def index
  end

  def connect
    person1 = params[:person1]
    person2 = params[:person2]

    render :json => Oj.dump([person1, 'interim@enron.com', person2])
  end

  def get_connections_between(start_person, end_person)
    if (start_person == end_person)
      return [start_person, end_person]
    end
    connection_map = {end_person => end_person}
    build_connection_map(connection_map, start_person, end_person)
    current_person = start_person
    connection_list = []
    while (current_person != end_person)
      connection_list.push(current_person)
      current_person = connection_map[current_person]
    end
    connection_list.push(end_person)
    return connection_list
  end

  def build_connection_map(connection_map, start_person, to_person)
    print "build_connection from #{start_person} => #{to_person}\n"
    immediate_connections = get_immediate_connections_to(to_person)
    need_to_check = []
    if immediate_connections.nil?
      return
    end
    for conn in immediate_connections
      if connection_map[conn].nil?
        connection_map[conn] = to_person
        need_to_check.push(conn)
      end
      if conn == start_person
        return
      end
    end
    if need_to_check.nil?
      return
    end
    for conn in need_to_check
      build_connection_map(connection_map, start_person, conn)
    end
  end

  def get_immediate_connections_to(person)
    query_to = QB.match({:To => person})
    query_results = Hashie::Mash.new(Enron.query(query_to))
    conns_to = query_results.hits.hits.map { |msg| msg._source.From }
    return conns_to.uniq!()
  end
end
