public with sharing class Mastodon_Range extends Mastodon_QueryableParameter {
    public Integer maxId;
    public Integer sinceId;
    public Integer limitNo;
    public Boolean isLocal;
    public Boolean isExcludeReplies;
    public Boolean isOnlyMedia;

    protected override Map<String, Object> getParams() {
   		Map<String, Object> params = new Map<String, Object> {
   			'max_id' => this.maxId,
   			'since_id' => this.sinceId,
   			'limit' => this.limitNo
   		};
   		if (this.isLocal != null && this.isLocal) {
   			params.put('local', 'true');
   		}
   		if (this.isExcludeReplies != null && this.isExcludeReplies) {
   			params.put('exclude_replies', 'true');
   		}
   		if (this.isOnlyMedia != null && this.isOnlyMedia) {
   			params.put('only_media', 'true');
   		}
   		return params;
   	}
}