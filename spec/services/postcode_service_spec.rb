# frozen_string_literal: true

RSpec.describe PostcodeService do
  describe '.lookup' do
    before do
      allow(described_class).to receive(:api_post).and_return(
        {
          status: 200,
          body: {
            'status' => 200,
            'result' => [
              { 'query' => 'Foo Foo', 'result' => nil },
              { 'query' => 'SE1 7QD', 'result' => { 'postcode' => 'SE1 7QD' } }
            ]
          }
        }
      )
    end

    let(:postcodes) { ['Foo Foo', 'SE1 7QD'] }

    subject { described_class.lookup(postcodes) }

    it 'invoke #api_post with postcodes params' do
      subject
      expect(described_class).to have_received(:api_post).with('/postcodes', { postcodes: postcodes })
    end

    it 'lookup results' do
      is_expected. to eq [['Foo Foo', false], ['SE1 7QD', true]]
    end

    context 'in whilelist' do
      before { allow(PostcodeWhitelist).to receive(:fetch_cache).and_return(['FooFoo']) }

      it 'lookup results' do
        is_expected. to eq [['Foo Foo', true], ['SE1 7QD', true]]
      end
    end
  end
end
