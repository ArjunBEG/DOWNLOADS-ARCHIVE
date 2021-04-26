class ActiveResource::Connection
  def http
    # Setup http object
    http = Net::HTTP.new(@site.host, @site.port)
    http.use_ssl = @site.is_a?(URI::HTTPS)
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE if http.use_ssl
    http.read_timeout = @timeout if @timeout

    # Log to stderr
    http.set_debug_output $stderr

    # Return http object
    return http
  end
end