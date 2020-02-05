import React, { Component } from 'react';
import TodoItem from './TodoItem';
import PropTypes from 'prop-types';

export class Todos extends Component {
  render() {
    // console.log(this.props.todos);

    return (
      <div>
        {this.props.todos.map(todo => (
          <TodoItem
            key={todo.id}
            todo={todo}
            onComplete={this.props.onComplete}
            onDelete={this.props.onDelete}
          />
        ))}
      </div>
    );
  }
}

Todos.propTypes = {
  todos: PropTypes.array.isRequired,
  onComplete: PropTypes.func.isRequired,
  onDelete: PropTypes.func.isRequired
};

export default Todos;
