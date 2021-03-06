import React, { Fragment, useState } from 'react';
import ReactDOM from 'react-dom';
import Modal from 'react-modal';
import PropTypes from 'prop-types';

// for accessibility,
// https://github.com/reactjs/react-modal/tree/master/docs/accessibility
Modal.setAppElement('#root');

const ModalForComponentWithButton = ({
  component,
  displayName,
  onClose,
}) => {
  const [modalVisible, setModalVisible] = useState(false);

  // eslint-disable-next-line no-undef
  const modalRoot = document.getElementById('root');

  const Component = component;

  const hideModal = () => {
    setModalVisible(false);
  };

  const showModal = () => {
    setModalVisible(true);
  };

  const successCallback = (data) => {
    hideModal();
    if (data) {
      onClose(data);
    }
  };

  // modal for creating a new entry in this category
  const modal = (
    <Modal
      className="custom-modal"
      isOpen
      onRequestClose={hideModal}
      overlayClassName="custom-modal-overlay"
    >
      <button
        className="custom-modal-x"
        onClick={hideModal}
        type="button"
      >
        x
      </button>
      <Component
        successCallback={successCallback}
      />
    </Modal>
  );

  return (
    <Fragment>
      <button
        className="button-primary"
        onClick={showModal}
        title={`Add New ${displayName}`}
        type="button"
      >
        +
      </button>
      {
        modalVisible
          ? ReactDOM.createPortal(modal, modalRoot)
          : undefined
      }
    </Fragment>
  );
};

ModalForComponentWithButton.defaultProps = {
  displayName: 'Entry',
};

ModalForComponentWithButton.propTypes = {
  component: PropTypes.oneOfType([
    PropTypes.func,
    PropTypes.element,
  ]).isRequired,
  displayName: PropTypes.string,
  onClose: PropTypes.func.isRequired,
};

export default ModalForComponentWithButton;
