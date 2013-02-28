# Beercalc

Beercalc is a small helper class that holds various calculations to aid in desiging your own beer recipes.  

## Installation

To get started include the gem.
```ruby
gem install beercalc
```
or if you are using this within a Rails project, include this within your Gemfile.
```ruby
gem 'beercalc'
```

## Methods

### Beercalc.abv(og, fg)
Calculates an estimated alcohol by volume estimate based on the original gravity (og) of the wort and final gravity (fg) of the produced beer.

* og   : number - original gravity
* fg   : number - final gravity

```ruby
Beercalc.abv(1.055, 1)
=> 7.204999999999992
```


### Beercalc.mcu(weight, lovibond, volume)
Calculates the Malt Color Unit of your recipe.

* weight   : number - lbs of grain
* lovibond : number - lovibond value of the grain
* volume   : number - gallons

```ruby
Beercalc.mcu(5, 5, 5)
=> 5
```


### Beercalc.srm(weight, lovibond, volume)
Provides a more accurate color rating of your recipe using the Morey equation.

* weight   : number - lbs of grain
* lovibond : number - lovibond value of the grain
* volume   : number - gallons

```ruby
Beercalc.srm(7,5,5)
=> 5.668651803424155
```


### Beercalc.aau(alpha, weight)
Calculates the Alpha Acid Units in hops.

* weight   : number - oz of hops
* alpha    : number - Alpha percentage of the hops

```ruby
Beercalc.aau(1, 4.6)
=> 4.6
```


### Beercalc.ibu(alpha, weight, time, gravity, volume)
Calculates the International Bittering Units scale.  This is calculated per hop addition and needs.  The sum of each hop addition is the total IBU for recipe.

* alpha    : number - Alpha percentage of the hops
* weight   : number - oz of hops
* time     : number - minutes hops are in the boil
* gravity  : number - gravity of the wort at the time of addition
* volume   : number - volume of the recipe.

In the below example we have two hop additions.  Each giving the IBU value for the respective addition.  The total IBU for the recipe would be the summation of these two additions.

```ruby
Beercalc.ibu(6.4, 1.5, 60, 1.080, 5)
=> 25.365869680614512
Beercalc.ibu(4.6, 1, 15, 1.080, 5)
=> 6.03108750923272
```

So the total IBU for the recipe is 25.365869680614512 + 6.03108750923272 = 31.39695718984723 

