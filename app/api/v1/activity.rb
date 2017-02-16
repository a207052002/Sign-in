module Signin
  module Activity
    module V1
      def load_activity
        resource :activities do
          route_param :id do
            desc 'return activities' do
              success Entities::Activity
              failure [[404, 'Not Found']]
            end
            params do 
              requires :id, type: Integer, desc: 'identifier'
            end
            get do
              not_found! 'activity' unless _activity = DB::Activity.find_by(id: params[:id])
              Entities::Activity.represent _activity
            end

            desc 'new activity' do
              success Entities::Activity
              failure [[404,'Not Found!']]
            end
            params do
              requires :name, type: String, desc:'name'
              requires :date_started, type: DateTime, desc:'start'
              reqiires :date_ended, type: DateTime, desc:'end'
            end
            post do
              _activity = DB::Activity.creat!()
            end
            Entities::Activity.represent _activity
          end
        end
      end
    end
  end
end
