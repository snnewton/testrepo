require "ec"


def recurse_property(arg,level, indent="")
    if arg.is_property_sheet? then
      puts "#{indent} #{level} - Getting sub properties for '#{arg.name}'"
      arg.get_properties().each do | comp |
        recurse_property(comp,level+1,indent + "  ")
      end
    else
      puts "#{indent} #{level} - #{arg.name}"
    end
end



cdProj = EC::Project.new("ContinuousDeliveryData")
prop = cdProj.get_property("components")


recurse_property(prop,0)




