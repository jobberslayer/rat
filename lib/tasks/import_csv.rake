require 'csv'

DEFAULT_TEST_USER = 'traceylester@gmail.com'

namespace :db do
  namespace :import do
    desc "csv import"
    task :csv => [:environment] do
      csv_text = File.read('lib/assets/import.csv')
      csv = CSV.parse(csv_text, headers: false)
      csv.each do |row|
        (company, cat, title, info, email) = row

        if info.nil? || info.empty?
          info = title
        end

        comp = Company.where(name: company).first
        if comp.nil?
          comp = Company.new(name: company, info: company)
          comp.save
          puts "Created #{comp.name}"
          comp.errors.messages
        end

        gory = Category.where(name: cat).first
        if gory.nil?
          gory = Category.new(name: cat, description: cat)
          gory.save
          gory.errors.messages
          puts "Created #{gory.name}"
        end

        if email.nil? || email.empty?
          email = DEFAULT_TEST_USER
        end

        user = User.where(email: email).first
        if user.nil?
          abort "Need a user that already exists."
        end

        t = Task.new(company_id: comp.id, category_id: gory.id, user_id: user.id, title: title, info: info)
        t.schedule = Schedule.new()
        t.save
        puts t.errors.messages
        puts "Created #{title}"
      end
    end
  end
end 
