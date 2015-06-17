class HomeController < ApplicationController

  def new
    @survey = Survey.new
  end

  def create
    @survey = Survey.new(survey_params)
    respond_to do |format|
      if session[:user_id] == @survey.last - 1
        @survey.save
        session[:user_id] = @survey.name

        format.html { redirect_to home_path(@survey), notice: 'Survey was successfully created.' }
        format.json { render :show, status: :created, location: @survey }
      else
        format.html { render :new }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @survey = Survey.find(params[:id])
  end



  private def survey_params
    params.require(:survey).permit(:name, :chocolate, :rainbow, :puppies, :cash)
  end

end
