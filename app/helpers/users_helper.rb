module UsersHelper
    def is_friend?(user, friend)
        user.friends.map { |friend| friend.friend_id}.include?(friend.id)
    end

    def country_code(name)
        @countries.key(name).upcase
    end
end
