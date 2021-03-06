require 'rails_helper'

feature 'User updates a monster with a trait', js: true do
  let(:monster) { create(:monster, author: user, traits: [build(:trait, name: "Unedited Trait")]) }
  let(:user) { create(:user) }

  scenario 'they see the updated trait on the page' do
    sign_in user

    visit edit_monster_path(monster)

    page.find('h3', text: "Traits").find(:xpath, "..")
      .fill_in 'Name', with: "Edited Trait"

    click_button "Update Monster"

    visit monster_path(monster)

    expect(page).to_not have_content "Unedited Trait"
    expect(page).to have_content "Edited Trait"
  end
end
