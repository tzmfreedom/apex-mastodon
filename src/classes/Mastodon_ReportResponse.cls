public with sharing class Mastodon_ReportRequest extends Mastodon_QueryableParameter {
	public Integer accountId;
	public List<Integer> statusIds;
	public String comment; 
	
	protected override Map<String, Object> getParams() {
		return new Map<String, Object> {
			'account_id' => this.accountId,
			'comment' => this.comment
		};
	}
	
	protected override Map<String, List<Object>> getListParams() {
		return new Map<String, List<Object>> {
			'status_ids' => this.statusIds	
		};
	}
}