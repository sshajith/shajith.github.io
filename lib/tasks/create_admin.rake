include Rails.application.routes.url_helpers
 
begin
  namespace :admin do
    task :create => :environment do
      puts "You will be prompted to enter an email address and password for the new admin"
      puts "Enter an email address:"
      email = STDIN.gets
      puts "Enter a password:"
      password = STDIN.gets
      unless email.strip!.blank? || password.strip!.blank?
        #account = Account.create! :name => 'Administrator', :subdomain => 'www'
        user = User.new(:email => email, :password => password, :password_confirmation =>  password)
        user.skip_confirmation!
        if user.save!
          puts "The admin was created successfully."
        else
          puts "Sorry, the admin was not created!"
        end
      end
      #tvl = Account.create! :name => 'Tirunelveli', :subdomain => 'tvl'

    end
  end
end