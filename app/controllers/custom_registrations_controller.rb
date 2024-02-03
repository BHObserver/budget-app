class CustomRegistrationsController < Devise::RegistrationsController
  def create
    super do |resource|
      if resource.persisted?
        # Your custom logic before redirecting (if needed)

        # Redirect to the confirmation page
        redirect_to confirmation_url(resource, confirmation_token: resource.confirmation_token)

        # Terminate the action after redirecting
        return
      end
    end
  end
end
