require 'rails_helper'

RSpec.describe StringCalculator, type: :model do
  describe '.add' do
    context 'with empty input' do
      it 'returns 0' do
        expect(StringCalculator.add('')).to eq(0)
      end
    end

    context 'with simple numbers' do
      it 'returns the sum of numbers separated by commas' do
        expect(StringCalculator.add('1,2,3')).to eq(6)
      end

      it 'returns the sum of numbers separated by newlines' do
        expect(StringCalculator.add("1\n2\n3")).to eq(6)
      end

      it 'returns the sum of numbers separated by commas and newlines' do
        expect(StringCalculator.add("1\n2,3")).to eq(6)
      end
    end

    context 'with custom delimiters' do
      it 'supports single custom delimiter' do
        expect(StringCalculator.add("//;\n1;2;3")).to eq(6)
      end

      it 'supports multiple custom delimiters' do
        expect(StringCalculator.add("//[;][*]\n1;2*3")).to eq(6)
      end
    end

    context 'with negative numbers' do
      it 'raises an error if negative numbers are provided' do
        expect { StringCalculator.add("1,-2,3") }.to raise_error("negative numbers not allowed -2")
      end

      it 'raises an error for multiple negative numbers' do
        expect { StringCalculator.add("1,-2,-3") }.to raise_error("negative numbers not allowed -2,-3")
      end
    end

    context 'with escaped newline characters' do
      it 'handles \\n correctly' do
        expect(StringCalculator.add("1\\n2,3")).to eq(6)  # Ensure '\\n' is treated as a newline
      end

      it 'handles multiple \\n correctly' do
        expect(StringCalculator.add("1\\n2\\n3")).to eq(6)
      end
    end

    context 'with large numbers' do
      it 'returns the sum correctly for large numbers' do
        expect(StringCalculator.add("1000,2000,3000")).to eq(6000)
      end
    end
  end
end
