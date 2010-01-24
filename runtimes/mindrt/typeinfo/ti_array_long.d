/*
 * ti_array_long.d
 *
 * This module implements the TypeInfo for long[]
 *
 * License: Public Domain
 *
 */

module mindrt.typeinfo.ti_array_long;

import mindrt.util;

class TypeInfo_Al : TypeInfo {
	char[] toString() {
		return "long[]";
	}

	hash_t getHash(void *p) {
		long[] s = *cast(long[]*)p;
		size_t len = s.length;
		auto str = s.ptr;
		hash_t hash = 0;

		while (len) {
			hash *= 9;
			hash += *cast(uint *)str + *(cast(uint *)str + 1);
			str++;
			len--;
		}

		return hash;
	}

	int equals(void *p1, void *p2) {
		long[] s1 = *cast(long[]*)p1;
		long[] s2 = *cast(long[]*)p2;

		return s1.length == s2.length &&
			memcmp(cast(ubyte*)s1.ptr, cast(ubyte*)s2.ptr, s1.length * long.sizeof) == 0;
	}

	int compare(void *p1, void *p2) {
		long[] s1 = *cast(long[]*)p1;
		long[] s2 = *cast(long[]*)p2;
		size_t len = s1.length;

		if (s2.length < len) {
			len = s2.length;
		}

		for (size_t u = 0; u < len; u++) {
			if (s1[u] < s2[u]) {
				return -1;
			}
			else if (s1[u] > s2[u]) {
				return 1;
			}
		}

		if (s1.length < s2.length) {
			return -1;
		}
		else if (s1.length > s2.length) {
			return 1;
		}

		return 0;
	}

	size_t tsize() {
		return (long[]).sizeof;
	}

	uint flags() {
		return 1;
	}

	TypeInfo next() {
		return typeid(long);
	}
}