#!/usr/bin/ruby
require 'aws-sdk'
require 'optparse'
require 'yaml'

options = {}

OptionParser.new do |opts|
    opts.banner = "Enter option:"
    opts.on("-a","--action [ACTION]", [:launch, :stop, :start, :terminate], "Please select action:") do |a|
        options[:action] = a
    end

    opts.on("-i", "--instance_id [SERVER_ID]", "server id:") do |s|
        options[:server_id] = s
    end

    opts.on('-v', '--verbose', 'extra information:') do |v|
        options[:verbose] = v
    end

    opts.on('-h', '--help', 'help:') do
        puts opts
        exit
    end

end.parse!

if options[:action].nil? then
    raise OptionParser::MissingArgument, "Provide options use -h or --help"
end

config = YAML.load_file('config.yaml')

client = Aws::EC2::Client.new({
        region: 'us-west-2',
        access_key_id: config['access_key_id'],
        secret_access_key: config['secret_access_key']
    })

if options[:action] == :launch then
    ec2 = Aws::EC2::Resource.new(client: client)
    instance = ec2.create_instances({
          image_id: config["image_id"],
          min_count: 1,
          max_count: 1,
          key_name: config['key_pair'],
          security_group_ids: config["security_group_ids"],
          instance_type: config['instance_type'],
          placement: {
            availability_zone: config['us-west-2a']
          }
    })

    ec2.client.wait_until(:instance_status_ok, {instance_ids: [instance[0].id]})
    inst = instance[0]
    inst.load()
    puts inst.id, inst.public_dns_name

elsif options[:action] == :stop then
    raise OptionParser::MissingArgument, "Error: SERVER_ID" if options[:server_id].nil?
    client.stop_instances({
          dry_run: false,
          instance_ids: [options[:server_id]],
          force: false,
        })

elsif options[:action] == :start then
    raise OptionParser::MissingArgument, "Error: SERVER_ID" if options[:server_id].nil?
    out = client.start_instances({
          instance_ids: [options[:server_id]],
          dry_run: false,
        })
    out = client.wait_until(:instance_running, instance_ids:[options[:server_id]])
    dns_name = out.reservations[0].instances[0].public_dns_name
    puts dns_name

elsif options[:action] == :terminate then
    raise OptionParser::MissingArgument, "Error: SERVER_ID" if options[:server_id].nil?
    client.terminate_instances({
          dry_run: false,
          instance_ids: [options[:server_id]],
    })
end
