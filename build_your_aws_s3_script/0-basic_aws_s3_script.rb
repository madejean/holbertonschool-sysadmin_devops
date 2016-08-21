#!/usr/bin/ruby
require 'aws-sdk'
require 'optparse'
require 'yaml'

options = {}

OptionParser.new do |opts|
    opts.banner = "Usage: 0-basic_aws_s3_script.rb [options]"
    opts.on("-a", "--action [action]", [:list, :upload, :delete, :download], "Please select action") do |a|
      options[:action] = a
    end

    opts.on("-v", "--verbose", "Run verbosely") do |v|
        options[:verbose] = v
      end

    opts.on("-b", "--bucketname=BUCKET_NAME", "Name of the bucket to perform the action on") do |b|
        options[:bucket_name] = b
      end

    opts.on("-f", "--filepath=FILE_PATH", "Path to the file to upload") do |f|
        options[:file_path] = f
      end

    opts.on("-h", "--help") do
        puts opts
          exit
      end

end.parse!

if options[:action].nil? then
  #raise OptionParser::MissingArgument, "Missing option"
end

config = YAML::load_file("config.yaml")
client = Aws::S3::Client.new({
    access_key_id: config['access_key'],
    secret_access_key: config['secret_access_key'],
    region: 'us-west-2',
    })
bucket = s3.bucket(options.bucketname)

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
