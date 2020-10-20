require_relative 'journey'

class Oystercard

  attr_reader :balance, :entry_station, :exit_station, :station_log
  LIMIT = 90
  MINFARE = 1
  PENALTY = 6

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
    fail "Insufficient funds" if @balance < MINFARE
    @entry_station = station
    @journeyclass.touch_in(station)
  end

  def touch_out(station)
    deduct(MINFARE)
    @journeyclass.touch_out(station)
    @exit_station = station
    @station_log << {boarding: @entry_station, departure: @exit_station}
  end

  private

  def deduct(money)
    @balance -= money
  end

  def valid_journey
    true if !entry_station.nil? && !exit_station.nil?
  end

  def fare
   valid_journey ? deduct(MINFARE) : deduct(PENALTY)
  end

  # def deduct_penalty
  #   deduct(PENALTY)
  # end

end
