$[/myProject/rubyHeader]
require 'ec'

# ======================================================================
# Define global variables
# ======================================================================
$project_created = EC::Project.new("$[linkToProject]")

proj_name        = "$[linkToProject]"
user_name        = "$[launchedByUser]"
proj_link_path   = "userSettings/shortcuts/#{proj_name}"
delete_link_path = "userSettings/shortcuts/z_#{proj_name}-delete"

begin

  #Create project homepage link
  user = ElectricCommander::User.new( user_name )
  user.set_property("#{proj_link_path}/shortcutName", proj_name)
  user.set_property("#{proj_link_path}/url",          "link/projectDetails/projects/#{proj_name}")

  # Create property sheet to pass to deletion script
  $project_created.set_property("deleteLinks/actualParameter0/actualParameterName", "projToDelete")
  $project_created.set_property("deleteLinks/actualParameter0/value", proj_name)
  $project_created.set_property("deleteLinks/numParameters", "1")

  # Create project deletion homepage link
  user.set_property("#{delete_link_path}/shortcutName", "DELETE: #{proj_name}")

#user.set_property("#{delete_link_path}/url", "https://$[/server/ecServerAlias]/commander/link/runProcedure/projects/$\[/plugins/ContinuousDelivery/projectName]/procedures/x_DeleteHomepageLinksAndProject?configurationPath=/projects/#{proj_name}/deleteLinks", {expand: false})

  user.set_property("#{delete_link_path}/url", "https://$[/server/ecServerAlias]/commander/link/runProcedure/projects/PROJECT-NAME-MAJOR.MINOR/procedures/x_DeleteHomepageLinksAndProject?configurationPath=/projects/#{proj_name}/deleteLinks", {expand: false})

rescue => e
  puts "#{user_name} is not a real user"
  puts e
  exit(false)
end
