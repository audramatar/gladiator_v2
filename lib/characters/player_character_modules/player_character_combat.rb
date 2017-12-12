module PlayerCharacterCombat
  def create_attack_object(enemies)
    target = select_target(enemies)
    msg_and_target = {target: target, message: ["#{@name} attacks #{enemies[target].name}!"]}
    attack_object = select_action(enemies)
    attack_object.merge!(msg_and_target)
    return attack_object
  end

  def select_target(enemies)
    valid_target = false
    while !valid_target
      answer = ask_question("Select a target for #{@name} to attack.", "Enter the name of the enemy to select it.")
      enemies.each_with_index do |enemy, index|
        if enemy.name.downcase == answer
          return index
        end
      end
      print_error_message("Invalid target #{answer}. Try again.")
    end
  end

  def select_action(enemies)
    valid_action = false
    while !valid_action
      answer = ask_question("What action do you wish for #{@name} to take?", "Enter the number beside the action.")
      case answer
        when "1"
          return auto_attack(enemies)
        when "2"
          print_error_message("Option currently unavailble. Try again.")
        when "3"
          print_error_message("Option currently unavailble. Try again.")
        when "4"
          print_error_message("Option currently unavailble. Try again.")
        else
      end
    end
  end
end