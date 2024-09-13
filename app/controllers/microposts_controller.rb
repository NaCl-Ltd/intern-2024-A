class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy news toggle_pin]
  before_action :logged_in_user, only: [:create, :pinn]
  before_action :correct_user,   only: %i[destroy toggle_pin ]

  def index
    @micropost  = current_user.microposts.build
    @feed_items = current_user.feed.order(created_at: :desc)
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = current_user.feed.order(created_at: :desc).limit(10) 
      render 'static_pages/home', status: :unprocessable_entity
    end
  end

  def latest
    user = current_user.following
    number = 10
    time = 48 * 3600 #48時間前
    @microposts = Micropost
                    .where(user: user)#, created_at: Time.zone.now - time)
                    .order(created_at: :desc)
                    .limit(number)
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    if request.referrer.nil?
      redirect_to root_url, status: :see_other
    else
      redirect_to request.referrer, status: :see_other
    end
  end

  def news
    @microposts = Micropost.includes(:user, images_attachments: :blob)
    .where(user_id: current_user.following_ids, created_at: 48.hours.ago..)
    .reorder('created_at DESC')
    .limit(Settings.news.count)
  end


  def show
  @feed_item = Micropost.find_by(id: params[:id])
    if @feed_item.nil?
      redirect_to root_url, status: :see_other   
  end
end

  def toggle_pin
    @micropost.toggle(:is_pinned).save!
    redirect_to root_path
  end

  def show
    @feed_item = Micropost.find_by(id: params[:id])
    if @feed_item.nil?
      redirect_to root_path
    end
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content, images: [])
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url, status: :see_other if @micropost.nil?
    end
end
