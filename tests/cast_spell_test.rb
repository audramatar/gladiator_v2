require_relative '../test_helper.rb'
require_relative '../lib/characters/test_character.rb'
require 'byebug'

# Testing casting spells in combat
class CastSpellTest < MiniTest::Test
  character = TestCharacter.new('Test')
  spell = Spells.damage_spells['magic missle']
  spell2 = Spells.damage_spells['burning hands']
  should_not_be_nil = { 'target' => :target, 'damage' => :damage,
                        'attack type' => :attack_type,
                        'spell dc' => :spell_dc }

  should_not_be_nil.each do |name, attribute|
    define_method("test_that_#{name}_is_not_nil_with_single_target") do
      attack_object = character.cast_spell(spell, [character])
      refute_nil(attack_object[attribute])
    end
  end

  should_not_be_nil.each do |name, attribute|
    define_method("test_that_#{name}_is_not_nil_with_target_all") do
      attack_object = character.cast_spell(spell2, [character])
      refute_nil(attack_object[attribute])
    end
  end

  sample_atk_object = { target: 'all', damage: 2,
                        message: ['Ally 1 attacks all enemies with burning hands!'],
                        spell_dc: 9, attack_type: 'spell' }
  def_should_not_be_nil = { 'message' => :message }

  def_should_not_be_nil.each do |name, attribute|
    define_method("test_that_#{name}_is_not_nil_in_def_object_with_spell") do
      defense_object = character.decode_attack_object(sample_atk_object)
      refute_nil(defense_object[attribute])
    end
  end
end
