class User < ActiveRecord::Base
  include Clearance::User
  ROLES = %w[admin moderator user]
end
