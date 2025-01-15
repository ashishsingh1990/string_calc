require 'rails_helper'

RSpec.describe StringCalculatorsController, type: :controller do
  describe 'POST #add' do
    context 'with valid input' do
      it 'returns a successful result' do
        post :add, params: { numbers: "1\n2,3" }

        expect(response).to render_template(:index)
        expect(assigns(:result)).to eq(6)
      end
    end

    context 'with negative numbers' do
      it 'raises an error and returns a custom message' do
        post :add, params: { numbers: "1\n-2,3" }

        expect(response).to render_template(:index)
        expect(assigns(:error)).to eq("negative numbers not allowed -2")
      end
    end

    context 'with empty input' do
      it 'returns 0' do
        post :add, params: { numbers: "" }

        expect(response).to render_template(:index)
        expect(assigns(:result)).to eq(0)
      end
    end
  end
end
