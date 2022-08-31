class UsersController < ApplicationController


    def my_portfolio
        @user=current_user
        @user_stocks=current_user.stocks
    end

    def my_friends
        @friendships = current_user.friends
    end

    def search
        if params[:search_param].blank?
            puts "You entered empty string"

        respond_to do |format|
            format.html { redirect_to article_path(@article), notice: "Atricle was successfully created." }   
        end
            flash[:danger] = "You have entered an empty search string"
        else
            @users = User.search(params[:search_param])
            flash[:danger] = "No users match this search criteria" if @users.blank?
        end
        render partial: 'friends/result'

    end

end