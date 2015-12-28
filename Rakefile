task :build do
	sh "gem build pickle-mongodb.gemspec"
end

task :localinstall do
	sh "gem install ./pickle-mongodb-0.5.gem"
end

task :push do
	sh "gem push ./pickle-mongodb-0.5.gem"
end
