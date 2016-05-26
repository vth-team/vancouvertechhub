var Organization = React.createClass({
  nameMatched: function() {
    return this.props.searchTerm === null || this.props.organization.name.toLowerCase().match(this.props.searchTerm.toLowerCase());
  },
  render: function() {
    if (!this.nameMatched()) {
      var styles = { display: "none" };
    }

    return <div style={styles} className="org-container col-lg-3 col-md-4 col-sm-6 col-xs-12 text-center" data-id={ this.props.organization.id } >
              <img src={ this.props.organization.logo } id="org-logo"/>
              <h3><a href={ "/organizations/" + this.props.organization.id } className="link-to-org">{ this.props.organization.name }</a></h3>
              <p>{ this.props.organization.employee_count } employees</p>
            </div>;
  }
});
