class Oystercard

  attr_reader :balance, :entry_station, :station_log
  LIMIT = 90
  MINFARE = 1
  def initialize
    @balance = 0
    @station_log = []
    @journeyclass = Journey.new
  end

  def top_up(money)
    fail "£#{LIMIT} Limit Reached" if @balance+money > LIMIT
    @balance += money
  end

  def touch_in(station)
    @journeyclass.touch_in(station)
  end

  def touch_out(station)
    @journeyclass.touch_out(station)
  end

  private
  def deduct(money)
    @balance -= money
  end
end

class Journey

  #attr_reader :journey
  MINFARE = 1
  def initialize
    @journey = false
  end

  def touch_in(station)
    fail "Insufficient funds" if @balance < MINFARE
    @entry_station = station
    @journey = true
  end

  def touch_out(station)
    deduct(MINFARE)
    @station_log << {boarding: @entry_station, departure: station}
    @journey = false
  end

  def in_journey?
    @journey
  end
end


class Station
  attr_reader :name, :zone

  def initialize(name,zone)
    @name = name
    @zone = zone
  end
end
