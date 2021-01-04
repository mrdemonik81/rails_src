import React from 'react'
import ReactDOM from 'react-dom'
import App from 'candidates/components/App';

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    React.createElement(App),
    document.body.appendChild(document.createElement('div')),
  )
});
