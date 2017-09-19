# name: ignore-list
# about: this plugin let you ignore some user posts
# version: 0.0.1
# authors: Jonathan Cambier

DiscoursePluginRegistry.serialized_current_user_fields << "ignored_users" #to change for a dynamic use later
PLUGIN_NAME = "ignored_users".freeze
after_initialize do
  User.register_custom_field_type('ignored_users', :text)

  Rails.logger.error("IgnoredUsers v: 10");
  Rails.logger.error("IgnoredUsers v: user_field_#{(UserField.find_by name: 'ignored_users').id}}");

  module ::IgnoreList
    class Engine < ::Rails::Engine
      engine_name PLUGIN_NAME
      isolate_namespace IgnoreList
    end
  end

  require_dependency "application_controller"
  class IgnoreList::IgnoreController < ::ApplicationController

    def get_list
      Rails.logger.info('IgnoredUsers list v6')
      Rails.logger.info("IgnoredUsers: #{current_user.custom_fields}")
      render json: current_user
    end
  end

  IgnoreList::Engine.routes.draw do
    get '/list' => 'ignore#get_list'
    post "/unaccept" => "answer#unaccept"
  end

  Discourse::Application.routes.append do
    mount ::IgnoreList::Engine, at: "ignored_users"
    #get "topics/voted-by/:username" => "list#voted_by", as: "voted_by", constraints: {username: USERNAME_ROUTE_FORMAT}
  end



  add_to_serializer(:user, :custom_fields, false) {
    if object.custom_fields == nil then
      "it' nil"
    else
      object.custom_fields
    end
  }
  add_to_serializer(:user, :ignored_users_key, false) {
    if object.custom_fields == nil then
      "it' nil"
    else
      "user_field_#{(UserField.find_by name: 'ignored_users').id}"
    end
  }

end
