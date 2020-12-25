class LabelsController < ApplicationController
  def new
    @label = Label.new
  end
  def confirm
    @label = Label.new(label_params)
  end
  def create
    @label = Label.new(label_params)
    if params[:back].present?
      render 'new'
    else
      if @label.save
        # flash[:notice] = t('.label created')
        # render 'show'
        redirect_to label_path(@label.id), notice: "#{t('.label created')}"
      else
        falsh.now[:danger] = "#{t('.not created')}"
        render 'new'
      end
    end
  end
  def index
    binding.pry
    @labels = Label.where(user_id: current_user.id)
    @default_labels = Label.where(user_id: nil)
    @default_label_ids = @default_labels.pluck(:id)
    # @default_label_ids = Label.where(user_id: nil).pluck(:id)
    @managers = Manager.where(label_id:[@default_label_ids])

  end
  def show
    @label = Label.find_by(id: params[:id])
  end
  private
  def label_params
    params.require(:label).permit(:label_name).merge(user_id: current_user.id)
  end
end
