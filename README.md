# Instagram
An application to duplicate the core functionality of Instagram using Rails 7, implemented in a test driven manner.

### User profile page
![Screenshot](https://i.imgur.com/WbR9m7q.png?1)

### User feed page
![Screenshot](https://i.imgur.com/x8Lgrd2.png?1)

### Signup page
![Screenshot](https://i.imgur.com/haYJgwL.png?2)

### Post profile page
![Screenshot](https://i.imgur.com/ra5CtFD.png?4)

## Specifications
- Users can signup. Presence, length and format validations plus email and username uniqueness validations in both model and database.
- Users can login with correct email and password.
- Logged in users can change their own profile information via 'Settings' or clicking on 'Edit Profile' on their profile page.
- Logged in users can create posts with an image (in the required format and size) and an optional caption (maximum 2200 characters).
- Logged in users can write comments (maximum 2200 characters) via the form and 'like' posts by clicking on the heart icon (once only).
- Logged in users can follow and unfollow other users (not themselves).
- Any user can visit the profile pages of other users which shows small images of the posts in reverse chronological order. It also shows the number of followers and following, clicking on either will display a list of those users if you are logged in. Logged in users will see a link to follow/unfollow the user depending on their current friendship status or if logged in as the profile owner, a link to edit their profile will be displayed instead.
-  Hovering over an image on the user's profile page will display that post's comments and like statistics. Clicking on an image will take you to the post's individual page showing a larger image, the caption, any comments and the number of likes. Logged in users can also 'like' and add comments here. If a user is logged in as the post owner, they will see links to edit or delete the post, otherwise a logged in user will see a link to follow/unfollow the post's owner depending on their current friendship status.
- Comments show the comment owner's username, clicking on it will take you to their profile page.
- Logged in users can click on the likes statistics which will show a list of the users who liked the post along with links to follow/unfollow the user depending on their current friendship status. Clicking on the username will take you to that user's profile page.  
- The homepage will show a feed of posts from the users you are following if you are logged in. You can also 'like' and add comments here. If you are not following anyone you will see a link to the users index page which shows a list of all the users you can follow, paginated.  If not logged in, you will see the login form, which includes a link to sign up in case you are not registered.
- Instead of showing user id's in the urls, they instead display the user's username, which will get updated if the user changes their username.
- Production: deployed on Heroku with images stored on Amazon S3.

## How to use
https://anjana-instagram.herokuapp.com Use the following login details to see sample data already setup: email: test@example.com, password: password

To use the app locally, please follow the below instructions:

### Install project dependencies
Clone the repo to your local machine, change into the directory, then:
```
$ bundle install
```

### Setup the databases
```
$ rails db:create
$ rails db:migrate

```

### Run the app
```
$ rails server
```
Visit http://localhost:3000

### Run tests
```
$ rails test
```

## Technologies used
* Amazon S3
* Bootstrap 5
* CSS
* Heroku
* HTML
* JavaScript
* PostgreSQL
* Ruby on Rails 7
