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

  def JsonConfig.fromFiles
    @json["links"].keys
  end
  def JsonConfig.toFiles
    @json["links"].values
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

  def link(fromA, toB) 
    if !File.exists?(fromA)
      throw ("file " + fromA + " does not exist")
    end
    if File.exist?(toB)
      printf "Do you want to overwrite %s? (y/n)",  toB
      if !user_says_yes?
        return false
      end
    end
    `ln -s #{fromA} #{toB}`
  end

  # def linkAll()
  #   getFilesToLink().each do |file| 
  #     link (file, )
  #   end
  # end
end


puts "==========================="
puts JsonConfig.fromFiles
puts JsonConfig.toFiles

linker = Linker.new

puts "Files to be linked"
linker.getFilesToLink.each do |file|
  puts "   " + file
end


puts "Linking"
linker.getFilesToLink.each do |file|
  printf "   Link %s :: %s\n", file, "~"
  linker.link(file, "~")
end