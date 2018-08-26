import React from 'react';
import { Route, Switch } from 'react-router-dom'

import Header from './Header';
import Footer from './Footer';

import Home from './Home';
import About from './About';
import Vision from './Vision';
import ResourceSuggestion from './ResourceSuggestion';
import Contact from './Contact';
import UnknownRoute from './UnknownRoute';

class App extends React.Component {
  render() {
    return (
      <div className="app container">
        <Header/>
        <main>
          <Switch>
            <Route exact path="/" component={Home}/>
            <Route exact path="/about" component={About}/>
            <Route exact path="/vision" component={Vision}/>
            <Route exact path="/suggest" component={ResourceSuggestion}/>
            <Route exact path="/contact" component={Contact}/>
            <Route component={UnknownRoute}/>
          </Switch>
        </main>
        <Footer/>
      </div>
    );
  }
}

export default App;
