class PokemonController < ApplicationController
  def show
    pokemon_info
  end

private

  def pokemon_info
    poke_res = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{params[:id]}/")
    poke_data = JSON.parse(poke_res.body)

    if poke_res.code == 404
      render_404
    else
      id = poke_data["id"]
      name  = poke_data["name"]
      types = poke_data["types"]

      giphy_res = HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{ENV["GIPHY_KEY"]}&q=#{name}&rating=g")
      giphy_data = JSON.parse(giphy_res.body)

      if giphy_res.code == 403
        render_403
      else
        gif_url = giphy_data["data"][0]["url"]
        render json: { 'id' => "#{id}", 'name' => "#{name}", 'type' => "#{types[0]["type"]["name"]}", 'gif' => "#{gif_url}"}
      end
    end
  end

  def render_404
    render json: { :message => "Pokemon not found." }, layout: false, status: 404
  end

  def render_403
    render json: { :message => "Invalid GIPHY API Key"}, layout: false, status: 403
  end

  def team
    6.times do

    end
  end

end
