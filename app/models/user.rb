class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :comments
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

         has_many :permissions
         has_many :roles, through: :permissions

         after_create :assign_user_role

         def assign_user_role
         	Permission.create(user_id: self.id, role_id: Role.last.id)
         end

         def role? role
         	self.roles.pluck(:name).include? role
         end
     end
 