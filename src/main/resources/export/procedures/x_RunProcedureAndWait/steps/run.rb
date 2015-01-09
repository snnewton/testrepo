$[/myProject/rubyHeader]
require 'ec'

project_name     = "$[projectToRun]"
procedure_name   = "$[procedureToRun]"
expected_outcome = "$[expectedOutcome]"
ignore_missing   = "$[ignoreMissingProcedureError]" =~ /^(true|yes|1)$/

#--------------------------------------------------------------------------------
# Lookup project and procedure.
# It is an error if either project or procedure do not exist
#--------------------------------------------------------------------------------

project   = nil
procedure = nil

begin
  project   = ElectricCommander::Project::new(project_name)
  procedure = ElectricCommander::Procedure::new(project, procedure_name)

rescue
  print "Project or procedure does not exist: #{project_name}:#{procedure_name} -- "
  if ignore_missing
    puts("(Ignoring)")
    exit(true)
  end
  puts("(Aborting)")
  exit(false)
end

#--------------------------------------------------------------------------------
# Run the procedure and catch exceptions
#--------------------------------------------------------------------------------

hash = { $[additionalArgsToRunProcedure] }
hash.merge!( { :linkName => "$[subJobLinkName]" } )

puts("\nRunning procedure: #{project.name}:#{procedure.name}")
job = procedure.run( hash )
puts("Procedure running as: #{job.name} (#{job.id})")

# Set "subJobId" property on parent
ElectricCommander::Commander::set_property("/myParent/subJobId", job.id())

# Wait for job to complete
job.wait

status = true
actual_outcome = job.outcome()
puts("\nJob completed with '#{actual_outcome}'")
if actual_outcome !~ /^#{expected_outcome}$/
  puts("ERROR: Expected outcome of '#{expected_outcome}' but job completed with '#{actual_outcome}'")
  status = false
end

# Update link and append PASS or FAIL
EC::Commander.get_property("/myJob/report-urls").get_properties().each do |prop|
#  puts "#{prop.name} ==> #{prop.value} == /commander/link/jobDetails/jobs/#{job.id}"
  if prop.value == "/commander/link/jobDetails/jobs/#{job.id}"
    EC::Commander.delete_property("/myJob/report-urls/#{prop.name}")
    EC::Commander.set_property("/myJob/report-urls/#{prop.name} - #{status ? "PASS" : "FAIL"}", prop.value)
  end
end

exit(status)
