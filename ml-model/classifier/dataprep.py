import os
import cv2


class DataPrep:
    def __init__(self, base_dir, target_size=(240, 240)):
        """ Initializes the data preparation class

        Args:
            base_dir (_type_): The root directory containing class subfolders
            target_size (tuple, optional): The desired size for all images. Defaults to (240, 240).
        """
        self.base_dir = base_dir
        self.target_size = target_size
        
    def resize_images(self):
        """
        Resize all images in subfolders to the specified target size and overwrites them
        """
        for class_folder in os.listdir(self.base_dir):
            class_path = os.path.join(self.base_dir, class_folder)
            
            if os.path.isdir(class_path):
                for img_name in os.listdir(class_path):
                    img_path = os.path.join(class_path, img_name)
                    
                    if img_name.lower().endswith(('.png', '.jpg', '.jpeg')):
                        img = cv2.imread(img_path)
                        
                        if img is not None:
                            img_resized = cv2.resize(img, self.target_size, interpolation=cv2.INTER_CUBIC)
                            cv2.imwrite(img_path, img_resized)
                            print(f"Resized: {img_path}")
                        else:
                            print(f"Skipped (corrupted file): {img_path}")
                            
if __name__ == "__main__":
    dataprep = DataPrep(base_dir="data/val")
    dataprep.resize_images() 