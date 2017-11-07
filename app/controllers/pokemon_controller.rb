class PokemonController < ApplicationController
  def show
    poke_res = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{params[:id]}/")
    poke_data = JSON.parse(poke_res.body)
    id = poke_data["id"]
    name  = poke_data["name"]
    types = poke_data["types"]

    giphy_res = HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{ENV["GIPHY_KEY"]}&q=#{name}&rating=g")
    giphy_data = JSON.parse(giphy_res.body)

    gif_url = giphy_data["data"][0]["url"]

    render json: { 'id' => "#{id}", 'name' => "#{name}", 'type' => "#{types[0]["type"]["name"]}", 'gif' => "#{gif_url}"}
  end
end
