class User < ApplicationRecord
  # Include default devise modules. Others available are: :registerable
  # :confirmable, :lockable,  :recoverable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :validatable
end
