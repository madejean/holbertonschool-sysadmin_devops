require 'aws-sdk'
require 'base64'
export AWS_CREDENTIAL_PROFILES_FILE = ~/.ssh

# User code that's executed when the instance starts
script = ''

encoded_script = Base64.encode64(script)

ec2 = Aws::EC2::Resource.new(region: 'us-west-2')

instance = ec2.create_instances({
  image_id: 'IMAGE_ID',
  min_count: 1,
  max_count: 1,
  key_name: 'NewInstanceKeyPair',
  security_group_ids: ['SECURITY_GROUP_ID'],
  user_data: encoded_script,
  instance_type: 't2.micro',
  placement: {
    availability_zone: 'us-west-2'
  },
  subnet_id: 'SUBNET_ID',
  network_interfaces: [{
    device_index: 0,
    associate_public_ip_address: true
  }],
  iam_instance_profile: {
    arn: 'arn:aws:iam::' + 'ACCOUNT_ID' + ':instance-profile/aws-opsworks-ec2-role'
  }
})

# Wait for the instance to be created, running, and passed status checks
ec2.client.wait_until(:instance_status_ok, {instance_ids: [instance[0].id]})

# Name the instance 'NewInstance' and give it the Group tag 'NewInstance'
instance.create_tags({ tags: [{ key: 'Name', value: 'NewInstance' }, { key: 'Group', value: 'NewInstance' }]})

puts instance.id
puts instance.public_ip_address
