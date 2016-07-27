
// react-select component
var MultiSelectField = React.createClass({
	displayName: 'MultiSelectField',
	propTypes: {
		label: React.PropTypes.string,
	},
	getInitialState: function() {
	  var techStack = this.props.techStacks.map(function(obj, index){
      return {value: obj.id.toString(), label: obj.name, data: obj.id}
    });
	  return {
			options: techStack,
			value: [],
		};
	},
	handleSelectChange: function(value) {
		console.log('You\'ve selected:', value);
    this.setState({ value });
    this.props.sendValue(value);
	},
	render: function() {
		return (
			<div id="techstack-search" className="section">
				<h3 className="section-heading">{this.props.label}</h3>
				<Select multi simpleValue disabled={this.state.disabled} value={this.state.value} placeholder="Search Technologies" options={this.state.options} onChange={this.handleSelectChange} />
			</div>
		);
	}
});
