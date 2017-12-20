# A module to enable spellcastin capibility for all characters.
module CharacterCastSpell
  def check_if_valid_spell(spell_name)
    return @known_spells[spell_name] if @known_spells[spell_name]
    print_error_message("#{spell_name} is not a valid spell.")
    false
  end

  def cast_spell(spell, enemies)
    case spell[:type]
    when 'damage'
      attack_object = cast_damage_spell(spell, enemies)
      attack_object[:spell_dc] = get_spell_dc(spell[:level])
      attack_object[:attack_type] = 'spell'
      attack_object
    when 'healing'
      return cast_healing_spell(spell)
    end
  end

  def cast_healing_spell(spell)
    message = []
    if spell[:target] == 'all'
    elsif spell[:target] == 'ally'
    elsif spell[:target] == 'self'
    elsif spell[:target] == 'any'
      target = get_random_target(@party)
      message.push("#{@name} heals #{@party[target].name} with #{spell[:name]}!")
      attack_object = @party[target].get_healing(spell)
      return false unless attack_object
      attack_object[:message].unshift(message)
      return attack_object
    end
  end

  def cast_damage_spell(spell, enemies)
    target = ''
    message = []
    if spell[:target] == 'all'
      target = 'all'
      message = ["#{@name} attacks all targets with #{spell[:name]}!"]
    else
      target = get_random_target(enemies)
      message = ["#{@name} attacks #{enemies[target].name} with #{spell[:name]}!"]
    end
    damage = get_spell_damage(spell)
    { target: target, damage: damage, message: message }
  end

  def get_bonus(bonus_to_get)
    if bonus_to_get == 'proficiency'
      @magic_prof
    elsif bonus_to_get == 'level'
      @level
    elsif bonus_to_get == 'magic'
      @mag_modifier
    elsif bonus_to_get == 'charisma'
      @cha_modifier
    elsif bonus_to_get == false
      0
    end
  end

  def check_if_spell_is_resisted(spell_dc, magic_resist, dice_roll = roll_dice(20, 1))
    dice_roll += magic_resist
    return false if dice_roll < spell_dc
    true
  end
end
