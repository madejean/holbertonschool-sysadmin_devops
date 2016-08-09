#!/usr/bin/env ruby
require 'aws-sdk'
require 'optparse'
require 'yaml'

options = {}
OptionParser.new do |opts|
  opts.banner = "enter action: [options]"

  opts.on("-a", "--action[action]", [:launch, :stop, :start, :terminate], "Please select an option") do |a|
    options[:action] = a
  end

  opts.on("-v", "--verbose", "verbose:") do |v|
    options[:verbose] = v
  end

  opts.on("-i", "--server_id[server_id]", "server_id:") do |id|
    options[:server_id] = id

  opts.on("-h", "--help", "help") do
    puts opts
    exit
  end

end.parse!

if options[:action] == :launch
  instance = ec2.create_instances({
    image_id: config['image_id'],
    min_count: 1,
    max_count: 1,
    key_name: config['key_pair'],
    security_group_ids: ['security_group_ids'],
    user_data: encoded_script,
    instance_type: config['instance_type'],
    placement: {
      availability_zone: config['availability-zone']
    },
  })

  puts instance.id
  puts instance.public_ip_address


elsif options[:action] == :stop
  i = instance.stop_instances({
    instance_ids: [options[:server_id]],
    })

elsif options[:action] == :start
  i = instance.start_instances({
    instance_ids: [options[:server_id]],
    })

if options[:action] == :terminate
  i = instance.terminate_instances({
    instance_ids: [options:[server_id]]
    })
end
