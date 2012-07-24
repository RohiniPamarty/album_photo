class PhotosController < ApplicationController
  def create
    @album = Album.find(params[:album_id])
    @photo = @album.photos.create(params[:photo])
    redirect_to user_album_path(:user_id =>current_user.id, :id => @album.id)
  end
end
