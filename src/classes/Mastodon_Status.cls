public with sharing class Mastodon_Status {
    public Integer id;
    public String uri;
    public String url;
    public Mastodon_Account account;
    public Integer in_reply_to_id;
    public Integer in_reply_to_account_id;
    public Mastodon_Status reblog;
    public String content;
    public DateTime created_at;
    public Integer reblogs_count;
    public Integer favourites_count;
    public Boolean reblogged;
    public Boolean favourited;
    public Boolean sensitive;
    public String spoiler_text;
    public String visibility;
    public List<Mastodon_Attachment> media_attachments;
    public List<Mastodon_Mention> mentions;
    public List<Mastodon_Tag> tags;
    public Mastodon_Application application; 
}