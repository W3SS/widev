// HelloWorldWidget is an arbitrary name for any "dumb" component. We do not recommend suffixing
// all your dump component names with Widget.

import React, { PropTypes } from 'react';
import _ from 'lodash';
import Axios from 'axios';
import moment from 'moment';
import {ModalContainer, ModalDialog} from 'react-modal-dialog';
import {ComposedChart, Line, Area, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend} from 'recharts';

// Simple example of a React "dumb" component
export default class ReportDetail extends React.Component {
  static propTypes = {
    row: PropTypes.object.isRequired
   };

  constructor(props, context) {
    super(props, context);
    this.state={
        row:this.props.row
    }
  }


    render() {

        let data = [];
        let i =0;
        let missing = 0
        while ( this.props.row.hasOwnProperty(i)){
            let val=this.props.row[i];
            if(val=='-') {
                val = 0;
                missing++;
            }
            data.push({name: i,hr: val, avg:this.props.row['avg'], avg15:this.props.row['avg15']})
            i++;
        }

        let {entid} = this.props.row;

        return (
            <div className="row panel">
                <div className="col-md-4">
                    <h4><small>Info for</small> {entid}</h4>

                    <p><strong>Total: </strong>{this.props.row['tot']}</p>
                    <p><strong>Forecast: </strong>{this.props.row['totfcast']}</p>
                    <p><strong>Avg: </strong>{this.props.row['avg']}</p>
                    <p><strong>Missing: </strong> {missing}</p>
                </div>
                <div className="col-md-8">
                    <ComposedChart width={600} height={250} data={data}
                                   margin={{top: 20, right: 20, bottom: 20, left: 20}}>
                        <XAxis dataKey="name"/>
                        <YAxis />
                        <Tooltip/>
                        <Legend/>
                        <CartesianGrid stroke='#f5f5f5'/>
                        <Bar dataKey='hr' barSize={20} fill='#413ea0'/>
                        <Line type='monotone' dataKey='avg15' stroke='#ff7300'/>
                        <Line type='monotone' dataKey='avg' stroke='#8884d8'/>
                    </ComposedChart>
                </div>

            </div>
        );
      }
}
