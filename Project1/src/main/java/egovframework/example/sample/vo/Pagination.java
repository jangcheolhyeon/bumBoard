package egovframework.example.sample.vo;

public class Pagination {
    private Integer totalCnt;
    private Integer totalPage;
    private Integer page;
    private Integer pageSize = 10;
    private Integer naviSize = 10;
    private Integer beginPage;
    private Integer endPage;
    private boolean showPrev;
    private boolean showNext;
    
    private String keyword;
    private String condition;
    
    
    public Pagination() {}
//	public Pagination(Integer totalCnt, Integer page, Integer pageSize) {
//		super();
//		this.totalCnt = totalCnt;
//		this.page = page;
//		this.pageSize = pageSize;
//		
//		this.totalPage = (int) Math.ceil(totalCnt / (double) pageSize);	
//		this.beginPage = (page - 1) / naviSize * naviSize + 1;
//		this.endPage = Math.min(beginPage + naviSize - 1, totalPage);
//		
//		showPrev = beginPage != 1;
//		showNext = endPage != totalPage;
//	}
    
	public Pagination(Integer totalCnt, Integer page, Integer pageSize) {
		this(totalCnt, page, pageSize, "", "A");
		
	}
	public Pagination(Integer totalCnt, Integer page, Integer pageSize, String keyword, String condition) {
		this.totalCnt = totalCnt;
		this.page = page;
		this.pageSize = pageSize;
		
		this.totalPage = (int) Math.ceil(totalCnt / (double) pageSize);	
		this.beginPage = (page - 1) / naviSize * naviSize + 1;
		this.endPage = Math.min(beginPage + naviSize - 1, totalPage);
		
		showPrev = beginPage != 1;
		showNext = endPage != totalPage;
		
		this.keyword = keyword;
		this.condition = condition;
	}
	
	
	public Integer getTotalCnt() {
		return totalCnt;
	}
	public void setTotalCnt(Integer totalCnt) {
		this.totalCnt = totalCnt;
	}
	public Integer getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(Integer totalPage) {
		this.totalPage = totalPage;
	}
	public Integer getPage() {
		return page;
	}
	public void setPage(Integer page) {
		this.page = page;
	}
	public Integer getPageSize() {
		return pageSize;
	}
	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}
	public Integer getNaviSize() {
		return naviSize;
	}
	public void setNaviSize(Integer naviSize) {
		this.naviSize = naviSize;
	}
	public Integer getBeginPage() {
		return beginPage;
	}
	public void setBeginPage(Integer beginPage) {
		this.beginPage = beginPage;
	}
	public Integer getEndPage() {
		return endPage;
	}
	public void setEndPage(Integer endPage) {
		this.endPage = endPage;
	}
	public boolean isShowPrev() {
		return showPrev;
	}
	public void setShowPrev(boolean showPrev) {
		this.showPrev = showPrev;
	}
	public boolean isShowNext() {
		return showNext;
	}
	public void setShowNext(boolean showNext) {
		this.showNext = showNext;
	}
	
	
	
	
	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getCondition() {
		return condition;
	}

	public void setCondition(String condition) {
		this.condition = condition;
	}
	
	

	@Override
	public String toString() {
		return "Pagination [totalCnt=" + totalCnt + ", totalPage=" + totalPage + ", page=" + page + ", pageSize="
				+ pageSize + ", naviSize=" + naviSize + ", beginPage=" + beginPage + ", endPage=" + endPage
				+ ", showPrev=" + showPrev + ", showNext=" + showNext + "]";
	}
    
    
}
