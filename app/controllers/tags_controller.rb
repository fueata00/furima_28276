class TagsController < ApplicationController
  def search
    return nil if params[:input] == ""
    tag = Tag.where(['name LIKE ?', "%#{params[:input]}%"] )
    render json:{ keyword: tag }
  end
end
