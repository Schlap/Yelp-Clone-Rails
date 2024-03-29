require 'rails_helper'

describe 'ReviewsHelper', :type => :helper do 
  context '#star rating' do

    it 'does nothing for not a number' do 
      expect(helper.star_rating('N/A')).to eq 'N/A'
    end

    it 'returns five black stars for 5' do
      expect(helper.star_rating(5)).to eq '★★★★★'
    end

    it 'returns 3 black stars and two white stars for 3' do
      expect(helper.star_rating(3)).to eq '★★★☆☆'
    end

    it 'returns four black stars and one white star for 3.5' do
      expect(helper.star_rating(3.5)).to eq '★★★★☆'
    end
  end
end