# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'v1/subject_types', type: :request do
  let(:subject_type1) { create(:subject_type) }
  let(:subject_type2) { create(:subject_type) }

  before do
    subject_type1
    subject_type2
  end

  describe '#index' do
    it 'lists subject_types' do
      get '/api/v1/subject_types'
      expect(json_ids(true)).to eq([subject_type1.id, subject_type2.id])
      assert_payload(:subject_type, subject_type1, json_items[0])
    end
  end

  describe '#show' do
    it 'returns relevant subject_type' do
      get "/api/v1/subject_types/#{subject_type1.id}"
      assert_payload(:subject_type, subject_type1, json_item)
    end
  end
end
