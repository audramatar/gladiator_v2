# Creates UI and display for characters.
module CharacterUI
  def print_character_sheet
    clear_screen
    print_line
    puts Paint['Name: '.ljust(15), :bold] + @name.to_s
    puts Paint['Level: '.ljust(15), :bold] + @level.to_s
    print_party_names(party)
    print_line
    puts Paint['HP: '.ljust(15), :bold] + @max_hp.to_s
    puts Paint['Mana: '.ljust(15), :bold] + @max_mana.to_s
    puts Paint['AC: '.ljust(15), :bold] + @ac.to_s
    print_line
    puts Paint['BAB: '.ljust(15), :bold] + format('%+d', @bab).to_s
    puts Paint['Init: '.ljust(15), :bold] + format('%+d', @init).to_s
    print_line
    puts Paint['Str: '.ljust(15), :bold] + @str.to_s.ljust(15) + format('%+d', @str_modifier).to_s
    puts Paint['Dex: '.ljust(15), :bold] + @dex.to_s.ljust(15) + format('%+d', @dex_modifier).to_s
    puts Paint['Con: '.ljust(15), :bold] + @con.to_s.ljust(15) + format('%+d', @con_modifier).to_s
    puts Paint['Mag: '.ljust(15), :bold] + @mag.to_s.ljust(15) + format('%+d', @mag_modifier).to_s
    puts Paint['Cha: '.ljust(15), :bold] + @cha.to_s.ljust(15) + format('%+d', @cha_modifier).to_s
    print_line
    puts Paint['One Handed: '.ljust(15), :bold] + @one_hand_prof.to_s.ljust(15)
    puts Paint['Dual Wield: '.ljust(15), :bold] + @dual_wield_prof.to_s.ljust(15)
    puts Paint['Two Handed: '.ljust(15), :bold] + @two_hand_prof.to_s.ljust(15)
    puts Paint['Unarmed: '.ljust(15), :bold] + @unarmed_prof.to_s.ljust(15)
    puts Paint['Magic: '.ljust(15), :bold] + @magic_prof.to_s.ljust(15)
    print_line
    puts Paint['Equipped Weapon: '.ljust(15), :bold] + @equipped_weapon[:name].to_s.ljust(15)
    puts Paint['Equipped Weapon: '.ljust(15), :bold] +
         @equipped_shield[:name].to_s.ljust(15) if @equipped_shield
    print_line
    display_inventory(@inventory)
    display_known_spells(@known_spells)
  end

  def print_party_names(party)
    print Paint['Current Party: '.ljust(15), :bold]
    party.each do |member|
      print member.name.ljust(10)
    end
    new_line
  end

  def display_inventory(inventory)
    puts Paint["#{@name}'s Inventory", :bold]
    print_line
    if inventory == {}
      puts Paint['Inventory is empty.', :red]
    else
      equipment = {}
      consumables = {}
      inventory.each_pair do |name, item|
        case item[:type]
        when 'weapon', 'armor', 'shield'
          equipment[name] = item
        else
          consumables[name] = item
        end
      end
      display_specific_inventory(equipment, 'Equipment')
      display_specific_inventory(consumables, 'Consumables')
    end
    print_line
  end

  def display_specific_inventory(inventory, label)
    puts Paint["#{label}: "]
    new_line
    count = 1
    inventory.each_pair do |name, item|
      puts "#{count}. " + name.ljust(22) + 'Type: '.ljust(5) + item[:type]
      count += 1
    end
    new_line
  end

  def display_known_spells(spells)
    puts Paint["#{@name}'s Known Spells", :bold]
    print_line
    if spells == {}
      puts Paint['No spells known.', :red]
    else
      count = 1
      spells.each_pair do |name, spell|
        print "#{count}. " + name.ljust(22) + spell[:description]
        count += 1
        new_line
      end
    end
    print_line
  end
end
