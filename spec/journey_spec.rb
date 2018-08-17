require 'journey'

describe Journey do

  let(:entry_station) { double :station, zone: 1 }
  let(:exit_station) { double :station, zone: 1 }
  subject { described_class.new(entry_station) }

  describe "@entry_station" do
    it "returns the entry station" do
      expect(subject.entry_station).to eq entry_station
    end
  end

  describe "#exit_station" do
    it "returns the exit station" do
      expect(subject.exit_station).to eq nil
    end
  end

  describe "#fare" do
  
    it "returns the penalty fare" do
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end

    it "returns the minimum fare" do
      subject.entry_station = entry_station
      subject.exit_station = exit_station
      expect(subject.fare).to eq Oystercard::MINIMUM_FARE
    end

  end

  describe "#journey_complete?" do

    it "returns true if the journey is complete" do
      subject.entry_station = entry_station
      subject.exit_station = exit_station
      expect(subject.journey_complete?).to eq true
    end
    it "returns false if the journey is complete" do
      subject.entry_station = entry_station
      subject.exit_station = nil
      expect(subject.journey_complete?).to eq false
    end
    it "returns false if the journey is complete" do
      subject.entry_station = nil
      subject.exit_station = exit_station
      expect(subject.journey_complete?).to eq false
    end
  end

      

end