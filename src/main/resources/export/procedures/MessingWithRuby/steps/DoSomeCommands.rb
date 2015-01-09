require "ec"

# do some electric commander stuff here

EC::Commander.set_property("/myJob/xxx", "someValue")
jinfo = EC::Commander.get_property("/myJob/xxx")
puts jinfo


EC::Project.get_projects().each do |value|
  puts value.name if value.name =~ /BuildOps/
end


#EC::Job.find_jobs({ propertyName: "projectName", operator: "equals", operand1: "BuildOps" } ).each do |str|


#EC::Job.find_jobs({}).each do |str|
#  puts "Aborted job: #{str.name}" if str.abort_status == "ABORT"
#  puts "Elapsed time: #{str.elapsed_time}" if str.elapsed_time > 5000
#  puts "Started by: #{str.launched_by_user}"
#end


#name = myproj.get_property("projectName").value
#puts name
#puts myproj.name

