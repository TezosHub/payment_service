require "sqlite3"
def conn
    SQLite3::Database.new "./list.db"
end