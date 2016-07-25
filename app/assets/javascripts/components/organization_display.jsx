var OrganizationsDisplay = React.createClass({

  getInitialState: function() {
    return { organizations: this.props.organizations, searchTerm: null, techSizeSearch: null, techStacks: null };
  },

  filterOrganizations: function() {
    var termSearch = this.refs.searchInput.value.toLowerCase();
    var techSizeSearch = this.refs.sizeInput.value;
    // var technologySearch = this.refs.technologyInput.value; comes in pluses
    var url = "search/?term="+termSearch+"?size="+techSizeSearch;

    $.ajax({
      url: url,
      method: "get",
      success: function(data) {
        this.setState({organizations: data})
        console.log(data)
      },
      error: function () {
        console.log("Error")
      }
    }.bind(this));

    //this.setState({ searchTerm: termSearch });
  },

  // filterOrganizationTechSize: function() {
  //   var techSizeSearch = this.refs.sizeInput.value;
  //   this.setState({ techSizeSearch: techSizeSearch });
  // },

  render: function() {
    var organizations = this.state.organizations.map(function(organization, index) {
      return <Organization organization = { organization }
                           key = { index }
                           searchTerm = { this.state.searchTerm }
                           techSizeSearch = { this.state.techSizeSearch }/>
    }.bind(this));

    return <div>
              <input id="organization-search" type="text" className="form-control" placeholder="Search" ref="searchInput" onChange= { this.filterOrganizations } ></input>
              <select id="team-size" className="form-control" ref="sizeInput" onChange= { this.filterOrganizations } >
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
