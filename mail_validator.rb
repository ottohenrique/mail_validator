require 'resolv'
require 'net/smtp'

address = ARGV[0].chomp
domain = address.split('@').last
dns = Resolv::DNS.new

puts "Resolving MX records for #{domain}..."
mx_records = dns.getresources domain, Resolv::DNS::Resource::IN::MX
mx_server  = mx_records.first.exchange.to_s
puts "Connecting to #{mx_server}..."

Net::SMTP.start mx_server, 25 do |smtp|
  r= smtp.helo "local.domain"
end

