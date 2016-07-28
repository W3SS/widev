// HelloWorldWidget is an arbitrary name for any "dumb" component. We do not recommend suffixing
// all your dump component names with Widget.

import React, { PropTypes } from 'react';
import _ from 'lodash';
import Axios from 'axios';

// Simple example of a React "dumb" component
export default class InstallationItemRow extends React.Component {
  static propTypes = {
    item: PropTypes.object.isRequired
 
  };

  constructor(props, context) {
    super(props, context);
    this.state={
           item:this.props.item
    }
  }
   componentDidMount(){
      

   }
    setStart(){
      Axios.get('/api/installation/startTask/'+this.props.item.id +'.json').then( (response) =>{
         this.setState({item:response.data } );
    })
    .catch(function (error) {
      alert(error);
    });
    }

    setDone(){
          Axios.get('/api/installation/endTask/'+this.props.item.id +'.json').then( (response) =>{
        this.setState({item:response.data } );
        })
        .catch(function (error) {
          alert(error);
       });
      }
  
    setError(){
          Axios.get('/api/installation/errorTask/'+this.props.item.id +'.json').then( (response) =>{
           this.setState({item:response.data } );
        })
        .catch(function (error) {
          alert(error);
       });
      }
  

  render() {
      
    const { item } = this.state;
    let done_enabled=true;
    let error_enabled=true;
    let start_enabled=true;
    let status="";
    
    if( item.start_time == null && item.end_time == null ){
      start_enabled=true
      error_enabled=false;
      done_enabled=false;
    }
    if( item.end_time == null && item.start_time != null ){
      error_enabled=true;
      done_enabled=true;
      start_enabled=false;
    }
    if( item.is_done || item.is_error){
      error_enabled=false;
      done_enabled=false;
      start_enabled=false;
    }
    if(item.is_started){
        status =<span className="label label-primary"> ON GOING </span>
    }
    if(item.is_done){
      status =<span className="label label-success"> SUCCESS </span>
    }
    if(item.is_error){
       status =<span className="label label-danger"> ERROR </span>
    }
     
    
    
    
    return (
         <tr>
            <td>{ item.rel_template_item.name }</td>
            <td>{ item.start_time }</td>
            <td>{ item.end_time }</td>
            <td> 5 min</td>
            <td>{ status } </td>
            <td><button disabled={!start_enabled} className="btn btn-primary" onClick={()=>this.setStart()}>Start</button></td>
            <td><button disabled={!done_enabled} className="btn btn-success" onClick={()=>this.setDone()} >Done</button></td>
            <td><button disabled={!error_enabled} className="btn btn-danger" onClick={()=>this.setError()} >Error</button></td>
         </tr>    
    );
  }
}
