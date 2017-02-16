module Activity
  module Sign
    module V1
      def load_sign do
        resource :sign do
          route_param :id do
            desc 'return all signs of the users' do
              success Entities::Signs
