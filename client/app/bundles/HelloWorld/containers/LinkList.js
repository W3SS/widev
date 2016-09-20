import React, { PropTypes } from 'react';
import Axios from 'axios';

export default class LinkList extends React.Component {
 static propTypes = {
    currentUser: PropTypes.object.isRequired, // this is passed from the Rails view
     environment: PropTypes.object.isRequired,
  };
  

  constructor(props, context) {
    super(props, context);
    this.state={
        environment:this.props.installation,
        links:[]
    }
  }

  componentDidMount(){
      Axios.get('/api/link/get_by_environment/'+this.props.environment.id ).then( (response) =>{
       this.setState({
         links:response.data
       });
    })
    .catch(function (error) {
      alert(error);
   });
}



    handleAddUrl(e){
        e.preventDefault();
        console.log(this.refs.desc);

        let newurl = {
            url:this.refs.url.value,
            description:this.refs.desc.value,
            environment_id:this.props.environment.id
        };
        Axios.post('/links.json',newurl ).then( (response) =>{
            let act = this.state.links;
            act.push(response.data);
            this.setState({
                links:act
            });

            this.refs.desc.value="";
            this.refs.url.value="";
        })
        .catch(function (error) {
            alert(error);
        });

  }
  
  handleDelete(m){
      console.log("Delete");
      console.log(m);
      Axios.delete('/links/' + m.id + '.json' ).then( (response) =>{
          let act = this.state.links;
          console.log(response);
          act.splice(act.indexOf(response),1);
          this.setState({
              links:act
          });

      })
          .catch(function (error) {
              alert(error);
          });

  }



  render() {
      let link_rows = this.state.links.map((m)=>
      {
          return(
              <tr>
                  <td>{m.description}</td>
                  <td>{m.url}</td>
                  <td><button onClick={()=>this.handleDelete(m)} className="btn btn-xs btn-danger"><i className="fa fa-trash" aria-hidden="true"></i> Remove</button> </td>
                  <td><a href={m.url} target="_blank" className="btn btn-xs btn-success"><i className="fa fa-link" aria-hidden="true"></i> Go</a></td>
              </tr>
          )
      });

    return (
        <div className="well">
            <div className="row">
                <div className="col-md-12">
                    <table  className="table table-bordered">
                        <thead>
                        <tr>
                            <th>Description</th>
                            <th>Url</th>
                            <th colSpan="2">Action</th>
                        </tr>
                        </thead>
                        <tbody>
                        {link_rows}
                        <tr>
                            <td><input type="text" className="form-control input-sm col-md-12"  ref="desc" /></td>
                            <td> <input type="text" className="form-control input-sm col-md-12" ref="url"  /></td>
                            <td colSpan="2"><button type="submit" onClick={(e)=>this.handleAddUrl(e)} className="btn btn-sm btn-success"><i className="fa fa-plus" aria-hidden="true"></i> Add URL</button></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    );
  }
}
