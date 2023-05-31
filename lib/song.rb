class Song
  attr_accessor :name, :album
  attr_reader :id

  def initialize(name:, album:, id: nil)
    @name = name
    @album = album
    @id = id
  end

 
 

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS songs(
        id INTEGER PRIMARY KEY,
        name TEXT,
        album TEXT
      );
    SQL
    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
    INSERT INTO songs (name, album)
    VALUES (?, ?) 
    SQL

    DB[:conn].execute(sql, self.name, self.album)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]
    self

  end

  def self.create(name:, album:)
    song= Song.new(name: name, album: album)
    song.save
  end

end
gold_digger = Song.new(name: "Gold Digger", album: "Late Registration")

puts gold_digger.name
# => "Gold Digger"

puts gold_digger.album
# => "Late Registration"
puts gold_digger.id
rich =  Song.create(name: "rich", album: "young")
puts rich.name 