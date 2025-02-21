import os
import random
import numpy as np
import cv2
import tensorflow as tf

class AugmentData:
    def __init__(self, data_dir, target_size=(224, 224)):
        self.data_dir = data_dir
        self.target_size = target_size

    def random_augmentation(self, image):
        """ Applies a random augmentation technique to an image using TensorFlow augmentation APIs. """
        image = tf.convert_to_tensor(image, dtype=tf.float32)
        if random.random() < 0.5:
            image = tf.image.flip_left_right(image)  # Horizontal flip
        if random.random() < 0.5:
            image = tf.image.flip_up_down(image)  # Vertical flip
        if random.random() < 0.5:
            angle = random.uniform(-20, 20) * (np.pi / 180)
            image = tf.image.rot90(image, k=random.choice([1, 2, 3]))  # Rotate 90, 180, or 270 degrees
        if random.random() < 0.5:
            delta = random.uniform(-0.3, 0.3)
            image = tf.image.adjust_brightness(image, delta)
        image = tf.cast(image, tf.uint8)
        return image.numpy()

    def augment_class(self, class_path, num_needed):
        """ Augments images in a class folder until it reaches the desired count. """
        images = [f for f in os.listdir(class_path) if f.endswith(('png', 'jpg', 'jpeg'))]
        save_dir = class_path
        
        while len(images) < num_needed:
            img_name = random.choice(images)
            img_path = os.path.join(class_path, img_name)
            
            img = cv2.imread(img_path)
            img = cv2.resize(img, self.target_size)
            img = self.random_augmentation(img)
            
            new_img_name = f"aug_{len(images)}_{img_name}"
            cv2.imwrite(os.path.join(save_dir, new_img_name), img)
            images.append(new_img_name)

    def process_all_classes(self):
        """ Applies augmentation based on class count strategy """
        for class_name in os.listdir(self.data_dir):
            class_path = os.path.join(self.data_dir, class_name)
            if not os.path.isdir(class_path):
                continue
            
            num_images = len([f for f in os.listdir(class_path) if f.endswith(('png', 'jpg', 'jpeg'))])
            
            if num_images < 50:
                self.augment_class(class_path, 120)
            elif num_images < 100:
                self.augment_class(class_path, 180)
            elif num_images < 200:
                self.augment_class(class_path, 250)

    @staticmethod
    def save_npz(data_dir, output_file):
        """ Saves images and labels as .npz file. """
        X, Y = [], []
        
        for class_name in os.listdir(data_dir):
            class_path = os.path.join(data_dir, class_name)
            if not os.path.isdir(class_path):
                continue
            
            images = [f for f in os.listdir(class_path) if f.endswith(('png', 'jpg', 'jpeg'))]
            for img_name in images:
                img_path = os.path.join(class_path, img_name)
                img = cv2.imread(img_path)
                img = cv2.resize(img, (224, 224))
                X.append(img)
                Y.append(class_name.replace('_', ' ').title())
                
        X = np.array(X)
        Y = np.array(Y)
        np.savez(output_file, X=X, Y=Y)
        print(f"Saved {output_file} with {len(X)} samples.")


augmenter = AugmentData(data_dir="data/images")
# augmenter.process_all_classes()
AugmentData.save_npz("data/images", "npz/data.npz")
