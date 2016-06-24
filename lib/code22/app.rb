
module Code22
 class App
    #!/usr/bin/env ruby
  require 'gli'
  begin # XXX: Remove this begin/rescue before distributing your app
  rescue LoadError
    STDERR.puts "In development, you need to use `bundle exec bin/code22` to run your app"
    STDERR.puts "At install-time, RubyGems will make sure lib, etc. are in the load path"
    STDERR.puts "Feel free to remove this message from bin/code22 now"
    exit 64
  end
  extend GLI::App # those class are class method now
  program_desc 'Describe your application here'

  version Code22::VERSION

  subcommand_option_handling :normal
  arguments :strict

  desc 'Describe some switch here'
  switch [:s,:switch]

  desc 'Describe some flag here'
  default_value 'the default'
  arg_name 'The name of the argument'
  flag [:f,:flagname]

  desc 'Describe write here'
  arg_name 'Describe arguments to write here'
  #arg :name => :required
  command :write do |c|
    c.desc 'Describe a switch to write'
    c.switch :s

    c.desc 'Describe a flag to write'
    c.default_value 'default'
    c.flag :f

    c.action do |global_options,options,args|

      class Language
        def initialize(name,creator)
          @name= name

          @creator= creator
        end
        def description
          puts " I'm #{@name} and i created by #{@creator}!"
        end
      end
      ruby=Language.new(args[0],"Yuki") # new is a class method because call by calls
      ruby.description # description is an instance method because call by object
      paython=Language.new(args[1],"Gido")
      java=Language.new(args[2],"Brendan")
      paython.description
      java.description




      # Your command logic here

      # If you have any errors, just raise them
      # raise "that command made no sense"

      puts "write command ran"
    end
  end

  desc 'Describe read here'
  arg_name 'Describe arguments to read here'
  command :read do |c|
    c.action do |global_options,options,args|
     class Computer
        $manufacturer= "Mango computer, Inc"  #global veriable
        @@files= {hello: "hello, world!"} # class veriables
        def initialize(username,password)
          @username= username
          @password= password
        end
        def current_user
         @username
        end
        def self.display_files
          @@files
        end
      end

     hal= Computer.new(args[0],args[1])
     puts "current user: #{hal.current_user}"
     puts "Manufacture:#{$manufacturer}"
     puts "files: #{Computer.display_files}"
      puts "read command ran"
    end
  end

  pre do |global,command,options,args|
    # Pre logic here
    # Return true to proceed; false to abort and not call the
    # chosen command
    # Use skips_pre before a command to skip this block
    # on that command only
    true
  end

  post do |global,command,options,args|
    # Post logic here
    # Use skips_post before a command to skip this
    # block on that command only
  end

  on_error do |exception|
    # Error logic here
    # return false to skip default error handling
    true
  end

  #exit run(ARGV)
  end
end
