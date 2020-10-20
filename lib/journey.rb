class Journey

  MINFARE = 1
  PENALTY = 6

  def initialize
    @journey = false
  end

  def touch_in(station)
    @journey = true
  end

  def touch_out(station)
    @journey = false
  end

  def in_journey?
    @journey
  end

  def valid_journey
    true if !entry_station.nil? && !exit_station.nil?
  end

  def fare
   valid_journey ? deduct(MINFARE) : deduct(PENALTY)
  end

end
