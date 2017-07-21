class User < ApplicationRecord
	has_secure_password

	# https://stackoverflow.com/questions/19277377/customize-password-confirmation-doesnt-match-password-in-rails
	validates :user_id, :presence => { message: "아이디를 입력해주세요"}, :uniqueness => { message: "이미 존재하는 유저 아이디 입니다" }
	validates :name, :presence => { message: "닉네임을 입력해주세요" }

	has_many :todos, dependent: :destroy
	has_many :logs, dependent: :destroy
end
