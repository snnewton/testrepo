$[/myProject/rubyHeader]
require 'ec'

# ======================================================================
# Define global variables
# ======================================================================

$projectLink = "$[projToDelete]"
$deleteLink = "z_$[projToDelete]-delete"

# ======================================================================
# Declare Methods
# ======================================================================

def delete_project_and_links()

  # Delete project

  puts "$[confirmDeleteProject]"

  # Check for confirmation
  if $[confirmDeleteProject] != true
    exit(1)
  end

  puts "Deleting #{$projectLink}"
  begin
    EC::Project.delete_project($projectLink)
    puts "#{$projectLink} deleted"
  rescue
    puts '#{$projectLink} does not exist.'
  end


  #Delete links

  puts "Deleting homepage links"
  begin
    user = ElectricCommander::User.new( "$[launchedByUser]" )

    user.delete_property("userSettings/shortcuts/#{$projectLink}")
    #user.delete_property("userSettings/shortcuts/#{$projectLink}/shortcutName")
    #user.delete_property("userSettings/shortcuts/#{$projectLink}/url")

    # Removal Link
    user.delete_property("userSettings/shortcuts/#{$deleteLink}")
    #user.delete_property("userSettings/shortcuts/#{$deleteLink}/shortcutName")
    #user.delete_property("userSettings/shortcuts/#{$deleteLink}/url")

    puts "#{$projectLink} deleted"
  rescue
    puts "$[launchedByUser] is not a real user"
  end

end

# ======================================================================
# Main Algorithm
# ======================================================================

delete_project_and_links()

exit(true)
