import React, { PropTypes } from 'react';
import _ from 'lodash';

// Simple example of a React "dumb" component
export default class CheckResultRow extends React.Component {
    static propTypes = {
        item: PropTypes.object.isRequired,
        coloredIdx:PropTypes.array.isRequired
    };

    constructor(props, context) {
        super(props, context);
    }



    render(){

        const item = this.props.item;
        const coloredIDX = this.props.coloredIdx;

        let cells ="";
        let values = [];
        for (var i in item) {
            values.push(item[i])
        }

        cells = values.map((val,i)=>{
            if ( coloredIDX.indexOf(i) > -1){
                if ( val > 0 ){
                    return <td className="cell-red">{val}</td>
                }else{
                    return <td className="cell-green">{val}</td>

                }

            }else{
                return <td >{val}</td>

            }
        });

        return (
            <tr>
               {cells}
            </tr>
        );
    }
}
