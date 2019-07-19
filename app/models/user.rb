# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Associations
  has_many :access_tokens, dependent: :destroy

  def generate_access_token
    access_tokens.create
  end

  def get_access_token
    self.access_tokens.destroy_all
    self.generate_access_token
  end
end
