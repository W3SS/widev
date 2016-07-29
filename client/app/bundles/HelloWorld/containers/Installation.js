import React, { PropTypes } from 'react';
import _ from 'lodash';
import Axios from 'axios';
import InstallationItemRow from '../components/InstallationItemRow';

// Simple example of a React "smart" component
export default class Installation extends React.Component {
 static propTypes = {
    currentUser: PropTypes.object.isRequired, // this is passed from the Rails view
    installation: PropTypes.object.isRequired, 
  };
  

  constructor(props, context) {
    super(props, context);
    this.state={
        installation:this.props.installation,
        items:[],
        is_done:false
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
  

  render() {
      
    const inst  = this.state.installation;
    let complete_enabled=true;
    
    let item_rows = this.state.items.map((i)=>{
      console.log(i);
      if (!i.is_done && !i.is_error ) 
      { 
        complete_enabled=false;
      }
      return <InstallationItemRow key={i.id} item={i} />
    })
    
    let btn="";
    if(this.state.installation != null){
      if (this.state.installation.is_done){
        btn=<h3>Completed</h3>
      }else{
        btn=<button disabled={!complete_enabled} onClick={()=>this.markCompleted()} className="btn btn-success">Mark Completed</button>
      }
    }
    
    return (
      <div >
        <div className="row">
              <div className="col-md-12">
               <h1> {inst.release}</h1>
                {btn}
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
                            <th colSpan="3"></th>
                          </tr>
                        </thead><tbody>
                        {item_rows}
                        </tbody>
                  </table>
              </div>
        </div>
      </div>
    );
  }
}
