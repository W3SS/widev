import React, { PropTypes } from 'react';
import _ from 'lodash';
import axios from 'axios';
import {ModalContainer, ModalDialog} from 'react-modal-dialog';
import Select from 'react-select';
import SkillDetail from '../components/SkillDetail';
import Moment from 'moment';
// Simple example of a React "smart" component
export default class SkillToProfile extends React.Component {
 static propTypes = {
    currentUser: PropTypes.object,
     profile : PropTypes.object,
     skill :PropTypes.object,
     proficency : PropTypes.object,
     onNewSkillToProfile: PropTypes.function,
     onSelectSkill: PropTypes.function
 };
  

  constructor(props, context) {
    super(props, context);
      this.state={
          profile:this.props.profile,
          skill:this.props.skill,
          currentUser:this.props.currentUser,
          proficency:this.props.proficency,
          onNewSkillToProfile:this.props.onNewSkillToProfile,
          is_loading:false
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

  submitReport(){
      this.setState({
          input_visible:false,
          is_loading:true
      });
      const newreport= {user_profile_id:this.state.profile.id ,
                        skill_id:this.state.skill.id,
                        proficency:this.proficency_val.value
                        };

      axios.post('/skills_to_profiles.json',newreport)
          .then((resp)=>{
             console.log(resp);
             this.setState({
                proficency:resp.data
             });
              this.props.onNewSkillToProfile(resp.data);
          })
          .catch((e)=>{
              console.log(e);
          });


  }


    showDetail(){
        console.log("SkillToProfile -> showDetail");
        this.setState({
            visible_detail:true
        });
        this.props.onSelectSkill(this.state.skill);
    }

    proficencyChange(e){
        if(isNaN(e.target.value)){
            this.setState({
                val_message:"Proficency must be a number!",
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
      let button = <button className="btn btn-xs btn-success" onClick={()=>this.handleReport()}> <strong>NA</strong> </button>
      let graph_btn = '';
      let p_value ="NA";

      if(this.state.proficency != null ) {
          button = <button className="btn btn-xs btn-danger" onClick={()=>this.handleReport()}><strong>{ this.state.proficency.proficency}</strong></button>
          graph_btn=  <button className="btn btn-xs btn-primary" onClick={()=>this.showDetail()} ><i className="fa fa-line-chart" aria-hidden="true"></i></button>

      }

      if(this.state.proficency){
          p_value = this.state.proficency.proficency
      }

    return (
        <td >
              {button} {graph_btn}
                {
                this.state.input_visible &&
                <ModalContainer onClose={()=>this.handleClose()}>
                    <ModalDialog onClose={()=>this.handleClose()}>
                        <h1>Report Proficency for {this.state.skill.name} </h1>

                        <div className="row">
                            <div className="col-md-12">
                                <label>Proficency</label>
                                <input type="text" onChange={(e)=>this.proficencyChange(e)} className="form-control" ref={(ref)=>this.proficency_val = ref}/>
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
        </td>
         
    );
  }
}
