import React, { Component } from 'react';
import './App.css';

class App extends Component {
  render() {
    return (
      <div className="App">
        <header className="sticky">
          <label htmlFor="drawer-checkbox" className="button drawer-toggle hidden-desktop"></label>
          <span href="#" className="logo">Autumn Blog</span>
          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="feather feather-search"><circle cx="10.5" cy="10.5" r="7.5"></circle><line x1="21" y1="21" x2="15.8" y2="15.8"></line></svg>
          <input type="search" className="searchBox"/>
        </header>
        <div className="row">
          <input type="checkbox" id="drawer-checkbox" />
          <div className="drawer">
            <label htmlFor="drawer-checkbox" className="button drawer-toggle hide"></label>
            <div className="post-link-container">
              <!-- Add links for posts here -->
            </div>
          </div>
          <div className="col-sm-12 col-md content">
            <!-- Add actual posts here -->
          </div>
        </div>
      </div>
    );
  }
}