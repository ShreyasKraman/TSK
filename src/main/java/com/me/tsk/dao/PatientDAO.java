package com.me.tsk.dao;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;

import com.me.tsk.pojo.doctor;
import com.me.tsk.pojo.patient;

public class PatientDAO extends DAO{
	
	public boolean registerPatient(patient p) {
		
		try {
        	if(!getSession().getTransaction().isActive())
                begin();
			Query q = getSession().createQuery("from patient where email=:useremail");
			q.setString("useremail",p.getEmail());
			patient pat = (patient)q.uniqueResult();
			if(pat != null) {
				pat.setVerify(true);
				pat.setPassword(p.getPassword());
				getSession().update(pat);
				commit();
				close();
				return false;
			}else {
				getSession().save(p);
				commit();
				close();
				return true;
			}
		}catch(HibernateException e) {
			e.printStackTrace();
			rollback();
		}finally{
			close();
		}
		
		return false;
	}
	
	public boolean updatePatient(String email) {
		
		try {
			
        	if(!getSession().getTransaction().isActive())
                begin();
			
			Query q = getSession().createQuery("from patient where email=:useremail");
			q.setString("useremail",email);
			patient pat = (patient)q.uniqueResult();
			if(pat != null) {
				pat.setVerify(true);
				getSession().update(pat);
				commit();
				close();
				return true;
			}else {
				return false;
			}
		}catch(Exception e) {
			
		}
		
		return false;
		
	}
	
	public patient get(String userEmail, String password) throws Exception {

        try {
        	if(!getSession().getTransaction().isActive())
            begin();

            Query q = getSession().createQuery("from patient where email = :useremail and password = :password");

            q.setString("useremail", userEmail);

            q.setString("password", password);            

            patient user = (patient) q.uniqueResult();
            
            
            return user;

        } catch (HibernateException e) {

            rollback();

            throw new Exception("Could not get user " + userEmail, e);

        }finally {
        	close();
        }

    }
	
	public patient getPatientRecord(long imageId) {
		 try {
	        	if(!getSession().getTransaction().isActive())
	        		begin();

	            Query q = getSession().createQuery("from patient where patientId = :patid");

	            q.setLong("patid", imageId);          

	            patient user = (patient) q.uniqueResult();

	            return user;

	        } catch (HibernateException e) {

	            rollback();

	            e.printStackTrace();

	        }
		return null;
	}
	
	public patient getPatientInfo(String userEmail) throws Exception {

        try {
        	if(!getSession().getTransaction().isActive())
        		begin();

            Query q = getSession().createQuery("from patient where email = :useremail");

            q.setString("useremail", userEmail);          

            patient user = (patient) q.uniqueResult();

            return user;

        } catch (HibernateException e) {

            rollback();

            throw new Exception("Could not get user " + userEmail, e);

        }
    }
	
	
}
