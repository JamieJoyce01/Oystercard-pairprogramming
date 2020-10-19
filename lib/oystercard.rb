class Oystercard
  #@stations = {:entrystation => entry_station, :exitstation => exit_station}

  attr_reader :balance, :entry_station
  LIMIT = 90
  MINFARE = 1

  def initialize
    @balance = 0
    @journey = false
    @entry_station = nil
  end

  def top_up(money)
    fail "£#{LIMIT} Limit Reached" if @balance+money > LIMIT
    @balance += money
  end

  def touch_in(station)
    fail "Insufficient funds" if @balance < MINFARE
    @stations[:entrystation].push(station)
    @entry_station = station
    @journey = true
  end

  def touch_out
    deduct(MINFARE)
    @entry_station = nil
    @journey = false
  end

  def in_journey?
    @journey
  end

  private
  def deduct(money)
    @balance -= money
  end

end
