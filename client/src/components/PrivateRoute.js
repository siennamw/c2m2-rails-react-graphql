import React, { useContext } from 'react';
import { Route, Redirect } from 'react-router-dom';

import { AuthContext } from './App';

const PrivateRoute = ({ component: Component, ...rest }) => {
  const { authState } = useContext(AuthContext);

  return (
    <Route
      {...rest}
      render={props => (
        authState
          ? <Component {...props} />
          : (
            <Redirect to={{
              pathname: '/sign-in',
              state: { from: props.location },
            }}
            />
          )
      )}
    />
  );
};

export default PrivateRoute;
