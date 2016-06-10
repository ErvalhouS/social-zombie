class ReportController < ApplicationController

  # GET /infected_survivors
  def infected_survivors
      render json: {infected:(Survivor.infected_percentage.to_s || '00') + '%'}, status: :ok
  end
  # GET /healthy_survivors
  def healthy_survivors
    render json: {infected:(Survivor.healthy_percentage.to_s || '00') + '%'}, status: :ok
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

