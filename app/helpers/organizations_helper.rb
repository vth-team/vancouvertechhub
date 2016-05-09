module OrganizationsHelper
  def organizations_json(organizations)
    Gmaps4rails.build_markers(organizations) do |organization, marker|
      marker.lat organization.latitude
      marker.lng organization.longitude
      marker.infowindow organization.name
    end
  end
end
