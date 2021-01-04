# ======================================================================
# There are 5 questions in this test with increasing difficulty from 1-5
# Please note that the weight of the grade for the question is relative
# to its difficulty. So your Category 1 question will score much less
# than your Category 5 question.
# ======================================================================
#
# Basic Datasets question
#
# For this task you will train a classifier for Iris flowers using the Iris dataset
# The final layer in your neural network should look like:
# tf.keras.layers.Dense(3, activation=tf.nn.softmax)
# The input layer will expect data in the shape (4,)
# We've given you some starter code for preprocessing the data
# You'll need to implement the preprocess function for data.map


import tensorflow as tf
import tensorflow_datasets as tfds
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense, Dropout
from tensorflow.keras.callbacks import ModelCheckpoint

#data = tfds.load("iris", split=tfds.Split.TRAIN.subsplit(tfds.percent[:80]))
data_t = tfds.load("iris", split='train[:80%]')
data_v = tfds.load("iris", split='train[80%:]')

for data in data_t.take(1):
    print(data)

def preprocess(data):
    # YOUR CODE HERE
    # Should return features and one-hot encoded labels
    x = data['features']
    y = data['label']
    tf.print("one-hot 전에 : ", y)
    y = tf.one_hot(y, 3)
    tf.print("one-hot 전에 : ",y)
    return x, y

def solution_model():
    train_dataset = data_t.map(preprocess).batch(10)
    valid_dataset = data_v.map(preprocess).batch(10)

    # YOUR CODE TO TRAIN A MODEL HERE
    # 성능개선해보세요~
    # model = Sequential([
    #     Dense(64, input_shape=(4,), activation='relu'),
    #     Dropout(0.5),
    #     Dense(32, activation='relu'),
    #     Dense(3, activation='softmax')
    # ])
    model = Sequential([
        Dense(128, input_shape=(4,), activation='relu'),
        Dropout(0.5),
        Dense(64, activation='relu'),
        Dense(3, activation='softmax')
    ])
    model.compile(loss='categorical_crossentropy', optimizer='adam',
                  metrics=['acc'])
    checkpoint_path = 'iris_checkpoint.ckpt'
    checkpoint = ModelCheckpoint(filepath=checkpoint_path,
                                 save_weights_only=True,
                                 save_best_only=True,
                                 monitor='val_loss',
                                 verbose=1)
    model.fit(train_dataset, validation_data=(valid_dataset), epochs=100,
              callbacks=[checkpoint])
    model.load_weights(checkpoint_path)
    return model


# Note that you'll need to save your model as a .h5 like this
# This .h5 will be uploaded to the testing infrastructure
# and a score will be returned to you
if __name__ == '__main__':
    model = solution_model()
    model.save("TF2-iris.h5")

# 목표: 0.14
# val_loss = 0.13425
# val_loss = 0.13003