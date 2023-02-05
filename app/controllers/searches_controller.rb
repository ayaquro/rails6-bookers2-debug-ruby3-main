class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]

    if @range == "User"
      @records = User.looks(params[:search], params[:word])
    else
      @records = Book.looks(params[:search], params[:word])
    end
  end
end

#サンプルコードは以下の書き方
#def search
	#@model = params[:model]
	#@content = params[:content]
	#@method = params[:method]
		#if @model == 'user'
			#@records = User.search_for(@content, @method)
		#else
			#@records = Book.search_for(@content, @method)
#end
