require 'sinatra'
require './conn.rb'
port = ARGV[0]
set :bind, '0.0.0.0'
set :port, port
set :root, File.dirname(__FILE__)
set :public_folder, Proc.new { File.join(root, "static") }
set :views, Proc.new { File.join(root, "view") }
get '/' do
    @title = "tezos 打款"
    name = ['tom','jerry','scott','bob','david','jack','iris','verne','jobs','bill','ann','jeff']
    address = ['tz1fBAUZoBEAJGaAcDeaQ7uXPtTPaMruhw17','tz1SkohgSByWXEQ2Dqs7N15pyrd1F4UQNGqj','tz1cYVZPmuTsqKPtjEZa4NmFE2yibsMQx6QF']
    @name = name[rand(0..11)]
    @address = address[rand(0..2)]
    @amount = rand(1..20)
    @fee = (rand(1..50)*0.1).round(2)
    erb :index
end

get '/tasks' do
    @title = "tezos 打款人物列表"
    sql = "select * from `task`;"
    @items = []
    conn.execute( sql ) do |row|
        id = row[0]
        time = row[1]
        name = row[2]
        address = row[3]
        amount = row[4]
        fee = row[5]
        status = row[6]
        @items << {
           :id => id,
           :time => time,
           :name => name,
           :address => address,
           :amount => amount,
           :fee =>fee,
           :status => status 
        }
    end
    erb :list
end

post '/payment' do

    name = params["name"]
    time = Time.now.to_i

    pay_name = "name_#{time}"
    pay_address = params["address"]
    pay_amount = params["amount"]
    pay_fee = params["fee"]

    sql = "INSERT INTO `task`(`id`,`time`,`name`,`address`,`amount`,`fee`) VALUES (NULL,#{time},'#{pay_name}','#{pay_address}','#{pay_amount}','#{pay_fee}');"
    conn.execute( sql )

    # # 生成批量转账脚本
    # @index = 0
    # File.open(config[:autoBashFile],"w+") do |file|
    #     usersJson.each do |user|
    #         @index += 1
    #         bakingUser = bakingUserJson["name"]
    #         userName = user["name"]
    #         amount = user["amount"]
    #         file.puts("echo transfer #{@index} :from #{bakingUser} to #{userName}  pay #{amount} fee 0.05;")
    #         file.puts("echo  ;")
    #         file.puts("tezos-client transfer #{amount} from #{bakingUser} to #{userName} --fee 0.05;")
    #         file.puts("echo  ;")
    #         file.puts("echo  ;")
    #     end
    # end

    # # 执行批量转账脚本
    # @out_text = ""
    # exefile = config[:autoBashFile]
    # IO.popen("sh #{exefile}") do |f|
    #     begin
    #     line = f.gets
    #     puts "\n#{line}"
    #     @out_text += "#{line}"
    #     end while line!=nil
    # end
    # @out_text
    "#{time}"
end

post '/status' do
    id = params["id"]
    sql = "select status from `task` where `time` = '#{id}';"
    conn.execute( sql ) do |row|
        @status = row[0]
    end
    "#{@status}"
end