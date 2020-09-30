require('pg')

class SqlRunner

  def self.run(sql, values = [])
    begin
      # TO RUN LOCALLY
      # db = PG.connect({dbname: 'vet_surgery', host: 'localhost'})
      # db.prepare("query", sql)
      # result = db.exec_prepared("query", values)

      db = PG.connect( {dbname: 'dasdkdsaldkj',
      host: 'ec2-1-1-1-1-1.compute-1.amazonaws.com',
      port: 5432, user: 'nsdlkdjalskjd', password: 'sadlskjadlkjASDAD'}
    ensure
      db.close() if db != nil
    end
    return result
  end

end