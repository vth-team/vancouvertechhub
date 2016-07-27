var MultiSelect = React.createClass({
  getInitialState: function(){
    return {
      vis: "none",
      text: ""
    }
  },
  handleChange: function(event) {
  var options = event.target.options;
  var value = [];
  var text = [];
  for (var i = 0, l = options.length; i < l; i++) {
    if (options[i].selected) {
      value.push(options[i].value);
      text.push(options[i].text);
    }
  }
  // this.props.someCallback(value);
  this.setState({text: text.join(", ")})
  this.props.getTechValue(value);
  },
  showMenu: function(){
    console.log(this.refs.selectBox)
    if (this.state.vis === "none"){
      this.setState({vis: "block"});
    }else{
      this.setState({vis: "none"});
    }
  },
  render: function() {
    var options = this.props.techStacks.map(function(obj, index){
      return <option key={index} value={obj.id}>{obj.name}</option>
    });
    var height = "" + this.props.techStacks.length * 16 + "px" //font height variable?
   
    return (
      <div>

      <input id="techstack-search" type="text" className="form-control" onClick={this.showMenu} value={this.state.text} placeholder="Tech Stacks" ref="searchInput" onChange= { this.filterOrganizations } ></input>
        <select style={{display: this.state.vis, height: height, lineHeight: height, border: '1px black solid' }} multiple={true} ref="selectBox" value={this.props.arrayOfOptionValues} onChange={this.handleChange}>
         {options}
        </select>
      </div>
    );
  }
});

