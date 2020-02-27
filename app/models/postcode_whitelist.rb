# frozen_string_literal: true

class PostcodeWhitelist < ApplicationRecord
  POSTCODE_WHITELISTS_CACHE = 'postcode_whitelists'

  after_save    :delete_cache
  after_destroy :delete_cache

  class << self
    def fetch_cache
      Rails.cache.fetch(POSTCODE_WHITELISTS_CACHE) do
        where(active: true).pluck(:postcode).map do |postcode|
          postcode.gsub(/\s/, '')
        end
      end
    end
  end

  private

  def delete_cache
    Rails.cache.delete(POSTCODE_WHITELISTS_CACHE)
  end
end
