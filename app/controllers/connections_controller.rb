require 'index_access'
require 'hashie/mash'
require 'elasticsearch'

class ConnectionsController < ApplicationController
  def index
  end

  def connect
    person1 = params[:person1]
    person2 = params[:person2]

    render :json => Oj.dump(get_connections_between(person1, person2))
  end

  def get_connections_between(start_person, end_person)
    if (start_person == end_person)
      return [start_person, end_person]
    end
    connection_map = {end_person => end_person}
    build_out_tier(connection_map, start_person, [end_person], 1)
    current_person = start_person
    if (connection_map[current_person].nil?)
      return []
    end
    connection_list = []
    while (current_person != end_person)
      connection_list.push(current_person)
      current_person = connection_map[current_person]
    end
    connection_list.push(end_person)
    return connection_list
  end

  def build_out_tier(connection_map, start_person, tier_list, tier)
    print "build_connection from #{start_person} => #{tier_list}\n"
    if (tier > 3)
      return
    end
    if (tier_list.empty?)
      return
    end
    new_tier = []
    for tier_item in tier_list
      immediate_connections = get_immediate_connections_to(tier_item)
      if immediate_connections.nil?
        next
      end
      for conn in immediate_connections
        if connection_map[conn].nil?
          connection_map[conn] = tier_item
          new_tier.push(conn)
        end
        if conn == start_person
          return
        end
      end
    end
    if new_tier.nil?
      return
    end
    new_tier.uniq!
    build_out_tier(connection_map, start_person, new_tier, tier + 1)
  end

  def get_immediate_connections_to(person)
    query_to = QB.match({:To => person})
    query_results = Hashie::Mash.new(Enron.query(query_to))
    conns_to = query_results.hits.hits.map { |msg| msg._source.From }
    return conns_to.uniq!()
  end
end
