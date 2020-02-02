import React, { Component } from 'react';
// import logo from './logo.svg';
import './App.css';
import Counters from './components/counters';
import NavBar from './components/navBar';

export default class App extends Component {
  state = {
    counters: [
      { id: 1, value: 4 },
      { id: 2, value: 0 },
      { id: 3, value: 0 },
      { id: 4, value: 0 }
    ]
  };

  handleDelete = id => {
    console.log('Delete Handle Clicked', id);
    const counters = this.state.counters.filter(counter => counter.id !== id);
    this.setState({ counters });
  };

  handleIncrement = counter => {
    const counters = [...this.state.counters];
    const index = counters.indexOf(counter);
    counters[index] = { ...counter };
    this.setState({ counters });

    // this.state.counters.filter(c => c.id === counter.id)[0].value++;
    // this.setState({ counters: this.state.counters });
  };

  handleReset = () => {
    this.state.counters.map(c => {
      c.value = 0;
      return c;
    });
    this.setState({ counters: this.state.counters });
  };

  render() {
    return (
      <React.Fragment>
        <NavBar count={this.state.counters.filter(c => c.value > 0).length} />
        <div className='container'>
          <Counters
            counters={this.state.counters}
            onDelete={this.handleDelete}
            onIncrement={this.handleIncrement}
            onReset={this.handleReset}
          />
        </div>
        {/* <main role='main' class='container'>
          <Counters />
        </main> */}
      </React.Fragment>
    );
  }
}
