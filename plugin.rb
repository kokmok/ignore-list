# name: ignore-list
# about: this plugin let you ignore some user's posts
# version: 0.0.1
# authors: Jonathan Cambier

DiscoursePluginRegistry.serialized_current_user_fields << "ignored_users" #to change for a dynamic use later
PLUGIN_NAME = "ignored_users".freeze
after_initialize do
  User.register_custom_field_type('ignored_users', :text)

  Rails.logger.error("IgnoredUsers v: 0.1");

  module ::IgnoreList
    class Engine < ::Rails::Engine
      engine_name PLUGIN_NAME
      isolate_namespace IgnoreList
    end
  end

  add_to_serializer(:user, :custom_fields, false) {
    if object.custom_fields == nil then
      {}
    else
      object.custom_fields
    end
  }
  add_to_serializer(:user, :ignored_users_key, false) {
    if object.custom_fields == nil then
      {}
    else
      "user_field_#{(UserField.find_by name: 'ignored_users').id}"
    end
  }

end
