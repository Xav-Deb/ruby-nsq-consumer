require 'nsq'
require 'logger'
require 'yaml'

#def read_config
config = YAML.load_file("config.yaml")
#	@nsqlookupd = config["config"]["nsqlookupd"]
#	@topic = config["config"]["topic"]
#	@channel = config["config"]["channel"]
#end

logger = Logger.new(STDOUT)

logger.info('initialize') { "Initializing..." }

while true
#	Nsq.logger = Logger.new(STDOUT)
	consumer = Nsq::Consumer.new(
		nsqlookupd: config['nsqlookupd'],
		topic: config['topic'],
		channel: config['channel']
		)

# Pop a message off the queue
	msg = consumer.pop
	puts msg.body
	msg.finish

# Close the connections
	consumer.terminate
end
