module Signin
  module Activity
    module V1
      def load_activity
        resource :activities do
          route_param :id do
            desc 'Return a activity.' do
              success Entities::Activity
              failure [[401,'Unauthorized'],[400,'Access_token is missing!'],[404,'Not Found']]
            end

            get do
              not_found! 'activity' unless _activity = DB::Activity.where(creator_id: access_token[:resource_owner_id]).find_by(id: params[:id])
              Entities::Activity.represent _activity
            end

            desc 'Update a activity'
            params do
              requires :name, type: String, desc:'name of the activity'
              requires :dateStarted, type: Integer, desc:'start'
              requires :dateEnded, type: Integer, desc:'end'
            end
            put do
              not_found! 'activity' unless _activity = DB::Activity.where(creator_id: access_token[:resource_owner_id]).find_by(id: params[:id])
              _activity.name = params[:name]
              _activity.date_end = params[:dateEnded].to_t
              _activity.date_start = params[:dateStarted].to_t
              _activity.save
              Entities::Activity.represent _activity
            end

            desc 'delete a activity'
            delete do
              not_found! 'activity'  unless _activity == DB::Activity.where(creator_id: params[:access_token]).find_by(id: params[:id])
              Entities::Activity.represent _activity.destroy
            end
          end
          desc 'create an activity'
          params do
            requires :name, type: String, desc: 'name of the activity'
            requires :dateStarted, type: Integer, desc: 'start'
            requires :dateEnded, type: Integer, desc: 'end'
          end
          post do
            _activity = DB::Activity.create!(name: params[:name], date_start: params[:dateStarted].to_t, date_end: params[:dateEnded].to_t, creator_id: access_token[:resource_owner_id])
            Entities::Activity.represent(_activity, only: [:name, :dateStarted, :dateEnded])
          end

          desc'get activities of a creator'
          params do
            optional :page, type: Integer, default: 1, desc: 'page for app'
            optional :size, type: Integer, default: 10, desc: 'page for app'
          end
          get do
            _activities = DB::Activity.where(creator_id: access_token[:resource_owner_id]).page(params[:page]).per(params[:size])
            not_found! if _activities.out_of_range?
            Entities::Activities.represent({ content: _activities, page_metadata:{ size: params[:size], total_elements: _activities.total_count, total_pages: _activities.total_pages, number: _activities.count } })
          end
        end
      end
    end
  end
end
