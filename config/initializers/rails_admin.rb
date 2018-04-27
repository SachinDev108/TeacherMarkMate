RailsAdmin.config do |config|

  ### Popular gems integration
  config.main_app_name = [""]

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :admin
  end
  config.current_user_method(&:current_admin)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  config.show_gravatar = true
  config.included_models = ['Teacher']

  config.actions do
    dashboard
    index                         # mandatory
    new
    edit
    bulk_delete
    show
    delete

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.model Teacher do
    list do
      field :name
      field :email
      field :sign_in_count
      field :last_sign_in_at
      field :current_sign_in_at
      field :created_at
      field :marked do
        def value
          bindings[:view] = bindings[:object].details.updated_in_between((Time.zone.now - 30.days), Time.zone.now).count
        end
      end
      field :created_by do
        def value
          if bindings[:object].is_head? && bindings[:object].admin_id?
            text = "SuperAdmin"
          elsif ((bindings[:object].is_head? && bindings[:object].admin_id.blank?))
            text = "Self"
          else
            text = "HeadTeacher"
          end
          bindings[:view] = text
        end
      end
    end
    edit do
      field :name
      field :email
      field :users  do
        required true
        render do
          bindings[:view].render :partial => 'new_partial', :locals => {:field => self, :form => bindings[:form]}
        end
      end
      field :subscription_plan do
        render do
          bindings[:view].render :partial => 'plan_status', :locals => {:field => self, :form => bindings[:form]}
        end
      end
      field :period  do
        render do
          bindings[:view].render :partial => 'period_partial', :locals => {:field => self, :form => bindings[:form]}
        end
      end
      field :password
      field :password_confirmation
      field :admin_id, :hidden  do
        def value
          if bindings[:object].admin_id.present? || !bindings[:object].persisted?
            bindings[:view]._current_user.id
          end
        end
      end
      field :role, :hidden  do
        def value
          if bindings[:object].persisted?
            bindings[:view] = bindings[:object].role
          else
            bindings[:view] = "HeadTeacher"
          end
        end
      end
    end
  end
end
