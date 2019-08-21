# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RoleType do
  it_behaves_like 'a type dictionary'

  it 'has its default description set by the config' do
    expect(described_class.default_description).to eq(EventWarehouse::Application.config.default_role_type_description)
  end
end
