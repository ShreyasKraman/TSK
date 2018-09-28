package com.me.tsk.dao;

import org.hibernate.query.Query;

import com.me.tsk.pojo.doctor;

public class DoctorDAO extends DAO {

	public boolean registerdoc(doctor doc) {

		try {
			if (!getSession().getTransaction().isActive())
				begin();

			Query query = getSession().createQuery("Select count(*) from doctor");
			Long count = (Long) query.uniqueResult();
			doc.setId(count + 1);
			Query query1 = getSession().createQuery("from doctor where reg_id=:regId");
			query1.setString("regId", doc.getRegistered_id());
			doctor doctor = (doctor) query1.uniqueResult();
			if (doctor != null) {
				doctor.setFirstName(doc.getFirstName());
				doctor.setLastName(doc.getLastName());
				doctor.setMobileNo(doc.getMobileNo());
				doctor.setQualification(doc.getQualification());
				doctor.setPatients(doc.getPatients());
				doctor.setDoctorAppointments(doc.getDoctorAppointments());
				getSession().update(doctor);
				commit();
				close();

			} else {
				getSession().save(doc);
				commit();
				close();
			}
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			rollback();
			return false;
		} finally {
			close();
		}

	}

	public doctor getDoc(String doctorRegId) {

		try {
			if (!getSession().getTransaction().isActive())
				begin();

			Query query = getSession().createQuery("from doctor where reg_id=:regId");
			query.setString("regId", doctorRegId);
			doctor doc = (doctor) query.uniqueResult();
			return doc;

		} catch (Exception e) {
			e.printStackTrace();
			rollback();
		} finally {
			close();
		}

		return null;
	}
	
	public doctor getDocInfo(long docId) {

		try {
			if (!getSession().getTransaction().isActive())
				begin();

			Query query = getSession().createQuery("from doctor where id=:id");
			query.setLong("id", docId);
			doctor doc = (doctor) query.uniqueResult();
			return doc;

		} catch (Exception e) {
			e.printStackTrace();
			rollback();
		} finally {
			close();
		}

		return null;
	}
	
	public doctor getAllDoctors() {
		
		return null;
	}
	

}
