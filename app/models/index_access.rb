require 'hashie/mash'
require 'elasticsearch'

class ESO
  def initialize(incoming_hash)
    @wrapped = Hashie::Mash.new(incoming_hash)
  end

  def es_object
    @wrapped._source
  end

  def es_information
    return @info unless @info.nil?

    @info = @wrapped.clone
    @info["_source"] = nil

    @info
  end

end

class Enron
  @@es = Elasticsearch::Client.new hosts: ['cluster-7-slave-00.sl.hackreduce.net:9200']

  def self.get(hash_args)
    query_hash = hash_args.merge({:index =>"enron"})
    @@es.get query_hash
  end

  def self.get_source(hash_args)
    query_hash = hash_args.merge({:index =>"enron"})
    @@es.get_source query_hash
  end

  def self.search(hash_args)
    query_hash = hash_args.merge({:index => "enron"})
    @@es.search query_hash
  end

  def self.query(query_args)
    self.search({:body => query_args})
  end
end

class QB
  def self.match(args)
    {:query => {:match => args}}
  end

  #def self.suggest(text)
  #end

  def self.wildcard(args)
    {:query => {:wildcard => args}}
  end
end

#the_mail = Enron.get_source({:id => 'Dk87jMrmSPuhwzk0K-tuCQ'})
#puts the_mail["To"]

#from rex.shelby@enron.com
#query_from = {:query => {:match => {:From => 'kenneth.lay@enron.com'}}}
#query_from = QB.match({:From => 'kenneth.lay@enron.com'})
#query_from = QB.wildcard({:content => '*chosen to leave Enron*'})
#puts query_from
#query_from = {:query => {:match_all => {}}}
# look for term
#x = Hashie::Mash.new(Enron.query(query_from))

