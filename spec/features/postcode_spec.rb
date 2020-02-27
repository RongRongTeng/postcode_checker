# frozen_string_literal: true

RSpec.describe 'postcode', type: :feature do
  describe '/postcodes' do
    let(:postcodes) { 'Foo Foo' }

    before do
      visit '/postcodes'

      within('#new_postcode') do
        fill_in 'Postcodes', with: postcodes
      end

      click_button 'Submit'
    end

    it 'shows results of lookup' do
      expect(page).to have_css('table', text: 'Foo Foo false')
    end

    context 'invalid input' do
      let(:postcodes) { '' }

      it 'shows validation error' do
        expect(page).to have_content 'Postcodes can\'t be blank'
      end
    end
  end
end
