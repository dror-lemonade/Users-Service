
class UsersController < ApplicationController
    DISPLAY_FIELDS = [:first_name, :last_name, :email, :id]

    skip_before_action :verify_authenticity_token
    before_action :set_user_by_token, except: %i[index create sign_in]
    before_action :validate_user_by_id, only: %i[show update]

    def index # Should add some admin privileges to this endpoint
        users = User.all
        render(json: users)
    end

    def create
        @user = User.create!(user_params)
        render_user
    end

    def show
        render_user
    end

    def sign_in
        @user = User.find_by(email: params.fetch(:email))
        if @user && @user.password == params.fetch(:password)
            add_token
            render_user
        else
            unauthorized
        end
    end

    def update
        @user.update(user_params)
        render_user
    end

    def sign_out
        @user.update(token: nil)
        cookies.delete :token
    end

    private
        def set_user_by_token
            token = cookies[:token]
            unauthorized unless token
            @user = User.find_by(token: token)
            unauthorized unless @user
        end

    private
        def add_token
            token = SecureRandom.uuid
            cookies[:token] = token
            @user.update(token: token)
        end

    private 
        def validate_user_by_id
            unauthorized unless params.fetch(:id, nil) == @user.id.to_s
        end

    private
        def render_user
            render(json: @user.as_json(only: DISPLAY_FIELDS))
        end

    private
        def user_params
            params.require(:user).permit(:first_name, :last_name, :email, :password)
        end

    private
        def unauthorized
            head 401
        end
end
