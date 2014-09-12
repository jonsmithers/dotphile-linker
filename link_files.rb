#!/usr/bin/env ruby
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
    puts @files
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
end


puts "==========================="
l = Linker.new
l.link("./folder/myfile", "./destination")
