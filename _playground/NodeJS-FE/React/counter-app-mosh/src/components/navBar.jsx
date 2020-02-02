import React from 'react';

function NavBar({ count }) {
  return (
    <nav className='navbar navbar-expand-lg navbar-light bg-light'>
      <a className='navbar-brand' href='##'>
        Navbar <span className='badge badge-pill badge-secondary'>{count}</span>
      </a>
    </nav>
  );
}

export default NavBar;
