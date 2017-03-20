# Salido Challenge

## Models and Relationships

The [models](https://github.com/arielperez82/salido-challenge/tree/master/app/models) as defined are pretty self-explanatory.

The primary relationships are as follows:

[Brands](https://github.com/arielperez82/salido-challenge/tree/master/app/models/brand.rb)
  * have many [Locations](https://github.com/arielperez82/salido-challenge/tree/master/app/models/location.rb)
    * have many [Day Parts](https://github.com/arielperez82/salido-challenge/tree/master/app/models/day_part.rb)
    * have many [Location Price Levels](https://github.com/arielperez82/salido-challenge/tree/master/app/models/location_price_level.rb)
      * belong to an [Order Type](https://github.com/arielperez82/salido-challenge/tree/master/app/models/order_type.rb)
      * belong to an optional [Day Part](https://github.com/arielperez82/salido-challenge/tree/master/app/models/day_part.rb)
      * belong to a [Price Level](https://github.com/arielperez82/salido-challenge/tree/master/app/models/price_level.rb)
    * have many [Location Menu Items](https://github.com/arielperez82/salido-challenge/tree/master/app/models/location_menu_item.rb)
      * belong to a [Menu Item](https://github.com/arielperez82/salido-challenge/tree/master/app/models/menu_item.rb)
  * have many [Order Types](https://github.com/arielperez82/salido-challenge/tree/master/app/models/order_type.rb)
  * have many [Menu Items](https://github.com/arielperez82/salido-challenge/tree/master/app/models/menu_item.rb)
    * have many [Menu Item Prices](https://github.com/arielperez82/salido-challenge/tree/master/app/models/menu_item_price.rb)
      * belong to a [Price Level](https://github.com/arielperez82/salido-challenge/tree/master/app/models/price_level.rb)
  * have many [Price Levels](https://github.com/arielperez82/salido-challenge/tree/master/app/models/price_level.rb)

The [Location Menu Item](https://github.com/arielperez82/salido-challenge/tree/master/app/models/location_menu_item.rb) model isn't needed, but it certainly makes it easier to manage which [Menu Items](https://github.com/arielperez82/salido-challenge/tree/master/app/models/menu_item.rb) are available at a particular [Location](https://github.com/arielperez82/salido-challenge/tree/master/app/models/location.rb).

## Constraints, Validations, and Referential Integrity

  * Uniqueness validations and referential checks are in the AR models, as this are generally easy to code and also provide for easy to understand messages to users.
  * Foreign key relationships are enforced in the DB and unique composite indices were added to the tables to prevent duplicate entries, which AR validations won't catch if they're persisted simultaneously.
  * Cascading deletes are handled in AR as other clean up during instance destruction can be also executed in a callback, if needed. This is not as likely to be possible if cascading deletes were implemented in the DB.
  * All timestamp fields have a timezone to make it easier to make it easier to have a consistent frame of reference for times in the application. Added [this initializer](https://github.com/arielperez82/salido-challenge/blob/master/config/initializers/postgresql_native_types.rb) to facilitate this for Postgres.

## Unit and Integration Testing

Given time constraints, I only added [unit tests](https://github.com/arielperez82/salido-challenge/blob/master/spec/models/location_spec.rb#L13) for the most important method, which is the one that determines the price of a menu item given the location, order type, and day part.

## The Demo Application

You can find a Live version [here](https://ariel-salido-challenge.herokuapp.com). The first load may take a while since it's a free dyno on Heroku.

[Active Admin](https://github.com/activeadmin/activeadmin/blob/master/README.md) was used because it auto-generates lots of the scaffolding needed for an administration app.

The management tool I built can definitely use some design and user flow work, but it gets the job done. I focused more on the logic, validations, and schema than the navigation.
Possible improvements:
  * When adding multiple location menu items, for example, already added menu items should not be available in the drop-down in order to prevent dupes
    * The same goes for menu item prices and location price levels.
