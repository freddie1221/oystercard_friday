require_relative 'oystercard'

class Journey

  PENALTY_FARE = 6

  attr_accessor :entry_station, :exit_station

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def fare
    @entry_station && @exit_station ? Oystercard::MINIMUM_FARE : Journey::PENALTY_FARE
  end

  def journey_complete?
    @entry_station && @exit_station ? true : false
  end

end


