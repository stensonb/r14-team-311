class Event
  include Mongoid::Document
  include Mongoid::Timestamps

  field :data, type: Hash
end
