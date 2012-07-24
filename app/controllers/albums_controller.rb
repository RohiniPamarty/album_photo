class AlbumsController < ApplicationController
def index
@albums = current_user.albums 
end
def new
@album = Album.new
@user = User.find(current_user.id)
end
def create
    @album = current_user.albums.create(params[:album])
    @album.save
    redirect_to user_album_path(:user_id =>current_user.id, :id => @album.id)
end
def show
@album = Album.find(params[:id])
end
end
