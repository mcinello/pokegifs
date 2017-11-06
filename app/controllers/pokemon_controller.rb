require 'json'

class PokemonController < ApplicationController
  def show
    res = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{params[:id]}/")
    body = JSON.parse(res.body)
    id = body["id"]
    name  = body["name"]
    types = body["types"]
    render json: {
      id: id,
      name: name,
      types: types[0]["type"]["name"]
    }
  end
end
