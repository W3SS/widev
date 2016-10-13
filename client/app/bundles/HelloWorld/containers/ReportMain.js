import React, { PropTypes } from 'react';
import _ from 'lodash';
import axios from 'axios';
import {ModalContainer, ModalDialog} from 'react-modal-dialog';
import Select from 'react-select';
import Spinner from 'react-spinkit';
import Moment from 'moment';
import ReactDataGrid from 'react-data-grid'
import {ReactDataGridPlugins,Toolbar, Data} from 'react-data-grid/addons';
import ReportDetail from '../components/ReportDetail';

const Selectors = Data.Selectors;

// Simple example of a React "smart" component
export default class ReportMain extends React.Component {
 static propTypes = {
    currentUser: PropTypes.object.isRequire,
     users:PropTypes.array,
     reports:PropTypes.array
  };
  

  constructor(props, context) {
    super(props, context);
      this.state={
          currentUser:this.props.currentUser,
          users:this.props.users,
          reports:this.props.reports,
          rows:this.props.rows,
          filters : {},
          selectedIndexes:[]
      }
   }

  componentDidMount(){
  }

    getRows() {
        return Selectors.getRows(this.state);
    }

    getSize() {
        return this.getRows().length;
    }

    rowGetter(rowIdx){
        var rows = this.getRows();
        return rows[rowIdx];
    }

    handleFilterChange(filter){
        var newFilters = Object.assign({}, this.state.filters);
        if (filter.filterTerm) {
            newFilters[filter.column.key] = filter;
        } else {
            delete newFilters[filter.column.key];
        }
        this.setState({filters: newFilters});
    }

    onClearFilters(){
        //all filters removed
        this.setState({filters: {} });
    }

    onRowsSelected(rows) {
       // this.setState({selectedIndexes: this.state.selectedIndexes.concat(rows.map(r => r.rowIdx))});
        this.setState({selectedIndexes: rows.map(r => r.rowIdx)});
    }

    onRowsDeselected(rows) {
        var rowIndexes = rows.map(r => r.rowIdx);
        this.setState({selectedIndexes: this.state.selectedIndexes.filter(i => rowIndexes.indexOf(i) === -1 )});
    }

  render() {
      var columns = this.props.columns;
        let infos ="";

      if (this.state.selectedIndexes.length){
          infos = <ReportDetail row={this.state.rows[this.state.selectedIndexes[0]]} />
      }


   return (
        <div>
            <div className="row">
                <div className="col-md-12">
                    {infos}
                </div>
            </div>
            <ReactDataGrid
                columns={columns}
                rowGetter={(i)=>this.rowGetter(i)}
                enableCellSelect={true}
                rowsCount={this.getSize()}
                toolbar={<Toolbar enableFilter={true}/>}
                onAddFilter={(filter)=>this.handleFilterChange(filter)}
                onClearFilters={()=>this.onClearFilters}
                minHeight={500}
                rowSelection={{
                    showCheckbox: true,
                    enableShiftSelect: false,
                    onRowsSelected: (rows)=>this.onRowsSelected(rows),
                    onRowsDeselected:(rows)=>this.onRowsDeselected(rows),
                    selectBy: {
                        indexes: this.state.selectedIndexes
                    }
                }}
                    />
        </div>
         
    );
  }
}
