# apex-mastodon

Apex Library for mastodon

## Install

<a href="https://githubsfdeploy.herokuapp.com?owner=tzmfreedom&repo=apex-mastodon">
  <img alt="Deploy to Salesforce" src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png">
</a>

or use spm command

```bash
$ spm install https://github.com/tzmfreedom/apex-mastodon/src -u {USERNAME} -p {PASSWORD}
```

## Usage

### Use Named Credentials

```apex
Mastodon_Client client = new Mastodon_Client('callout:{named_credential_name}');
Mastodon_Status result = client.postStatus(new Mastodon_Toot('hello mastodon'));
```
### Use ClientID/ClientSecret/RedirectUri

WIP


## Status of implementations

* [ ] GET /api/v1/accounts/:id
* [ ] GET /api/v1/accounts/verify_credentials
* [ ] PATCH /api/v1/accounts/update_credentials
* [ ] GET /api/v1/accounts/:id/followers
* [ ] GET /api/v1/accounts/:id/following
* [ ] GET /api/v1/accounts/:id/statuses
* [ ] POST /api/v1/accounts/:id/follow
* [ ] POST /api/v1/accounts/:id/unfollow
* [ ] GET /api/v1/accounts/:id/block
* [ ] GET /api/v1/accounts/:id/unblock
* [ ] GET /api/v1/accounts/:id/mute
* [ ] GET /api/v1/accounts/:id/unmute
* [ ] GET /api/v1/accounts/relationships
* [ ] GET /api/v1/accounts/search
* [ ] POST /api/v1/apps
* [ ] GET /api/v1/blocks
* [ ] GET /api/v1/favourites
* [ ] GET /api/v1/follow_requests
* [ ] POST /api/v1/follow_requests/:id/authorize
* [ ] POST /api/v1/follow_requests/:id/reject
* [ ] POST /api/v1/follows
* [ ] GET /api/v1/instance
* [ ] POST /api/v1/media
* [ ] GET /api/v1/mutes
* [ ] GET /api/v1/notifications
* [ ] GET /api/v1/notifications/:id
* [ ] POST /api/v1/notifications/clear
* [ ] GET /api/v1/reports
* [ ] POST /api/v1/reports
* [ ] GET /api/v1/search
* [ ] GET /api/v1/statuses/:id
* [ ] GET /api/v1/statuses/:id/context
* [ ] GET /api/v1/statuses/:id/card
* [ ] GET /api/v1/statuses/:id/reblogged_by
* [ ] GET /api/v1/statuses/:id/favourited_by
* [x] POST /api/v1/statuses
* [ ] DELETE /api/v1/statuses/:id
* [ ] POST /api/v1/statuses/:id/reblog
* [ ] POST /api/v1/statuses/:id/unreblog
* [ ] POST /api/v1/statuses/:id/favourite
* [ ] POST /api/v1/statuses/:id/unfavourite
* [ ] GET /api/v1/timelines/home
* [ ] GET /api/v1/timelines/public
* [ ] GET /api/v1/timelines/tag/:hashtag

## LICENSE

MIT
