$[/myProject/rubyHeader]
require 'ec'

user = "$[launchedByUser]"

if user =~ /^project:/
  new_project_name = "$[/myProject/projectName]-$[projectNameSuffix]"
else
  new_project_name = "$[/myProject/projectName]-#{user}-$[projectNameSuffix]"
end

puts "New project name: #{new_project_name}"

my_job = ElectricCommander::Job.my_job
my_job.set_property( "newProjectName", new_project_name )
