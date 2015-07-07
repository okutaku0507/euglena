# -*- SkipSchemaAnnotations

require 'rails_helper'

RSpec.describe Organism, :type => :model do
  describe 'Factory' do
    example 'Organism作成' do
      create(:organism)
      expect(Organism.count).to eq(1)
    end
  end
end
