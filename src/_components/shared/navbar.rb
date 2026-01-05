class Shared::Navbar < Bridgetown::Component
  include BreadcrumbHelper
  def initialize(metadata:, resource:)
    @metadata, @resource = metadata, resource
  end
end
