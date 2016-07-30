require 'aws-sdk'

ec2 = Aws::EC2::Resource.new(region: 'us-west-2')
      
i = ec2.instance('i-123abc')
    
if i.exists?
  case i.state.code
  when 48  # terminated
    puts "#{id} is terminated, so you cannot stop it"
  when 64  # stopping
    puts "#{id} is stopping, so it will be stopped in a bit"
  when 89  # stopped
    puts "#{id} is already stopped"
  else
    i.stop
  end
end
