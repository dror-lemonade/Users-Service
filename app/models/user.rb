require 'securerandom'

class User < ApplicationRecord
    validates :first_name, :last_name, :email, :password, presence: true
    validates :email, uniqueness: true
    
    attr_encrypted :password, key: "\xCC\x9F\xBDv0M\xCC\x00\xBA\xA0_\xAD\xE7c\xBCe\xD6\xCF\xFBl\xF6\xA7Nj\xC6\xA9\xF2\x1E\xB5/\x1E\x81"
end
