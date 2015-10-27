class ResoursesController < ApplicationController
  def add_resourses
  	
  end

  def change_cat
    @user=current_user;
    @user.category=params[:request];
    @user.save;
  end
end
