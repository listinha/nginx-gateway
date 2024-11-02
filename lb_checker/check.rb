require 'logger'
require 'excon'

accum = {}
mutx = Mutex.new

threads = 1_000.times.map do
  Thread.new do
    r = Excon.get('http://listinha.localhost:8000/hello-world')
    if r.status == 200
      app_id = r.headers['x-app-id']

      mutx.synchronize do
        accum[app_id] ||= 0
        accum[app_id] += 1
      end
    end
  end
end

threads.each(&:join)

puts accum
