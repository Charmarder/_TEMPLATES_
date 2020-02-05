import React, { Component } from 'react';
import PropTypes from 'prop-types';

export class TodoItem extends Component {
  getStyle = () => {
    return {
      backgroundColor: '#f4f4f4',
      padding: '10px',
      textDecoration: this.props.todo.completed ? 'line-through' : 'none',
      border: 'dotted #ccc 1px'
    };
  };

  render() {
    const { todo, onComplete, onDelete } = this.props;
    return (
      <div style={this.getStyle()}>
        <input
          type='checkbox'
          onChange={() => onComplete(todo.id)}
          checked={todo.completed ? true : false}
        />{' '}
        {}
        <span>{todo.title}</span>
        <button style={btnStyle} onClick={() => onDelete(todo.id)}>
          x
        </button>
      </div>
    );
  }
}

const btnStyle = {
  backgroundColor: 'red',
  color: 'white',
  float: 'right',
  borderRadius: '30%',
  padding: '5px 10px',
  cursor: 'pointer',
  border: 'none'
};

TodoItem.propTypes = {
  todo: PropTypes.object.isRequired,
  onComplete: PropTypes.func.isRequired,
  onDelete: PropTypes.func.isRequired
};

export default TodoItem;
