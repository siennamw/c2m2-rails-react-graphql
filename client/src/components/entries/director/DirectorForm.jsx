import React from 'react';
import PropTypes from 'prop-types';
import { useMutation } from '@apollo/client';

import {
  CREATE_DIRECTOR,
  DELETE_DIRECTOR,
  UPDATE_DIRECTOR
} from '../../../mutations';
import { DIRECTOR_BY_ID } from '../../../queries';
import {
  addIdToSchema,
  getInitialFormValuesForSchema,
  directorValidationSchema
} from '../../../validationSchemas';

import EntryFormButtons, { DeleteButton } from '../EntryFormButtons';
import EntryFormWrapper from '../EntryFormWrapper';
import QueryWrap from '../QueryWrap';
import DirectorFormFields from './DirectorFormFields';

const DirectorForm = ({ match, successCallback }) => {
  const id = match && match.params && match.params.id
    ? match.params.id
    : null;

  const [createMutation] = useMutation(CREATE_DIRECTOR);
  const [updateMutation] = useMutation(UPDATE_DIRECTOR);
  const [deleteMutation] = useMutation(DELETE_DIRECTOR, {
    update(cache) {
      const normalizedId = cache.identify({ id, __typename: 'Director' });
      cache.evict({ id: normalizedId });
      cache.gc();
    }
  });

  const schema = id
    ? addIdToSchema(directorValidationSchema)
    : directorValidationSchema;

  if (id) {
    // updating
    return (
      <QueryWrap
        id={id}
        query={DIRECTOR_BY_ID}
        queryName="director"
      >
        {
          (data) => {
            return (
              <EntryFormWrapper
                initialValues={getInitialFormValuesForSchema(schema, data)}
                mutation={updateMutation}
                mutationName="updateDirector"
                successCallback={successCallback}
                yupSchema={schema}
              >
                <h3>Edit Director</h3>
                <DirectorFormFields />
                <EntryFormButtons>
                  <DeleteButton
                    data={data}
                    deleteMutation={deleteMutation}
                    deleteMutationName="deleteDirector"
                  />
                </EntryFormButtons>
              </EntryFormWrapper>
            );
          }
        }
      </QueryWrap>
    );
  }

  // creating
  return (
    <EntryFormWrapper
      clearAfterSubmit
      initialValues={getInitialFormValuesForSchema(schema)}
      mutation={createMutation}
      mutationName="createDirector"
      successCallback={successCallback}
      yupSchema={schema}
    >
      <h3>New Director</h3>
      <DirectorFormFields />
      <EntryFormButtons />
    </EntryFormWrapper>
  );
};

DirectorForm.defaultProps = {
  successCallback: null,
};

DirectorForm.propTypes = {
  match: PropTypes.shape({
    params: PropTypes.shape({
      id: PropTypes.string,
    }),
  }),
  successCallback: PropTypes.func,
};

export default DirectorForm;
