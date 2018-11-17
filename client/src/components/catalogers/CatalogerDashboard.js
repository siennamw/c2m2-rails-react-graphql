import React from 'react';
import { NavLink, Route, Switch } from 'react-router-dom'

import Nav from '../nav/Nav';

import CatalogerHome from "./CatalogerHome";
import CatalogerForm from "../forms/CatalogerForm";
import CollectionForm from "../forms/CollectionForm";
import RepositoryForm from "../forms/RepositoryForm";

const CatalogerDashboard = ({ match }) => {
  return (
    <div>
      <h2>Cataloger Dashboard</h2>
      <Nav>
        <NavLink to={`${match.path}/home`}>Home</NavLink>
        <NavLink to={`${match.path}/cataloger`}>New Cataloger</NavLink>
        <NavLink to={`${match.path}/collection`}>New Collection</NavLink>
        <NavLink to={`${match.path}/repository`}>New Repository</NavLink>
        <NavLink to={'/sign-out'}>Sign Out</NavLink>
      </Nav>
      <div className="tabs">
        <Switch>
          <Route exact path={`${match.path}/home`} component={CatalogerHome} />
          <Route exact path={`${match.path}/cataloger`} component={CatalogerForm} />
          <Route exact path={`${match.path}/collection`} component={CollectionForm} />
          <Route exact path={`${match.path}/repository`} component={RepositoryForm} />
          <Route component={CatalogerHome}/>
        </Switch>
      </div>
    </div>
  )
};

export default CatalogerDashboard;