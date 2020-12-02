# frozen_string_literal: true

require_relative 'password_validator'
require 'pry'

describe PassWordValidator do
  let(:pass_word_validator) { PassWordValidator.new(requirements) }
  describe 'parsed_password_requirement' do
    let(:requirements) { '1-3 b: cdefg' }
    let(:password_requirements) do
      pass_word_validator.parsed_password_requirement
    end

    describe 'required_letter' do
      it 'finds the required letter for the password' do
        expect(
          password_requirements[:required_letter]
        ).to eq('b')
      end
    end

    describe 'minimum_occurence' do
      it 'finds the minimum occurences required from the input' do
        expect(
          password_requirements[:minimum_occurence]
        ).to eq(1)
      end
    end

    describe 'maximum_occurences' do
      it 'determines the maximum occurences required from the input' do
        expect(
          password_requirements[:maximum_occurence]
        ).to eq(3)
      end
    end

    describe 'entered_password' do
      it 'parses the entered password' do
        expect(password_requirements[:entered_password]).to eq('cdefg')
      end
    end
  end

  describe 'valid_password?' do
    context 'checks if the password meets the password criteria' do
      describe 'invalid password' do
        let(:requirements) { '1-3 b: cdefg' }

        it 'is invalid' do
          expect(
            PassWordValidator.new(requirements).valid_password?
          ).to be(false)
        end
      end

      describe 'valid password' do
        let(:valid_password) { '1-3 a: abcde' }
        let(:valid_password_2) { '2-9 c: ccccccccc' }

        it 'is valid' do
          expect(
            PassWordValidator.new(valid_password).valid_password?
          ).to be(true)
          expect(
            PassWordValidator.new(valid_password_2).valid_password?
          ).to be(true)
        end
      end
    end
  end
end
