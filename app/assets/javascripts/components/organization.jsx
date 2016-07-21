var Organization = React.createClass({
  render: function() {
    return <div style={styles} className="org-container col-lg-3 col-md-4 col-sm-6 col-xs-12 text-center" data-id={ this.props.organization.id } >
              <img src={ this.props.organization.logo } id="org-logo"/>
              <h3><a href={ "/organizations/" + this.props.organization.id } className="link-to-org">{ this.props.organization.name }</a></h3>
              <p>{ this.props.organization.employee_count } employees</p>
            </div>;
  }
});
