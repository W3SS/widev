import React, { PropTypes } from 'react';
import _ from 'lodash';

// Simple example of a React "dumb" component
export default class MessageInput extends React.Component {
  static propTypes = {
    onSend: PropTypes.func.isRequired, // this is passed from the Rails view
  };
  
  
  
  constructor(props, context) {
    super(props, context);

    _.bindAll(this, 'handleSend');
  }

  handleSend(e) {
    const mess = this.refs.message.value;
    console.log(mess);
    this.props.onSend(mess);
    this.refs.message.value="";
  }

  render() {
    return (
           <div className="chat-box bg-white">
                <div className="input-group">
                    <input ref="message" className="form-control border no-shadow no-rounded" placeholder="Type your message here" />
                    <span className="input-group-btn">
                        <button className="btn btn-success no-rounded"  onClick={(e)=>this.handleSend(e)} type="button">Send</button>
                    </span>
                </div>
            </div> 
     );
  }
}
