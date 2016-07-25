import React, { PropTypes } from 'react';
import _ from 'lodash';

// Simple example of a React "dumb" component
export default class UserList extends React.Component {
  static propTypes = {
      };
  
  

  render() {
      
      const {users} = this.props
      
      const userList  = users.map((u)=>{
          return(
                 <li key={u}>
                    <a href="#" class="clearfix">
                        <div className="friend-name">   
                            <strong>{u}</strong>
                        </div>
                    <small className="chat-alert text-muted"><i class="fa fa-check"></i></small>
                    </a>
                </li> 
             
              );
      })
      
    return (
        
        <div className="col-md-4 bg-white ">
            <ul className="friend-list">
                {userList}
            </ul>
        </div>
            
     );
  }
}
