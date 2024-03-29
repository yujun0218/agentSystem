package com.jeeplus.modules.agentsystem.agency.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.service.CrudService;
import com.jeeplus.modules.agentsystem.agency.dao.WasInvoiceApplicationDao;
import com.jeeplus.modules.agentsystem.agency.entity.WasInvoiceApplication;

/**
 * 
 * @author WR
 * @version 2017-9-29
 */
@Service
@Transactional(readOnly = true,rollbackFor=Exception.class)
public class WasInvoiceApplicationService extends CrudService<WasInvoiceApplicationDao, WasInvoiceApplication> {
	@Autowired
	private WasInvoiceApplicationDao wasInvoiceApplicationDao;
	
	@Override
	public Page<WasInvoiceApplication> findPage(Page<WasInvoiceApplication> page, WasInvoiceApplication entity) {
		// TODO Auto-generated method stub
		return super.findPage(page, entity);
	}
	@Override
	public WasInvoiceApplication get(WasInvoiceApplication entity) {
		// TODO Auto-generated method stub
		return super.get(entity);
	}	
	public WasInvoiceApplication findPageOrder(WasInvoiceApplication wasInvoiceApplication) {
		// TODO Auto-generated method stub
		return wasInvoiceApplicationDao.findPageOrder(wasInvoiceApplication);
	}
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public Integer insert(WasInvoiceApplication wasInvoiceApplication) {
		// TODO Auto-generated method stub
		return wasInvoiceApplicationDao.insertInvoice(wasInvoiceApplication);
	}

	
}
