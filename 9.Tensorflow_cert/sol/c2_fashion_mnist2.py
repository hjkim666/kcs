# ======================================================================
# There are 5 questions in this test with increasing difficulty from 1-5
# Please note that the weight of the grade for the question is relative
# to its difficulty. So your Category 1 question will score much less
# than your Category 5 question.
# ======================================================================
#
# Basic Datasets Question
#
# Create a classifier for the Fashion MNIST dataset
# Note that the test will expect it to classify 10 classes and that the
# input shape should be the native size of the Fashion MNIST dataset which is
# 28x28 monochrome. Do not resize the data. YOur input layer should accept
# (28,28) as the input shape only. If you amend this, the tests will fail.


import tensorflow as tf
from tensorflow.keras.layers import Dense, Flatten, Dropout
from tensorflow.keras.models import Sequential
from tensorflow.keras.callbacks import ModelCheckpoint

#### 성능개선해보세요~!!! 3:35 다시시작

# 10개중 하나 분류문제 -> softmax
def solution_model():
    fashion_mnist = tf.keras.datasets.fashion_mnist
    # YOUR CODE HERE
    (X_train, y_train), (X_test, y_test) = fashion_mnist.load_data()
    # print(X_train.shape, y_train.shape)
    # print(X_test.shape, y_test.shape)
    # print(X_train[0])

    X_train = X_train/255.    #최소최대정규화
    X_test = X_test/255.

    model = Sequential([
        Flatten(input_shape=(28,28)),
        Dense(256, activation='relu'),
        Dropout(0.5),
        Dense(128, activation='relu'),
        Dense(10, activation='softmax')
    ])
    model.compile(loss='sparse_categorical_crossentropy',
                  optimizer='adam', metrics=['acc'])
    checkpoint_path = 'fashion_mnistcheckpoint.ckpt'
    checkpoint = ModelCheckpoint(filepath=checkpoint_path,
                                 save_best_only=True,
                                 save_weights_only=True,
                                 monitor='val_loss', verbose=1)
    model.fit(X_train, y_train, validation_data=(X_test, y_test),
              epochs=50, callbacks=[checkpoint])
    model.load_weights(checkpoint_path)
    return model


# Note that you'll need to save your model as a .h5 like this
# This .h5 will be uploaded to the testing infrastructure
# and a score will be returned to you
if __name__ == '__main__':
    model = solution_model()
    model.save("TF2-fashion-mnist.h5")

# val_loss=0.3303