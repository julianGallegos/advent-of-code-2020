# frozen_string_literal: true

# typed: true
require 'sorbet-runtime'
require 'pry'

class PassWordValidator
  extend T::Sig

  sig { params(password_requirement: String).void }
  def initialize(password_requirement)
    @password_requirement = password_requirement
  end

  sig { returns(Hash) }
  def parsed_password_requirement
    password_criteria = @password_requirement.split(' ')
    required_letter = T.must(password_criteria)[1]
    minimum_and_maximum_occurences =
      T.must(T.must(password_criteria).first).split('-')

    {
      minimum_occurence: minimum_and_maximum_occurences.first.to_i,
      maximum_occurence: minimum_and_maximum_occurences[1].to_i,
      # we need to remove the ':' from the required letter
      required_letter: required_letter.delete(':'),
      entered_password: T.must(password_criteria).last
    }
  end

  sig { returns(T::Boolean) }
  def valid_password?
    counter = 0
    password.each_char do |current_character|
      counter += 1 if current_character == required_letter
    end

    return false if counter.zero?

    counter >= minimum_occurence && counter <= maximum_occurence
  end

  private

  sig { returns(String) }
  attr_reader :password_requirement

  def password
    parsed_password_requirement[:entered_password]
  end

  def required_letter
    parsed_password_requirement[:required_letter]
  end

  def maximum_occurence
    parsed_password_requirement[:maximum_occurence]
  end

  def minimum_occurence
    parsed_password_requirement[:minimum_occurence]
  end
end
