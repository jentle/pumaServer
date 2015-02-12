require 'net/http'
require 'uri'

module DCAPI
   SCI_URI = "http://login.etherios.com/ws/sci"

  def self.send_data(api_url, data)
    
    url = URI.parse(api_url)
    headers = {
        'Accept' => 'application/xml'
    }
# Create a HTTPRequest Object based on HTTP Method.
    req = Net::HTTP::Post.new(url.path, headers)

# Sets The Request up for Basic Authentication.
# Replace YourUsername and YourPassword with your username and password respectively.
    req.basic_auth 'jentlelong', 'Gujiang2010+'
# Injects XML Content into Request Body.
    req.body='<!--
See http://www.digi.com/wiki/developer/index.php/Rci for
an example of a python implementation on a NDS device to
handle this SCI request
-->
<sci_request version="1.0">
  <send_message>
    <targets>
      <device id="00000000-00000000-1C4BD6FF-FFCFF8DA"/>
    </targets>
    <rci_request version="1.1">
      <do_command target="xig">
        <at hw_address="00:13:A2:00:40:B1:C1:79" command="AP"/>
      </do_command>
    </rci_request>
  </send_message>
</sci_request>
'
# Informs Server that the input is in XML format.
    req.set_content_type('text/xml')
# Create an HTTP connection and send data to capture response.
    res = Net::HTTP.new(url.host, url.port).start {|http| http.request(req) }

# Print the Response!
    puts res.body
  end


  def get_data(api_url)

  end
end

