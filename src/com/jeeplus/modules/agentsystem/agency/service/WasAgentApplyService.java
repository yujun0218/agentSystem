package com.jeeplus.modules.agentsystem.agency.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jeeplus.common.service.CrudService;
import com.jeeplus.modules.agentsystem.agency.dao.WasAgentApplyDao;
import com.jeeplus.modules.agentsystem.agency.entity.WasSysUser;
import com.jeeplus.modules.agentsystem.sysdata.entity.WasAgentLevel;
/**
 * 代理商申请Service
 * @author Wb
 * @date  2017-9-29
 * @version 1.0
 */
@Service
@Transactional(readOnly = true)
public class WasAgentApplyService extends CrudService<WasAgentApplyDao, WasSysUser>{
@Autowired
private WasAgentApplyDao wasAgentApplyDao;

	@Transactional(readOnly = false)
	public Integer pass(WasSysUser wasSysUser){
		return wasAgentApplyDao.pass(wasSysUser);
	}
	
	@Transactional(readOnly = false)
	public Integer overRule(WasSysUser wasSysUser){
		return wasAgentApplyDao.overRule(wasSysUser);
	}
	
	public List<WasSysUser> selectAllSuperAgent(){
		return wasAgentApplyDao.selectAllSuperAgent();
	}
	
	public List<WasAgentLevel>	getAllAgentLevel(){
		return wasAgentApplyDao.getAllAgentLevel();
	}
	
	public Integer	getCountByCopanyName(String companyName){
		return wasAgentApplyDao.getCountByCopanyName(companyName);
	}
	
	public WasAgentLevel getAgentLevelById(Integer id){
		return wasAgentApplyDao.getAgentLevelById(id);
	}
	
	 public String getCashPledgeByUid(String id){
		 return wasAgentApplyDao.getCashPledgeByUid(id);
	 }
}
