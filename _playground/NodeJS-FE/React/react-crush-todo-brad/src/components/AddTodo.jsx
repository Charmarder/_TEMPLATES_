import React, { Component } from 'react';
import PropTypes from 'prop-types';

export class AddTodo extends Component {
  state = {
    title: ''
  };

  // this event handler can be used for many inputs
  handleChange = e =>
    this.setState({
      [e.target.name]: e.target.value
    });

  handleSubmit = e => {
    e.preventDefault();
    this.props.onAdd(this.state.title);
    this.setState({ title: '' });
  };

  render() {
    return (
      <form onSubmit={this.handleSubmit} action='' style={{ display: 'flex' }}>
        <input
          type='text'
          name='title'
          placeholder='Add Todo ...'
          style={{ flex: '10', padding: '5px' }}
          value={this.state.title}
          onChange={this.handleChange}
        />
        <button
          type='submit'
          value='submit'
          className='btn'
          style={{ flex: '1' }}
        >
          Submit
        </button>
      </form>
    );
  }
}

AddTodo.propTypes = {
  onAdd: PropTypes.func.isRequired
};

export default AddTodo;
