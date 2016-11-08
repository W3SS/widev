// HelloWorldWidget is an arbitrary name for any "dumb" component. We do not recommend suffixing
// all your dump component names with Widget.

import React, { PropTypes } from 'react';
import _ from 'lodash';
import Axios from 'axios';
import moment from 'moment';
import {ComposedChart, Line, Area, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend,BarChart} from 'recharts';

export default class SkillDetail extends React.Component {
  static propTypes = {
    profile: PropTypes.object.isRequired,
    skill: PropTypes.object.isRequired,
      onClose:PropTypes.function
   };

  constructor(props, context) {
    super(props, context);

  }


  handleClose(){
      this.props.onClose()
  }

    render() {

        let data = [];

       this.props.profile.skills_to_profiles.forEach((s)=>{
           if(s.skill_id == this.props.skill.id){

               let dt = moment(s.created_at).format('L');
               data.push({name: dt ,pr: s.proficency})

           }
       });


        let mail = this.props.profile.email;

        return (
            <div className="row panel well">
                <div className="col-md-4">
                   <h4><small>Info for</small> {mail}</h4>
                   <h4><small>Skill </small> {this.props.skill.name}</h4>
                    <p>{this.props.skill.description}</p>
                    <br/>
                    <br/>
                    <button className="btn btn-success" onClick={()=>this.handleClose()} >Close</button>
                </div>
                <div className="col-md-8">
                    <BarChart width={600} height={300} data={data}
                              margin={{top: 5, right: 30, left: 20, bottom: 5}}>
                        <XAxis dataKey="name"/>
                        <YAxis/>
                        <CartesianGrid strokeDasharray="3 3"/>
                        <Tooltip/>
                        <Legend />
                        <Bar dataKey="pr" fill="#8884d8" />
                    </BarChart>
                </div>
            </div>
        );
      }
}
