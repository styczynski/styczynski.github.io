import * as React from 'react';

import { Route } from 'react-router-dom';

import HomePage from 'pages/Home';

const ROUTES = {
    '/': HomePage,
    '/home': HomePage
};

function mapper(key, index, options) {
    return (
        <Route
          exact
          key={`route-${index}-${key}`}
          path={key}
          component={options}
        />
    );
};

export default function() {
    let baseRoutes = Object.keys(ROUTES)
      .map((key, index) => mapper(key, index, ROUTES[key]))
      .filter(e => !!e);
        
    return baseRoutes;
};