# frozen_string_literal: true

RSpec.describe PostcodeForm do
  let(:form) { described_class.new }

  describe '#attributes=' do
    let(:attrs) do
      ActionController::Parameters.new(
        postcodes: 'SH24 1AA,  SH24 2AA , OX495NU'
      )
    end

    subject { form.attributes = attrs }

    it 'assign attributes' do
      subject
      expect(form.postcodes).to eq 'SH24 1AA,  SH24 2AA , OX495NU'
      expect(form.postcode_array).to eq ['SH24 1AA', 'SH24 2AA', 'OX495NU']
    end
  end

  describe '#valid?' do
    before do
      form.postcodes = postcodes
      form.postcode_array = postcode_array
    end

    subject { form.valid? }

    context 'valid' do
      let(:postcodes) { 'SH24 1AA' }
      let(:postcode_array) { ['SH24 1AA'] }

      it { is_expected.to be_truthy }
    end

    context 'invalid' do
      context 'postcodes do not presence' do
        let(:postcodes) { '' }
        let(:postcode_array) { [] }

        it { is_expected.to be_falsy }
      end

      context 'postcodes exceed limitation' do
        before { stub_const('PostcodeForm::POSTCODES_SIZE', 2) }

        let(:postcodes) { 'SH24 1AA,  SH24 2AA , OX495NU' }
        let(:postcode_array) {  ['SH24 1AA', 'SH24 2AA', 'OX495NU'] }

        it { is_expected.to be_falsy }
      end
    end
  end
end
