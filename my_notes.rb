#!/usr/bin/env ruby
# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'erb'
require 'json'
require 'securerandom'
require 'date'
require 'pg'

def make_db_name
  'my_notes'
end

def make_table_name
  'notes'
end

def make_connection
  PG.connect(dbname: make_db_name)
end

before do
  connection = PG.connect(dbname: make_db_name)
  @notes = connection.exec("SELECT * FROM #{make_table_name}")
end

helpers do
  def h(str)
    Rack::Utils.escape_html(str)
  end
end

set :show_exceptions, :after_handler if :environment == :production

error do
  "エラーが発生しました。 - #{env['sinatra.error'].message}"
end

not_found do
  status 404
  erb :page_not_found
end

def make_app_name
  'My Notes'
end

def make_home_path
  '/home'
end

def get_target_note_from_notes(notes, note_id)
  notes.find { |note| note['id'] == note_id }
end

def get_target_note(id)
  # json_data = make_json_data
  # get_target_note_from_notes(json_data['notes'], id)
  # connection = PG.connect(dbname: 'my_notes')
  # connection.exec("SELECT * FROM #{make_table_name} WHERE id = #{id}").first
  @notes.find{|note| note['id'] == id}
end

module Add
  class << self
    def add_note_to_json(params, id = nil)
      connection = make_connection
      sql = make_sql(params, id)
      connection.exec(sql)
    end

    private

    def make_sql(params, id)
      title = params[:title] == '' ? '（無題）' : params[:title]
      if id.nil?
        "INSERT INTO #{make_table_name} (title, content) VALUES ('#{title}', '#{params[:content]}')"
      else
        "INSERT INTO #{make_table_name} (id, title, content) VALUES ('#{id}', '#{title}', '#{params[:content]}')"
      end
    end
  end
end

module Delete
  class << self
    def delete_note_from_json(id)
      connection = make_connection
      connection.exec("DELETE FROM #{make_table_name} WHERE id = #{id}")
    end
  end
end

get make_home_path do
  @title = "ホーム / #{make_app_name}"
  # json_data = make_json_data
  # @notes = json_data['notes']
  # @notes = connection.exec("SELECT * FROM #{make_table_name}")
  erb :home
end

get '/new' do
  @title = "新規メモの追加 / #{make_app_name}"
  erb :new
end

post '/new' do
  Add.add_note_to_json(params)
  redirect to(make_home_path)
end

get '/notes/:id' do |id|
  @note = get_target_note(id)
  @title = "メモ: #{@note['title']} / #{make_app_name}"
  erb :note
rescue NoMethodError
  erb :page_not_found
end

get '/notes/:id/edit' do |id|
  @note = get_target_note(id)
  @title = "変更: #{@note['title']} / #{make_app_name}"
  erb :edit
end

delete '/notes/:id' do |id|
  Delete.delete_note_from_json(id)
  redirect to(make_home_path)
end

patch '/notes/:id/edit' do |id|
  Delete.delete_note_from_json(id)
  Add.add_note_to_json(params, id)
  redirect to(make_home_path)
end
