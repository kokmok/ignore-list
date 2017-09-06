# name: ignore-list
# about: this plugin let you ignore some user posts
# version: 0.0.1
# authors: Jonathan Cambier

DiscoursePluginRegistry.serialized_current_user_fields << "ignored-users" #to change for a dynamic use later
after_initialize do
  User.register_custom_field_type('ignored-users', :text)

  # add_to_serializer(:user, :custom_fields, false) {
  #   if object.custom_fields == nil then
  #     object.custom_fields['ignored-users']
  #   else
  #     object.custom_fields
  #   end
  # }

end