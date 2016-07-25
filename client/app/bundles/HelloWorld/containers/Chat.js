import React, { PropTypes } from 'react';
import _ from 'lodash';
import 'pubnub';
import MessageInput from '../components/MessageInput';
import UserList from '../components/UserList';



    


// Simple example of a React "smart" component
export default class Chat extends React.Component {
 static propTypes = {
    currentUser: PropTypes.object.isRequired, // this is passed from the Rails view
    channel: PropTypes.string.isRequired, // this is passed from the Rails view
  };
  

  constructor(props, context) {
    super(props, context);
      this.state = { history: [] , users:[] };

  }

  componentDidMount(){
      
    let publish_key =  'pub-c-b2b03759-be93-423c-9bef-ac0f131dc2a0'; 
    let subscribe_key  = 'sub-c-4be724ac-5249-11e6-9c7c-0619f8945a4f'; 
 
     this.PubNub = require('pubnub').init({                         
          publish_key   : publish_key,
          subscribe_key : subscribe_key,
          ssl: true,
          uuid: this.props.currentUser.email
    });

        this.PubNub.subscribe({
            channel: this.props.channel,
            
            message: (message) =>{
                 console.log(message);
                
                 this.setState({ 
                    history: this.state.history.concat(message).reverse()
                 })
            }
               
        });
      
      this.PubNub.history({
        channel : this.props.channel,
         callback : (m)=>{
             m[0].reverse()
          for (var v of m[0]) {
            let newList = this.state.history.concat(v);
            this.setState({history: newList});
          }
        },
        count : 100, // 100 is the default
        reverse : true // false is the default
       });
       
       
       this.PubNub.here_now({
            channel : this.props.channel,
            callback : (m)=>{
                console.log(m);
                this.setState({users: m.uuids});
            }
        });
    }
  
  
  handleSend(mess){
      
    var data = {
      username: this.props.currentUser.email,
      message : mess,
      timestamp: Date.now()
    };
    
    console.log("SENDING TO PUBNUB");
    console.log(data);
    this.PubNub.publish({
      channel: this.props.channel,
      message: data,
    });
    
  }
  

  render() {
      
    let { history,users } = this.state;

    var hist = history.map((messageObj) => {
                let lrclass='left';    

                if (messageObj.username == this.props.currentUser.email){
                    lrclass = "left clearfix"

                }else{
                    lrclass = "left clearfix"
                }
    
              return (
                  
                  <li key={messageObj.timestamp} className={ lrclass }>
                        <span className="chat-img pull-left">
                            <img src="http://bootdey.com/img/Content/user_1.jpg" alt="User Avatar" />
                        </span>
                        <div className="chat-body clearfix">
                            <div className="header">
                                <strong className="primary-font">{messageObj.username}</strong>
                                <small className="pull-right text-muted"><i className="fa fa-clock-o"></i>{messageObj.timestamp}</small>
                            </div>
                            <p>
                                {messageObj.message}    
                            </p>
                        </div>
                    </li>
                 
                 ); 
    });
    
     return (
        <div className="container bootstrap snippet">
            <div className="row">
                <UserList users={users} />
                <div className="col-md-8 bg-white ">
                    <div className="chat-message">
                        <ul className="chat">
                            { hist }
                        </ul>
                    </div>
                    <MessageInput onSend={(mess)=>this.handleSend(mess)}/>
                </div>
            </div>
        </div>
    );
  }
}
