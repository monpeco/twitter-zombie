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
