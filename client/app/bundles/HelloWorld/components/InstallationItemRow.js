// HelloWorldWidget is an arbitrary name for any "dumb" component. We do not recommend suffixing
// all your dump component names with Widget.

import React, { PropTypes } from 'react';
import _ from 'lodash';
import Axios from 'axios';
import moment from 'moment';
import {ModalContainer, ModalDialog} from 'react-modal-dialog';

// Simple example of a React "dumb" component
export default class InstallationItemRow extends React.Component {
  static propTypes = {
    item: PropTypes.object.isRequired,
    show_button:PropTypes.boolean
 
  };

  constructor(props, context) {
    super(props, context);
    this.state={
        item:this.props.item,
        isShowingModal:false,
        log:'',
        joburl:'#'
    }
  }

  componentDidMount(){
      if(this.props.item.rel_template_item.command ){
          this.getJenkUrl();
      }
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


      startJenk() {
          console.log("Start Job on Jenkins");

          Axios.get('/api/jenkins/runjob/'+this.props.item.id +'.json').then( (response) =>{
                 this.setStart();
                 this.getJenkUrl();
              this.setState({item:response.data } );

          })
        .catch(function (error) {
            alert(error);
        });
      }


    getJenkLog() {

        Axios.get('/api/jenkins/joblog/'+this.props.item.id +'.json').then( (response) =>{
            this.setState({log:response.data } );
        })
            .catch(function (error) {
                alert(error);
            });
    }

    getJenkUrl(){
        Axios.get('/api/jenkins/getbuildurl/'+this.props.item.id +'.json').then( (response) =>{
            console.log("Job url");
            this.setState({joburl:response.data } );
        })
            .catch(function (error) {
                alert(error);
            });
    }


    handleClose() {
        this.setState({isShowingModal: false});
    }

    handleClick() {
        this.getJenkLog()
        this.setState({isShowingModal: true});
    }

    render() {
        const { item } = this.state;
        const { log,joburl } = this.state;

        let done_enabled=true;
        let error_enabled=true;
        let start_enabled=true;
        let jenk_enabled=true;
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
          start_enabled=true;
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
            jenk_enabled=false;
        }
        if(item.is_started){
            status =<span className="label label-primary"> ON GOING </span>
            jenk_enabled=false;
        }
        if(item.is_done){
          status =<span className="label label-success"> SUCCESS </span>
        }
        if(item.is_error){
           status =<span className="label label-danger"> ERROR </span>
        }
        let jenk=<td></td>
        let jenk_log=<td></td>



        if(item.job_id != null){
            jenk_enabled = false;
            jenk_log =  <td>
                <button className="btn btn-success" onClick={()=>this.handleClick() }>
                    {
                        this.state.isShowingModal &&
                        <ModalContainer onClose={()=>this.handleClose()}>
                            <ModalDialog onClose={()=>this.handleClose()}>
                                <h3>Job log <small><a href={joburl} target="_blank"> View on Jenkins </a></small></h3> <button className="btn btn-sm btn-success" onClick={()=>this.getJenkLog()}>Update...</button>

                               <div className="pre">
                                   <pre>{log}</pre>
                               </div>
                            </ModalDialog>
                        </ModalContainer>
                    }
                    Log
                </button>
            </td>
        }

        if(item.rel_template_item.command ){//&& item.job_id  == null){
            jenk = <td><button  disabled={!jenk_enabled} className="btn btn-warning" onClick={()=>this.startJenk()} ><i className="fa fa-play" aria-hidden="true"></i> Jenkins</button> </td>
        }

         const startF= item.start_time?moment(item.start_time).format('MMMM Do, h:mm:ss a'):"-";
         const endF= item.end_time?moment(item.end_time).format('MMMM Do, h:mm:ss a'):"-";

          let button1=<td></td>
          let button2=<td></td>;
          let button3=<td></td>;
          let button4=<td></td>;

          if(this.props.show_button != false){
            button1 = <td><button disabled={!start_enabled} className="btn btn-primary" onClick={()=>this.setStart()}>Start</button></td>
            button2=     <td><button disabled={!done_enabled} className="btn btn-success" onClick={()=>this.setDone()} >Done</button></td>
            button3  =  <td><button disabled={!error_enabled} className="btn btn-danger" onClick={()=>this.setError()} >Error</button></td>
            button4  =  <td><button disabled={!start_enabled} className="btn btn-danger" onClick={()=>this.setNa()} >N/A</button></td>
          }

        return (
             <tr key={item.id} >
                <td>{ item.rel_template_item.name }</td>
                <td>{ startF }</td>
                <td>{ endF }</td>
                <td> { elapsed } </td>
                <td>{ status } </td>
                {button1}
                {button2}
                {button3}
                {button4}
                {jenk}
                {jenk_log}

             </tr>
        );
      }
}
