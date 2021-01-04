# ======================================================================
# There are 5 questions in this test with increasing difficulty from 1-5
# Please note that the weight of the grade for the question is relative
# to its difficulty. So your Category 1 question will score much less
# than your Category 5 question.
# ======================================================================
#
# Basic Datasets Question
#
# Create a classifier for the MNIST dataset
# Note that the test will expect it to classify 10 classes and that the
# input shape should be the native size of the MNIST dataset which is
# 28x28 monochrome. Do not resize the data. Your input layer should accept
# (28,28) as the input shape only. If you amend this, the tests will fail.
#

import tensorflow as tf
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense, Flatten, Dropout
from tensorflow.keras.callbacks import ModelCheckpoint

def solution_model():
    mnist = tf.keras.datasets.mnist
    # YOUR CODE HERE
    (X_train, y_train), (X_test, y_test) = mnist.load_data()

    X_train = X_train / 255.
    X_test = X_test / 255.


    model = Sequential([
        Flatten(input_shape=(28,28)),
        Dense(256, activation='relu'),
        Dropout(0.5),
        Dense(128, activation='relu'),
        Dense(10, activation='softmax')
    ])
    model.compile(loss='sparse_categorical_crossentropy', optimizer='adam'
                  , metrics=['acc'])
    checkpoint_path = 'mnist_checkpoint.ckpt'
    checkpoint =  ModelCheckpoint(filepath=checkpoint_path, save_weights_only=True
                                  , save_best_only=True,
                             monitor='val_loss', verbose=1)

    model.fit(X_train, y_train, validation_data=(X_test, y_test), epochs=30, callbacks=[checkpoint])
    model.load_weights(checkpoint_path)
    return model


# Note that you'll need to save your model as a .h5 like this
# This .h5 will be uploaded to the testing infrastructure
# and a score will be returned to you
if __name__ == '__main__':
    model = solution_model()
    model.save("TF2-mnist.h5")

# 목표: 0.07
# val_loss = 0.06105
# val_loss = 0.05934
