import React, { Fragment } from 'react';
import PropTypes from 'prop-types';

import SelectFieldWithQuery from '../SelectFieldWithQuery';
import InputField from '../InputField';

import * as queries from '../../../queries';

import NewCollection from '../collection/NewCollection';
import NewFilm from '../film/NewFilm';
import NewMaterialFormat from '../materialFormat/NewMaterialFormat';
import NewPublisher from '../publisher/NewPublisher';
import SelectField from '../SelectField';

const WorkForm = ({ selfIsAdmin, setFieldValue }) => {
  const model = 'work';
  const selectOnChange = (evt, name) => {
    if (name.includes('_ids')) {
      // when selecting from a multiselect to set an array of IDs,
      // build array manually
      setFieldValue(
        name,
        // turn array-like object into a real array
        [].slice
          .call(evt.target.selectedOptions)
          .map(option => option.value),
      );
    } else {
      setFieldValue(
        name,
        evt.target.value,
      );
    }
  };

  const pubStatusOptions = [
    { id: 'draft', name: 'draft' },
    { id: 'provisional', name: 'provisional' },
  ];

  if (selfIsAdmin) pubStatusOptions.push({ id: 'approved', name: 'approved' });

  return (
    <Fragment>
      <SelectFieldWithQuery
        componentForModal={<NewFilm />}
        displayName="Film"
        fieldName="film_id"
        modelName={model}
        onChangeCallback={selectOnChange}
        query={queries.LIST_ALL_FILMS}
        queryName="allFilms"
      />
      <InputField
        displayName="Finding Aid Link"
        fieldName="finding_aid_link"
        fieldType="url"
        modelName={model}
      />
      <InputField
        displayName="Digital Copy Link"
        fieldName="digital_copy_link"
        fieldType="url"
        modelName={model}
      />
      <InputField
        displayName="Citation Source"
        fieldName="citation_source"
        modelName={model}
      />
      <SelectFieldWithQuery
        disableAddButton
        displayName="Material Format"
        fieldName="material_format_id"
        modelName={model}
        onChangeCallback={selectOnChange}
        query={queries.LIST_ALL_MATERIAL_FORMATS}
        queryName="allMaterialFormats"
      />
      <SelectFieldWithQuery
        componentForModal={<NewCollection />}
        displayName="Collection(s)"
        fieldName="collection_ids"
        isMulti
        modelName={model}
        onChangeCallback={selectOnChange}
        query={queries.LIST_ALL_COLLECTIONS}
        queryName="allCollections"
      />
      <SelectFieldWithQuery
        componentForModal={<NewPublisher />}
        displayName="Publisher(s)"
        fieldName="publisher_ids"
        isMulti
        modelName={model}
        onChangeCallback={selectOnChange}
        query={queries.LIST_ALL_PUBLISHERS}
        queryName="allPublishers"
      />
      <InputField
        displayName="Cataloging Notes"
        fieldName="cataloging_notes"
        modelName={model}
      />
      <SelectField
        disablePlaceholder
        displayName="Publication Status"
        fieldName="publication_status"
        modelName={model}
        onChangeCallback={selectOnChange}
        options={pubStatusOptions}
      />
    </Fragment>
  );
};

WorkForm.defaultProps = {
  selfIsAdmin: false,
};

WorkForm.propTypes = {
  selfIsAdmin: PropTypes.bool,
};

export default WorkForm;
