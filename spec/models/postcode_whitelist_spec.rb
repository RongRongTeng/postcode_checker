# frozen_string_literal: true

RSpec.describe PostcodeWhitelist do
  shared_examples 'invoke delete_cache callback' do
    it 'invoke #delete_cache' do
      subject
      expect(postcode_whitelist).to have_received(:delete_cache)
    end
  end

  describe '.fetch_cache' do
    before do
      create :postcode_whitelist, postcode: 'SH24 1AA'
      create :postcode_whitelist, postcode: 'SH242AA'
      create :postcode_whitelist, :inactive, postcode: 'SH24 3AA'

      allow(PostcodeWhitelist).to receive(:where).and_call_original
    end

    subject { described_class.fetch_cache }

    it 'fetch active postcode whiltlist' do
      is_expected.to eq %w[SH241AA SH242AA]
    end

    it 'invoke query' do
      subject
      expect(PostcodeWhitelist).to have_received(:where)
    end

    context 'cache hit' do
      before { allow(Rails).to receive_message_chain('cache.fetch') }

      it 'does not invoke query' do
        subject
        expect(PostcodeWhitelist).to_not have_received(:where)
      end
    end
  end

  describe '#save' do
    before { allow_any_instance_of(PostcodeWhitelist).to receive(:delete_cache) }

    let(:postcode_whitelist) { create :postcode_whitelist }

    subject { postcode_whitelist }

    it_behaves_like 'invoke delete_cache callback'
  end

  describe '#destroy' do
    before { allow_any_instance_of(PostcodeWhitelist).to receive(:delete_cache) }

    let!(:postcode_whitelist) { create :postcode_whitelist }

    subject { PostcodeWhitelist.destroy(postcode_whitelist.id) }

    it_behaves_like 'invoke delete_cache callback'
  end
end
