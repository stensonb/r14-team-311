# Gamegit


We're trying to make git even more **fun and competitive**. 
You earn points for doing actions on your repository (like committing, closing issues, reviewing pull requests, etc..) 
You can see the feed and leaderboards of the project in almost real time.

As a project manager, you can use this tool to give **bonifications to your employees** at the end of the month. It also helps to measure the performance of the team while keeping the motivation up. 
Another benefit is that it **encourages good practices** like push small commits, reviewing pull requests and closing issues.

**NOTE**  
The application will be open-source and easy to deploy on heroku, you can find a live demo here: [http://sleepy-shore-3191.herokuapp.com/]()

## Rails Rumble

If you like this project, please [vote for us](http://railsrumble.com/entries/311-gamegit).


## Deploying it on heroku


Clone the repository:

    git clone git@github.com:railsrumble/r14-team-311.git gamegit

Create a heroku app:

    cd gamegit
    heroku apps:create

Enable mongohq (free plan):

    heroku addons:add mongohq:sandbox

Set your secret token. It is going to be used when enabling the Github webhooks.

	heroku config:set GAMEGIT_SECRET_TOKEN=<your secret token>

Deploy to heroku:

	git push heroku master

And finally open it in your browser:

	heroku open


## Adding the webhook to Github

1. Open your repository settings on Github, then go to "Webhooks & Services -> Add webhook".
2. Enter to password to continue.
3. As url use: http://<replace me>.herokuapp.com/api/github.
4. As secret enter the secret you assigned before. If you don't remember it just type: `heroku config:get GAMEGIT_SECRET_TOKEN` in the gamegit repository.
5. In the next section select the option "Let me select individual events" and select "Push", "Pull request" and "Issues".
6. Click the "add webhook" button



## Customizing points system

You can easily customize the points awarded by the system:

	heroku config:set COMMIT_POINTS=3 OPENED_ISSUE_POINTS=1 CLOSED_ISSUE_POINTS=5 OPENED_PULL_REQUEST_POINTS=1 CLOSED_PULL_REQUEST_POINTS=6


## Customizing achievements

Adding new achievements is easy! Just edit the file [config/achievements.yml](https://github.com/railsrumble/r14-team-311/blob/master/config/achievements.yml).
The conditions should match the fields listed in the [UserStats](https://github.com/railsrumble/r14-team-311/blob/master/models/user_stats.rb) model.


## Roadmap

- Improve UI
- Badges
- Levels
- Add compatibility with trello
- Implement API
- User view





