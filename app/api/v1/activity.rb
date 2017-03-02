module Signin
  module Activity
    module V1
      def load_activity
        resource :activities do
          route_params :id do
            desc 'Return a activity.' do
              success Entities::Activity
              failure [[401,'Unauthorized'],[403,'Forbidden'],[404,'Not Found']]
            end

            get do
              token_error!(access_token) unless access_token == 200
              token_missing! if access_token == 400
              not_found! 'activity' unless _activity = DB::Activity.find_by(id: params[:id])
              Entities::Activity.represent _activity
            end

            desc 'Update a activity'
            params do
              require :name, type: String, desc:'name of the activity'
              require :date_started, type: Integer, desc:'start'
              require :date_ended, type: Integer, desc:'end'
            end

            put do
              token_error!(access_token) unless access_token == 200
              token_missing! if access_token == 400
              not_found! 'activity' unless _activity = DB::Activity.find_by(id: params[:id])
              not_found! 'creator' unless _activity.creator_id  == access_token[:resource_owner_id]
              _activity.name = params[:name]
              _activity.date_end = params[:date_ended].to_t
              _activity.date_start = params[:date_started].to_t
              _activity.save
              Entities::Activity.represent _activity
            end

            desc 'delete a activity'
            delete do
              token_error!(access_token) unless access_token == 200
              token_missing! if access_token == 400
              not_found! 'activity'  unless _activity == DB::Activity.find_by(id: params[:id])
              not_found! 'creator' unless _activity.creator_id == access_token[:resource_owner_id]
              Entities::Activity.represent _activity.destroy
            end
          end
          desc 'create an activity'
          params do
            require :name, type: String, desc: 'name of the activity'
            require :date_started, type: Integer, desc: 'start'
            require :date_ended, type: Integer, desc: 'end'
          end
          post do
            token_error!(access_token) unless access_token == 200
            token_missing! if access_token == 400
            _activity = DB::Activity.create!(name: params[:name], date_start: params[:date_started].to_t, date_ended: params[:date_ended].to_t)
            Entities::Activity.represent _activity
          end

          desc'get activities of a creator'
          params do
            optional :page, type: Integer, default: 1, desc: 'page for app'
            optional :size, type: Integer, default: 10, desc: 'page for app'
          end
          get do
            token_error!(access_token) unless access_token == 200
            token_missing! if access_token == 400
            _activities = DB::Activity.where(creator_id: params[:id]).page(params[:page]).per(params[:size])
            not_found! if _activities.out_of_range?
            Entities::Activities.represent({ content: _activities, page_meta_data:{ size: params[:size], total_elements: _activities.total_count, total_pages: _activities.total_pages, number: _activities.count } })
          end
        end
      end
    end
  end
end
