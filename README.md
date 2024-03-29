# Discovery App

A Flutter App to Implement Pagination

## Guide
- Make Sure the Device has internet while using the application (Loading may take some time as the data is being fetched from serverless function hosted on public cloud)
- Application may pose as a threat while installing but can be installed without worry

---

## HomeScreen
  - Consists of a Listview which on the end of the scroll calls the api endpoint and displays it in the list

## Code Explanation
  - Dio Package was used for Http request handling because dio provides with many options including option to upload files to the endpoint
  - Data Model was created as per standardize methodologies in industry through which we can maintain a consistent and structured approach to handling data within our application
  - Tuple Package was used to send around multiple items in single function calls
  - Cached Network Image Package was used to reduce the network dependency of fetching image from an hosted endpoint
  - Code follows all the standard practices and taken care wioth alll the error handling

## Screenshots
<div>
  <img src="https://github.com/Tanujkarteek/Discovery/blob/main/assets/discovery.png" width="300">
  <img src="https://github.com/Tanujkarteek/Discovery/blob/main/assets/nomore.png" width="300">
</div>
