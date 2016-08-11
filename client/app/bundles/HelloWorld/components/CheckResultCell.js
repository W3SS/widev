import React, { PropTypes } from 'react';
import _ from 'lodash';

// Simple example of a React "dumb" component
export default class CheckResultRow extends React.Component {
    static propTypes = {
        value: PropTypes.string.isRequired,
    };

    constructor(props, context) {
        super(props, context);
    }



    render(){

        const {value} = this.props;

        let cells ="";



        return (
            <td>
                {value}
            </td>
        );
    }
}
