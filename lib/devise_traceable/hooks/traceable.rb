# After each sign in, sign out.
# This is only triggered when the user is explicitly set (with set_user)
# and on authentication. Retrieving the user from session (:fetch) does
# not trigger it.

Warden::Manager.after_set_user :except => :fetch do |record, warden, options|
  if record.respond_to?(:stamp_sign_in!)
    record.stamp_sign_in!
  end
end

Warden::Manager.before_logout do |record, warden, options|
  if record.respond_to?(:stamp_sign_out!)
    record.stamp_sign_out!(warden.request)
  end
end

# Warden::Manager.before_logout do |record, warden, opts|
#   if record.respond_to?(:stamp!)
#     record.stamp!
#   end
# end
