require 'oystercard'

describe Oystercard do

  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey_instance)  { double :journey, :journey_complete? => false } 
  let(:journey_class) { double :journey_class, :new => journey_instance}
  

  describe "#balance" do
    it "returns a balance" do
      expect(subject.balance).to eq 0
    end
  end

  describe "#top_up" do
    it "adds to the balance" do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end
    it "throws an error when the maxium balance is exceeded" do
    expect{ subject.top_up Oystercard::MAXIMUM_BALANCE + 1 
    }.to raise_error("Maximum balance of #{Oystercard::MAXIMUM_BALANCE} exceeded!")
    end
  end

  describe "#touch_in" do
    it "should raise error if insufficient balance for minimum fare" do
      expect{ subject.touch_in(entry_station) }.to raise_error("You don't have enough balance for the minimum fare of #{Oystercard::MINIMUM_FARE}!")
    end
  end

  describe "#touch_out" do
    before(:example) do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(entry_station)
    end
    it "should remove balance from the card" do
      expect { subject.touch_out(exit_station) }.to change{ subject.balance }.by( -Oystercard::MINIMUM_FARE)
    end
    it "should store a record of the journey" do      
      expect { subject.touch_out(exit_station) }.to change{ subject.journeys.length }.by 1
    end
  end
  
  describe "#journeys" do
    let(:journey){ {entry_station: entry_station, exit_station: exit_station} } # defining the structure of a journey element
    it 'has an empty list of journeys by default' do
      expect(subject.journeys).to be_empty
    end
    it "contains a journey object" do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(entry_station)
      expect { subject.touch_out(exit_station) }.to change{ subject.journeys.length }.by 1
    end
  end

end
