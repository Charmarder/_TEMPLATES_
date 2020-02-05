import React from 'react';
import { Link } from 'react-router-dom';

export default function Header() {
  return (
    <div style={headerStyle}>
      <h1>TodoList</h1>
      <Link style={linkStyle} to='/'>
        Home
      </Link>{' '}
      |{' '}
      <Link style={linkStyle} to='/about'>
        About
      </Link>
    </div>
  );
}

const headerStyle = {
  color: '#fff',
  backgroundColor: '#333',
  padding: '10px',
  textAlign: 'center'
};

const linkStyle = {
  color: '#fff',
  textDecoration: 'none'
};
