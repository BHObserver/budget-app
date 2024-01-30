require 'rails_helper'

RSpec.describe 'Expenses', type: :request do
  before(:each) do
    @user = User.create(
      id: 2,
      name: 'becky',
      email: 'becky@mail.com',
      password: 'abcxyz123',
      confirmed_at: Time.now
    )
    @expense = Expense.create(
      name: 'Expense 2',
      icon: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'icon.png'), 'image/png'),
      user_id: @user.id
    )
    sign_in @user
    get '/expenses'
  end

  describe 'GET /index' do
    it 'should be response successull' do
      expect(response).to have_http_status(:ok)
    end

    it 'should render the expenses index file' do
      expect(response).to render_template(:index)
    end

    it 'should include the placeholder' do
      expect(response.body).to include('Expense 2')
    end
  end

  describe 'GET /show' do
    it 'should be response successull' do
      get expense_path(@expense)
      expect(response).to have_http_status(:ok)
    end

    it 'should be response successull' do
      get expense_path(@expense)
      expect(response).to render_template(:show)
    end

    it 'should be response successull' do
      get expense_path(@expense)
      expect(response.body).to include('Expense 2')
    end
  end

  describe 'GET /new' do
    it 'should be response successfull' do
      get new_expense_path
      expect(response).to have_http_status(:ok)
    end

    it 'should render the new file' do
      get new_expense_path
      expect(response).to render_template(:new)
    end

    it 'should include the placeholder' do
      get new_expense_path
      expect(response.body).to include('New Category')
    end
  end

  describe 'POST /create' do
    it 'should create a new expense' do
      post expenses_path, params: {
        expense: {
          name: 'New Expense',
          icon: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'icon2.png'), 'image/png')
        }
      }
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(assigns(:expenses))
      follow_redirect!
      expect(response).to have_http_status(:ok)
    end

    it 'should render new template on invalid data' do
      post expenses_path, params: {
        expense: {
          name: ' ',
          icon: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'icon2.png'), 'image/png')
        }
      }
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:new)
    end
  end
end
