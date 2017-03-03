package com.mapping;

public class BillStat extends DataEntity {

		public int idbill;
		public int idprojet;
		public int getIdbill() {
			return idbill;
		}
		public void setIdbill(int idbill) {
			this.idbill = idbill;
		}
		public int getIdprojet() {
			return idprojet;
		}
		public void setIdprojet(int idprojet) {
			this.idprojet = idprojet;
		}
		public String getCode() {
			return code;
		}
		public void setCode(String code) {
			this.code = code;
		}
		public Double getEstimation() {
			return estimation;
		}
		public void setEstimation(Double estimation) {
			this.estimation = estimation;
		}
		public Double getActuel() {
			return actuel;
		}
		public void setActuel(Double actuel) {
			this.actuel = actuel;
		}
		public String code;
		public Double estimation;
		public Double actuel;
}
