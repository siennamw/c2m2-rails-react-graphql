import React, { Fragment } from 'react';
import InputField from '../InputField';

import { LIST_ALL_REPOSITORIES } from '../../../queries';

import SelectFieldWithQuery from '../SelectFieldWithQuery';
import NewRepository from '../repository/NewRepository';
import { reactSelectOnChange } from '../../../utils';

const CollectionForm = ({ setFieldValue, values }) => {
  const model = 'collection';

  const selectOnChange = (evt, name) => {
    reactSelectOnChange(evt, name, setFieldValue);
  };

  return (
    <Fragment>
      <InputField
        displayName="Name"
        fieldName="name"
        modelName={model}
      />
      <SelectFieldWithQuery
        componentForModal={<NewRepository />}
        displayName="Repository"
        fieldName="repository_id"
        modelName={model}
        onChangeCallback={selectOnChange}
        query={LIST_ALL_REPOSITORIES}
        queryName="allRepositories"
        selected={values.repository_id}
      />
      <InputField
        displayName="Description"
        fieldName="description"
        modelName={model}
      />
    </Fragment>
  );
};

export default CollectionForm;
