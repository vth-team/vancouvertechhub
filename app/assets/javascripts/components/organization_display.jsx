var OrganizationsDisplay = React.createClass({

  getInitialState: function() {
    return { organizations: this.props.organizations, searchTerm: null, techSizeSearch: null, technologySearch: null };
  },
  getTechValue: function(array){
      // do stuff here
    console.log(array.join('+'));
    this.setState({
      technologySearch: "" + array.join('+') + ""
    }, this.filterOrganizations);
  },
  filterOrganizations: function() {
    var termSearch = this.refs.searchInput.value.toLowerCase();
    var techSizeSearch = this.refs.sizeInput.value;
    // var technologySearch = "";
    var url = "search/";
    var that = this;
    console.log(url)
    $.ajax({
      url: url,
      method: "get",
      dataType: 'json',
      data: {
        term: termSearch,
        size: techSizeSearch,
        tech: this.state.technologySearch
      },
      success: function(data) {
        that.setState({organizations: data})
      },
      error: function () {
        console.log("Error")
      }
    });
  },
  render: function() {
    var organizations = this.state.organizations.map(function(organization, index) {
      return <Organization organization = { organization }
                           key = { index }
                           searchTerm = { this.state.searchTerm }
                           techSizeSearch = { this.state.techSizeSearch }/>
    }.bind(this));

    return <div>
      <MultiSelect getTechValue={this.getTechValue} ref="techStack" techStacks={this.props.techStacks} />
      <input id="organization-search" type="text" className="form-control" placeholder="Search" ref="searchInput" onChange= { this.filterOrganizations } ></input>
              <select id="team-size" className="form-control" ref="sizeInput" onChange= { this.filterOrganizations } >
                <option value="0" defaultValue> Team Size </option>
                <option value="1"> 25 or fewer </option>
                <option value="2"> 26 - 50 </option>
                <option value="3"> more than 50 </option>
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
