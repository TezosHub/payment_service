require './conn.rb'
require 'json'
require './config.rb'
require './keys_helper.rb'
require 'pp'
# 定时

# 找到正在打款的
def paying_count
    sql = "select count(id) from task where `status` = 'paying'"
    @count = 0
    conn.execute( sql ) do |row|
        @count = row[0]
    end
    @count
end

# 找到正在等待的
def wait_count
    sql = "select count(id) from task where `status` = 'wait'"
    @count = 0
    conn.execute( sql ) do |row|
        @count = row[0]
    end
    @count
end

# 找到已经完成的
def finish_count
    sql = "select count(id) from task where `status` = 'finish'"
    @count = 0
    conn.execute( sql ) do |row|
        @count = row[0]
    end
    @count
end

# 找到已经失败的
def fail_count
    sql = "select count(id) from task where `status` = 'fail'"
    @count = 0
    conn.execute( sql ) do |row|
        @count = row[0]
    end
    @count
end

# 拿到一个等待的
def get_wait_one
    sql = "select * from task where `status` = 'wait' order by id limit 0,1"
    conn.execute( sql ) do |row|
        id = row[0]
        time = row[1]
        name = row[2]
        address = row[3]
        amount = row[4]
        fee = row[5]
        status = row[6]
        @task = {
           :id => id,
           :time => time,
           :name => name,
           :address => address,
           :amount => amount,
           :fee =>fee,
           :status => status 
        }
    end
    @task
end

def pay(task)
    time = task[:time]
    # 生成配置信息
    make_public_keys
    make_secret_keys
    make_public_keys_hash(task[:name],task[:address])

    #执行转账操作

    amount = task[:amount]
    from = name = config[:name]
    to = task[:address]
    fee = task[:fee]
    sh = "tezos-client transfer #{amount} from #{from} to #{to} --fee #{fee};"


    @status = "filed"
    IO.popen(sh) do |f|
        begin
        line = f.gets

        if "#{line}".include?"successfully"
            @status = "finish"
        end

        puts "\n#{line}"
        end while line!=nil
    end

    sql = "update task set `status` = '#{@status}' where `time` = '#{time}'"
    conn.execute( sql )
    #删除配置信息
    clear_keys
end


if paying_count == 0
    # 如果没有正在支付的
    pay(get_wait_one)
end