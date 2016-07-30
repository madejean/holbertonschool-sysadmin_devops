require 'aws-sdk'

ec2 = Aws::EC2::Resource.new(region: 'us-west-2')
      
i = ec2.instance('i-123abc')
    
if i.exists?
  case i.state.code
  when 48  # terminated
    puts "#{id} is terminated, so you cannot reboot it"
  else
    i.reboot
  end
end
