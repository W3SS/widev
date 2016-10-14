import React, { PropTypes } from 'react';
import _ from 'lodash';
import axios from 'axios';
import {ModalContainer, ModalDialog} from 'react-modal-dialog';
import Select from 'react-select';
import Spinner from 'react-spinkit';
import Moment from 'moment';
// Simple example of a React "smart" component
export default class DayTimeReport extends React.Component {
 static propTypes = {
    currentUser: PropTypes.object.isRequired, 
    date :PropTypes.string.isRequired,
     reports : PropTypes.array,
     reasons :PropTypes.array
  };
  

  constructor(props, context) {
    super(props, context);
      this.state={
          input_visible:false,
          reports:this.props.reports,
          reasons:this.props.reasons,
          selected_reason:this.props.reasons[0],
          currentUser:this.props.currentUser,
          is_loading:false,
          is_submit_enabled:false
      }
   }

  componentDidMount(){
  }

  handleReport(){
    this.setState({
        input_visible:true
    })
  }
  handleClose(){
      this.setState({
          input_visible:false
      })
  }
  openInput(){

  }


  submitReport(){
      this.setState({
          input_visible:false,
          is_loading:true
      });
      const newreport= {user_id:this.state.currentUser.id ,
                         repdate:this.props.date,
                        hours:this.hours.value ,
                        time_reason_id:this.state.selected_reason.value,
                        };

      axios.post('/time/time_reports.json',newreport)
          .then((resp)=>{
              let repor = this.state.reports;
              repor.push(resp.data);
              this.setState({
                  reports:repor,
                  is_loading:false

              });
          })
          .catch((e)=>{
              console.log(e);
          });


  }

    handleDelete(e){
        this.setState({
            is_loading:true
        });
        console.log(e);
        axios.delete('/time/time_reports/'+e.id+'.json')
            .then((resp)=>{
                let repor = this.state.reports;
                  repor.splice( repor.indexOf(e),1);
                this.setState({
                    reports:repor,
                    is_loading:false
                });
            })
            .catch((e)=>{
                console.log(e);
            });
    }

    reasonChange(e){
        this.setState({
            selected_reason:e
        })
    }

    hourChange(e){
        if(isNaN(e.target.value)){
            this.setState({
                val_message:"Hours must be a number!",
                is_submit_enabled:false}
                );
        }else{
            this.setState({
                val_message:'',
                is_submit_enabled:true}
            );
        }
    }

  render() {

      let date = Moment(this.props.date).format('DD/MM/YY');

      console.log(date);
      let reports  = this.state.reports.map((e)=>{
          return <li className="list-group-item" key={e.id}>{e.hours} hr {e.time_reason.name}
                      <span className="pull-right">
                          <button  onClick={()=>this.handleDelete(e)} className="btn btn-xs">
                            <i className="fa fa-trash fa-1" aria-hidden="true"></i>
                          </button>
                        </span>
                </li>
      });

      let reasons = [];
      this.state.reasons.forEach((r)=>{
         reasons.push({value:r.id,label:r.name})
      });
      let sum=0;
      this.state.reports.forEach((r)=>{
          sum = sum +r.hours;
      });

      let button = <button className="btn btn-xs btn-success" onClick={()=>this.handleReport()}><i className="fa fa-clock-o" aria-hidden="true"></i></button>
      if(this.state.reports == 0) {
          button = <button className="btn btn-xs btn-danger" onClick={()=>this.handleReport()}><i className="fa fa-clock-o" aria-hidden="true"></i></button>
      }


    return (
        <div>
            <div className="cal-header" >{date} - <strong className="pull-right">Tot {sum}</strong>   {this.state.is_loading && <Spinner spinnerName="three-bounce" noFadeIn />}</div>

            <ul className="list-group">
                {reports}
            </ul>
            {button}
            {
                this.state.input_visible &&
                <ModalContainer onClose={()=>this.handleClose()}>
                    <ModalDialog onClose={()=>this.handleClose()}>
                        <h1>Add Report for {date}</h1>

                        <div className="row">
                            <div className="col-md-12">
                                <label>Reason</label>
                                <Select
                                    name="form-field-name"
                                    value={this.state.selected_reason}
                                    options={reasons}
                                    onChange={(e)=>this.reasonChange(e)}

                                />
                            </div>
                        </div>
                        <div className="row">
                            <div className="col-md-12">
                                <label>Hours</label>
                                <input type="text" onChange={(e)=>this.hourChange(e)} className="form-control" ref={(ref)=>this.hours = ref}/>
                                <p style={{color:'red'}}>{this.state.val_message}</p>

                            </div>
                        </div>
                        <br/>

                        <div className="row">
                            <div className="col-md-12">
                            <button disabled={!this.state.is_submit_enabled} onClick={()=>this.submitReport()} className="btn btn-success">Save</button>
                            </div>
                        </div>
                    </ModalDialog>
                </ModalContainer>
            }
        </div>
         
    );
  }
}
