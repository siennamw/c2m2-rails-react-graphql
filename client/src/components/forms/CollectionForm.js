import React from 'react';
import { Formik, Form, Field, ErrorMessage } from 'formik';
import * as Yup from 'yup';

const validationSchema = Yup.object().shape({
  name: Yup.string()
    .required('Name is required'),
});

const InnerCollectionForm = ({ handleSubmit, isSubmitting }) => {
  return (
    <Form>
      <label htmlFor='name'>
        Name <ErrorMessage name='name' component='div' className='form-error' />
      </label>
      <Field type='text'
             name='name'
             className='u-full-width'/>
      <label htmlFor='name'>
        Description <ErrorMessage name='description' component='div' className='form-error' />
      </label>
      <Field type='text'
             name='description'
             className='u-full-width'/>
      <button type='submit'
              className='button-primary u-full-width'
              disabled={isSubmitting}
              onClick={handleSubmit}>
        Submit
      </button>
    </Form>
  )
};

const CollectionForm = () => {
  return (
    <div>
      <h3>New Collection</h3>
      <Formik
        initialValues={{
          name: '',
          description: '',
        }}
        validationSchema={validationSchema}
        onSubmit={(values, { setSubmitting }) => console.log(values)}
        render={InnerCollectionForm}
      />
    </div>
  )
};

export default CollectionForm;