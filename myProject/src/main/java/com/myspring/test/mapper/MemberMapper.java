package com.myspring.test.mapper;

import java.util.Map;
import org.apache.ibatis.annotations.Mapper;
import com.myspring.test.member.Member;

@Mapper		// mybatis api
public interface MemberMapper {

	public Member loginMemberCheck(Map<String, Object> data);
	public Member checkDoubleId(Map<String, Object> data);
	public Member checkDoubleEmail(Map<String, Object> data);
	public int insertMember(Map<String, Object> data);
	
}
