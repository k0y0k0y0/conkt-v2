class AnswersController < ApplicationController
  def new
    @profile = current_user.profile
    @questions = Question.all
    @answer = current_user.answer || current_user.build_answer
  end

  def create
    answer_data = params[:answers].values.map { |value| value[:response] }
    @answer = current_user.answer || current_user.build_answer
    @answer.response = answer_data

    if @answer.save
      redirect_to pages_show_path, notice: '回答が保存されました。'
    else
      render :new
    end
  end

  private

  def answer_params
    params.require(:answers).permit(:response)
  end
end
