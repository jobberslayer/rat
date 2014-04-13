require 'highline'

namespace :db do
  namespace :admin do
    desc "Create an admin user"
    task :create => [:environment] do 
      ui = HighLine.new

      fname = ui.ask("First name:")
      lname = ui.ask("Last name:")
      email = ui.ask("Email:")
      password = ui.ask("Password:") { |q| q.echo = false }
      confirm = ui.ask("Confirm:") { |q| q.echo = false }

      user = User.new(
        first_name: fname,
        last_name: lname,
        email: email,
        password: password,
        password_confirmation: confirm,
        admin: true
      )

      if user.save
        puts "User account for '#{user.full_name}' created."
      else
        puts
        puts "Problem creating user account:"
        puts user.errors.full_messages
      end
    end
  end
end
