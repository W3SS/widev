import React, { PropTypes } from 'react';
import {ModalContainer, ModalDialog} from 'react-modal-dialog';
import SkillToProfile from './SkillToProfile';
import SkillRow from './SkillRow';
import SkillDeatail from '../components/SkillDetail';


export default class SkillTable extends React.Component {
 static propTypes = {
     currentUser: PropTypes.object,
     profiles : PropTypes.array,
     skills :PropTypes.array,
 };
  

  constructor(props, context) {
    super(props, context);
      this.state={
          profiles:this.props.profile,
          skills:this.props.skills,
          currentUser:this.props.currentUser,
          detail_visible:false
      }
   }

  componentDidMount(){
  }

  handleShowDetail(){
      this.setState({
          details_visible:true
      })
  }
  handleSelectSkill(profile,skill){
      console.log("SkillTable -> handleSelectSkill");
      this.setState({
          selectedSkill:skill,
          selectedProfile:profile,
          detail_visible:true
      })
  }
  handleDetailClose(){
      this.setState({
         detail_visible:false
      })
  }

  render() {

      let headcells = this.state.skills.map((s)=>{
          return <th className="skillcell" key={s.id} >{s.name}</th>
      });

      let profileRow = this.props.profiles.map((p)=>{
          return <SkillRow key={p.id} profile={p} onSelectSkill={(profile,skill)=>this.handleSelectSkill(profile,skill)} currentUser={this.state.currentUser} skills={this.state.skills} />
      });
      return (
            <div>
                {this.state.detail_visible &&
                <SkillDeatail onClose={()=>this.handleDetailClose()} profile={this.state.selectedProfile} skill={this.state.selectedSkill} />}
                <table className="table table-bordered skilltable">
                    <thead>
                        <tr>
                            <th>Email </th>
                            <th className="skillcell" >Avg </th>
                            {headcells}
                            <th className="rampcell" >Ramp</th>
                        </tr>
                    </thead>
                    <tbody>
                        {profileRow}
                    </tbody>
                </table>
            </div>
    );
  }
}
