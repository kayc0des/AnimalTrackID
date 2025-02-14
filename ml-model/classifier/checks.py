import os

def check_number_of_files(dir_paths):
    """Check the number of files in each subdirectory of dir_paths."""
    for dir in os.listdir(dir_paths):
        full_dir_path = os.path.join(dir_paths, dir)
        
        if os.path.isdir(full_dir_path):  # Ensure it's a directory
            num_files = len([entry for entry in os.listdir(full_dir_path) if os.path.isfile(os.path.join(full_dir_path, entry))])
            print(f"{dir}: {num_files} files")

check_number_of_files(dir_paths="data/train")