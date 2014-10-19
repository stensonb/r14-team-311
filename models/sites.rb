class Site
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  field :name, type: String

  def self.default
    Site.new(name: "Gamegit")
  end
end

