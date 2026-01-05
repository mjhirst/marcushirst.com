module BreadcrumbHelper
  def breadcrumbs(resource = nil)
    # If no resource is passed, try to use the component's @resource or the view's resource
    resource ||= @resource if defined?(@resource)
    resource ||= view.resource if respond_to?(:view)

    return [] unless resource

    path = resource.relative_url
    parts = path.split("/").reject(&:empty?)

    crumbs = []
    crumbs << { name: "Home", url: "/" }

    current_path = ""
    parts.each do |part|
      current_path += "/#{part}"
      crumbs << {
        name: part.split(/[-_]/).map(&:capitalize).join(" "),
        url: current_path
      }
    end

    crumbs
  end
end

class Builders::Helpers < Bridgetown::Builder
  def build
    helper "breadcrumbs" do |resource = nil|
      breadcrumbs(resource)
    end
  end
end