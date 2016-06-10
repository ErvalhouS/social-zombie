class ReportController < ApplicationController

  # GET /infected_survivors
  def infected_survivors
      render json: Survivor.infected_percentage, status: :ok
  end
  # GET /healthy_survivors
  def healthy_survivors
    render json: Survivor.healthy_percentage, status: :ok
  end
  # GET /average_resource/1.json
  def average_resource
    render json: Item.resource_per_capita, status: :ok
  end
  # GET /loss_by_infection
  def loss_by_infection
    render json: Item.lost_resources, status: :ok
  end

end
