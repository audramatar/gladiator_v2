require_relative "lib/character.rb"
require_relative "lib/characters/player_character.rb"
require_relative "lib/combat.rb"

character1 = PlayerCharacter.new("PC")
character2 = PlayerCharacter.new("Ally 1")
character3 = Character.new("Enemy 1")
character4 = Character.new("Enemy 2")
character5 = Character.new("Enemy 3")
character6 = Character.new("Ally 3")

character2.party = character1.join_party([character2])

character1.inventory = {"health potion" => { name: "health potion", type: "healing", stat: "hp", bonus: 20, target: "any", price: 10}}

combat = Combat.new(character1.party, [character3, character4])

combat.auto_combat