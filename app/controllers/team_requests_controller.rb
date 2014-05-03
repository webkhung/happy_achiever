class TeamRequestsController < ApplicationController

  def new
    @user = User.find(params[:user_id])
    @team_request = TeamRequest.new
  end

  def create
    @team_request = TeamRequest.new(params[:team_request])
    @team_request.requester = current_user
    @team_request.receiver_user_id = params[:user_id] # Or I can do this instead for an extra db call: @team_request.receiver = User.find(params[:user_id])
    @team_request.save!

    TeamRequestMailer.team_request_email(current_user, User.find(@team_request.receiver_user_id), @team_request.message).deliver

    redirect_to root_path, notice: 'Request sent!'
  end

  def destroy
    @team_request = TeamRequest.find(params[:id])
    @team_request.status = TeamRequest::REQUEST_STATUS[:denied]
    @team_request.save!

    redirect_to root_path
  end

  def show

  end

  def accept
    @team_request = TeamRequest.find(params[:id])
    @team_request.status = TeamRequest::REQUEST_STATUS[:accepted]

    ActiveRecord::Base.transaction do
      @team_membership = TeamMembership.new
      @team_membership.user_id = @team_request.requester_user_id
      @team_membership.teammate_user_id = @team_request.receiver_user_id
      @team_membership.save!
      @team_request.save!
    end

    redirect_to root_path(modal: 'joined_team', name: @team_request.requester.display_name), notice: "You have joined #{@team_request.requester.display_name}'s team!"
  end

end
