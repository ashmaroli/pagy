require 'pagy/extras/elasticsearch_rails'

module ElasticsearchRailsTest

  RESULTS = { 'a' => ('a-1'..'a-1000').to_a,
              'b' => ('b-1'..'b-1000').to_a }

  class Results
    attr_reader :raw_response
    def initialize(query, options={})
      results = RESULTS[query][options[:from],options[:size]]
      @raw_response = {'hits' => {'hits' => results, 'total' => RESULTS[query].size}}
    end

    def records
      @raw_response['hits']['hits'].map{|r| "R-#{r}"}
    end

    def count
      @raw_response['hits']['hits'].size
    end

  end
end

class ElasticsearchModel
  extend Pagy::Elasticsearch::Model

  def self.search(*args)
    ElasticsearchRailsTest::Results.new(*args)
  end
end

