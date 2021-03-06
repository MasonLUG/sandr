require 'getoptlong'
$a=0
$argsgiven=false
opts = GetoptLong.new(
  [ '--help', '-h', GetoptLong::NO_ARGUMENT ],
  [ '--file', '-f', GetoptLong::REQUIRED_ARGUMENT ],
  [ '--search', '-s', GetoptLong::REQUIRED_ARGUMENT],
  [ '--replace', '-r', GetoptLong::REQUIRED_ARGUMENT],
  [ '--directory', '-d', GetoptLong::REQUIRED_ARGUMENT],
)
opts.each do |opt, arg|
  case opt
    when '--help' || '-h'
      puts <<-EOF

sandr can be run with no arguments, it takes values from a config file which it will create when it runs.  The search value will be replaced by the replace value specified.  If a file and no directory is specified, the file specified in the current directory will be modified.  If a directory and no file is specified, all files within the directory will be modified.  If a file AND a directory are specified, only that file will be modified within the specified directory.
operations:
	sandr {-h --help}
	sandr {-f --file} <file>
	sandr {-s --search} <value>
	sandr {-r --replace} <value>
	sandr {-d --directory} <v/a/l/u/e>
	EOF
      abort("")
    when '--file' || '-f'
      $argsgiven=true
      $filetosandr=File.new(arg,"a+")
    when '--search' || '-s'
      $argsgiven=true
      $search=arg
    when '--replace' || '-r'
      $argsgiven=true
      $replace=arg
    when '--directory' || '-d'
      $dir=Dir.new(arg)
      if !(Dir.exists?($dir))
        abort("The specified directory does not exist");
      end
      $argsgiven=true
  end
end
def sandr(f,s,r)
  puts "Searching in file "+File.basename(f) + " for the value: "+ s+" to be replaced by: "+r	
  File.open(f,"a+") do |config|	
    contents = File.read(f)
    File.open(f,"w+")
    contents = contents.gsub(s, r)
    f.syswrite(contents)
    f.close	
  end
end
def sandrdir
  af=Dir.entries($dir)
  i=0
  Dir.chdir($dir)
  while i < af.length
    if af[i]=="."||af[i]==".."
    else
      temp=File.new(af[i],"a+")
      sandr(temp,$search,$replace)
    end
    i=i+1
  end
end
def check
  if $argsgiven==true
    if !(($filetosandr!=nil && $search!=nil && $replace!=nil) || ($dir!=nil && $search!=nil && $replace!=nil))
      abort( "If specified: either (file or directory), search, and replace all need proper arguments\n(try --help)")      
    end
    if $dir==nil
      sandr($filetosandr,$search,$replace)
    elsif $filetosandr!=nil
      Dir.chdir($dir)
      $filetosandr=File.new($filetosandr,"a+")
      sandr($filetosandr,$search,$replace)
    else
      sandrdir
    end
  elsif File.exists?("config") && !(File.zero?("config"))
    line = IO.readlines("config")
    if line[0][0,2]=="d="
      $dir=line[0][2,line[0].length].chop
      $search=line[1].chop
      $replace=line[2].chop
      sandrdir
    elsif line[0][0,2]=="f="
      filetosandr = File.new(line[0][2,line[0].length].chop,"a+")
      search = line[1].chop
      replace = line[2].chop
      sandr(filetosandr,search,replace)
    else
      puts "Config file is missing or corrupt, attempting to delete it now"
      File.delete("config")
      check
    end
  else
    puts "No configuration file found!"
    puts "Generating a new one now..."
    config = File.new("config","w+")
    properinput=0
    while properinput==0
      puts "Would you like to modify an entire folder of files?(y/n)"
      qin=gets.chop
      if (qin=="y" || qin=="yes" || qin=="Yes" || qin=="YES")
        puts "Please enter the directory"
        inputdir=gets.chop
        $dir=Dir.new(inputdir)
        if !(Dir.exists?($dir))
          puts "The specified directory does not exist"
        else
          config.syswrite("d="+inputdir+"\n")
          properinput=properinput+1
        end
      elsif (qin=="n" || qin=="no" || qin=="No" || qin=="NO")   
        puts "Please enter the name of the file to be searched"
        fileg = gets
        config.syswrite("f="+fileg)
        properinput=properinput+1
      else
        puts "Invlaid input, try again"
      end
    end
    puts "\nPlease enter the value to search for"
    searchg = gets
    config.syswrite(searchg)
    puts "\nPlease enter the value to replace all found instances"
    replaceg = gets
    config.syswrite(replaceg)
    config.close
    check
  end
end
if $a==0 then
  $a+=1
  check
end
