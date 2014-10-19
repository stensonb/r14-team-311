# Gamegit


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










