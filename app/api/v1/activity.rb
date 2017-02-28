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
              token_error! access_token
              token_missing! if access_token == 400
              not_found! 'activity' unless _activity = DB::Activity.find_by(id: params[:id])
              forbidden! unless access_token == 401
              Entities::Activity.represent _activity
            end

            desc 'Update a activity'
            params do
              require :name, type: String, desc:'name of the activity'
              require :date_started, type: Integer, desc:'start'
              require :date_ended, type: Integer, desc:'end'
            end
            put do
              token_error! access_token
              token_missing! access_token == 400
              not_found! 'activity' unless _activity = DB::Activity.find_by(id: params[:id])
              not_found! 'creator' unless _activity.creator_id  == access_token[:resource_owner_id]
              _activity.name = params[:name]
              _activity.date_end = itime params[:date_ended]
              _activity.date_start = itime params[:date_started]
              _activity.save
              Entities::Activity.represent _activity
            end

            desc 'delete a activity'
            delete do
              token_error! access_token
              token_missing! access_token == 400
              not_found! 'activity'  unless _activity == DB::Activity.find_by(id: params[:id])
              not_found! 'creator' unless _activity.creator_id == access_token[:resource_owner_id]
              Entities::Activity.represent _activity.destroy
            end
          end
          params do
            require :name, type: String, desc: 'name of the activity'
            require :date_started, type: Integer, desc: 'start'
            require :date_ended, type: Integer, desc: 'end'
          end
          post do
            token_error! access_token
            token_missing! access_token == 400
            _activity = DB::Activity.create!(name: params[:name], date_start: itime params[:date_started], date_ended: itime params[:date_ended])
            Entities::Activity.represent _activity
          end

          params do
            optional :page
            optional :size
          end
          get do
            token_error! access_token
            token_missing! access_token == 400
            not_found! unless _activities = DB::Activity.find_by(creator_id: params[:id])
            not_found! unless paged = _activities.page(params[:page]).per(params[:size]).out_of_range?
            paged = _activities.page(params[:paga]).per(params[:size])
            data = Entities::Activities.represent(paged)
            data.merge! pagaMetadata: [size: params[:size], totalElements: _activities.count, totalPages: paged.total_pages, number: paged.size]
          end
        end
      end
    end
  end
end
