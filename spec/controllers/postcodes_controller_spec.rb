# frozen_string_literal: true

RSpec.describe PostcodesController do
  describe 'GET lookup' do
    before { get :lookup }

    it { expect(response).to render_template('lookup') }
    it { expect(assigns(:results)).to be nil }

    context 'lookup with form submit' do
      let(:params) do
        { postcode: { postcodes: '123' }, commit: :submit }
      end

      before { get :lookup, params: params }

      it { expect(response).to render_template('lookup') }
      it { expect(assigns(:results)).to be_kind_of(Array) }
    end
  end
end
