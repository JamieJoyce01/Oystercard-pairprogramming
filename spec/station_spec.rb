require 'station'

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
