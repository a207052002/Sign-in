module Signin
    module Entities
        ##full info (id, name, date start/end/creat, creatorid)
        class Activity < Grape::Entity
            expose :activity_id, as: :id, documentation: { type:'string', dsec:'id', required:true }
            expose :name, documentation: { type: 'string', desc: 'name', required:true }
            expose :date_start, as: :dateStarted
            expose :date_end, as: :dateEnded
            expose :created_at, as: :dateCreated
            expose :creator_id, as: :creatorId
        end

        class PageMetadata < Grape::Entity
        end

        ##userid, datecreat
        class Sign < Grape::Entity
            expose :user_id, as: :userId
            expose :created_at, as: :dateCreated
        end

        ##'content':{'uid':'xxx', 'datecreat': xxx}, 'pageMetadata':{}
        class Signs < Grape::Entity
            expose :content, using: Sign
            expose :pageMetadata, using: PageMetadata
        end

        ##'content':[{fullinfo}],'pagemetadata':{}
        class Activities < Grape::Entity
            expose :content, using: Activity, documentation: { is_array: true }
            expose :pageMetadata, using: PageMetadata
        end
    end
end
