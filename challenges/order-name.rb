z = Zombie.all.order(:name)
#<ActiveRecord::Relation [#<Zombie id: 2, name: "Ashley", graveyard: "Glen Haven Memorial Cemetery">, #<Zombie id: 1, name: "Bob", graveyard: "Chapel Hill Cemetery">, #<Zombie id: 3, name: "Katie", graveyard: "My Father's Basement">]>
#Found all Zombies ordered by their names.
