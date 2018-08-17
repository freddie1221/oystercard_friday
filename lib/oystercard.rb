class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  attr_reader :balance, :entry_station

  def initialize
    @balance = 0
    # @in_journey = false
  end

  def top_up(amount)
    raise "Maximum balance of #{Oystercard::MAXIMUM_BALANCE} exceeded!" if maximum_exceeded?(amount)
    self.balance += amount 
  end
  
  def in_journey?
    @entry_station ? true : false
  end

  def touch_in(station)
    raise ("You don't have enough balance for the minimum fare of #{Oystercard::MINIMUM_FARE}!") if insufficient_balance?
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end

  private
  
  attr_writer :balance
  attr_accessor :in_journey

  def maximum_exceeded?(amount)
    @balance + amount > MAXIMUM_BALANCE ? true : false
  end

  def insufficient_balance?
    @balance < MINIMUM_FARE ? true : false
  end

  def deduct(amount)
    self.balance -= amount
  end

end