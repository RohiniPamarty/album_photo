class UsersController < ApplicationController

def index
@users=User.all
end
def show
render :text => "signed off"
current_user.id=nil
end
end
