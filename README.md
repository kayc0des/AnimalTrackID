# AnimalTrackID: An ML-based Solution for Noninvasive Wildlife Tracking from Animal Tracks


[Mockup Up Demo Video: Watch Here](https://drive.google.com/file/d/1WIJYdQ36cga6bWSNRFGZnqNp0RiGx58x/view?usp=sharing)

## Abstract
Wildlife tracking is the science that facilitates identifying and interpreting the signs of animal activity and provides accurate and localized observations amid a changing world. The benefits of wildlife tracking underscore its importance in wildlife conservation—it unpacks information relating not only to species identification and recognition but also to population dynamics, migration patterns, habitat use, and the effects of environmental changes. Most traditional wildlife tracking methods, such as collaring, banding, and GPS tracking, are invasive methods that require physical interaction with wildlife, potentially causing stress or disrupting its natural behavior. In addition, these methods are expensive and logistically challenging. However, the impressions left by the foot of terrestrial animals provide a noninvasive alternative to traditional wildlife tracking methods. Despite its potential, building machine learning models for wildlife tracking remains a daunting challenge due to the absence of a comprehensive and well-labeled dataset. This leaves researchers and conservationists without a scalable, cost-effective tool for tracking wildlife. This project seeks to amplify the need to curate a comprehensive dataset of animal footprints by leveraging the first publicly available open-source dataset to develop a machine-learning model to classify animal footprints, aiding in species identification and providing insights into their movement patterns and habitat usage. The implementation of this work will contribute to advancing non-invasive wildlife tracking methods, addressing the limitations of traditional approaches by offering a scalable and cost-effective solution. It will provide the conservation sector and researchers with a tool to classify animal footprints accurately, enabling improved species identification, wildlife monitoring and studies, and understanding of habitat usage.

## Project Update

AnimalTrackID builds upon Shinoda et al. (2024) dataset to showcase the ability of machine learning models to deliver valuable insights on species while amplifying the need for a comprehensive dataset for future advancement. The project will thrive in sourcing and adding more data to the base dataset, augmenting the existing dataset, and creating an open-source dataset for public. Some notable changes have already been made to the dataset which are highlighted below:

- `ml-model/classifier/dataprep.py`: Loads the data folder and resizes the images to 240 * 240
- `ml-model/classifier/datagen.py`: An augmentation class augments data in different folders according to a defined rule created to handle class imbalances.

The notebook contains a `data preprocessing class` and a test CNN architecture for classification which raised concerns of overfitting and class imbalance. A second iteration was explored to access the performance of `Vision Transformers` (ml-model/classifier/vit.py`) and not much success was recorded as limited hardware resources and the complexity of the task exhausted avaialable application memory.

## ToDo List

- Mitigate Class Imbalance
- Find solutions to Hardware Challenges
- Explore Vision Transformers
- Build Mobile App Front End
- Build Web App
- Backend Design and Implementation
- API Integration

---

## Contributors

- [kayc0des](https://github.com/kayc0des)