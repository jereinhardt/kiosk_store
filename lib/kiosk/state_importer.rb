module Kiosk
  module StateImporter
    def self.import
      states = File.read(File.join(Kiosk.root, 'db', 'states.txt')).split("\n").map {|c| c.split(", ")}

      states.each do |a, b, c|
        state = State.new(state_name: a, state_code: b, zip_codes: c)
        state.save
      end
    end
  end
end