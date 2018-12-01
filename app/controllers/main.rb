Downstairser::App.controller do
  get :auth, :csrf_protection => false, :map => '/auth/:provider/callback' do
    auth = request.env["omniauth.auth"]
    user = User.find_by_email(auth.info.name) ||
           User.create_with_omniauth(auth)
    # set_current_account(account)
    # redirect "http://" + request.env["HTTP_HOST"] + url(:profile)
  end

  get :paper do
    return Paper.make
  end
end

# Downstairser::App.controllers :admin do
#   
#   # get :index, :map => '/foo/bar' do
#   #   session[:foo] = 'bar'
#   #   render 'index'
#   # end
#
#   # get :sample, :map => '/sample/url', :provides => [:any, :js] do
#   #   case content_type
#   #     when :js then ...
#   #     else ...
#   # end
#
#   # get :foo, :with => :id do
#   #   "Maps to url '/foo/#{params[:id]}'"
#   # end
#
#   # get '/example' do
#   #   'Hello world!'
#   # end
#   
#
# end
