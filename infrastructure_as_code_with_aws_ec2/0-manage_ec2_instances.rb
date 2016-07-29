#!/usr/bin/ruby

require 'rubygems'
require 'aws-sdk'

Aws.config(:credentials => ENV['AWS_ACCES_KEY_ID'],
           :credentials => ENV['AWS_SECRET_KEY'])

ec2 = Aws::EC2.new.regions['us-west-2b']
ami_name = 'amzn-ami-hvm-2016.03.3.x86_64-gp2 (ami-7172b611)'
key_pair_name = qwikLABS-L265-609409
private_key_file = "#{ENV['HOME']}/.ssh/AmazonSecretAccessKey.pem"
security_group_name = 'launch-wizard-1'
instance_type = 't2.micro'
ssh_username = amzn-ami


image = Aws.memoize do
  ec2.images.filter("root-device-type", "ebs").filter('name', ami_name).first
end

if image
  puts "Using AMI: #{image.id}"
else
  raise "No image found matching #{ami_name}"
end

key_pair = ec2.key_pairs[key_pair_name]
puts "Using keypair #{key_pair.name}, fingerprint: #{key_pair.fingerprint}"

security_group = ec2.security_groups.find{|sg| sg.name == security_group_name}
puts "Using security group: #{security_group.name}"

instance = ec2.instances.create(:image_id => image.id,
                                :instance_type => instance_type,
                                :count => 1,
                                :security_groups => security_group,
                                :key_pair => key_pair)
puts "Launching machine ..."

sleep 1 until instance.status != :pending
puts "Launched instance #{instance.id}, status: #{instance.status}, public dns: #{instance.dns_name}, public ip: #{instance.ip_addess}"
exit 1 unless instance.status == :running

puts "Launched: You can SSH to it with;"
puts "ssh -i #{private_key_file} #{ssh_username}@#{instance.ip_address}"


  
  
