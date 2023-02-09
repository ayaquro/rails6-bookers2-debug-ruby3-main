class Favorite < ApplicationRecord

 belongs_to :user
 belongs_to :book
 #↓過去１週間のいいね合計数に表示のサンプルコード
 validates_uniqueness_of :book_id, scope: :user_id

end