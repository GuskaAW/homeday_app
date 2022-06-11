# frozen_string_literal: true

require 'rails_helper'
# require 'spec_helper'

describe 'SetAppointmentService' do
  fixtures :realtors
  before do
    Timecop.freeze(2022, 6, 11, 10, 0, 0)
  end

  describe 'does not create apoointment with bad data, returns errors' do
    context '#distance more than 20 km' do
      let(:payload) do
        { appointment:
          { lat: 50.775555, lng: 6.083611,
            address: 'Katschhof, 52062 Aachen',
            time: '27/06/2022 10:00',
            seller: { name: 'Alexander Schmit', phone: '+498005800550' } } }
      end

      it 'returns error if relator has more than 20 km to appointment point' do
        response = SetAppointmentService.new.call(payload)
        expect(response[:message]).to eq("No realtor available")
      end
    end

    context '#check if appointment is on weekend' do
      let(:payload) do
        { appointment:
          { lat: 52.090389, lng: 13.163691,
            address: 'Berlin',
            time: '18/06/2022 10:00',
            seller: { name: 'Alexander Schmit', phone: '+498005800550' } } }
      end

      it 'returns error if appointmet day is on weekend' do
        response = SetAppointmentService.new.call(payload)
        expect(response[:message]).to eq("No realtor available")
      end
    end

    context '#check if appointment is not during opening hours' do
      let(:payload) do
        { appointment:
          { lat: 52.090389, lng: 13.163691,
            address: 'Berlin',
            time: '16/06/2022 7:00',
            seller: { name: 'Alexander Schmit', phone: '+498005800550' } } }
      end

      it 'returns error if appointmet day is not in range of opening hours' do
        response = SetAppointmentService.new.call(payload)
        expect(response[:message]).to eq("No realtor available")
      end
    end

    context '#missing appointments params' do
      let(:payload) do
        { appointment:
          { lat: 52.090389, lng: 13.163691,
            address: 'Berlin',
            seller: { name: 'Alexander Schmit', phone: '+498005800550' } } }
      end

      it 'returns error if appointmet has no time' do
        response = SetAppointmentService.new.call(payload)
        expect(response[:message]).to eq("Missing input values")
      end
    end
  end

  describe 'create appointment' do
    context '#creates appointment with good data' do
      let(:payload) do
        { appointment:
          { lat: 52.090389, lng: 13.163691,
            address: 'Berlin',
            time: '16/06/2022 11:00',
            seller: { name: 'Alexander Schmit', phone: '+498005800550' } } }
      end

      it 'returns time of appointmet correctly' do
        response = SetAppointmentService.new.call(payload)
        expect(response[:time]).to eq('16/06/2022 11:00')
      end

      it 'returns name of relator correctly' do
        response = SetAppointmentService.new.call(payload)
        expect(response[:realtor][:name]).to eq('Zelma Hammersley')
      end
    end
  end
end
