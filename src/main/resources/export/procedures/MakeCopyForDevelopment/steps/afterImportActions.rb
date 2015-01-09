$[/myProject/rubyHeader]
require 'ec'

project_name = "$[newProjectName]"
project = ElectricCommander::Project.new( project_name )

# Make the new project visible
project.set_property( "ec_visibility", "all" )

# Put a link on the myJob page
job_link = "/commander/link/projectDetails/projects/#{project_name}"
ElectricCommander::Job.my_job.set_property( "report-urls/#{project_name}", job_link )

puts "Creating ACL Entry for #{project_name} to be able to modify SLIDE-Data such as build numbers."
ElectricCommander::AclEntry.delete_acl_entry( "user", "project: #{project_name}", 
                                              { :projectName => "$[/myProject/dataProjectName]" } )
ElectricCommander::AclEntry.create_acl_entry( "user", "project: #{project_name}",
                                              { :projectName => "$[/myProject/dataProjectName]", :modifyPrivilege => "allow" } )

puts "Creating ACL Entry for $[launchedByUser] to be able to modify the new project."
ElectricCommander::AclEntry.delete_acl_entry( "user", "$[launchedByUser]",
                                              { :projectName => project_name } )
ElectricCommander::AclEntry.create_acl_entry( "user", "$[launchedByUser]",
                                              { :projectName => project_name, 
                                                :modifyPrivilege => "allow",
                                                :changePermissionsPrivilege => "allow" } )
