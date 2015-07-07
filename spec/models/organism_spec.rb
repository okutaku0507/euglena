# -*- SkipSchemaAnnotations

require 'rails_helper'

RSpec.describe Administrator, :type => :model do
  describe 'Factory' do
    example 'Administrator作成' do
      create(:administrator)
      expect(Administrator.count).to eq(1)
    end
  end
end
