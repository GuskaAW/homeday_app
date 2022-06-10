# frozen_string_literal: true

desc 'fill db with realtors from json'
namespace :realtor do
  task fill_db_with_realtors: :environment do
    file = File.read(Rails.root.join('realtors.json'))
    JSON.parse(file).each do |json_realtor_object|
      Realtor.create!(json_realtor_object)
    end
  end
end
# Hint:
# https://stackoverflow.com/questions/68837026/how-to-fill-modeldatabase-in-ruby-on-rails-with-json-file
