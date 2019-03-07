class Message < ActiveRecord::Base
	before_create do |message|
	  message.body = Gibberish::AES.new('p4ssw0rd').encrypt(self.body)
	  message.link=SecureRandom.hex
	end

	def decrypted_name
		Gibberish::AES.new('p4ssw0rd').decrypt(self.body)
	end
end 