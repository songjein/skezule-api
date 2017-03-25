class MemosController < ApplicationController
	def index
		render json: Memo.first
	end

	def create
		if Memo.first
			memo = Memo.first
			memo.memo = params[:memo]
			memo.save
		else
			memo = Memo.new
			memo.memo = params[:memo]
			memo.save
		end

		render json: memo
	end
end
