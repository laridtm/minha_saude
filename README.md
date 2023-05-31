# Minha saúde - Frontend Mobile iOS

Frontend written in Swift for the Minha Saúde mobile project.

It is a personal health management application for the `Trabalho de Conclusão de Curso Sistemas de Informação - Universidade do Sul de Santa Catarina/ UNISUL`.

## Minha saúde - Backend

Backend written in Go for the project in this [link](https://github.com/laridtm/minha_saude_backend)

To run the mobile project locally you need to have the backend project running on your machine. In the read me of the repository you will find the step by step.

### Installation

The project manages dependencies through CocoaPods.

Simply clone this repository or download its zip file to your computer, install its dependencies and run the project in Xcode.

```bash
$ git clone git@github.com/laridtm/minha_saude
$ cd minha_saude
$ pod install
```
### Architecture

It was built using the Swift programming language and following the practices suggested by the `VIP/VIPER` organizational architecture. 

VIPER is an acronym formed by the following words: View , Interactor, Presenter, Entity and Router. 

The VIPER architecture is based on the Model-View-Controller (MVC) software development pattern, but adds an additional layer, the presenter. It suggests how to make the interactions between the layers proposed by Uncle Bob.

![Captura de Tela 2023-05-31 às 17 19 12](https://github.com/laridtm/minha_saude/assets/55598696/d98a173a-d04a-4069-818a-e6c475c848ff)

### Used Libraries

* [**Cartography**](https://github.com/SciTools/cartopy)
* [**SwiftGen**](https://github.com/SwiftGen/SwiftGen)
* [**Moya**](https://github.com/Moya/Moya)

### Screenshots

| Acesso | Home | Empty State |  Perfil | 
|-------------|-------------|-------------|-------------|
| ![Simulator Screen Shot - iPhone 11 - 2023-05-06 at 16 20 30](https://github.com/laridtm/minha_saude/assets/55598696/cfe403ea-4125-4c05-a827-4734f09b45b7) | ![Simulator Screen Shot - iPhone 11 - 2023-05-06 at 16 20 43](https://github.com/laridtm/minha_saude/assets/55598696/1d4a24cd-2081-41fb-ba3a-0ed493bea0a3) |![Simulator Screen Shot - iPhone 11 - 2023-05-06 at 16 52 48](https://github.com/laridtm/minha_saude/assets/55598696/b5a26726-7e94-42dc-89de-fce50f29212f) | ![Simulator Screen Shot - iPhone 11 - 2023-05-06 at 16 20 50](https://github.com/laridtm/minha_saude/assets/55598696/d4405303-8a59-41bf-b537-10c64722c352) |

| Lembretes | Criação Lembretes | Edição Lembretes | 
|-------------|-------------|-------------|
|![Simulator Screen Shot - iPhone 11 - 2023-05-06 at 16 20 58](https://github.com/laridtm/minha_saude/assets/55598696/af5a2f66-8a2e-42d0-890c-0df2f19a05b6) | ![Simulator Screen Shot - iPhone 11 - 2023-05-06 at 16 21 04](https://github.com/laridtm/minha_saude/assets/55598696/a5e6cc9c-5c22-4cdc-a9b4-7dc5cc6a0da9)| ![Simulator Screen Shot - iPhone 11 - 2023-05-06 at 16 21 12](https://github.com/laridtm/minha_saude/assets/55598696/2f069095-288e-469c-81ff-b5a0c5d8bcb5)|

| Histórico | Criação Registro | Edição Registro | 
|-------------|-------------|-------------|
| ![Simulator Screen Shot - iPhone 11 - 2023-05-06 at 16 21 20](https://github.com/laridtm/minha_saude/assets/55598696/98bd316c-eacd-46c6-9b03-6b31a6bac121) | ![Simulator Screen Shot - iPhone 11 - 2023-05-06 at 16 21 29](https://github.com/laridtm/minha_saude/assets/55598696/9a5033a7-bc95-4de8-bc85-462fb592cc43) | ![Simulator Screen Shot - iPhone 11 - 2023-05-06 at 16 21 38](https://github.com/laridtm/minha_saude/assets/55598696/444aa504-3e86-453c-81e8-c823d28d4410)| 

### Next Steps

As a form of continuity and improvement for the present work, it would be interesting to include the following functionalities:

* List of doctors by specialty
* Listing of doctors and clinics by proximity and/or region
* Consultation of availability of medical care by specialty and price
* Inclusion of mask for CPF
* Login with email and password
* Upload profile picture
* Notification of Reminders
* Attachment of exams and proof of vaccines
* Develop tests for frontend and backend
* Publishing on the Apple store

### Author

| [![Larissa](https://avatars.githubusercontent.com/u/55598696?v=4&s=80)](https://github.com/laridtm/) | [@laridtm](https://github.com/laridtm/) |
| ------ | ------ |
