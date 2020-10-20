class Journey

attr_reader :journey

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

end
