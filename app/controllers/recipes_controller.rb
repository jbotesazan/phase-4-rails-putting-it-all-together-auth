class RecipesController < ApplicationController
    # instead of using .to_json(include: [:user]), we can also use the serializers to do the work

    def index
        render json: Recipe.all.to_json(include: [:user]), status: :created
    end

    def create
        # user = User.find_by(id: session[:user_id])
        recipe = @user.recipes.new(recipe_params)
        if recipe.valid?
            recipe.save
            render json: recipe.to_json(include: [:user]), status: :created
        else
            render json: {errors: recipe.errors.full_messages}, status: :unprocessable_entity
        end
    end

    private

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end
end
