require 'csv'
require 'pry'

class Contact

  attr_accessor :name, :email

  def initialize(name, email)
    @name = name
    @email= email
  end
  class << self

    def initial_message
      menu = %{
        Here is a list of available commands:
              new     -Create a new contact
              list    -list all contacts
              show    - Show a contact
              search  - Search contacts
      }

      puts menu

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
        puts find(id) ? find(id) : "not found"
      elsif response == "search"
        puts "Type in a keyword of the contact you are trying to search for"
        term = gets.chomp.downcase
        puts search(term).join(', ')     
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

    def find(id)
      index = 1
      CSV.foreach('contacts.csv','r') do |row|
        if index == id
          return "contact is #{row}"
        else
          return nil
        end
        index += 1 
      end
    end

    def search(term)
      CSV.foreach('contacts.csv', 'r') do |row|
        
        return row if row.join(',').downcase.include? term.downcase  
      end
    end

  end

end

Contact.initial_message
