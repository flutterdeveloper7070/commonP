# predator_pest

A new Flutter project.

## Getting Started

- ### Flutter version required 
    - 3.19.1
- ### Dart version required
    - 3.3.0

- ### first run proyect
    - run `Run command` if run app on emulator/device. 

- ### Run command
    - debug dev `flutter run -t lib/main_dev.dart --flavor=dev`

    - release dev `flutter run -t lib/main_dev.dart --release --flavor=dev`

    - debug prod `flutter run -t lib/main.dart --flavor=prod`

    - release prod `flutter run -t lib/main.dart --release --flavor=prod`

- ### Build command
    - Android
        - dev `flutter build apk -t lib/main_dev.dart --flavor=dev`
        
        - prod `flutter build apk -t lib/main.dart --flavor=prod`

    - iOS
        - dev `flutter build ios -t lib/main_dev.dart --flavor=dev`

        - prod `flutter build ios -t lib/main.dart --flavor=prod`