def make_public_keys

    name = config[:name]
    publicKey = config[:public]

    text = []
    text << {
        :name => "#{name}",
        :value => {
            :locator => "unencrypted:#{publicKey}",
            :key => "#{publicKey}"
        } 
    }

    text_json = JSON text
    File.open(config[:public_keys],"w+") do |file|
        file.puts text_json
    end
end

def make_public_keys_hash(name,address)
    json = []
    baking_user_name = config[:name]
    baking_user_address = config[:address]
    json << {
        :name => baking_user_name, 
        :value => baking_user_address
    }
    json << {
        :name => name, 
        :value => address
    }
    public_key_hashs = JSON json
    File.open(config[:public_key_hashs],"w+") do |file|
        file.puts(public_key_hashs)
    end
end

def make_secret_keys
    name = config[:name]
    privateKey = config[:private]
    json = []
    json << {
        :name => "#{name}", 
        :value => "unencrypted:#{privateKey}"
    }
    text_json = JSON json
    File.open(config[:secret_keys],"w+") do |file|
        file.puts text_json
    end
end


def clear_keys
    File.delete(config[:public_key_hashs])
    File.delete(config[:public_keys])
    File.delete(config[:secret_keys])
end