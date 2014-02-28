def parse_json(schedule_path)
#pre-conditions:
#A valid schedule.json file
#A valid absolute path to schedule.json specified by schedule_path
#
#post-conditions:
#Array of hashes is populated by data in schedule.json
#
#Side effects:
#
  if !Dir.exist?(schedule_path) #checks validity of argument
    abort("Invalid path to schedule.json!")
  end
  Dir.chdir(schedule_path) #sets working directory to schedule_path
  if !File.exist?("schedule.json") #ensures schedule.json exists in schedule_path
    abort("No schedule.json file in the specified directory!")
  end

  #implement method to check if schedule.json is formatted correctly here

  schedule = File.new("schedule.json", "r") #load schedule.json for reading

  $schedule = Array.new(20) { Hash.new } #initializes array for storage of schedule.json #implement way of determining needed size

  until schedule.readline == nil do #read until end of file
    #fill $schedule here
  end
end
def replace(template_path, schedule)
#pre-conditions:
#A valid Array, schedule, via parse_json
#A valid absolute path to a template file specified by template_path
#
#post-conditions:
#A new file based on the specified template with the relevant data from schedule inserted
#
#Side effects:
#Generates a new file with the same name as the template

end
