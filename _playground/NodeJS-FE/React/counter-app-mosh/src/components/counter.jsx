import React, { Component } from 'react';

export class Counter extends Component {
  render() {
    const { counter, onDelete, onIncrement } = this.props;

    return (
      <div>
        <span className={this.getBadgeClasses()}>{this.formatCount()}</span>
        <button
          onClick={() => onIncrement(counter)}
          className='btn btn-secondary btn-sm'
        >
          Increment
        </button>
        <button
          onClick={() => onDelete(counter.id)}
          className='btn btn-danger btn-sm m-2'
        >
          Delete
        </button>
      </div>
    );
  }

  getBadgeClasses() {
    return (
      'badge m-2 badge-' +
      (this.props.counter.value === 0 ? 'warning' : 'primary')
    );
  }

  formatCount() {
    const { value } = this.props.counter;
    return value === 0 ? 'zero' : value;
  }
}

export default Counter;
