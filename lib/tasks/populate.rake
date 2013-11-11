namespace :db do 
  desc "Erase and fill database"
  task :populate => :environment do
    require 'faker'

    [User, Company, Task, Schedule].each(&:delete_all)

    puts "creating companies"
    5.times do
      c = Company.new
      c.name = Faker::Company.name
      c.info = Faker::Lorem::sentences(1..3).join(' ')
      unless c.save
        puts "company had errors: #{c.errors.full_messages}"
      end
    end

    puts "creating users"
    10.times do
      u = User.new
      u.first_name = Faker::Name.first_name
      u.last_name = Faker::Name.last_name
      u.email = Faker::Internet.email
      u.password = 'secret123'
      u.password_confirmation = 'secret123'
      unless u.save
        puts "user had errors: #{u.errors.full_messages}"
      end
    end

    puts "creating tasks"
    100.times do
      t = Task.new
      t.company_id = Company.first(offset: rand(Company.count)).id
      t.user_id = User.first(offset: rand(User.count)).id
      t.title = Faker::Lorem::words(1..3).join(' ')
      t.info = t.info = Faker::Lorem::sentences(2..5).join(' ')
      t.schedule = Schedule.new(kind: :none)

      unless t.save
        puts "task had errors: #{u.errors.full_messages}"
      end

      rand(5).times do
        st = Task.new
        st.company_id = t.company_id
        st.user_id = User.first(offset: rand(User.count)).id
        st.title = Faker::Lorem::words(1..3).join(' ')
        st.info = Faker::Lorem::sentences(2..5).join(' ')
        st.schedule = Schedule.new(kind: :none)

        unless st.save
          puts "subtask had errors: #{st.errors.full_messages}"
        end
        st.move_to_child_of(t)
      end
    end
  end  
end