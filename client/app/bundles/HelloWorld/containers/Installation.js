import React, { PropTypes } from 'react';
import _ from 'lodash';
import Axios from 'axios';
import InstallationItemRow from '../components/InstallationItemRow';

// Simple example of a React "smart" component
export default class Installation extends React.Component {
 static propTypes = {
    currentUser: PropTypes.object.isRequired, // this is passed from the Rails view
    installation: PropTypes.object.isRequired, 
    show_btn:PropTypes.bool
  };
  

  constructor(props, context) {
    super(props, context);
    this.state={
        installation:this.props.installation,
        items:[],
        is_done:false,
        newitemname:''
    }
  }

  componentDidMount(){
    
    Axios.get('/installations/'+this.props.installation.id +'.json').then( (response) =>{
       this.setState({
         installation:response.data.installation,
         items: response.data.installation.items,
         is_done:false
       });
    })
    .catch(function (error) {
      alert(error);
   });
}

  markCompleted(){
     Axios.get('/api/installation/complete/'+this.props.installation.id +'.json').then( (response) =>{
      this.setState({
         installation:response.data.installation
        });
      })
    .catch(function (error) {
      alert(error);
   });
  }
  
  handleAddItem(){
    const name = this.state.newitemname;
    console.log (name)
   const data = {
     item_name:name,
     installation_id:this.state.installation.id
   }
    this.setState({
         newitemname:''
       });
   
    Axios.post('/api/installation/additem.json',data).then( (response) =>{
      
      let newitems = this.state.items.concat(response.data);
      
       this.setState({
         items: newitems,
         newitemname:''
       });
       
    })
    .catch(function (error) {
      alert(error);
   });
  }
  
  handleInpChange(e){
    const newval= e.target.value;
    console.log(newval);
    this.setState({
      newitemname:newval
    })
  }
  

  render() {
      
    const inst  = this.state.installation;
    const show_btn =  this.props.show_btn;
    let complete_enabled=true;
    
    let item_rows = this.state.items.map((i)=>{
      if (!i.is_done && !i.is_error ) 
      { 
        complete_enabled=false;
      }
      return <InstallationItemRow key={i.id} item={i} show_button={show_btn} />
    })
    
    let btn="";
    
    if(this.state.installation != null && show_btn != false){
      if (this.state.installation.is_done){
        btn=<h3>Completed</h3>
      }else{
        btn=<button disabled={!complete_enabled} onClick={()=>this.markCompleted()} className="btn btn-success">Mark Completed</button>
      }
    }
    
    let thbtn ="";
    let formAddItem="";
    
    let btn_disabled = true;
    if (this.state.newitemname != ''){
      btn_disabled=false;
    }
    
    if( show_btn != false )
    {
      thbtn = <th colSpan="7"></th>
      formAddItem = <div className="row">
                        <div className="col-md-12">
                        <div className="form-inline">
                          <div className="form-group">
                                <input value={this.state.newitemname} onChange={(e)=>this.handleInpChange(e)} className="form-control" type="text" placeholder="Add extra item" ref="newitem" id="query_title"/>
                                <button disabled={btn_disabled} className="btn btn-primary" onClick={()=>this.handleAddItem()}>Add</button>
                          </div>
                        </div>
                        </div>
                      </div>
    }
    
    let envname = "Loading...";
    if( inst.environment != null ){
     envname= inst.environment.name;
    }
    
    
    return (
      <div >
        <div className="row">
              <div className="col-md-12">
               <h1> {inst.release}  <small> on {envname}</small>                 {btn}</h1>
               <br/>
               <br/>
              </div>
        </div>
         <div className="row">
              <div className="col-md-12">
                  <table  className="table table-bordered">
                      <thead>
                          <tr>
                            <th>Step name</th>
                            <th>Start</th>
                            <th>Stop</th>
                            <th>Elapsed</th>
                            <th>Status</th>
                            {thbtn}
                          </tr>
                        </thead><tbody>
                        {item_rows}
                        </tbody>
                  </table>
              </div>
        </div>
     {formAddItem}
      </div>
    );
  }
}
