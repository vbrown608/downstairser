Downstairser::App.controller do
  get :index do
    render "home"
  end

  get :auth, :csrf_protection => false, :map => '/auth/:provider/callback' do
    auth = request.env["omniauth.auth"]
    user = User.find_by_email(auth.info.name) ||
           User.create_with_omniauth(auth)
    # set_current_account(account)
    # redirect "http://" + request.env["HTTP_HOST"] + url(:profile)
  end

  get :paper do
    render "paper"
  end
end
