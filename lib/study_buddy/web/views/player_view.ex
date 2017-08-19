defmodule StudyBuddy.Web.PlayerView do
  use StudyBuddy.Web, :view
  alias StudyBuddy.Web.PlayerView

  def render("index.json", %{players: players}) do
    %{data: render_many(players, PlayerView, "player.json")}  
  end

  def render("player.json", %{player: player}) do
    %{id: player.id,
      name: player.name,
      level: player.level
    }
  end
end
