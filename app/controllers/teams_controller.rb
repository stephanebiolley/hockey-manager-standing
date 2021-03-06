class TeamsController < ApiController
  # GET /teams
  def index
    @teams = Team.select('name').all
    render json: @teams.to_json
  end

  # GET /teams/:id
  def show
    @team = Team.find(params[:id])
    render json: @team.to_json(:include => {
      :ranking_days => {
        :include => { :day => {
          :only => [:date] }
        },
        :only => [:ranking, :points]
      }},
    only: [:name])
  end
end
