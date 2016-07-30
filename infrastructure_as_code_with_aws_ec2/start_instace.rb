require 'aws-sdk'

ec2 = Aws::EC2::Resource.new(region: 'us-west-2')
      
i = ec2.instance('i-123abc')
    
if i.exists?
  case i.state.code
  when 0  # pending
    puts "#{id} is pending, so it will be running in a bit"
  when 16  # started
    puts "#{id} is already started"
  when 48  # terminated
    puts "#{id} is terminated, so you cannot start it"
  else
    i.start
  end
end
