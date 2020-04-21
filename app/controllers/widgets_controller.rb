class WidgetsController < ApplicationController

  before_action :current_user, only: :create

  def index
    outcome = Widgets::Visible.run(term: params[:term])
    if outcome.valid?
      @widgets = outcome.result.dig('data', 'widgets')
      flash[:success] = "#{@widgets.count} widgets found"
    end
  end

  def new
  end

  def create
    outcome = Widgets::Create.run(token: current_user, widget: widget_param.to_hash)
    if outcome.valid?
      @widget = outcome.result.dig('data', 'widget')
      flash[:success] = 'Successfully created!'
    else
      flash[:alert] = outcome.errors.messages.dig(:create).first[:message]
    end
  end

  private

  def widget_param
    params[:widget].permit(:name, :description, :kind)
  end
end
