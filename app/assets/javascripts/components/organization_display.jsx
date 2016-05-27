var OrganizationsDisplay = React.createClass({
  getInitialState: function() {
    return { searchTerm: null, techSizeSearch: null };
  },
  filterOrganizations: function() {
    var searchTerm = this.refs.searchInput.value.toLowerCase();
    this.setState({ searchTerm: searchTerm });
  },
  filterOrganizationTechSize: function() {
    var techSizeSearch = this.refs.sizeInput.value;
    this.setState({ techSizeSearch: techSizeSearch});
  },
  render: function() {
    var organizations = this.props.organizations.map(function(organization, index) {
      return <Organization organization = { organization }
                           key = { index }
                           searchTerm = { this.state.searchTerm }
                           techSizeSearch = { this.state.techSizeSearch }/>
    }.bind(this));

    return <div>
              <input id="organization-search" type="text" className="form-control" placeholder="Search" ref="searchInput" onChange= { this.filterOrganizations } />
              {/*<select :technologies, options_for_select(@technologies.each.map{|stack| stack.name}), class: "chosen-select form-control", id: "tech-stacks", multiple: true, data: {placeholder: "Tech Stacks (Max 3)"} />*/}
              <select id="team-size" className="form-control" ref="sizeInput" onChange= { this.filterOrganizationTechSize } >
                <option value="0" defaultValue> Team Size </option>
                <option value="1"> 25 or less </option>
                <option value="2"> 26 - 50 </option>
                <option value="3"> 50 or more </option>
              </select>
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
