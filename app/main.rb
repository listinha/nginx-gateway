require 'spyder'

server = Spyder::Server.new('0.0.0.0', 8080)

server.router.add_route 'GET', '/hello-world' do |request, _|
  which_world = request.query_params['world'] || 'Earth'

  resp = Spyder::Response.new
  resp.add_standard_headers
  resp.set_header 'content-type', 'text/html'
  resp.set_header 'cache-control', "public, max-age=#{3600 * 24}"

  if (app_id = ENV['APP_ID'])
    resp.set_header 'x-app-id', app_id
  end

  puts "Now serving request"

  resp.body = <<~HTML
  <!DOCTYPE html>
  <html lang="en" dir="ltr">
    <head>
      <meta charset="utf-8">
      <title></title>
    </head>
    <body>
      <div>
        World is #{which_world} and
        time is #{Time.now}
      </div>

      <div id="main">
        Loading...
      </div>

      <script src="/main.js"></script>
    </body>
  </html>
  HTML

  resp
end

puts "Starting server"
server.start
