require_relative 'contact'

class CRM

  def initialize
    main_menu
  end

  def main_menu
    while true
      print_main_menu
      user_selected = gets.to_i
      call_option(user_selected)
    end
  end

  def print_main_menu
    puts '[1] Add a new contact'
    puts '[2] Modify an existing contact'
    puts '[3] Delete a contact'
    puts '[4] Display all contacts'
    puts '[5] Search by attribute'
    puts '[6] Exit'
    puts 'Enter a number: '
  end

  def call_option(user_selected)
    case user_selected
      when 1 then add_new_contact
      when 2 then modify_existing_contact
      when 3 then delete_contact
      when 4 then display_all_contacts
      when 5 then search_by_attribute
      when 6 then exit
    end
  end

  def add_new_contact
    print 'Enter First Name: '
    first_name = gets.chomp

    print 'Enter Last Name: '
    last_name = gets.chomp

    print 'Enter Email Address: '
    email = gets.chomp

    print 'Enter a Note: '
    note = gets.chomp
    puts ""
    puts ""
    new_contact = Contact.create(first_name, last_name, email, note)
    puts "Congratulations! You have added #{new_contact.full_name} to your contacts!"
    puts ""
    puts ""
  end


  def modify_existing_contact
    print "Enter the ID of the contact you'd like to modify."
    by_id = gets.chomp.to_i

    contact = Contact.find(by_id)

    if contact == nil
      puts ""
      puts ""
      puts "We have no contacts that match that ID."
      puts ""
      puts ""
      main_menu
    end

    attribute = nil

    while ( attribute == nil )
      attribute_menu
      user_selected = gets.to_i
      attribute = ( attribute_option(user_selected))
    end

    print "What is the new value?"
    new_value = gets.chomp.to_s

    contact.update(attribute, new_value)
    puts ""
    puts ""
    puts" You have successfully updated your contact!"
    puts ""
    puts ""
  end

  def attribute_menu
    puts "Which attribute?"
    puts '[1] First Name'
    puts '[2] Last Name'
    puts '[3] Email'
    puts '[4] Note'
    puts 'Enter a number: '
  end

  def attribute_option(user_selected)
    case user_selected
      when 1 then attribute = "first_name"
      when 2 then attribute = "last_name"
      when 3 then attribute = "email"
      when 4 then attribute = "note"
      else
      attribute = nil
    end
    return attribute
  end

  def delete_contact
    print "Enter the ID of the contact you'd like to delete."
    by_id = gets.chomp.to_i
    contact = Contact.find(by_id)

    if contact == nil
      puts ""
      puts ""
      puts "We have no contacts that match that ID."
      puts ""
      puts ""
      main_menu
    end

    choice = nil

    while (choice == nil)
      delete_menu
      user_selected = gets.to_i
      choice = delete_confirm(user_selected)
    end

    puts ""
    puts ""
    puts "#{contact.full_name} Deleted."
    puts ""
    puts ""
    contact.delete
  end

  def delete_menu
    puts "Are you sure you would like to delete?"
    puts "[1] Yes"
    puts "[2] No"
  end

  def delete_confirm(user_selected)
    case(user_selected)
      when 1 then choice = true
      when 2 then main_menu
      else choice = nil
    end
  end

  def display_all_contacts
    puts ""
    puts ""
    puts "Contact List:"
    puts ""
    puts ""
    all_contacts = Contact.all
    all_contacts.each do |contact|
      print "[ID]#{contact.id} "
      print "[NAME]#{contact.full_name} "
      print "[EMAIL]#{contact.email} "
      puts "[NOTES]#{contact.note}"
    end
    puts ""
    puts ""
  end

  def search_by_attribute

    attribute = nil

    while ( attribute == nil)
      attribute_menu
      user_selected = gets.to_i
      attribute = ( attribute_option(user_selected))
    end

    print "What is the value of the attribute?"
    value = gets.chomp.to_s

    contact = Contact.find_by(attribute, value)

    if contact == nil
      puts ""
      puts ""
      puts "I'm sorry we could not find a match"
      puts ""
      puts ""
      main_menu
    end

    puts ""
    puts ""
    print "[ID]#{contact.id} "
    print "[NAME]#{contact.full_name} "
    print "[EMAIL]#{contact.email} "
    puts "[NOTES]#{contact.note}"
    puts ""
    puts ""
  end

  app = CRM.new

end
