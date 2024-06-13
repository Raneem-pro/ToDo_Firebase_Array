## ToDo List Project with Firebase

### Using Arrays

Another structural approach in our ToDo list project is using arrays within the user's document to store tasks. This method simplifies the data model by keeping all tasks in a single array, which can enhance performance for smaller datasets. Arrays are straightforward to implement and are efficient for applications with a limited number of tasks or where tasks are rarely updated. However, this approach may present challenges when tasks require frequent updates or complex querying, as the entire array needs to be read and written each time a modification is made.
