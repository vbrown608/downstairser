Downstairser::App.controller do
  get :index do
    render "home"
  end

  get :auth, :csrf_protection => false, :map => '/auth/:provider/callback' do
    auth = request.env["omniauth.auth"]
    user = User.find_by_email(auth.info.name) ||
           User.create_with_omniauth(auth)
    if user
      render "home"
    else
      return "Unauthorized"
    end
  end

  get :paper do
    render "paper"
  end

  get :pdf do
    url = "#{request.base_url}/paper"
    system("node pdf.js #{Shellwords.escape(url)} public/files/downstairser.pdf")
    send_file "public/files/downstairser.pdf"
  end
end
