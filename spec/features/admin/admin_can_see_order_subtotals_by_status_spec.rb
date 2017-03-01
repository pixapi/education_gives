require 'rails_helper'

RSpec.describe "Admin can see order subtotals by status" do
  scenario "admin can see order subtotals by status" do

    admin = create(:user, role: 1)
    allow_any_instance_of(ApplicationController)
    .to receive(:current_user).and_return(admin)

    create(:order, status: "ordered")
    create_list(:order, 2, status: "paid")
    create_list(:order, 3, status: "cancelled")
    create_list(:order, 4, status: "completed")

    visit admin_dashboard_path

    within("#subtotals") do
      expect(page).to have_content("10")
      expect(page).to have_content("1")
      expect(page).to have_content("2")
      expect(page).to have_content("3")
      expect(page).to have_content("4")
    end
  end
end
