import React from "react";

import NewEntry from '../../NewEntry';

import PublisherForm from './PublisherForm';
import { CREATE_PUBLISHER } from '../../../mutations';
import { publisherValidationSchema } from '../../../validationSchemas';

const NewPublisher = () => {
  return (
    <NewEntry
      title='New Publisher'
      variablesList={Object.keys(publisherValidationSchema.fields)}
      gqlMutation={CREATE_PUBLISHER}
      yupSchema={publisherValidationSchema}
      FormComponent={PublisherForm}
    />
  );
};

export default NewPublisher;
