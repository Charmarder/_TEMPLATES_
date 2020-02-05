import React, { Component } from 'react';
import { BrowserRouter as Router, Route } from 'react-router-dom';
// import uuid from 'uuid';
import axios from 'axios';
// import logo from './logo.svg';
import './App.css';
import Todos from './components/Todos';
import Header from './components/layout/Header';
import AddTodo from './components/AddTodo';
import About from './components/pages/About';

class App extends Component {
  state = {
    todos: [
      // {
      //   id: uuid.v4(),
      //   title: 'todo 1',
      //   completed: false
      // },
      // {
      //   id: uuid.v4(),
      //   title: 'todo 2',
      //   completed: true
      // },
      // {
      //   id: uuid.v4(),
      //   title: 'todo 3',
      //   completed: false
      // }
    ]
  };

  // apiUrl = 'http://jsonplaceholder.typicode.com/todos';
  apiUrl = 'http://localhost:8080/todos';

  componentDidMount() {
    axios
      .get(this.apiUrl)
      // .then(res => console.log(res.data))
      .then(res => {
        this.setState({ todos: res.data });
        console.log(res.data);
      })
      .catch(err => console.log('err:', new Error(err)));
  }

  handleComplete = id => {
    console.log('id', id);
    this.setState({
      todos: this.state.todos.map(todo => {
        if (todo.id === id) todo.completed = !todo.completed;
        return todo;
      })
    });
  };

  handleDelete = id => {
    console.log('id', id);
    axios.delete(`${this.apiUrl}/${id}`).then(res =>
      this.setState({
        todos: this.state.todos.filter(todo => todo.id !== id)
      })
    );
  };

  handleAdd = title => {
    console.log('title', title);
    // const newId = Math.max(...this.state.todos.map(todo => todo.id)) + 1;
    // const newId = uuid.v4();
    // const newTodo = {
    //   id: newId,
    //   title: title,
    //   completed: false
    // };
    axios
      .post(this.apiUrl, {
        title,
        completed: false
      })
      .then(res => this.setState({ todos: [...this.state.todos, res.data] }));
  };

  render() {
    return (
      <Router>
        <div className='container'>
          <Header />
          <Route
            exact
            path='/'
            render={props => (
              <React.Fragment>
                <AddTodo onAdd={this.handleAdd} />
                <Todos
                  todos={this.state.todos}
                  onComplete={this.handleComplete}
                  onDelete={this.handleDelete}
                />
              </React.Fragment>
            )}
          ></Route>
          <Route path='/about' component={About}></Route>
        </div>
      </Router>
    );
  }
}

export default App;
