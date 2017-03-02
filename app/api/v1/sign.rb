module Signin
  module Sign
    module V1
      def load_sign
        resource :activities do
          route_param :id do
            resource :sign_in do
              desc 'sign in an activity'
              params do
                requires :userId, type: String, desc: 'id'
              end
              post do
                not_found! unless sign = DB::Activity.find_by(creator_id: access_token[:resource_owner_id]).signs.create!(user_id: params[:userId])
                Entities::Sign.represent sign
              end

              desc 'get signs'
              params do
                optional :page, type: Integer, default: 1
                optional :size, type: Integer, default: 10
              end
              get do
                not_found! unless activity = DB::Activity.find_by(creator_id: access_token[:resource_owner_id])
                signs = activity.signs.page(params[:paga]).per(params[:size])
                not_found! if signs.out_of_range?
                Entities::Signs.represent({ content: signs, paga_metadata:{ size: params[:size], total_elements: signs.total_count, total_pages: signs.total_pages, number: signs.count } })
              end
            end
          end
        end
      end
    end
  end
end
