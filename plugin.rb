# name: ignore-list
# about: this plugin let you ignore some user's posts
# version: 0.0.1
# authors: Jonathan Cambier

enabled_site_setting :ignored_users_enabled

DiscoursePluginRegistry.serialized_current_user_fields << "ignored_users"
PLUGIN_NAME = "ignored_users".freeze
after_initialize do
  User.register_custom_field_type('ignored_users', :text)

  if SiteSetting.ignored_users_enabled then

    add_to_serializer(:user, :custom_fields, false) {
      if object.custom_fields == nil then
        {}
      else
        object.custom_fields
      end
    }
  end
end

register_asset "javascripts/discourse/templates/connectors/user-custom-preferences/ignored_users-preferences.hbs"
