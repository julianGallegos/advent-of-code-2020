# frozen_string_literal: true

# typed: true
require 'sorbet-runtime'
require 'pry'

require_relative 'password_validator'

class CountValidPasswords
  extend T::Sig

  sig { params(passwords: Array).void }
  def initialize(passwords)
    @passwords = passwords
    @valid_password_count = 0
  end

  sig { returns(Integer) }
  def number_of_valid_passwords
    passwords.each do |password|
      password_validator = PassWordValidator.new(password)

      @valid_password_count += 1 if password_validator.valid_password?
    end

    @valid_password_count
  end

  sig { returns(Array) }
  attr_reader :passwords

  sig { returns(Integer) }
  attr_accessor :valid_password_count
end
