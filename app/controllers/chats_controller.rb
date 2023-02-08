class ChatsController < ApplicationController
 before_action :reject_non_related, only: [:show]

  def show
    #チャットする相手（@user）は誰？
   @user = User.find(params[:id])
  #ログイン中のユーザーの部屋情報をすべて習得
   rooms = current_user.user_rooms.pluck(:room_id)
  #その中に、チャットする相手とのルームがあるか確認
   user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)

  #ユーザールームがnilじゃなかったら？（つまりあったら）
   unless user_rooms.nil?
    #変数@roomにユーザー（自分と相手）と紐づいているroomを代入
    @room = user_rooms.room
   #ユーザールームがなかったら
   else
    #新しくRoomを作る
    @room = Room.new
    #保存
    @room.save
    #相手の中間テーブルを作る
     UserRoom.create(user_id: @user.id, room_id: @room.id)
    #自分の中間テーブルを作る
     UserRoom.create(user_id: current_user.id, room_id: @room.id)
   end

   #チャットの一覧用の変数
    @chats = @room.chats
   #チャットの投稿用の変数
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    @chat = current_user.chats.new(chat_params)
    render :validater unless @chat.save
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

  def reject_non_related
    user = User.find(params[:id])
    unless current_user.following?(user) && user.following?(current_user)
    #現在のユーザー（私）が対象のuser(あなた）をフォローしていて、かつ対象のユーザーが現在のユーザーをフォローしていなかった場合）)
      redirect_to books_path
      #bookの一覧画面にリダイレクトさせる
    end
  end

end
