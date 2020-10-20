require 'oystercard'

RSpec.describe Oystercard do
  let(:station){ double :station }
  let(:exitstation){ double :station }

  describe "#balance" do

    it 'tests intial oystercard returns balance of 0' do
      expect(subject.balance).to eq 0
    end

    it "tops up the balance of the card" do
      expect(subject.top_up(1)).to eq 1
    end

    it 'fails if you try and exceed the money limit' do
      expect{ subject.top_up(Oystercard::LIMIT+1) }.to raise_error "£#{Oystercard::LIMIT} Limit Reached"
    end
  end

  describe "#touch_in" do

    it 'checks that the user can touch_in' do
      subject.top_up(1)
      expect(subject.touch_in(station)).to be true
    end

    it "expects minimum balance in order to touch in" do
      expect{subject.touch_in(station)}.to raise_error "Insufficient funds"
    end

    it 'stores the entry station' do
      subject.top_up(1)
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end

    it 'checks that the user is in_journey?' do
      subject.top_up(1)
      subject.touch_in(station)
      expect(subject.in_journey?).to be true
    end
  end

  describe "#touch_out" do

    it 'checks that the user can touch_out' do
      expect(subject.touch_out(exitstation)).to be false
    end

    it 'tests if user is charged the minimum fair after touching out' do
      subject.top_up(10)
      subject.touch_in(station)
      expect { subject.touch_out(exitstation) }.to change {subject.balance}.by (-Oystercard::MINFARE)
    end
  end

  describe "#journey" do

    it "checks journey log is empty by default" do
      expect(subject.station_log).to eq []
    end

    it "checks that touching in and out creates a journey" do
      subject.top_up(10)
      subject.touch_in(station)
      subject.touch_out(exitstation)
      expect(subject.station_log).to eq [{boarding: station, departure: exitstation}]
    end
  end
end

RSpec.describe Station do
  let(:testname){ double :name }
  let(:testzone){ double :zone }

  subject {Station.new(testname,testzone)} #Can also use described_class.new instead of Station.new

  describe '#station' do

    it "tests to see if the station knows its name" do
      expect(subject.name).to eq testname
    end

    it "tests to see if the station knows its zone" do
      expect(subject.zone).to eq testzone
    end
  end
end
# it "deducts money from the balance of the card" do
#   card = Oystercard.new
#   card.top_up(10)
#   card.deduct(1)
#   expect(card.balance).to eq 9
# end
# Can't test private methods
