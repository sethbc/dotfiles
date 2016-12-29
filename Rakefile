require 'rake'
require 'erb'

desc "install the dot files into user's home directory"
task :install do
  replace_all = false
  Dir['*'].each do |file|
    next if %w[Rakefile Brewfile README.md osx.sh].include? file
    if File.exist?(File.join(ENV['HOME'], ".#{file.sub('.erb', '')}"))
      if File.identical? file, File.join(ENV['HOME'], ".#{file.sub('.erb', '')}")
        puts "identical ~/.#{file.sub('.erb', '')}"
      elsif replace_all
        replace_file(file)
      else
        print "overwrite ~/.#{file.sub('.erb', '')}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file)
        when 'y'
          replace_file(file)
        when 'q'
          exit
        else
          puts "skipping ~/.#{file.sub('.erb', '')}"
        end
      end
    else
      link_file(file)
    end
  end
end

def replace_file(file)
  system %Q{rm -rf "$HOME/.#{file.sub('.erb', '')}"}
  link_file(file)
end

def link_file(file)
  if file =~ /.erb$/
    puts "generating ~/.#{file.sub('.erb', '')}"
    File.open(File.join(ENV['HOME'], ".#{file.sub('.erb', '')}"), 'w') do |new_file|
      new_file.write ERB.new(File.read(file)).result(binding)
    end
  else
    puts "linking ~/.#{file}"
    system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
  end
end

desc "compress git submodules"
task :compress do
  system "git submodule foreach --recursive 'git gc --aggressive'"
end

desc "Clean the docs"
task :clean do
  system "git clean -dfx"
  system "git submodule foreach --recursive 'git clean -dfx'"
end

desc "Install"
task :default => [
  :pull,
  :update_vim,
  :install
]

desc "initialize the git repo after cloning (without --recursive)"
task :init do
  system "git submodule init"
  system "git submodule update"
end

desc "Update all submodules.  Remember to commit after."
task :pull do
  system "git pull"
  system "git submodule foreach git pull"
end

desc "Prepare System"
task :prepare_system do
  system "./install-software.sh"
end

desc "Change default shell to zsh"
task :change_shell do
  sh "chsh -s /bin/zsh"
end

desc "update vim"
task :update_vim do
  Dir.chdir 'spf13-vim-3' do
    system "vim +BundleInstall! +BundleClean +q"
  end
end

task :bootstrap => [
#  :prepare_system,
  :change_shell,
  :init
]
