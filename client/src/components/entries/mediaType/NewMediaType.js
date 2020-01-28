import React from 'react';
import PropTypes from 'prop-types';

import NewEntry from '../NewEntry';

import MediaTypeForm from './MediaTypeForm';
import { CREATE_MEDIA_TYPE } from '../../../mutations';
import { mediaTypeValidationSchema } from '../../../validationSchemas';

const NewMediaType = ({ successCallback }) => (
  <NewEntry
    successCallback={successCallback}
    clearAfterSubmit
    FormComponent={MediaTypeForm}
    gqlMutation={CREATE_MEDIA_TYPE}
    mutationName="createMediaType"
    title="New Media Type"
    yupSchema={mediaTypeValidationSchema}
  />
);

NewMediaType.defaultProps = {
  successCallback: null,
};

NewMediaType.propTypes = {
  successCallback: PropTypes.func,
};

export default NewMediaType;
