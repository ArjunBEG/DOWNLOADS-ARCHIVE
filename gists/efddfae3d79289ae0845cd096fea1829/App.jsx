// React and other imports...
import { connect } from 'react-redux';
import { viewAll, searchPost } from './actions';

class App extends Component {
  // Code for our App component...
}

// Mapping state to props
function mapStateToProps(state){
  return {
    posts: state
  }
}

// Connecting the App component
export default connect(mapStateToProps, { viewAll, searchPost })(App);