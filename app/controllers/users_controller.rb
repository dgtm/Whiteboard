class UsersController < ActionController::Base
  layout 'authenticate'
  protected

   def self.find_for_database_authentication(warden_conditions)
     conditions = warden_conditions.dup
     login = conditions.delete(:login)
     where(conditions).where(["username = :value OR email = :value", { :value => login }]).first
   end

end