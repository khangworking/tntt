# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default("")
#  encrypted_password     :string           default(""), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  phone                  :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,
         :trackable

  has_one :person
  has_many :manage_levels, through: :person, source: :manage_levels
  has_many :user_roles
  has_many :roles, through: :user_roles

  class << self
    def auth(payload)
      case payload['grant_type']
      when 'password'
        auth_with_password(payload['credential'])
      when 'refresh_token'
        auth_with_refresh_token(payload['credential']['refresh_token'])
      end
    end

    def auth_with_password(credential)
      return [false, nil] if %w[phone password].any? { |field| credential[field].blank? }

      user = find_by(phone: credential['phone'])
      return [false, nil] unless user
      return [false, user] unless user.valid_password?(credential['password'])

      [true, user]
    end

    def auth_with_refresh_token(token)
      return [false, nil] unless token

      begin
        payload = JWT.decode token, ENV['SECRET_KEY'], true, { algorithm: 'HS256' }
        return [false, nil] if payload[0]['type'] != 'refresh'

        user = find(payload[0]['id'])
        [true, user]
      rescue JWT::ExpiredSignature
        [false, nil]
      rescue ActiveRecord::RecordNotFound
        [false, nil]
      end
    end
  end

  def email_required?
    false
  end

  def admin?
    roles.where(name: 'admin').exists?
  end

  def manager?
    roles.where(name: 'manager').exists?
  end

  def generate_access_token
    payload = {
      id: id,
      phone: phone,
      type: 'token',
      profile: {
        christain_name: person.christain_name,
        fullname: person.fullname,
        gender: person.gender
      },
      exp: Time.zone.now.to_i + 86400
    }
    JWT.encode payload, ENV['SECRET_KEY'], 'HS256'
  end

  def generate_refresh_token
    payload = {
      id: id,
      type: 'refresh',
      exp: Time.zone.now.to_i + 604_800
    }
    JWT.encode payload, ENV['SECRET_KEY'], 'HS256'
  end
end
