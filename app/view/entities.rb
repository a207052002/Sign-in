module Signin
  module Entities
    ##full info (id, name, date start/end/creat, creatorid)
    class Activity < Grape::Entity
      expose :id, as: :id, documentation: { type: 'string', dsec:'id', required: true }
      expose :name, documentation: { type: 'string', desc: 'name', required: true }
      expose :dateStarted, documentation: { type: 'DateTime', desc: 'beginning of an activity', require: true } do |activity, options|
        activity.date_start.to_i * 1000
      end
      expose :dateEnded, documentation: { type: 'DateTime', desc: 'end of an activity', require: true } do |activity, options|
        activity.date_end.to_i * 1000
      end
      expose :dateCreated, documentation: { type: 'DataTime', desc: 'time datas create at', require: true } do |activity, options|
          activity.created_at.to_i * 1000
      end
      expose :creator_id, as: :creatorId, documentation: { type: 'Integer', desc: 'activity creator', require: true }
    end

    class Page_metadata < Grape::Entity
      expose :size
      expose :total_elements, as: :totalElements
      expose :total_pages, as: :totalPages
      expose :number
    end

    ##userid, datecreat
    class Sign < Grape::Entity
      expose :user_id, as: :userId
      expose :dateCreated do |sign, options|
        sign.created_at.to_i * 1000
      end
    end

    ##'content':{'uid':'xxx', 'datecreat': xxx}, 'pageMetadata':{}
    class Signs < Grape::Entity
      expose :content, using: Sign
      expose :page_metadata, using: Page_metadata, as: :pageMetadata
    end

    ##'content':[{fullinfo}],'pagemetadata':{}
    class Activities < Grape::Entity
      expose :content, using: Activity, documentation: { is_array: true }
      expose :page_metadata, using: Page_metadata, as: :pageMetadata
    end
  end
end
