# frozen_string_literal: true

class PostcodeForm < BaseForm
  # Postcodes.io accepts up to 100 postcodes for bulk lookup
  POSTCODES_SIZE = 100

  validates_presence_of :postcodes
  validate :validate_postcodes_count

  attr_accessor :postcodes, :postcode_array

  class << self
    def model_name
      ActiveModel::Name.new(self, nil, 'postcode')
    end
  end

  def attributes=(attrs)
    @postcodes = attrs[:postcodes]
    @postcode_array = postcodes.split(/\s*,\s*/)
  end

  private

  def validate_postcodes_count
    return unless @postcode_array.size >= POSTCODES_SIZE

    errors.add(:postcodes, format(I18n.t('form.errors.wrong_size', scope: 'postcodes'), count: POSTCODES_SIZE))
  end
end
