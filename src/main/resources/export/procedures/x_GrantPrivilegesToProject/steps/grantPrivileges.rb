$[/myProject/rubyHeader]
require 'ec'

pname = "$[targetProjectName]"

#---------------------------------------------------------------------------------
# Grant the new ContinuousDelivery plugin privileges it will need. 
# Any privileges needed to run the ContinuousDelivery acceptance tests should be granted here 
# (and in the GrandAdditionalPrivilegesToTestProject procedure)
#---------------------------------------------------------------------------------

puts "Creating ACL Entry for #{pname} to be able to modify $[/myProject/dataProjectName] such as build numbers (and grant that right to later versions)."
begin
  EC::AclEntry.create_acl_entry("user", "project: #{pname}",
                                { projectName:                "$[/myProject/dataProjectName]",
                                  modifyPrivilege:            "allow",
                                  changePermissionsPrivilege: "allow" })
rescue => e
  puts e
end

puts "Creating ACL Entry for #{pname} to be able to import new versions of plugins (and grant that right to later versions)."
begin
  EC::AclEntry.create_acl_entry("user", "project: #{pname}",
                                { systemObjectName:           "plugins",
                                  modifyPrivilege:            "allow",
                                  changePermissionsPrivilege: "allow" })
rescue => e
  puts e
end

puts "Creating ACL Entry for #{pname} to be able to import projects (and grant that right to later versions)."
begin
  EC::AclEntry.create_acl_entry("user", "project: #{pname}",
                                { systemObjectName:           "admin",
                                  modifyPrivilege:            "allow",
                                  changePermissionsPrivilege: "allow" })
rescue => e
  puts e
end

puts "Creating ACL Entry for #{pname} to be able to delete projects (and grant that right to later versions)."
begin
  EC::AclEntry.create_acl_entry("user", "project: #{pname}",
                                { systemObjectName:           "projects",
                                  modifyPrivilege:            "allow",
                                  changePermissionsPrivilege: "allow" })
rescue => e
  puts e
end
	
puts "Creating ACL Entry for #{pname} to be able to create and delete resource pools (and grant that right to later versions)."
begin
  EC::AclEntry.create_acl_entry("user", "project: #{pname}",
                                { systemObjectName:           "resources",
                                  modifyPrivilege:            "allow",
                                  changePermissionsPrivilege: "allow" })
rescue => e
  puts e
end


puts "Creating ACL Entry for #{pname} to be able to start jobs at heightened priority (and grant that right to later versions)"
begin
  EC::AclEntry.create_acl_entry("user", "project: #{pname}",
                                { systemObjectName:           "priority",
                                  executePrivilege:           "allow",
                                  changePermissionsPrivilege: "allow" })
rescue => e
  puts e
end

