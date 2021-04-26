class PgbouncerStats < Scout::Plugin
  # need the ruby-pg gem
  needs 'pg'
  
  OPTIONS=<<-EOS
    user:
      name: Pgbouncer username
      notes: Specify the username to connect with
    password:
      name: Pgbouncer password
      notes: Specify the password to connect with
      attributes: password
    host:
      name: Pgbouncer host
      notes: Specify the host name of the Pgbouncer server. If the value begins with
              a slash it is used as the directory for the Unix-domain socket. An empty
              string uses the default Unix-domain socket.
      default: localhost
    pool_db:
      name: Database
      notes: The database name to monitor
      default: postgres
    pool_user:
      name: User
      notes: The user to monitor
      default: postgres
    port:
      name: Pgbouncer port
      notes: Specify the port to connect to Pgbouncer with
      default: 6432
  EOS
    
  NON_COUNTER_ENTRIES = ["user", "database"]

  PGBOUNCER_DBNAME = "pgbouncer"

  def build_report    
    begin
      PGconn.new(:host=>option(:host), :user=>option(:user), :password=>option(:password), :port=>option(:port).to_i, :dbname=>option(PGBOUNCER_DBNAME)) do |pgconn|

        result = pgconn.exec('SHOW POOLS;')

        result.each do |row|
          if row["user"] == option(:pool_user) and row["database"] == option(:pool_db)
            row.each do |name, val|
              if !NON_COUNTER_ENTRIES.include?(name)
                counter(name,val.to_i,:per => :second)
              end
            end
          end
        end
      end

    rescue PGError => e
      return errors << {:subject => "Unable to connect to pgbouncer.",
                        :body => "Scout was unable to connect to the pgbouncer server: \n\n#{e}\n\n#{e.backtrace}"}
    end
  end
end