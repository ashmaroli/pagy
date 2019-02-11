---
title: Elasticsearch Rails
---
# Elasticsearch Rails Extra

Paginate `ElasticsearchRails` response objects.

## Synopsis

See [extras](../extras.md) for general usage info.

In the `pagy.rb` initializer:

```ruby
require 'pagy/extras/elasticsearch_rails'
```

Where you includes the `Elasticsearch::Model`:

```ruby
include Elasticsearch::Model
extend Pagy::Elasticsearch::Model
```

In a controller use `pagy_search` in place of `search`:

```ruby
records = Article.pagy_search(params[:q]).records
@pagy, @articles = pagy_elasticsearch_rails(records, items: 10)
```

## Files

This extra is composed of 1 file:

- [elasticsearch_rails.rb](https://github.com/ddnexus/pagy/blob/master/lib/pagy/extras/elasticsearch_rails.rb)

## Pagy::Elasticsearch::Model

```ruby
include Elasticsearch::Model
extend Pagy::Elasticsearch::Model
```

The `Pagy::Elasticsearch::Model` extends your model(s) with the `pagy_search` method that you must use in place of the standard `search` method.

### pagy_search(query_or_payload, options={})

This method accepts the same arguments of the `search` method and you must use it in its place. This extra uses it in order to capture the arguments, automatically merging the `:from` and `:size` options before passing them to the standard `search` method internally.

## Methods

This extra adds the `pagy_elasticsearch_rails` method to the `Pagy::Backend` to be used when you have to paginate a `ElasticsearchRails` object. It also adds a `pagy_elasticsearch_rails_get_variables` sub-method, used for easy customization of variables by overriding.

**Notice**: there is no `pagy_elasticsearch_rails_get_items` method to override, since the items are fetched directly by Elasticsearch Rails.

### pagy_elasticsearch_rails(Model.pagy_search(...), vars=nil)

This method is similar to the generic `pagy` method, but specialized for Elasticsearch Rails. (see the [pagy doc](../api/backend.md#pagycollection-varsnil))

It expects to receive a `Model.pagy_search(...)` result and returns a paginated response. You can use it in a couple of ways:

```ruby
response = Model.pagy_search(params[:q])
@pagy, @response = pagy_elasticsearch_rails(response, ...)
...
records = @response.records
results = @response.results

# or directly with the collection you need
@pagy, @records = pagy_elasticsearch_rails(Model.pagy_search(params[:q]).records, ...)
```

### pagy_elastic_search_rails_get_vars(array)

This sub-method is similar to the `pagy_get_vars` sub-method, but it is called only by the `pagy_elasticsearch_rails` method. (see the [pagy_get_vars doc](../api/backend.md#pagy_get_varscollection-vars)).
