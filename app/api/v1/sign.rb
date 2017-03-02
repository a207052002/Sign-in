module Signin
  module Sign
    module V1
      def load_sign
        resource :activities do
          route_params :id do
            resource :sign_in do
              desc 'sign in an activity'
              params do
                require :userId, type: Integer, desc: 'id'
              end
              post do
                token_missing! if access_token == 400
                token_error!(access_token) unless access_token == 200
                not_found! unless activity = DB::Activity.find_by(id: params[:id])
                sign = activity.sign.create!(activity_id: params[:id], user_id: params[:userId])
                Entities::Sign.represent sign
              end

              desc 'get signs'
              params do
                optional :page, type: Integer, default: 1
                optional :size, type: Integer, default: 10
              end
              get do
                token_missing! if access_token == 400
                token_error!(access_token) unless access_token == 200
                not_found! unless activity = DB::Activity.find_by(params[:id])
                signs = activity.sign.page(params[:paga]).per(params[:size])
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
