import React, { PropTypes } from 'react';
import _ from 'lodash';
import Axios from 'axios';
import CheckResultRow  from '../components/CheckResultRow'

// Simple example of a React "smart" component
export default class CheckResult extends React.Component {
 static propTypes = {
    currentUser: PropTypes.object.isRequired,
    result: PropTypes.array.isRequired,
     prev_result:PropTypes.array.isRequired,
     viewold:PropTypes.boolean
  };
  

  constructor(props, context) {
    super(props, context);
    this.state={
        result: this.props.result,
        prev_result : this.props.prev_result,
        curr_data:[],
        latest_data:[],
        viewold:this.props.viewold,
        viewdelta:true,
        colored:[]
    }
  }

  componentDidMount(){

      var curr = this.props.result;
      var latest = this.props.prev_result;

      var main_data =[]; //Array di Array
      var latest_data =[]; //Array di Array

      curr.forEach((item)=>{
          let row=[];
          for (let k in item) {
              row.push(item[k]);
          }
          main_data.push(row);
      });

      latest.forEach((item)=>{
          let row=[];
          for (let k in item) {
              row.push(item[k]);
          }
          latest_data.push(row);
      });


      this.setState({
          curr_data:main_data,
          latest_data:latest_data
      })

  }

  toggleOld(){
      let vold= this.state.viewold;

      vold = vold?false:true;
      this.setState({
          viewold:vold
      })
  }

    toggleDelta(){
        let del= this.state.viewdelta;

        del = del?false:true;
        this.setState({
            viewdelta:del
        })
    }

    handleCheck(e){
        console.log(e.target.checked);
        console.log(e.target.value);
        let newcolored = this.state.colored;

        if (e.target.checked){
            newcolored.push(e.target.value);
        }else{
            newcolored.splice(newcolored.indexOf(e.target.value),1);
        }

        this.setState({
            colored:newcolored
        });
        console.log(newcolored);
    }


    render() {

      var curr_data = this.state.curr_data;
      var latest_data = this.state.latest_data;
      let curr = this.state.result;
        const colored= this.state.colored;

      let table_heading = [];
      let i=0;
      for (let k in curr[0]) {
          table_heading.push(k);
          if (this.state.viewold == true && i>0){
              table_heading.push('OLD '+ k);
          }
          if (this.state.viewdelta == true && i>0){
              table_heading.push('DELTA '+ k);
          }
          i++;
      }


      let coloredIDX =[]; //indici delle colonne colorate
        for(let i=0;i<table_heading.length;i++){
            if (colored.indexOf(table_heading[i])>= 0){
                coloredIDX.push(i);
            }
        }

      console.log(coloredIDX);


      let tabledata=[];
      curr_data.forEach((row)=>{
          let tbcells=[];
          let lat_row;
          let main = row[0];
          tbcells.push(main); //Metto il primo valore come chiave

          latest_data.forEach((lt_row)=>{
              if (lt_row[0] == main){
                  lat_row=lt_row; //Assegno la del vecchio risultato
              }
          });

          for( let i=1;i<row.length;i++){ //Per ogni elemento della mia riga
              tbcells.push(row[i]); //Aggiungo il valore attuale

              if (this.state.viewold == true ){
                  if (lat_row && lat_row.length>i){
                      tbcells.push(lat_row[i]);//Aggiungo il valore vecchio
                  }else {
                      tbcells.push('-');
                  }
              }

              if (this.state.viewdelta == true){
                  if (lat_row && lat_row.length > i) {
                      tbcells.push((row[i] - lat_row[i]));//Aggiungo il valore vecchio
                  }else {
                      tbcells.push('-');
                  }
              }
          };

          tabledata.push(tbcells);

      });

      let rows="";
      let head="";

       if(tabledata.length >0 ){
          rows = tabledata.map((row)=>{
              return <CheckResultRow coloredIdx={coloredIDX} item={row}></CheckResultRow>
          });
           head = table_heading.map((head)=>{

               return <th>{head} <input  type="checkbox" value={head} onChange={(e)=>this.handleCheck(e)}/> </th>
           })
       }


    return (
         <div className="row">
              <div className="col-md-12">

                  <button onClick={()=>this.toggleOld()} className="btn btn-xs btn-success">Prev ON/OFF</button>
                  <button onClick={()=>this.toggleDelta()} className="btn btn-xs btn-success">Delta ON/OFF  </button>
                  <div class="table-responsive ">

                <table className="table table-bordered table-hover">
                    <thead>
                        <tr>{head}</tr>
                    </thead>
                    <tbody>
                    {rows}

                    </tbody>
                </table>
                      </div>

              </div>
        </div>
    );
   }
}
