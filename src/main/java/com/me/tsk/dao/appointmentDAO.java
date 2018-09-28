package com.me.tsk.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.query.Query;

import com.me.tsk.pojo.PatientAppointment;
import com.me.tsk.pojo.doctor;
import com.me.tsk.pojo.patient;

public class appointmentDAO extends DAO {

	public doctor getAppointments(String doctorRegId) {

		try {
			if (!getSession().getTransaction().isActive())
				begin();
			Query query = getSession().createQuery("from doctor where reg_id=:regId");
			query.setString("regId", doctorRegId);
			doctor doc = (doctor) query.uniqueResult();
			return doc;
		} catch (Exception e) {
			rollback();
			e.printStackTrace();
		}

		return null;
	}

	public doctor getDoctor(long appointmentId) {
		try {
			if (!getSession().getTransaction().isActive())
				begin();
			doctor doc = null;
			String hql = "from doctor as doc inner join doc.doctorAppointments as da where da.id=:id";
			List<?> list = getSession().createQuery(hql).setLong("id",appointmentId).list();
			for (int i = 0; i < list.size(); i++) {
				Object[] row = (Object[]) list.get(i);
				doc = (doctor) row[0];
				break;
			}
			return doc;

		} catch (Exception e) {
			rollback();
			e.printStackTrace();
		}
		return null;
	}

}
