class Coffee
  attr_accessor :id, :blend, :origin, :variety, :notes

  def initialize(options_hash)
    @blend = options_hash["blend"]
    @origin = options_hash["origin"]
    @variety = options_hash["variety"]
    @notes = options_hash["notes"]

  end

  def friendly_notes
    friendly_notes = ""
    friendly_notes_array = []
    friendly_notes_array = notes.split(", ")
    friendly_notes_array.each do |note|
      friendly_notes += " | " + note.capitalize + " | "
    end
    return friendly_notes
  end

  def self.find(coffee_id)
    @coffee = Coffee.new(Unirest.get("#{ ENV['HOST_NAME'] }/api/v2/coffees/#{coffee_id}.json").body)
  end

  def self.all
    coffee_collection = []
    response = Unirest.get("#{ ENV['HOST_NAME'] }/api/v2/coffees.json").body

    response.each do |coffee_hash|
      coffee_collection << Coffee.new(coffee_hash)
    end
    return coffee_collection
  end

  def self.destroy(coffee_id)
    coffee = Unirest.delete("#{ ENV['HOST_NAME'] }/api/v2/coffees/#{coffee_id}.json").body
  end



end