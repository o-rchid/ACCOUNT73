package kr.co.seoulit.account.sys.base.to;


import lombok.Data;

@Data
public class BoardBean extends BaseBean{

	private String reply;
	private String id;
	private String writer;
	private String title;
	private String contents;
	private String writtenBy;
	private String updateBy;
	private String writeDate;
	private String updateDateTime;
	private String lookup;
	private String boardLike;

	private String rid;
	private String bid;
	private String reContents;
	private String reWritter;
	private String reWrittedate;
	private String reUpdatedate;

	// 파일 업로드용
	private int fileId;
	private int boardId;
	private String fileName;
	private String fileOriName;
	private String fileUrl;

}