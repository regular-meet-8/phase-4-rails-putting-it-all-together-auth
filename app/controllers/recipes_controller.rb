class RecipesController < ApplicationController
    
    def index 
      if session[:user_id] 
        recipes = Recipe.all 
        render json: recipes, status: :ok, include: [:user]
      else 
        render json: {errors: ["Not authorized"]}, status: :unauthorized
      end
    end
    
    def create 
        if session[:user_id] 
          recipe = Recipe.create(recipe_params.merge(user_id: session[:user_id]))
          if recipe.valid?
            render json: recipe, status: :created, include: [:user]
          else
            render json: {errors: recipe.errors.full_messages}, status: :unprocessable_entity
          end
        else 
          render json: {errors: ["Not authorized"]}, status: :unauthorized
        end
      end
      
    
    private 
    
    def recipe_params 
      params.permit(:title, :instructions, :minutes_to_complete)
    end
  end
  