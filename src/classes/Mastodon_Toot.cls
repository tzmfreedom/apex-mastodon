public with sharing class Mastodon_Toot extends Mastodon_QueryableParameter{
    public String status;
    public Integer inReplyToId;
    public List<Integer> mediaIds;
    public Boolean sensitive;
    public String spoilerText;
    public String visibility;    

    public Mastodon_Toot(String status) {
        this.status = status;
    }
   
    protected override Map<String, Object> getParams() {
   		Map<String, Object> params = new Map<String, Object> {
   			'status' => this.status,
   			'in_reply_to_id' => this.inReplyToId,
   			'sensitive' => this.sensitive,
   			'spoiler_text' => this.spoilerText,
   			'visibility' => this.visibility
   		};
        return params;
   	}
   	
   	protected override Map<String, List<Object>> getListParams() {
   		return new Map<String, List<Object>> {
   			'media_ids' => this.mediaIds
   		};
   	}
}