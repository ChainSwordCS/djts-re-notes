
// pseudocode

namespace Agent {
	
	void FUN_020110a8(Agent* this) {
		/* todo */
	}
	
	void Agent_FUN_0202eb40(Agent* this, OnCollision_param2_struct* param_1, CollisionBody* param_2) {
		// example input:
		// this    = 0x021DBBF0
		// param_1 = 0x027E0A48
		// param_2 = 0x022609B0
		// return address = 0x0208f1b0
		
		CollisionCompensator* cc;
		
		for (cc = this->var_bc_collisionCompensator; cc != nullptr; cc = cc->nextCollisionCompensator) {
			/* this calls CollisionCompensator::OnCollision() */
			(*(code*)(cc->vptr->vtable[6]))(cc, param_1, param_2);
		}
		FUN_020110a8(this);
		return;
	}
}
