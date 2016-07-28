// HelloWorldWidget is an arbitrary name for any "dumb" component. We do not recommend suffixing
// all your dump component names with Widget.

import React, { PropTypes } from 'react';
import _ from 'lodash';

// Simple example of a React "dumb" component
export default class TemplateTaskRow extends React.Component {
  static propTypes = {
    item: PropTypes.object.isRequired,
    btntext:PropTypes.string.isRequired,
    onaction:PropTypes.func.isRequired
  };

  constructor(props, context) {
    super(props, context);
  }
  
  onbtnClik(){
    console.log("Click");
    this.props.onaction(this.props.item);
  }

    render(){
         
         const item = this.props.item;
    
    return (
      <tr>
        <td>{  item.name }</td>
        <td><button className="btn btn-primary" onClick={()=>this.onbtnClik()}>{this.props.btntext}</button></td>
      </tr>
    );
  }
}
