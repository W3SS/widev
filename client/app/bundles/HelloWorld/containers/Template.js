import React, { PropTypes } from 'react';
import _ from 'lodash';
import Axios from 'axios';
import TemplateTaskRow from '../components/TemplateTaskRow';

// Simple example of a React "smart" component
export default class Template extends React.Component {
 static propTypes = {
    currentUser: PropTypes.object.isRequired, 
    template :PropTypes.object.isRequired
  };
  

  constructor(props, context) {
    super(props, context);
    this.state={
        availble_steps:[],
        selected_steps:[]
    }
  }

  componentDidMount(){
    
    
    Axios.get('/api/template/getavailablesteps.json').then( (response) =>{
       this.setState({
         availble_steps:response.data,
       });
    })
    .catch(function (error) {
      alert(error);
   });
   
   Axios.get('/api/template/getstepfortemplate/'+this.props.template.id+'.json').then( (response) =>{
       this.setState({
         selected_steps:response.data,
       });
    })
    .catch(function (error) {
      alert(error);
   });
}

 handleAdd(item){
      Axios.get('/api/template/addsteptotemplate.json?templ_id='+this.props.template.id+'&task_id='+item.id+'').then( (response) =>{
       let selected = this.state.selected_steps;
       selected.push(response.data);
       this.setState({selected_steps:selected});
    })
    .catch(function (error) {
      alert(error);
   });
 }
 
 handleRemove(item){
       Axios.get('/api/template/removestepfromtemplate.json?templ_id='+this.props.template.id+'&task_id='+item.id+'').then( (response) =>{
    
        let selected = this.state.selected_steps;
         for(var i = selected.length; i--;) {
             console.log(selected[i])
          if(selected[i].id === response.data.id) {
              selected.splice(i, 1);
          }
         }
       this.setState({selected_steps:selected});

        
    })
    .catch(function (error) {
      alert(error);
   });
 }
  

  render() {
    
    let available_itemrows = this.state.availble_steps.map((i)=>{
      return <TemplateTaskRow item={i} btntext="Add" onaction={(item)=>this.handleAdd(item)}/>
    })
    let selected_itemrows = this.state.selected_steps.map((i)=>{
      return <TemplateTaskRow item={i} btntext="Remove" onaction={(item)=>this.handleRemove(item)} />
    })
    
    return (
        <div className="row">
              <div className="col-md-6">
              <h2>Available Steps</h2>
                <table  className="table table-bordered">
                    <thead>
                        <tr>
                          <th>Name</th>
                          <th></th>
                        </tr>
                      </thead>
                    <tbody>
                       {available_itemrows}
                    </tbody>
                </table>
            </div>
            <div className="col-md-6">
                          <h2>Selected Steps</h2>

                <table  className="table table-bordered">
                    <thead>
                        <tr>
                          <th>Name</th>
                          <th></th>
                        </tr>
                      </thead>
                    <tbody>
                       {selected_itemrows}
                    </tbody>
                </table>
            </div>
        </div>
         
    );
  }
}
