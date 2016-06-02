var Organization = React.createClass({
  nameMatched: function() {
    return (
      this.props.searchTerm === null || this.props.organization.name.toLowerCase().match(this.props.searchTerm.toLowerCase())
    );
  },
  teamSizeMatched: function() {
    var sizeInput = this.props.sizeInput;
    var techTeamSize = this.props.organization.tech_team_size;

    return (
      this.props.techSizeSearch === null ||
      (sizeInput === "1" && techTeamSize < 25) ||
      (sizeInput === "2" && techTeamSize > 25 && techTeamSize < 50) ||
      (sizeInput === "3" && techTeamSize > 50)
    );
  },
  render: function() {
    if ((!this.nameMatched()) || (!this.teamSizeMatched())) {
      var styles = { display: "none" };
    }

    return <div style={styles} className="org-container col-lg-3 col-md-4 col-sm-6 col-xs-12 text-center" data-id={ this.props.organization.id } >
              <img src={ this.props.organization.logo } id="org-logo"/>
              <h3><a href={ "/organizations/" + this.props.organization.id } className="link-to-org">{ this.props.organization.name }</a></h3>
              <p>{ this.props.organization.employee_count } employees</p>
            </div>;
  }
});

// PSEUDOCODE to refactor multiple param search in React
//
// this.setState({filteredOrganizations: this.filterOrganizations();)});
// filterOrganizations: function() {
//   this.props.organizations.filter(function(element){
//     return this.elementMatched(element);
//   }.bind(this));
// }
//
// elementMatched: function(element) {
//   returnee this .pr
// }
