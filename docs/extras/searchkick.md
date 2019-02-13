---
title: Searchkick
---
# Searchkick Extra

Paginate `Searchkick::Results` objects.

It is expected that you let Searchkick handle the `page` and `per_page` variables instead of providing the relative `:page` and `:items` variables to Pagy.

The `Searchkick::Results` object has already consumed the `:page` and `:per_page` options passed to the `search` method. We just need to tell Pagy how to get the relative `:page` and `:count` from it.

The downside of that approach is that the [items](items.md) extra cannot work with this extra.

## Synopsis

See [extras](../extras.md) for general usage info.

In the `pagy.rb` initializer:

```ruby
require 'pagy/extras/searchkick'
```

In a controller:

```ruby
@pagy_s, @models = pagy_searchkick(
  Model.search("*",
    {
      where: {
        ...
      },
      fields: [...],
      select: [...],
      load: true,
      page: params[:page],
      per_page: 25
    }
  )
  ,
  ...
 )

# independently paginate some other collections as usual
@pagy_b, @records = pagy(some_scope, ...)
```

## Files

This extra is composed of 1 file:

- [searchkick.rb](https://github.com/ddnexus/pagy/blob/master/lib/pagy/extras/searchkick.rb)

## Methods

This extra adds the `pagy_searchkick` method to the `Pagy::Backend` to be used in place (or in parallel) of the `pagy` method when you have to paginate a `Searchkick::Results` object. It also adds a `pagy_searchkick_get_variables` sub-method, used for easy customization of variables by overriding.

**Notice**: there is no `pagy_searchkick_get_items` method to override, since the items are fetched directly by Searchkick.

### pagy_searchkick(Model.search(...), vars=nil)

This method is the same as the generic `pagy` method, but specialized for Searchkick. (see the [pagy doc](../api/backend.md#pagycollection-varsnil))

### pagy_searchkick_get_vars(array)

This sub-method is the same as the `pagy_get_vars` sub-method, but it is called only by the `pagy_searchkick` method. (see the [pagy_get_vars doc](../api/backend.md#pagy_get_varscollection-vars)).
