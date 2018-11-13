def config
    rootDir = "/home/pm"
    {
        # config file
        :bakingUserFile => "./data/bakingUser.json",
        :public_key_hashs => "#{rootDir}/.tezos-client/public_key_hashs",
        :public_keys => "#{rootDir}/.tezos-client/public_keys",
        :secret_keys => "#{rootDir}/.tezos-client/secret_keys",
        # baking info
        :name => "alice",
        :address => "tz1amfhHn47i5ZYVnUGsTodsZW6G52vqAThE",
        :public => "edpkvJgayg1PDSC8PQhYHR2vC2QXfKkRrQe8BboAN9nU8ssNdARzWe",
        :private => "edsk2rTLCMy9DPkxsdECiZ1kp24n6ngSWQbFsa36D3RjK5F2GdsbgA"
    }
end