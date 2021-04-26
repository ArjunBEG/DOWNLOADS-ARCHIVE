// Import necessary packages...
class App extends Component {
  // Constructor and methods...
  
  // Mounting the component causes an action
  componentDidMount(){
    fetch("https://jsonbin.io/b/59f721644ef213575c9f6531")
    .then( response => response.json())
    .then( data => {
      let posts = {
        data: data
      };
      this.updatePosts(posts);
    });
  }
  
  // render() -> Remember to change this.state to this.props
}

// mapStateToProps and connect as before