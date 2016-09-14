import React, { PropTypes } from 'react';
import _ from 'lodash';
import Axios from 'axios';

// Simple example of a React "smart" component
export default class Defect extends React.Component {
 static propTypes = {
    currentUser: PropTypes.object.isRequired, // this is passed from the Rails view
     rmitems: PropTypes.object.isRequired,
     installation: PropTypes.object
 };
  

  constructor(props, context) {
    super(props, context);
    this.state={
        rmitems:this.props.rmitems
    }
  }


    handleVF(i){
        console.log("Setting Validate FIX on : " + i);
        console.log(i);
        Axios.get('/api/rtc/updateWorkItemByInstallation?wi='+i.DESCRIPTION+'&installation_id='+this.props.installation.id).then( (response) =>{

        })
        .catch(function (error) {
            alert(error);
        });
    }

  render() {


      let items = this.state.rmitems.map((i)=>{
          let btn="";
          if (!isNaN(i.DESCRIPTION)){
              btn = <button onClick={ () => this.handleVF(i) } className="btn btn-xs btn-success">Validate FIX</button>
              //btn = <button className="btn btn-sm btn-success">Validate FIX</button>
          }else{
              btn = "No action"
          }

          return(
              <tr>
                  <td>{i.NAME}</td>
                  <td>{i.DESCRIPTION}</td>
                  <td>{i.TYPE}</td>
                  <td>{btn} </td>
              </tr>
          )
      });


      return(
          <div>
              <table className="table table-bordered objtable">
                  <thead>
                  <tr>
                      <th>Object</th>
                      <th>Description</th>
                      <th>Type</th>
                      <th>RTC</th>
                  </tr>
                  </thead>
                  <tbody>
                  {items}
              </tbody>
             </table>
        </div>
          )

  }
}
