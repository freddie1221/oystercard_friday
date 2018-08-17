class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  attr_reader :balance, :entry_station, :journeys

  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(amount)
    raise "Maximum balance of #{Oystercard::MAXIMUM_BALANCE} exceeded!" if maximum_exceeded?(amount)
    @balance += amount 
  end
  
  def in_journey?
    @entry_station ? true : false
    # could also write !!entry_station
  end

  def touch_in(station)
    raise ("You don't have enough balance for the minimum fare of #{Oystercard::MINIMUM_FARE}!") if insufficient_balance?
    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @journeys << {entry_station: @entry_station, exit_station: station}
    @entry_station = nil
  end

  private

  def maximum_exceeded?(amount)
    @balance + amount > MAXIMUM_BALANCE ? true : false
  end

  def insufficient_balance?
    @balance < MINIMUM_FARE ? true : false
  end

  def deduct(amount)
    @balance -= amount
  end

end