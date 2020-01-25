class AddOnboardingCompletedAtToSellers < ActiveRecord::Migration[6.0]
  def change
    add_column :sellers, :onboarding_completed_at, :datetime
  end
end
