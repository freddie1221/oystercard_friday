require_relative 'oystercard'

class Journey

  PENALTY_FARE = 6

  attr_reader :entry_station, :exit_station

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def fare
    PENALTY_FARE
  end

end