$[/myProject/rubyHeader]
require 'ec'

src_project_name = "$[SourceProject]"
tgt_project_name = "$[TargetProject]"

src_procedure_name = "$[SourceProcedure]"
tgt_procedure_name = "$[TargetProcedure]"

src_path = "/projects/#{src_project_name}/procedures/#{src_procedure_name}"
tgt_path = "/projects/#{tgt_project_name}/procedures/#{tgt_procedure_name}"

overwrite       = "$[Overwrite]"     == "true"
move_procedure  = "$[MoveProcedure]" == "true"
export_file     = "#{ENV["COMMANDER_WORKSPACE"]}/export-$[/myJob/jobId]"

tgt_project        = nil
begin
  tgt_project = EC::Project.new(tgt_project_name)
rescue
  tgt_project = EC::Project.create_project(tgt_project_name)
end

src_project = nil
src_procedure = nil
begin
  src_project   = EC::Project.new(src_project_name)
  begin
    src_procedure = EC::Procedure.new(src_project, src_procedure_name)

  rescue => e
    puts "Source procedure not found: #{src_procedure_name}"
    puts e
    exit false
  end
rescue => e
  puts "Source project not found: #{src_project_name}"
  puts e
  exit false
end


puts "Exporting #{src_path} to #{export_file}"
EC::Commander.export(export_file, {path: src_path, relocatable: true})

# If project names are different, change all references to src project to target project
`sed --in-place -e #s/#{src_project_name}/#{tgt_project_name}/g"`

puts "Importing #{export_file} to #{tgt_path}"
EC::Commander.import(export_file, {path: tgt_path, force: overwrite})

# delete source location if move enabled
if (move_procedure)
  puts "Removing source procedure: #{src_procedure_name}"
  src_procedure.delete
end
