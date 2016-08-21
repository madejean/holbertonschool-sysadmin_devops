#!/usr/bin/ruby
require 'aws-sdk'
require 'optparse'
require 'yaml'

options = {}

OptionParser.new do |opts|
    opts.banner = "Enter option:"
    opts.on("-a", "--action [action]", [:list, :upload, :delete, :download], "Please select action") do |a|
      options[:action] = a
    end

    opts.on("-h", "--help") do
      puts opts
      exit
    end

end.parse!

if options[:action].nil? then
  raise OptionParser::MissingArgument, "Missing option"
end

config = YAML::load_file("config.yaml")
client = Aws::S3::Client.new({
    access_key_id: config['access_key'],
    secret_access_key: config['secret_access_key'],
    region: 'us-west-2',
    })
bucket = s3_resource.bucket(options.bucketname)

  if options[:action] == :list then
    s3 = Aws::S3::Resource.new(client: client)
    s3.buckets.each do |bucket|
    puts bucket.name
  end

  elsif options[:action] == :upload then
    s3 = Aws::S3::Resource.new(client: client)
    s3.bucket(options.bucketname).object(bucket.key).upload_file(options.filepath)

  elsif options[:action] == :delete then
    s3 = Aws::S3::Resource.new(client: client)
    bucket.delete_objects({
      delete: {
        objects: [
          key: bucket.key,
          ],
        },
      })

  elsif options[:action] == :download then
    s3 = Aws::S3::Resource.new(client: client)
    resp = s3.get_object(options.bucketname, bucket.key)
    resp.body

  end
