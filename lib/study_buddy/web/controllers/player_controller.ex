defmodule StudyBuddy.Web.PlayerController do
  use StudyBuddy.Web, :controller
  
  def index(conn, _params) do
    players = [
      %{id: "1",
        name: "Sam",
        level: 1
      },
      %{id: "2",
        name: "Billy",
        level: 2
      },
      %{id: "3",
        name: "Gary",
        level: 3
       }
    ]
    render(conn, "index.json", players: players)
  end

  def show(conn, %{"id" => id}) do
    player = 
      %{id: id,
        name: "Player #{id}",
        level: 4
       }
    render(conn, "player.json", player: player)
  end

  def update(conn, player) do
    player = %{id: player["id"], name: player["name"], level: player["level"] + 1} 
    render(conn, "player.json", player: player)
  end
end
