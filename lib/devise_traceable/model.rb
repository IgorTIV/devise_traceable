require 'devise_traceable/hooks/traceable'

module Devise
  module Models
    # Trace information about your user sign in. It tracks the following columns:

    # * resource_id
    # * at
    # * ip
    # * action

    module Traceable
      # quick and dirty fix
      # method modified to store user logins and logouts without sti details
      # assume thats device use only user and inherited classes

      def stamp_sign_in!
        sign_time = self.current_sign_in_at || Time.now.utc
        'UserTracing'.constantize.create(:at => sign_time,
                                         :user_id => self.id,
                                         :ip => self.current_sign_in_ip,
                                         :action => :sign_in)
      end

      def stamp_sign_out!(request = nil)
        ip = request.remote_ip if request
        'UserTracing'.constantize.create(:at => Time.now.utc,
                                         :user_id => self.id,
                                         :ip => ip,
                                         :action => :sign_out)
      end
    end
  end
end
