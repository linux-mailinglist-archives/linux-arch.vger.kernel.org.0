Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA29643AA3
	for <lists+linux-arch@lfdr.de>; Thu, 13 Jun 2019 17:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731968AbfFMPWp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Jun 2019 11:22:45 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:50624 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731964AbfFMMdt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Jun 2019 08:33:49 -0400
Received: by mail-yw1-f73.google.com with SMTP id p18so5124633ywe.17
        for <linux-arch@vger.kernel.org>; Thu, 13 Jun 2019 05:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nTyT6z08CUm2wRhb0PBuVFW+TkegThF+CqD5j6KVtL0=;
        b=CnxsNOUInhhH/OvSCJL6tck0ZL2wuMJiTokE8t2863KBUauJI3xy+YlSGUSufOYdgT
         VdJ0ihW/SektymeSVtd/g/MtdEOBa9QCm/KvRgIv8SnUF82gO9+pyKo87gyJX2Jloq4J
         RJVjglQcolzNycTshtC1qdcpYGXapmvn+7u/eTW+oM27Ve7pfve+8AzNVK1lt37k7Ko3
         SHMcWHHAGmXBuXDJOteu75cJ33zhaS2eNR1O0LaLkqCf/K1qgzrX/PLZwpnHcUV4jzxy
         LQq5NXgHpAg2ZTYrpQzwK30fL4CCsZ7RGTAun1O9uFLkoW5MZR4ytvZS0xdGRsPJ7mY1
         aCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nTyT6z08CUm2wRhb0PBuVFW+TkegThF+CqD5j6KVtL0=;
        b=CZrXER9V1gqR+eiBlq7Qr6DoUU2DTtyQRjDEE3E5AyiFqDkYXOslV5+RYnYiAEPlLo
         BI4SkHr5SzxmJvSgovUtwC9hhKfDdY3trlrlrNmnsAspM+3yWu4a0EZrKr1WjAXIs1PM
         CrNFlFQMY5T2UiZq/uuLeoL2spLzqX5rP8030yfRj1Vypvcurfo6k3VwjcvqA3BIADS0
         TUONIiSG6kkkSueJkGwpX8ie1D0+aF6tZPXaXvemlrAzCUTLso8nm8rJTxtST/kj49Y1
         Cb+zRshU9ErERqb49DTsvzH71zgKW+jSPKP3sr45tnL0O1JSAZWG6YFZrAzQ0YQyDwH/
         B+Ow==
X-Gm-Message-State: APjAAAXrUZapT0pwiIJ2WNLamuJMBfxKuC0XLzIy2IpMF4h30wq9SJws
        WmcBJMAtd8oTegGrFyI11WIjpR6v8g==
X-Google-Smtp-Source: APXvYqyYeG9kuY2GuO7yH6gp6XvoR9wxXpj4gokWzcXhyoUsBmy8cKvux41YM4Kmj0jkzqCcDffTHTtrwQ==
X-Received: by 2002:a81:6f84:: with SMTP id k126mr36223172ywc.496.1560429228329;
 Thu, 13 Jun 2019 05:33:48 -0700 (PDT)
Date:   Thu, 13 Jun 2019 14:30:28 +0200
In-Reply-To: <20190613123028.179447-1-elver@google.com>
Message-Id: <20190613123028.179447-4-elver@google.com>
Mime-Version: 1.0
References: <20190613123028.179447-1-elver@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v4 3/3] asm-generic, x86: Add bitops instrumentation for KASAN
From:   Marco Elver <elver@google.com>
To:     peterz@infradead.org, aryabinin@virtuozzo.com, dvyukov@google.com,
        glider@google.com, andreyknvl@google.com, mark.rutland@arm.com,
        hpa@zytor.com
Cc:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        x86@kernel.org, arnd@arndb.de, jpoimboe@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, kasan-dev@googlegroups.com,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This adds a new header to asm-generic to allow optionally instrumenting
architecture-specific asm implementations of bitops.

This change includes the required change for x86 as reference and
changes the kernel API doc to point to bitops-instrumented.h instead.
Rationale: the functions in x86's bitops.h are no longer the kernel API
functions, but instead the arch_ prefixed functions, which are then
instrumented via bitops-instrumented.h.

Other architectures can similarly add support for asm implementations of
bitops.

The documentation text was derived from x86 and existing bitops
asm-generic versions: 1) references to x86 have been removed; 2) as a
result, some of the text had to be reworded for clarity and consistency.

Tested: using lib/test_kasan with bitops tests (pre-requisite patch).

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=198439
Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
Changes in v3:
* Remove references to 'x86' in API documentation; as a result, had to
  reword doc text for clarify and consistency.
* Remove #ifdef, since it is assumed that if asm-generic bitops
  implementations are used, bitops-instrumented.h is not needed.

Changes in v2:
* Instrument word-sized accesses, as specified by the interface.
---
 Documentation/core-api/kernel-api.rst     |   2 +-
 arch/x86/include/asm/bitops.h             | 189 ++++------------
 include/asm-generic/bitops-instrumented.h | 263 ++++++++++++++++++++++
 3 files changed, 302 insertions(+), 152 deletions(-)
 create mode 100644 include/asm-generic/bitops-instrumented.h

diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
index a29c99d13331..65266fa1b706 100644
--- a/Documentation/core-api/kernel-api.rst
+++ b/Documentation/core-api/kernel-api.rst
@@ -51,7 +51,7 @@ The Linux kernel provides more basic utility functions.
 Bit Operations
 --------------
 
-.. kernel-doc:: arch/x86/include/asm/bitops.h
+.. kernel-doc:: include/asm-generic/bitops-instrumented.h
    :internal:
 
 Bitmap Operations
diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index 8e790ec219a5..ba15d53c1ca7 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -49,23 +49,8 @@
 #define CONST_MASK_ADDR(nr, addr)	WBYTE_ADDR((void *)(addr) + ((nr)>>3))
 #define CONST_MASK(nr)			(1 << ((nr) & 7))
 
-/**
- * set_bit - Atomically set a bit in memory
- * @nr: the bit to set
- * @addr: the address to start counting from
- *
- * This function is atomic and may not be reordered.  See __set_bit()
- * if you do not require the atomic guarantees.
- *
- * Note: there are no guarantees that this function will not be reordered
- * on non x86 architectures, so if you are writing portable code,
- * make sure not to rely on its reordering guarantees.
- *
- * Note that @nr may be almost arbitrarily large; this function is not
- * restricted to acting on a single-word quantity.
- */
 static __always_inline void
-set_bit(long nr, volatile unsigned long *addr)
+arch_set_bit(long nr, volatile unsigned long *addr)
 {
 	if (IS_IMMEDIATE(nr)) {
 		asm volatile(LOCK_PREFIX "orb %1,%0"
@@ -78,32 +63,14 @@ set_bit(long nr, volatile unsigned long *addr)
 	}
 }
 
-/**
- * __set_bit - Set a bit in memory
- * @nr: the bit to set
- * @addr: the address to start counting from
- *
- * Unlike set_bit(), this function is non-atomic and may be reordered.
- * If it's called on the same region of memory simultaneously, the effect
- * may be that only one operation succeeds.
- */
-static __always_inline void __set_bit(long nr, volatile unsigned long *addr)
+static __always_inline void
+arch___set_bit(long nr, volatile unsigned long *addr)
 {
 	asm volatile(__ASM_SIZE(bts) " %1,%0" : : ADDR, "Ir" (nr) : "memory");
 }
 
-/**
- * clear_bit - Clears a bit in memory
- * @nr: Bit to clear
- * @addr: Address to start counting from
- *
- * clear_bit() is atomic and may not be reordered.  However, it does
- * not contain a memory barrier, so if it is used for locking purposes,
- * you should call smp_mb__before_atomic() and/or smp_mb__after_atomic()
- * in order to ensure changes are visible on other processors.
- */
 static __always_inline void
-clear_bit(long nr, volatile unsigned long *addr)
+arch_clear_bit(long nr, volatile unsigned long *addr)
 {
 	if (IS_IMMEDIATE(nr)) {
 		asm volatile(LOCK_PREFIX "andb %1,%0"
@@ -115,26 +82,21 @@ clear_bit(long nr, volatile unsigned long *addr)
 	}
 }
 
-/*
- * clear_bit_unlock - Clears a bit in memory
- * @nr: Bit to clear
- * @addr: Address to start counting from
- *
- * clear_bit() is atomic and implies release semantics before the memory
- * operation. It can be used for an unlock.
- */
-static __always_inline void clear_bit_unlock(long nr, volatile unsigned long *addr)
+static __always_inline void
+arch_clear_bit_unlock(long nr, volatile unsigned long *addr)
 {
 	barrier();
-	clear_bit(nr, addr);
+	arch_clear_bit(nr, addr);
 }
 
-static __always_inline void __clear_bit(long nr, volatile unsigned long *addr)
+static __always_inline void
+arch___clear_bit(long nr, volatile unsigned long *addr)
 {
 	asm volatile(__ASM_SIZE(btr) " %1,%0" : : ADDR, "Ir" (nr) : "memory");
 }
 
-static __always_inline bool clear_bit_unlock_is_negative_byte(long nr, volatile unsigned long *addr)
+static __always_inline bool
+arch_clear_bit_unlock_is_negative_byte(long nr, volatile unsigned long *addr)
 {
 	bool negative;
 	asm volatile(LOCK_PREFIX "andb %2,%1"
@@ -143,48 +105,23 @@ static __always_inline bool clear_bit_unlock_is_negative_byte(long nr, volatile
 		: "ir" ((char) ~(1 << nr)) : "memory");
 	return negative;
 }
+#define arch_clear_bit_unlock_is_negative_byte                                 \
+	arch_clear_bit_unlock_is_negative_byte
 
-// Let everybody know we have it
-#define clear_bit_unlock_is_negative_byte clear_bit_unlock_is_negative_byte
-
-/*
- * __clear_bit_unlock - Clears a bit in memory
- * @nr: Bit to clear
- * @addr: Address to start counting from
- *
- * __clear_bit() is non-atomic and implies release semantics before the memory
- * operation. It can be used for an unlock if no other CPUs can concurrently
- * modify other bits in the word.
- */
-static __always_inline void __clear_bit_unlock(long nr, volatile unsigned long *addr)
+static __always_inline void
+arch___clear_bit_unlock(long nr, volatile unsigned long *addr)
 {
-	__clear_bit(nr, addr);
+	arch___clear_bit(nr, addr);
 }
 
-/**
- * __change_bit - Toggle a bit in memory
- * @nr: the bit to change
- * @addr: the address to start counting from
- *
- * Unlike change_bit(), this function is non-atomic and may be reordered.
- * If it's called on the same region of memory simultaneously, the effect
- * may be that only one operation succeeds.
- */
-static __always_inline void __change_bit(long nr, volatile unsigned long *addr)
+static __always_inline void
+arch___change_bit(long nr, volatile unsigned long *addr)
 {
 	asm volatile(__ASM_SIZE(btc) " %1,%0" : : ADDR, "Ir" (nr) : "memory");
 }
 
-/**
- * change_bit - Toggle a bit in memory
- * @nr: Bit to change
- * @addr: Address to start counting from
- *
- * change_bit() is atomic and may not be reordered.
- * Note that @nr may be almost arbitrarily large; this function is not
- * restricted to acting on a single-word quantity.
- */
-static __always_inline void change_bit(long nr, volatile unsigned long *addr)
+static __always_inline void
+arch_change_bit(long nr, volatile unsigned long *addr)
 {
 	if (IS_IMMEDIATE(nr)) {
 		asm volatile(LOCK_PREFIX "xorb %1,%0"
@@ -196,42 +133,20 @@ static __always_inline void change_bit(long nr, volatile unsigned long *addr)
 	}
 }
 
-/**
- * test_and_set_bit - Set a bit and return its old value
- * @nr: Bit to set
- * @addr: Address to count from
- *
- * This operation is atomic and cannot be reordered.
- * It also implies a memory barrier.
- */
-static __always_inline bool test_and_set_bit(long nr, volatile unsigned long *addr)
+static __always_inline bool
+arch_test_and_set_bit(long nr, volatile unsigned long *addr)
 {
 	return GEN_BINARY_RMWcc(LOCK_PREFIX __ASM_SIZE(bts), *addr, c, "Ir", nr);
 }
 
-/**
- * test_and_set_bit_lock - Set a bit and return its old value for lock
- * @nr: Bit to set
- * @addr: Address to count from
- *
- * This is the same as test_and_set_bit on x86.
- */
 static __always_inline bool
-test_and_set_bit_lock(long nr, volatile unsigned long *addr)
+arch_test_and_set_bit_lock(long nr, volatile unsigned long *addr)
 {
-	return test_and_set_bit(nr, addr);
+	return arch_test_and_set_bit(nr, addr);
 }
 
-/**
- * __test_and_set_bit - Set a bit and return its old value
- * @nr: Bit to set
- * @addr: Address to count from
- *
- * This operation is non-atomic and can be reordered.
- * If two examples of this operation race, one can appear to succeed
- * but actually fail.  You must protect multiple accesses with a lock.
- */
-static __always_inline bool __test_and_set_bit(long nr, volatile unsigned long *addr)
+static __always_inline bool
+arch___test_and_set_bit(long nr, volatile unsigned long *addr)
 {
 	bool oldbit;
 
@@ -242,28 +157,13 @@ static __always_inline bool __test_and_set_bit(long nr, volatile unsigned long *
 	return oldbit;
 }
 
-/**
- * test_and_clear_bit - Clear a bit and return its old value
- * @nr: Bit to clear
- * @addr: Address to count from
- *
- * This operation is atomic and cannot be reordered.
- * It also implies a memory barrier.
- */
-static __always_inline bool test_and_clear_bit(long nr, volatile unsigned long *addr)
+static __always_inline bool
+arch_test_and_clear_bit(long nr, volatile unsigned long *addr)
 {
 	return GEN_BINARY_RMWcc(LOCK_PREFIX __ASM_SIZE(btr), *addr, c, "Ir", nr);
 }
 
-/**
- * __test_and_clear_bit - Clear a bit and return its old value
- * @nr: Bit to clear
- * @addr: Address to count from
- *
- * This operation is non-atomic and can be reordered.
- * If two examples of this operation race, one can appear to succeed
- * but actually fail.  You must protect multiple accesses with a lock.
- *
+/*
  * Note: the operation is performed atomically with respect to
  * the local CPU, but not other CPUs. Portable code should not
  * rely on this behaviour.
@@ -271,7 +171,8 @@ static __always_inline bool test_and_clear_bit(long nr, volatile unsigned long *
  * accessed from a hypervisor on the same CPU if running in a VM: don't change
  * this without also updating arch/x86/kernel/kvm.c
  */
-static __always_inline bool __test_and_clear_bit(long nr, volatile unsigned long *addr)
+static __always_inline bool
+arch___test_and_clear_bit(long nr, volatile unsigned long *addr)
 {
 	bool oldbit;
 
@@ -282,8 +183,8 @@ static __always_inline bool __test_and_clear_bit(long nr, volatile unsigned long
 	return oldbit;
 }
 
-/* WARNING: non atomic and it can be reordered! */
-static __always_inline bool __test_and_change_bit(long nr, volatile unsigned long *addr)
+static __always_inline bool
+arch___test_and_change_bit(long nr, volatile unsigned long *addr)
 {
 	bool oldbit;
 
@@ -295,15 +196,8 @@ static __always_inline bool __test_and_change_bit(long nr, volatile unsigned lon
 	return oldbit;
 }
 
-/**
- * test_and_change_bit - Change a bit and return its old value
- * @nr: Bit to change
- * @addr: Address to count from
- *
- * This operation is atomic and cannot be reordered.
- * It also implies a memory barrier.
- */
-static __always_inline bool test_and_change_bit(long nr, volatile unsigned long *addr)
+static __always_inline bool
+arch_test_and_change_bit(long nr, volatile unsigned long *addr)
 {
 	return GEN_BINARY_RMWcc(LOCK_PREFIX __ASM_SIZE(btc), *addr, c, "Ir", nr);
 }
@@ -326,16 +220,7 @@ static __always_inline bool variable_test_bit(long nr, volatile const unsigned l
 	return oldbit;
 }
 
-#if 0 /* Fool kernel-doc since it doesn't do macros yet */
-/**
- * test_bit - Determine whether a bit is set
- * @nr: bit number to test
- * @addr: Address to start counting from
- */
-static bool test_bit(int nr, const volatile unsigned long *addr);
-#endif
-
-#define test_bit(nr, addr)			\
+#define arch_test_bit(nr, addr)			\
 	(__builtin_constant_p((nr))		\
 	 ? constant_test_bit((nr), (addr))	\
 	 : variable_test_bit((nr), (addr)))
@@ -504,6 +389,8 @@ static __always_inline int fls64(__u64 x)
 
 #include <asm-generic/bitops/const_hweight.h>
 
+#include <asm-generic/bitops-instrumented.h>
+
 #include <asm-generic/bitops/le.h>
 
 #include <asm-generic/bitops/ext2-atomic-setbit.h>
diff --git a/include/asm-generic/bitops-instrumented.h b/include/asm-generic/bitops-instrumented.h
new file mode 100644
index 000000000000..ddd1c6d9d8db
--- /dev/null
+++ b/include/asm-generic/bitops-instrumented.h
@@ -0,0 +1,263 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * This file provides wrappers with sanitizer instrumentation for bit
+ * operations.
+ *
+ * To use this functionality, an arch's bitops.h file needs to define each of
+ * the below bit operations with an arch_ prefix (e.g. arch_set_bit(),
+ * arch___set_bit(), etc.).
+ */
+#ifndef _ASM_GENERIC_BITOPS_INSTRUMENTED_H
+#define _ASM_GENERIC_BITOPS_INSTRUMENTED_H
+
+#include <linux/kasan-checks.h>
+
+/**
+ * set_bit - Atomically set a bit in memory
+ * @nr: the bit to set
+ * @addr: the address to start counting from
+ *
+ * This is a relaxed atomic operation (no implied memory barriers).
+ *
+ * Note that @nr may be almost arbitrarily large; this function is not
+ * restricted to acting on a single-word quantity.
+ */
+static inline void set_bit(long nr, volatile unsigned long *addr)
+{
+	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	arch_set_bit(nr, addr);
+}
+
+/**
+ * __set_bit - Set a bit in memory
+ * @nr: the bit to set
+ * @addr: the address to start counting from
+ *
+ * Unlike set_bit(), this function is non-atomic. If it is called on the same
+ * region of memory concurrently, the effect may be that only one operation
+ * succeeds.
+ */
+static inline void __set_bit(long nr, volatile unsigned long *addr)
+{
+	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	arch___set_bit(nr, addr);
+}
+
+/**
+ * clear_bit - Clears a bit in memory
+ * @nr: Bit to clear
+ * @addr: Address to start counting from
+ *
+ * This is a relaxed atomic operation (no implied memory barriers).
+ */
+static inline void clear_bit(long nr, volatile unsigned long *addr)
+{
+	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	arch_clear_bit(nr, addr);
+}
+
+/**
+ * __clear_bit - Clears a bit in memory
+ * @nr: the bit to clear
+ * @addr: the address to start counting from
+ *
+ * Unlike clear_bit(), this function is non-atomic. If it is called on the same
+ * region of memory concurrently, the effect may be that only one operation
+ * succeeds.
+ */
+static inline void __clear_bit(long nr, volatile unsigned long *addr)
+{
+	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	arch___clear_bit(nr, addr);
+}
+
+/**
+ * clear_bit_unlock - Clear a bit in memory, for unlock
+ * @nr: the bit to set
+ * @addr: the address to start counting from
+ *
+ * This operation is atomic and provides release barrier semantics.
+ */
+static inline void clear_bit_unlock(long nr, volatile unsigned long *addr)
+{
+	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	arch_clear_bit_unlock(nr, addr);
+}
+
+/**
+ * __clear_bit_unlock - Clears a bit in memory
+ * @nr: Bit to clear
+ * @addr: Address to start counting from
+ *
+ * This is a non-atomic operation but implies a release barrier before the
+ * memory operation. It can be used for an unlock if no other CPUs can
+ * concurrently modify other bits in the word.
+ */
+static inline void __clear_bit_unlock(long nr, volatile unsigned long *addr)
+{
+	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	arch___clear_bit_unlock(nr, addr);
+}
+
+/**
+ * change_bit - Toggle a bit in memory
+ * @nr: Bit to change
+ * @addr: Address to start counting from
+ *
+ * This is a relaxed atomic operation (no implied memory barriers).
+ *
+ * Note that @nr may be almost arbitrarily large; this function is not
+ * restricted to acting on a single-word quantity.
+ */
+static inline void change_bit(long nr, volatile unsigned long *addr)
+{
+	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	arch_change_bit(nr, addr);
+}
+
+/**
+ * __change_bit - Toggle a bit in memory
+ * @nr: the bit to change
+ * @addr: the address to start counting from
+ *
+ * Unlike change_bit(), this function is non-atomic. If it is called on the same
+ * region of memory concurrently, the effect may be that only one operation
+ * succeeds.
+ */
+static inline void __change_bit(long nr, volatile unsigned long *addr)
+{
+	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	arch___change_bit(nr, addr);
+}
+
+/**
+ * test_and_set_bit - Set a bit and return its old value
+ * @nr: Bit to set
+ * @addr: Address to count from
+ *
+ * This is an atomic fully-ordered operation (implied full memory barrier).
+ */
+static inline bool test_and_set_bit(long nr, volatile unsigned long *addr)
+{
+	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	return arch_test_and_set_bit(nr, addr);
+}
+
+/**
+ * __test_and_set_bit - Set a bit and return its old value
+ * @nr: Bit to set
+ * @addr: Address to count from
+ *
+ * This operation is non-atomic. If two instances of this operation race, one
+ * can appear to succeed but actually fail.
+ */
+static inline bool __test_and_set_bit(long nr, volatile unsigned long *addr)
+{
+	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	return arch___test_and_set_bit(nr, addr);
+}
+
+/**
+ * test_and_set_bit_lock - Set a bit and return its old value, for lock
+ * @nr: Bit to set
+ * @addr: Address to count from
+ *
+ * This operation is atomic and provides acquire barrier semantics if
+ * the returned value is 0.
+ * It can be used to implement bit locks.
+ */
+static inline bool test_and_set_bit_lock(long nr, volatile unsigned long *addr)
+{
+	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	return arch_test_and_set_bit_lock(nr, addr);
+}
+
+/**
+ * test_and_clear_bit - Clear a bit and return its old value
+ * @nr: Bit to clear
+ * @addr: Address to count from
+ *
+ * This is an atomic fully-ordered operation (implied full memory barrier).
+ */
+static inline bool test_and_clear_bit(long nr, volatile unsigned long *addr)
+{
+	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	return arch_test_and_clear_bit(nr, addr);
+}
+
+/**
+ * __test_and_clear_bit - Clear a bit and return its old value
+ * @nr: Bit to clear
+ * @addr: Address to count from
+ *
+ * This operation is non-atomic. If two instances of this operation race, one
+ * can appear to succeed but actually fail.
+ */
+static inline bool __test_and_clear_bit(long nr, volatile unsigned long *addr)
+{
+	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	return arch___test_and_clear_bit(nr, addr);
+}
+
+/**
+ * test_and_change_bit - Change a bit and return its old value
+ * @nr: Bit to change
+ * @addr: Address to count from
+ *
+ * This is an atomic fully-ordered operation (implied full memory barrier).
+ */
+static inline bool test_and_change_bit(long nr, volatile unsigned long *addr)
+{
+	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	return arch_test_and_change_bit(nr, addr);
+}
+
+/**
+ * __test_and_change_bit - Change a bit and return its old value
+ * @nr: Bit to change
+ * @addr: Address to count from
+ *
+ * This operation is non-atomic. If two instances of this operation race, one
+ * can appear to succeed but actually fail.
+ */
+static inline bool __test_and_change_bit(long nr, volatile unsigned long *addr)
+{
+	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	return arch___test_and_change_bit(nr, addr);
+}
+
+/**
+ * test_bit - Determine whether a bit is set
+ * @nr: bit number to test
+ * @addr: Address to start counting from
+ */
+static inline bool test_bit(long nr, const volatile unsigned long *addr)
+{
+	kasan_check_read(addr + BIT_WORD(nr), sizeof(long));
+	return arch_test_bit(nr, addr);
+}
+
+#if defined(arch_clear_bit_unlock_is_negative_byte)
+/**
+ * clear_bit_unlock_is_negative_byte - Clear a bit in memory and test if bottom
+ *                                     byte is negative, for unlock.
+ * @nr: the bit to clear
+ * @addr: the address to start counting from
+ *
+ * This operation is atomic and provides release barrier semantics.
+ *
+ * This is a bit of a one-trick-pony for the filemap code, which clears
+ * PG_locked and tests PG_waiters,
+ */
+static inline bool
+clear_bit_unlock_is_negative_byte(long nr, volatile unsigned long *addr)
+{
+	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	return arch_clear_bit_unlock_is_negative_byte(nr, addr);
+}
+/* Let everybody know we have it. */
+#define clear_bit_unlock_is_negative_byte clear_bit_unlock_is_negative_byte
+#endif
+
+#endif /* _ASM_GENERIC_BITOPS_INSTRUMENTED_H */
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

