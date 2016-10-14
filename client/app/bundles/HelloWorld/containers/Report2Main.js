import React, { PropTypes } from 'react';
import {AgGridReact} from 'ag-grid-react';


// Simple example of a React "smart" component
export default class Report2Main extends React.Component {
 static propTypes = {
    currentUser: PropTypes.object.isRequire,
     rows:PropTypes.array,
     columns:PropTypes.array
  };
  

  constructor(props, context) {
    super(props, context);
      this.state={
          currentUser:this.props.currentUser,
          columnsDef:this.props.columns,
          rowData:this.props.rows
      }
   }

    render(){
        return (
            <div className="ag-fresh" style={{ height: 475}}>
                <AgGridReact
                    columnDefs={this.state.columnDefs}
                    rowData={this.state.rowData}
                    rowSelection="single"
                    enableSorting="true"
                    enableFilter="true"
                    rowHeight="22"
                />
            </div>
        );
}
}
