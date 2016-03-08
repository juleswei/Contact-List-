require 'csv'

# Represents a person in an address book.
# The ContactList class will work with Contact objects instead of interacting with the CSV file directly

class Contact

  attr_accessor :name, :email
  
  # Creates a new contact object
  # @param name [String] The contact's name
  # @param email [String] The contact's email address
  def initialize(name, email)
    @name = name
    @email= email
    # TODO: Assign parameter values to instance variables.
  end
  class << self

    def initial_message
      puts " Here is a list of available commands:"
      puts "    new     -Create a new contact"
      puts "    list    -list all contacts"
      puts "    show    - Show a contact"
      puts "    search  - Search contacts"

      response = gets.chomp.downcase
      if response == "new"
        puts "What is the name you want to add?"
        name_input =gets.chomp.downcase
        puts "What is the email you want to add?"
        email_input=gets.chomp.downcase
        create(name_input, email_input)

      elsif response == "list"
        all 
      elsif response == "show"
        puts "What's the number(id) you want to search for?"
        id = gets.chomp.to_i
        find(id)
      elsif response == "search"
        puts "Type in a keyword of the contact you are trying to search for"
        term = gets.chomp.downcase
        search(term)     
      else
        puts" that's not a valid input, can you type it again?"    
      end
    end

    def all
      CSV.foreach('contacts.csv') do |row|
        puts row.inspect
      end
    end

    def create(name_input,email_input)
      CSV.open('contacts.csv', 'a') do |csv|
        csv << [name_input, email_input]
      end
    end
    # @return [Contact, nil] the contact with the specified id. If no contact has the id, returns nil.
    def find(id)
      index = 1
      CSV.foreach('contacts.csv','r') do |row|
        if index == id
          puts "contact is #{row}"
          # return row
        else
          puts "not found"
        end
        index += 1 
      end
    end
    
    # Search for contacts by either name or email.
    # @param term [String] the name fragment or email fragment to search for
    # @return [Array<Contact>] Array of Contact objects.
    def search(term)
      CVS.foreach('contacts.csv', 'r') do |row|
          row.each do |term|
            if include? term
              puts row ['term']
            end
          end
      end
      # TODO: Select the Contact instances from the 'contacts.csv' file whose name or email attributes contain the search term.
    end

  end

end

Contact.initial_message
