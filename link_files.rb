#!/usr/bin/env ruby
require 'json'

CONFIGPATH = "./config.json"

module JsonConfig
  if !File.exists?(CONFIGPATH) 
    puts "NO CONFIG FILE"
    puts "Creating config at " + File.absolute_path(CONFIGPATH)
    File.open(CONFIGPATH, "w") {|f| f.write("{\n\t\"links\": {\n\t\t\n\t}\n}")}
  end

  json_str = File.open(CONFIGPATH, "rb").read
  @json = JSON.parse(json_str);

  def JsonConfig.from_files
    @json["links"].keys
  end
  def JsonConfig.to_files
    @json["links"].values
  end
  def JsonConfig.each_file
    @json["links"].each_pair do |key, value|
      yield key, value
    end
  end
end

def user_says_yes?
  input = gets.chomp
  if (input != "" && "yY".include?(input)) || "yes" == input.downcase
    return true
  end
  return false
end

module OS
  def OS.windows?
    (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
  end

  def OS.mac?
   (/darwin/ =~ RUBY_PLATFORM) != nil
  end

  def OS.unix?
    !OS.windows?
  end

  def OS.linux?
    OS.unix? and not OS.mac?
  end
end #http://stackoverflow.com/questions/170956/how-can-i-find-which-operating-system-my-ruby-program-is-running-on

class Linker
  @files = nil

  def initialize
    # grab all files in/beneath working directory which end in symlink
    @files = Dir[Dir.getwd + "/**/*symlink"]
  end

  def getFilesToLink
    @files
  end

  def Linker.link(fromA, toB) 
    if !File.exists?(fromA)
      throw ("file " + fromA + " does not exist")
    end
    if File.exist?(toB)
      printf "Do you want to overwrite %s? (y/n)",  toB
      if !user_says_yes?
        return false
      end
    end
    fromA = File.expand_path(fromA)
    toB = File.expand_path(toB)
    `ln -s #{fromA} #{toB}`
  end

  # def linkAll()
  #   getFilesToLink().each do |file| 
  #     link (file, )
  #   end
  # end
end


puts "==========================="
# puts JsonConfig.from_files
# puts JsonConfig.to_files

printf "Linking\n   "
JsonConfig.each_file { | from_file, to_file |
  printf "%s to %s\n   ", from_file, to_file
  Linker.link(from_file, to_file)
}
puts ""
puts "Linking completed."

# puts "Linking"
# linker.getFilesToLink.each do |file|
#   printf "   Link %s :: %s\n", file, "~"
#   linker.link(file, "~")
# end