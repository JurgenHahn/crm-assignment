require_relative 'contact'

class CRM

  def initialize
    #seems to be fine with no code?
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
    puts '[4] Display all the contacts'
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

    Contact.create(first_name, last_name, email, note)
    puts 'Congratulations! You have made a new contact.'
    puts ""
    puts ""

  end

  def modify_existing_contact

    print "Enter the ID of the contact you'd like to modify."
    by_id = gets.chomp.to_i

    print "Which attribute would you like to modify?"
    attribute = gets.chomp.to_s

    print "What is the new value?"
    new_value = gets.chomp.to_s

    selected_id = Contact.find(by_id)

    selected_id.update(attribute, new_value)
    puts ""
    puts ""

  end

  def delete_contact
    print "Enter the ID of the contact you'd like to delete."
    by_id = gets.chomp.to_i

    selected_id = Contact.find(by_id)

    selected_id.delete

    puts 'Congratulations! You have made a new contact.'
    puts ""
    puts ""
  end

  def display_all_contacts
    all_contacts = Contact.all
    all_contacts.each do |contact|
      puts contact.full_name
    end

    puts 'This is a list of all your contacts'
    puts ""
    puts ""
  end

  def search_by_attribute

  end


end
