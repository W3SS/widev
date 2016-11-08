import React, { PropTypes } from 'react';
import {ModalContainer, ModalDialog} from 'react-modal-dialog';
import SkillToProfile from './SkillToProfile';


export default class SkillRow extends React.Component {
 static propTypes = {
     currentUser: PropTypes.object,
     profile : PropTypes.object,
     skills :PropTypes.array,
     onSelectSkill:PropTypes.function
 };
  

  constructor(props, context) {
    super(props, context);
      this.state={
          profile:this.props.profile,
          skills:this.props.skills,
          currentUser:this.props.currentUser,
          skills_profile:this.props.profile.skills_to_profiles,
          is_loading:false,
          average:0,
          selectedSkill:null
      }
   }

  componentDidMount(){
  }

  handleNewSkill(new_skill_to_profile){
      console.log("HandleNewSkill");
      console.log(new_skill_to_profile);
      let pr  = this.state.profile;
      pr.skills_to_profiles =  [new_skill_to_profile,...this.state.skills_profile];

      this.setState({
          skills_profile:[ new_skill_to_profile,...this.state.skills_profile],
          profile:pr
      });

      console.log(this);
  }

  handleSelectSkill(skill){
      console.log("SkillRow -> handleSelectSkill");
      this.setState({
          selectedSkill:skill
      });
      this.props.onSelectSkill(this.state.profile,skill);
  }


  render() {
     console.log("render skillRow")
      let tot_skill=0;
      let n_skill=0;

      let skillcell = this.state.skills.map((s)=>{
          let proficency = null;
          this.state.skills_profile.forEach((sp)=>{
              if(sp.skill_id == s.id && proficency == null){
                  proficency = sp;
                  tot_skill += sp.proficency;
                  n_skill ++;
              }
          });
          return <SkillToProfile key={s.id} skill={s} onSelectSkill={(e)=>{this.handleSelectSkill(e)}} onNewSkillToProfile={(e)=>{this.handleNewSkill(e)}} proficency={proficency} currentUser={this.props.currentUser} profile={this.props.profile}/>
      });

      let average = Math.round(tot_skill/n_skill,2);

    return (
        <tr>
            <td>{this.props.profile.email}</td>
            <td>{average}</td>
            {skillcell}
        </tr>

    );
  }
}
