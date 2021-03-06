import React from 'react';
import { useMutation } from '@apollo/client';
import {
  ErrorMessage,
  Field,
  Form,
  Formik,
  useFormikContext,
} from 'formik';
import * as Yup from 'yup';

import FormStatus from '../FormStatus';

import { GET_RESET_PASSWORD_TOKEN } from '../../mutations';

const validationSchema = Yup.object().shape({
  email: Yup.string()
    .email('E-mail is not valid')
    .required('E-mail is required'),
});

const RequestResetPasswordForm = () => {
  const { handleSubmit, isSubmitting } = useFormikContext();

  return (
    <Form>
      <label htmlFor="email">
        Email
        <ErrorMessage
          className="status-message form-message error"
          component="div"
          name="email"
        />
        <Field
          autoComplete="email"
          className="u-full-width"
          id="email"
          name="email"
          type="email"
        />
      </label>
      <button
        className="button-primary u-full-width"
        disabled={isSubmitting}
        onClick={handleSubmit}
        type="submit"
      >
        Request Password Reset
      </button>
      <FormStatus />
    </Form>
  );
};

const RequestResetPassword = () => {
  const [resetPasswordMutation] = useMutation(GET_RESET_PASSWORD_TOKEN);

  const handleSubmit = async ({ email }, setSubmitting, setStatus) => {
    setStatus(null);

    try {
      const variables = {
        email,
      };
      const {
        data: { getResetPasswordToken },
      } = await resetPasswordMutation({ variables });

      setSubmitting(false);

      if (getResetPasswordToken) {
        setStatus({
          type: 'success',
          message: 'Request was successful. Check your email for instructions.',
        });
      }
    } catch (err) {
      console.log('Error requesting password change', err);
      setStatus({
        type: 'error',
        message: 'Unknown error requesting password change. Please try again later.',
      });
    }
  };


  return (
    <div>
      <h2>Request Cataloger Password Reset</h2>
      <Formik
        initialValues={{
          email: '',
        }}
        validationSchema={validationSchema}
        onSubmit={(values, { setSubmitting, setStatus }) => (
          handleSubmit(values, setSubmitting, setStatus)
        )}
      >
        <RequestResetPasswordForm />
      </Formik>
    </div>
  );
};

export default RequestResetPassword;
