var OrganizationsDisplay = React.createClass({
  getInitialState: function() {
    return { searchTerm: null }
  },
  filterOrganizations: function() {
    var searchTerm = this.refs.searchInput.value.toLowerCase();
    this.setState({ searchTerm: searchTerm });
  },
  render: function() {
    var organizations = this.props.organizations.map(function(organization, index) {
      return <Organization organization = { organization }
                              key = { index }
                              searchTerm = { this.state.searchTerm } />
    }.bind(this));

    return <div>
              <input id="organization-search" type="text" className="form-control" placeholder="Search" ref="searchInput" onChange= { this.filterOrganizations } />
              <br />
              <div class="container-fluid text-center">
                <div class="row">
                  { organizations }
                </div>
              </div>
              <br />
            </div>;
  }
});
