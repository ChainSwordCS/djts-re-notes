
// pseudocode

/**
 *	Seems similar to malloc, by my understanding.
 */
void* operator.new[](size_t size, uint param_2) {
	/* snip */
}

void* operator.new[](size_t size) {
	return operator.new[](size, 0);
}

/**
 *	Seems similar to free(), I suppose.
 */
void* operator.delete[](void* ptr) {
	/* snip */
}
