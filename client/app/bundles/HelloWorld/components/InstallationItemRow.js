// HelloWorldWidget is an arbitrary name for any "dumb" component. We do not recommend suffixing
// all your dump component names with Widget.

import React, { PropTypes } from 'react';
import _ from 'lodash';
import Axios from 'axios';
import moment from 'moment';

// Simple example of a React "dumb" component
export default class InstallationItemRow extends React.Component {
  static propTypes = {
    item: PropTypes.object.isRequired,
    show_button:PropTypes.boolean
 
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
      
    setNa(){
          Axios.get('/api/installation/setnaTask/'+this.props.item.id +'.json').then( (response) =>{
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
    
    let start = moment(item.start_time);
    let end;
    if (item.end_time != null){
       end = moment(item.end_time);
    }else{
       end = moment(new Date());
    }
    let elapsed="-";
    if (item.start_time != null){
       elapsed = moment.duration(end.diff(start)).humanize();
    }
    
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
    
    
     const startF= item.start_time?moment(item.start_time).format('MMMM Do, h:mm:ss a'):"-";
     const endF= item.end_time?moment(item.end_time).format('MMMM Do, h:mm:ss a'):"-";
      let button1='';
      let button2='';
      let button3='';
      let button4='';
      
      if(this.props.show_button != false){
        button1 = <td><button disabled={!start_enabled} className="btn btn-primary" onClick={()=>this.setStart()}>Start</button></td>
        button2=     <td><button disabled={!done_enabled} className="btn btn-success" onClick={()=>this.setDone()} >Done</button></td>
        button3  =  <td><button disabled={!error_enabled} className="btn btn-danger" onClick={()=>this.setError()} >Error</button></td>
        button4  =  <td><button disabled={!start_enabled} className="btn btn-danger" onClick={()=>this.setNa()} >N/A</button></td>
      }
    
    return (
         <tr>
            <td>{ item.rel_template_item.name }</td>
            <td>{ startF }</td>
            <td>{ endF }</td>
            <td> { elapsed } </td>
            <td>{ status } </td>
            {button1}
            {button2}
            {button3}
            {button4}
            
         </tr>    
    );
  }
}
