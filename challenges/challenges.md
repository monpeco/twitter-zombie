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

--

####VIEWS SIMPLE
####Print out the zombie's name and graveyard.

app/views/zombies/show.html.erb
```ruby
<% zombie = Zombie.first %>

<h1><%= #insert zombie name here %></h1>

<p>
  <%= # insert zombie graveyard here %>
</p>
```

```ruby
<h1><%= zombie.name  %></h1>

<p>
  <%= zombie.graveyard %>
</p>
```



####LINKING
####Link to the zombie's show page. Use the zombie's name as the anchor text

```ruby
<% zombie = Zombie.first %>

<p>
<%= # insert zombie link here %>
</p>
```

```ruby
<p>
<%= link_to zombie.name, zombie %>
</p>
```



####EACH BLOCKS
####Use an each block to print the names of all the zombies.

```ruby
<% zombies = Zombie.all %>

<ul>
<% # insert block here %>
</ul>
```

```ruby
<ul>
<% zombies.each do |z| %>
  <%= z.name %>
<% end %>
</ul>
```



####IF
####In the each block, if a zombie has more than one tweet, print out SMART ZOMBIE.

```ruby
<% zombies = Zombie.all %>

<ul>
  <% zombies.each do |zombie| %>
    <li>
      <%= zombie.name %>
      # add if statement here
    </li>
  <% end %>
</ul>
```

```ruby
<ul>
  <% zombies.each do |zombie| %>
    <li>
      <%= zombie.name %>
      <%= 'SMART ZOMBIE' if zombie.tweets.count > 1 %>
    </li>
  <% end %>
</ul>
```

####LINKING IN BLOCKS
####In the each block, make the zombie's name link to its edit page.

```ruby
<ul>
  <% zombies.each do |zombie| %>
    <li>
      <%= zombie.name %>
    </li>
  <% end %>
</ul>
```

```ruby
<ul>
  <% zombies.each do |zombie| %>
    <li>
      <%= link_to zombie.name, edit_zombie_path(zombie) %>
    </li>
  <% end %>
</ul>
```

--

####SHOW ACTION
####Create the show action for the ZombiesController which finds a Zombie based on params[:id]. Store the Zombie object to an instance variable named @zombie.

app/controllers/zombies_controller.rb

```ruby
class ZombiesController < ApplicationController
  def show
    # put the show code here
  end
end
```

```ruby
class ZombiesController < ApplicationController
  def show
    @zombie = Zombie.find(params[:id])
  end
end
```

####RESPOND TO
####Finish the respond_to block so the action returns the XML of the @zombie record

```ruby
class ZombiesController < ApplicationController
  def show
    @zombie = Zombie.find(params[:id])

    respond_to do |format|

    end
  end
end
```

```ruby
class ZombiesController < ApplicationController
  def show
    @zombie = Zombie.find(params[:id])

    respond_to do |format|
		format.html
      	format.xml { render :xml => @zombie }
    end
  end
end
```

####CONTROLLER CREATE ACTION
####Write a create action that will create a new Zombie from the params and then redirect to the created Zombie's show page. Make sure to use Rails 4 strong_parameters.




```ruby
# params = {zombie: {name: 'Gregg', graveyard: 'TBA'}}

class ZombiesController < ApplicationController
  def create

  end

  private

  def zombie_params
    params.require(:zombie).permit(:name, :graveyard)
  end
end
```


```ruby
class ZombiesController < ApplicationController
  def create
    @zombie = Zombie.create(zombie_params)
    redirect_to @zombie
  end

  private

  def zombie_params
    params.require(:zombie).permit(:name, :graveyard)
  end
end
```

####CONTROLLER BEFORE ACTION
####Add a before_action that calls a method to check if a Zombie has tweets. Redirect to zombies_path if the zombie doesn't have tweets, only on show.


```ruby
class ZombiesController < ApplicationController
  before_action :find_zombie

  def show
    render action: :show
  end

  def find_zombie
    @zombie = Zombie.find params[:id]
  end
end
```


```ruby

```