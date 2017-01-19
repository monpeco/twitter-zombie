####zombies

|id	| name  | graveyard |
|---|-------|-----------|
|1	|Ashley	| Glen Haven Memorial Cemetery |
|2	|Bob	| Chapel Hill Cemetery |
|3	|Katie	| My Father's Basement |

####FIND I
#### 1. Try to find a Zombie where the ID is 1.

```ruby
Zombie.find(1)
#<Zombie id: 1, name: "Ashley", graveyard: "Glen Haven Memorial Cemetery">
Successfully found Zombie where ID = 1.
```

####CREATE
####Create a new Zombie.

```ruby
z = Zombie.create(name: 'Joe', graveyard: 'Last house on the left')
#<Zombie id: 4, name: "Joe", graveyard: "Last house on the left">
Created a Zombie record.
```

####FIND II
###Find the last Zombie in the database, but don't use IDs
```ruby
$ z = Zombie.last
#<Zombie id: 3, name: "Katie", graveyard: "My Father's Basement">
Found the last Zombie!
```

####QUERY
####Find all Zombies ordered by their names.

```ruby
$ z = Zombie.all.order(:name)
#<ActiveRecord::Relation [#<Zombie id: 2, name: "Ashley", graveyard: "Glen Haven Memorial Cemetery">, #<Zombie id: 1, name: "Bob", graveyard: "Chapel Hill Cemetery">, #<Zombie id: 3, name: "Katie", graveyard: "My Father's Basement">]>
Found all Zombies ordered by their names.
```

####UPDATE
####Update Zombie 3's graveyard to 'Benny Hills Memorial'

```ruby
$ z = Zombie.find(3).update(graveyard: 'Benny Hills Memorial')
true
Successfully updated Zombie 3's graveyard
```


####DESTROY
####Destroy the Zombie with an ID of 3.
```ruby
$ z = Zombie.find(3).destroy
#<Zombie id: 3, name: "Katie", graveyard: "My Father's Basement">
Destroyed Zombie 3.
```

--

####CREATE MODEL
####Define a Zombie model.

app/models/zombie.rb
```ruby
class Zombie < ActiveRecord::Base
end
```

####VALIDATIONS I
####Add a validation that checks for the presence of a Zombie's name

```ruby
class Zombie < ActiveRecord::Base
  validates :name, presence: true
end
```

####VALIDATIONS II
####Add a validation that checks for the uniqueness of a Zombie's name.
```ruby
class Zombie < ActiveRecord::Base
  validates :name, uniqueness: true
end
```

####VALIDATIONS III
####Validate both the uniqueness and the presence of a Zombie's name on a single line, using the new validation syntax.
```ruby
class Zombie < ActiveRecord::Base
  validates :name, uniqueness: true, presence: true
end
```

####BELONGS TO
####A Weapon belongs to a Zombie. Create that relationship.
```ruby
class Weapon < ActiveRecord::Base
  belongs_to :zombie
end
```

####RELATIONSHIP FIND
####Assuming the models and relationships are properly defined, find all the weapons that belong to Zombie 'Ashley'.
```ruby
$ Zombie.find(1).weapons 
#<ActiveRecord::Associations::CollectionProxy [#<Weapon id: 1, name: "Hammer", strength: 1, zombie_id: 1>]>
Successfully found all of Ashley's weapons.
```

```ruby
$  Zombie.where(:name => "Ashley").first.weapons
#<ActiveRecord::Associations::CollectionProxy [#<Weapon id: 1, name: "Hammer", strength: 1, zombie_id: 1>]>
Successfully found all of Ashley's weapons.
```



