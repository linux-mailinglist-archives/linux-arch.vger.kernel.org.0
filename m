Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1390553A2B
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jun 2022 21:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353388AbiFUTRM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jun 2022 15:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353156AbiFUTQ0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jun 2022 15:16:26 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AED729C9A;
        Tue, 21 Jun 2022 12:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655838981; x=1687374981;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yPLSnlPAiuoFniiK+v5SKZwgNXQsodjuxDe5Q0gIfLw=;
  b=P3rqK8/GsAn/o9dBBBzWr+OIQO0MEau4qU8uVdJ8bVKcmhHxOHC+dXF4
   J8mvVFe82u3fpeHDTcC17xY9IzloNSvPG2U82P0KHKCj8JmALsFjmcQAa
   y8Ke20EqjCveBYHQR6l7EKIwdlKiuYRN/7ELKlcEekFB1OkqTV06X5Amq
   OfBhiOdFImq2I9d0/SFWluSGRiohoHn0vQw0TOQpAlX3ClwB65xJvKYBH
   DbU45km9RjtSbz7y+HeWoyfbOhKqQGMRaTNREEEc1kyxJDJGxLHYFidzn
   7KedXWg1NNbtowxUqpgDMkBbmmOH4Oillnu92W5y73CTcXQEsdch0U0Eb
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="278985816"
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="278985816"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 12:16:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="586066087"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga002.jf.intel.com with ESMTP; 21 Jun 2022 12:16:14 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 25LJG7oC012650;
        Tue, 21 Jun 2022 20:16:12 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matt Turner <mattst88@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/8] bitops: unify non-atomic bitops prototypes across architectures
Date:   Tue, 21 Jun 2022 21:15:48 +0200
Message-Id: <20220621191553.69455-4-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621191553.69455-1-alexandr.lobakin@intel.com>
References: <20220621191553.69455-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Currently, there is a mess with the prototypes of the non-atomic
bitops across the different architectures:

ret	bool, int, unsigned long
nr	int, long, unsigned int, unsigned long
addr	volatile unsigned long *, volatile void *

Thankfully, it doesn't provoke any bugs, but can sometimes make
the compiler angry when it's not handy at all.
Adjust all the prototypes to the following standard:

ret	bool				retval can be only 0 or 1
nr	unsigned long			native; signed makes no sense
addr	volatile unsigned long *	bitmaps are arrays of ulongs

Next, some architectures don't define 'arch_' versions as they don't
support instrumentation, others do. To make sure there is always the
same set of callables present and to ease any potential future
changes, make them all follow the rule:
 * architecture-specific files define only 'arch_' versions;
 * non-prefixed versions can be defined only in asm-generic files;
and place the non-prefixed definitions into a new file in
asm-generic to be included by non-instrumented architectures.

Finally, add some static assertions in order to prevent people from
making a mess in this room again.
I also used the %__always_inline attribute consistently, so that
they always get resolved to the actual operations.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/alpha/include/asm/bitops.h               | 32 ++++++------
 arch/hexagon/include/asm/bitops.h             | 24 +++++----
 arch/ia64/include/asm/bitops.h                | 42 ++++++++--------
 arch/m68k/include/asm/bitops.h                | 49 +++++++++++++------
 arch/sh/include/asm/bitops-op32.h             | 34 ++++++++-----
 arch/x86/include/asm/bitops.h                 | 22 +++++----
 .../asm-generic/bitops/generic-non-atomic.h   | 24 ++++-----
 .../bitops/instrumented-non-atomic.h          | 21 +++++---
 include/asm-generic/bitops/non-atomic.h       | 13 +----
 .../bitops/non-instrumented-non-atomic.h      | 16 ++++++
 include/linux/bitops.h                        | 17 +++++++
 tools/include/asm-generic/bitops/non-atomic.h | 24 +++++----
 12 files changed, 198 insertions(+), 120 deletions(-)
 create mode 100644 include/asm-generic/bitops/non-instrumented-non-atomic.h

diff --git a/arch/alpha/include/asm/bitops.h b/arch/alpha/include/asm/bitops.h
index e1d8483a45f2..492c7713ddae 100644
--- a/arch/alpha/include/asm/bitops.h
+++ b/arch/alpha/include/asm/bitops.h
@@ -46,8 +46,8 @@ set_bit(unsigned long nr, volatile void * addr)
 /*
  * WARNING: non atomic version.
  */
-static inline void
-__set_bit(unsigned long nr, volatile void * addr)
+static __always_inline void
+arch___set_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	int *m = ((int *) addr) + (nr >> 5);
 
@@ -82,8 +82,8 @@ clear_bit_unlock(unsigned long nr, volatile void * addr)
 /*
  * WARNING: non atomic version.
  */
-static __inline__ void
-__clear_bit(unsigned long nr, volatile void * addr)
+static __always_inline void
+arch___clear_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	int *m = ((int *) addr) + (nr >> 5);
 
@@ -94,7 +94,7 @@ static inline void
 __clear_bit_unlock(unsigned long nr, volatile void * addr)
 {
 	smp_mb();
-	__clear_bit(nr, addr);
+	arch___clear_bit(nr, addr);
 }
 
 static inline void
@@ -118,8 +118,8 @@ change_bit(unsigned long nr, volatile void * addr)
 /*
  * WARNING: non atomic version.
  */
-static __inline__ void
-__change_bit(unsigned long nr, volatile void * addr)
+static __always_inline void
+arch___change_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	int *m = ((int *) addr) + (nr >> 5);
 
@@ -186,8 +186,8 @@ test_and_set_bit_lock(unsigned long nr, volatile void *addr)
 /*
  * WARNING: non atomic version.
  */
-static inline int
-__test_and_set_bit(unsigned long nr, volatile void * addr)
+static __always_inline bool
+arch___test_and_set_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	unsigned long mask = 1 << (nr & 0x1f);
 	int *m = ((int *) addr) + (nr >> 5);
@@ -230,8 +230,8 @@ test_and_clear_bit(unsigned long nr, volatile void * addr)
 /*
  * WARNING: non atomic version.
  */
-static inline int
-__test_and_clear_bit(unsigned long nr, volatile void * addr)
+static __always_inline bool
+arch___test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	unsigned long mask = 1 << (nr & 0x1f);
 	int *m = ((int *) addr) + (nr >> 5);
@@ -272,8 +272,8 @@ test_and_change_bit(unsigned long nr, volatile void * addr)
 /*
  * WARNING: non atomic version.
  */
-static __inline__ int
-__test_and_change_bit(unsigned long nr, volatile void * addr)
+static __always_inline bool
+arch___test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	unsigned long mask = 1 << (nr & 0x1f);
 	int *m = ((int *) addr) + (nr >> 5);
@@ -283,8 +283,8 @@ __test_and_change_bit(unsigned long nr, volatile void * addr)
 	return (old & mask) != 0;
 }
 
-static inline int
-test_bit(int nr, const volatile void * addr)
+static __always_inline bool
+arch_test_bit(unsigned long nr, const volatile unsigned long *addr)
 {
 	return (1UL & (((const int *) addr)[nr >> 5] >> (nr & 31))) != 0UL;
 }
@@ -450,6 +450,8 @@ sched_find_first_bit(const unsigned long b[2])
 	return __ffs(tmp) + ofs;
 }
 
+#include <asm-generic/bitops/non-instrumented-non-atomic.h>
+
 #include <asm-generic/bitops/le.h>
 
 #include <asm-generic/bitops/ext2-atomic-setbit.h>
diff --git a/arch/hexagon/include/asm/bitops.h b/arch/hexagon/include/asm/bitops.h
index 75d6ba3643b8..da500471ac73 100644
--- a/arch/hexagon/include/asm/bitops.h
+++ b/arch/hexagon/include/asm/bitops.h
@@ -127,38 +127,45 @@ static inline void change_bit(int nr, volatile void *addr)
  * be atomic, particularly for things like slab_lock and slab_unlock.
  *
  */
-static inline void __clear_bit(int nr, volatile unsigned long *addr)
+static __always_inline void
+arch___clear_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	test_and_clear_bit(nr, addr);
 }
 
-static inline void __set_bit(int nr, volatile unsigned long *addr)
+static __always_inline void
+arch___set_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	test_and_set_bit(nr, addr);
 }
 
-static inline void __change_bit(int nr, volatile unsigned long *addr)
+static __always_inline void
+arch___change_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	test_and_change_bit(nr, addr);
 }
 
 /*  Apparently, at least some of these are allowed to be non-atomic  */
-static inline int __test_and_clear_bit(int nr, volatile unsigned long *addr)
+static __always_inline bool
+arch___test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	return test_and_clear_bit(nr, addr);
 }
 
-static inline int __test_and_set_bit(int nr, volatile unsigned long *addr)
+static __always_inline bool
+arch___test_and_set_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	return test_and_set_bit(nr, addr);
 }
 
-static inline int __test_and_change_bit(int nr, volatile unsigned long *addr)
+static __always_inline bool
+arch___test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	return test_and_change_bit(nr, addr);
 }
 
-static inline int __test_bit(int nr, const volatile unsigned long *addr)
+static __always_inline bool
+arch_test_bit(unsigned long nr, const volatile unsigned long *addr)
 {
 	int retval;
 
@@ -172,8 +179,6 @@ static inline int __test_bit(int nr, const volatile unsigned long *addr)
 	return retval;
 }
 
-#define test_bit(nr, addr) __test_bit(nr, addr)
-
 /*
  * ffz - find first zero in word.
  * @word: The word to search
@@ -271,6 +276,7 @@ static inline unsigned long __fls(unsigned long word)
 }
 
 #include <asm-generic/bitops/lock.h>
+#include <asm-generic/bitops/non-instrumented-non-atomic.h>
 
 #include <asm-generic/bitops/fls64.h>
 #include <asm-generic/bitops/sched.h>
diff --git a/arch/ia64/include/asm/bitops.h b/arch/ia64/include/asm/bitops.h
index 577be93c0818..9f62af7fd7c4 100644
--- a/arch/ia64/include/asm/bitops.h
+++ b/arch/ia64/include/asm/bitops.h
@@ -53,7 +53,7 @@ set_bit (int nr, volatile void *addr)
 }
 
 /**
- * __set_bit - Set a bit in memory
+ * arch___set_bit - Set a bit in memory
  * @nr: the bit to set
  * @addr: the address to start counting from
  *
@@ -61,8 +61,8 @@ set_bit (int nr, volatile void *addr)
  * If it's called on the same region of memory simultaneously, the effect
  * may be that only one operation succeeds.
  */
-static __inline__ void
-__set_bit (int nr, volatile void *addr)
+static __always_inline void
+arch___set_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	*((__u32 *) addr + (nr >> 5)) |= (1 << (nr & 31));
 }
@@ -135,7 +135,7 @@ __clear_bit_unlock(int nr, void *addr)
 }
 
 /**
- * __clear_bit - Clears a bit in memory (non-atomic version)
+ * arch___clear_bit - Clears a bit in memory (non-atomic version)
  * @nr: the bit to clear
  * @addr: the address to start counting from
  *
@@ -143,8 +143,8 @@ __clear_bit_unlock(int nr, void *addr)
  * If it's called on the same region of memory simultaneously, the effect
  * may be that only one operation succeeds.
  */
-static __inline__ void
-__clear_bit (int nr, volatile void *addr)
+static __always_inline void
+arch___clear_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	*((__u32 *) addr + (nr >> 5)) &= ~(1 << (nr & 31));
 }
@@ -175,7 +175,7 @@ change_bit (int nr, volatile void *addr)
 }
 
 /**
- * __change_bit - Toggle a bit in memory
+ * arch___change_bit - Toggle a bit in memory
  * @nr: the bit to toggle
  * @addr: the address to start counting from
  *
@@ -183,8 +183,8 @@ change_bit (int nr, volatile void *addr)
  * If it's called on the same region of memory simultaneously, the effect
  * may be that only one operation succeeds.
  */
-static __inline__ void
-__change_bit (int nr, volatile void *addr)
+static __always_inline void
+arch___change_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	*((__u32 *) addr + (nr >> 5)) ^= (1 << (nr & 31));
 }
@@ -224,7 +224,7 @@ test_and_set_bit (int nr, volatile void *addr)
 #define test_and_set_bit_lock test_and_set_bit
 
 /**
- * __test_and_set_bit - Set a bit and return its old value
+ * arch___test_and_set_bit - Set a bit and return its old value
  * @nr: Bit to set
  * @addr: Address to count from
  *
@@ -232,8 +232,8 @@ test_and_set_bit (int nr, volatile void *addr)
  * If two examples of this operation race, one can appear to succeed
  * but actually fail.  You must protect multiple accesses with a lock.
  */
-static __inline__ int
-__test_and_set_bit (int nr, volatile void *addr)
+static __always_inline bool
+arch___test_and_set_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	__u32 *p = (__u32 *) addr + (nr >> 5);
 	__u32 m = 1 << (nr & 31);
@@ -269,7 +269,7 @@ test_and_clear_bit (int nr, volatile void *addr)
 }
 
 /**
- * __test_and_clear_bit - Clear a bit and return its old value
+ * arch___test_and_clear_bit - Clear a bit and return its old value
  * @nr: Bit to clear
  * @addr: Address to count from
  *
@@ -277,8 +277,8 @@ test_and_clear_bit (int nr, volatile void *addr)
  * If two examples of this operation race, one can appear to succeed
  * but actually fail.  You must protect multiple accesses with a lock.
  */
-static __inline__ int
-__test_and_clear_bit(int nr, volatile void * addr)
+static __always_inline bool
+arch___test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	__u32 *p = (__u32 *) addr + (nr >> 5);
 	__u32 m = 1 << (nr & 31);
@@ -314,14 +314,14 @@ test_and_change_bit (int nr, volatile void *addr)
 }
 
 /**
- * __test_and_change_bit - Change a bit and return its old value
+ * arch___test_and_change_bit - Change a bit and return its old value
  * @nr: Bit to change
  * @addr: Address to count from
  *
  * This operation is non-atomic and can be reordered.
  */
-static __inline__ int
-__test_and_change_bit (int nr, void *addr)
+static __always_inline bool
+arch___test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	__u32 old, bit = (1 << (nr & 31));
 	__u32 *m = (__u32 *) addr + (nr >> 5);
@@ -331,8 +331,8 @@ __test_and_change_bit (int nr, void *addr)
 	return (old & bit) != 0;
 }
 
-static __inline__ int
-test_bit (int nr, const volatile void *addr)
+static __always_inline bool
+arch_test_bit(unsigned long nr, const volatile unsigned long *addr)
 {
 	return 1 & (((const volatile __u32 *) addr)[nr >> 5] >> (nr & 31));
 }
@@ -443,6 +443,8 @@ static __inline__ unsigned long __arch_hweight64(unsigned long x)
 
 #ifdef __KERNEL__
 
+#include <asm-generic/bitops/non-instrumented-non-atomic.h>
+
 #include <asm-generic/bitops/le.h>
 
 #include <asm-generic/bitops/ext2-atomic-setbit.h>
diff --git a/arch/m68k/include/asm/bitops.h b/arch/m68k/include/asm/bitops.h
index 51283db53667..71495faf2a90 100644
--- a/arch/m68k/include/asm/bitops.h
+++ b/arch/m68k/include/asm/bitops.h
@@ -65,8 +65,11 @@ static inline void bfset_mem_set_bit(int nr, volatile unsigned long *vaddr)
 				bfset_mem_set_bit(nr, vaddr))
 #endif
 
-#define __set_bit(nr, vaddr)	set_bit(nr, vaddr)
-
+static __always_inline void
+arch___set_bit(unsigned long nr, volatile unsigned long *addr)
+{
+	set_bit(nr, addr);
+}
 
 static inline void bclr_reg_clear_bit(int nr, volatile unsigned long *vaddr)
 {
@@ -105,8 +108,11 @@ static inline void bfclr_mem_clear_bit(int nr, volatile unsigned long *vaddr)
 				bfclr_mem_clear_bit(nr, vaddr))
 #endif
 
-#define __clear_bit(nr, vaddr)	clear_bit(nr, vaddr)
-
+static __always_inline void
+arch___clear_bit(unsigned long nr, volatile unsigned long *addr)
+{
+	clear_bit(nr, addr);
+}
 
 static inline void bchg_reg_change_bit(int nr, volatile unsigned long *vaddr)
 {
@@ -145,14 +151,17 @@ static inline void bfchg_mem_change_bit(int nr, volatile unsigned long *vaddr)
 				bfchg_mem_change_bit(nr, vaddr))
 #endif
 
-#define __change_bit(nr, vaddr)	change_bit(nr, vaddr)
-
-
-static inline int test_bit(int nr, const volatile unsigned long *vaddr)
+static __always_inline void
+arch___change_bit(unsigned long nr, volatile unsigned long *addr)
 {
-	return (vaddr[nr >> 5] & (1UL << (nr & 31))) != 0;
+	change_bit(nr, addr);
 }
 
+static __always_inline bool
+arch_test_bit(unsigned long nr, const volatile unsigned long *addr)
+{
+	return (addr[nr >> 5] & (1UL << (nr & 31))) != 0;
+}
 
 static inline int bset_reg_test_and_set_bit(int nr,
 					    volatile unsigned long *vaddr)
@@ -201,8 +210,11 @@ static inline int bfset_mem_test_and_set_bit(int nr,
 					bfset_mem_test_and_set_bit(nr, vaddr))
 #endif
 
-#define __test_and_set_bit(nr, vaddr)	test_and_set_bit(nr, vaddr)
-
+static __always_inline bool
+arch___test_and_set_bit(unsigned long nr, volatile unsigned long *addr)
+{
+	return test_and_set_bit(nr, addr);
+}
 
 static inline int bclr_reg_test_and_clear_bit(int nr,
 					      volatile unsigned long *vaddr)
@@ -251,8 +263,11 @@ static inline int bfclr_mem_test_and_clear_bit(int nr,
 					bfclr_mem_test_and_clear_bit(nr, vaddr))
 #endif
 
-#define __test_and_clear_bit(nr, vaddr)	test_and_clear_bit(nr, vaddr)
-
+static __always_inline bool
+arch___test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
+{
+	return test_and_clear_bit(nr, addr);
+}
 
 static inline int bchg_reg_test_and_change_bit(int nr,
 					       volatile unsigned long *vaddr)
@@ -301,8 +316,11 @@ static inline int bfchg_mem_test_and_change_bit(int nr,
 					bfchg_mem_test_and_change_bit(nr, vaddr))
 #endif
 
-#define __test_and_change_bit(nr, vaddr) test_and_change_bit(nr, vaddr)
-
+static __always_inline bool
+arch___test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
+{
+	return test_and_change_bit(nr, addr);
+}
 
 /*
  *	The true 68020 and more advanced processors support the "bfffo"
@@ -522,6 +540,7 @@ static inline int __fls(int x)
 #define clear_bit_unlock	clear_bit
 #define __clear_bit_unlock	clear_bit_unlock
 
+#include <asm-generic/bitops/non-instrumented-non-atomic.h>
 #include <asm-generic/bitops/ext2-atomic.h>
 #include <asm-generic/bitops/fls64.h>
 #include <asm-generic/bitops/sched.h>
diff --git a/arch/sh/include/asm/bitops-op32.h b/arch/sh/include/asm/bitops-op32.h
index cfe5465acce7..565a85d8b7fb 100644
--- a/arch/sh/include/asm/bitops-op32.h
+++ b/arch/sh/include/asm/bitops-op32.h
@@ -2,6 +2,8 @@
 #ifndef __ASM_SH_BITOPS_OP32_H
 #define __ASM_SH_BITOPS_OP32_H
 
+#include <linux/bits.h>
+
 /*
  * The bit modifying instructions on SH-2A are only capable of working
  * with a 3-bit immediate, which signifies the shift position for the bit
@@ -16,7 +18,8 @@
 #define BYTE_OFFSET(nr)		((nr) % BITS_PER_BYTE)
 #endif
 
-static inline void __set_bit(int nr, volatile unsigned long *addr)
+static __always_inline void
+arch___set_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	if (__builtin_constant_p(nr)) {
 		__asm__ __volatile__ (
@@ -33,7 +36,8 @@ static inline void __set_bit(int nr, volatile unsigned long *addr)
 	}
 }
 
-static inline void __clear_bit(int nr, volatile unsigned long *addr)
+static __always_inline void
+arch___clear_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	if (__builtin_constant_p(nr)) {
 		__asm__ __volatile__ (
@@ -52,7 +56,7 @@ static inline void __clear_bit(int nr, volatile unsigned long *addr)
 }
 
 /**
- * __change_bit - Toggle a bit in memory
+ * arch___change_bit - Toggle a bit in memory
  * @nr: the bit to change
  * @addr: the address to start counting from
  *
@@ -60,7 +64,8 @@ static inline void __clear_bit(int nr, volatile unsigned long *addr)
  * If it's called on the same region of memory simultaneously, the effect
  * may be that only one operation succeeds.
  */
-static inline void __change_bit(int nr, volatile unsigned long *addr)
+static __always_inline void
+arch___change_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	if (__builtin_constant_p(nr)) {
 		__asm__ __volatile__ (
@@ -79,7 +84,7 @@ static inline void __change_bit(int nr, volatile unsigned long *addr)
 }
 
 /**
- * __test_and_set_bit - Set a bit and return its old value
+ * arch___test_and_set_bit - Set a bit and return its old value
  * @nr: Bit to set
  * @addr: Address to count from
  *
@@ -87,7 +92,8 @@ static inline void __change_bit(int nr, volatile unsigned long *addr)
  * If two examples of this operation race, one can appear to succeed
  * but actually fail.  You must protect multiple accesses with a lock.
  */
-static inline int __test_and_set_bit(int nr, volatile unsigned long *addr)
+static __always_inline bool
+arch___test_and_set_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
@@ -98,7 +104,7 @@ static inline int __test_and_set_bit(int nr, volatile unsigned long *addr)
 }
 
 /**
- * __test_and_clear_bit - Clear a bit and return its old value
+ * arch___test_and_clear_bit - Clear a bit and return its old value
  * @nr: Bit to clear
  * @addr: Address to count from
  *
@@ -106,7 +112,8 @@ static inline int __test_and_set_bit(int nr, volatile unsigned long *addr)
  * If two examples of this operation race, one can appear to succeed
  * but actually fail.  You must protect multiple accesses with a lock.
  */
-static inline int __test_and_clear_bit(int nr, volatile unsigned long *addr)
+static __always_inline bool
+arch___test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
@@ -117,8 +124,8 @@ static inline int __test_and_clear_bit(int nr, volatile unsigned long *addr)
 }
 
 /* WARNING: non atomic and it can be reordered! */
-static inline int __test_and_change_bit(int nr,
-					    volatile unsigned long *addr)
+static __always_inline bool
+arch___test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
@@ -129,13 +136,16 @@ static inline int __test_and_change_bit(int nr,
 }
 
 /**
- * test_bit - Determine whether a bit is set
+ * arch_test_bit - Determine whether a bit is set
  * @nr: bit number to test
  * @addr: Address to start counting from
  */
-static inline int test_bit(int nr, const volatile unsigned long *addr)
+static __always_inline bool
+arch_test_bit(unsigned long nr, const volatile unsigned long *addr)
 {
 	return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
 }
 
+#include <asm-generic/bitops/non-instrumented-non-atomic.h>
+
 #endif /* __ASM_SH_BITOPS_OP32_H */
diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index a288ecd230ab..973c6bd17f98 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -63,7 +63,7 @@ arch_set_bit(long nr, volatile unsigned long *addr)
 }
 
 static __always_inline void
-arch___set_bit(long nr, volatile unsigned long *addr)
+arch___set_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	asm volatile(__ASM_SIZE(bts) " %1,%0" : : ADDR, "Ir" (nr) : "memory");
 }
@@ -89,7 +89,7 @@ arch_clear_bit_unlock(long nr, volatile unsigned long *addr)
 }
 
 static __always_inline void
-arch___clear_bit(long nr, volatile unsigned long *addr)
+arch___clear_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	asm volatile(__ASM_SIZE(btr) " %1,%0" : : ADDR, "Ir" (nr) : "memory");
 }
@@ -114,7 +114,7 @@ arch___clear_bit_unlock(long nr, volatile unsigned long *addr)
 }
 
 static __always_inline void
-arch___change_bit(long nr, volatile unsigned long *addr)
+arch___change_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	asm volatile(__ASM_SIZE(btc) " %1,%0" : : ADDR, "Ir" (nr) : "memory");
 }
@@ -145,7 +145,7 @@ arch_test_and_set_bit_lock(long nr, volatile unsigned long *addr)
 }
 
 static __always_inline bool
-arch___test_and_set_bit(long nr, volatile unsigned long *addr)
+arch___test_and_set_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	bool oldbit;
 
@@ -171,7 +171,7 @@ arch_test_and_clear_bit(long nr, volatile unsigned long *addr)
  * this without also updating arch/x86/kernel/kvm.c
  */
 static __always_inline bool
-arch___test_and_clear_bit(long nr, volatile unsigned long *addr)
+arch___test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	bool oldbit;
 
@@ -183,7 +183,7 @@ arch___test_and_clear_bit(long nr, volatile unsigned long *addr)
 }
 
 static __always_inline bool
-arch___test_and_change_bit(long nr, volatile unsigned long *addr)
+arch___test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	bool oldbit;
 
@@ -219,10 +219,12 @@ static __always_inline bool variable_test_bit(long nr, volatile const unsigned l
 	return oldbit;
 }
 
-#define arch_test_bit(nr, addr)			\
-	(__builtin_constant_p((nr))		\
-	 ? constant_test_bit((nr), (addr))	\
-	 : variable_test_bit((nr), (addr)))
+static __always_inline bool
+arch_test_bit(unsigned long nr, const volatile unsigned long *addr)
+{
+	return __builtin_constant_p(nr) ? constant_test_bit(nr, addr) :
+					  variable_test_bit(nr, addr);
+}
 
 /**
  * __ffs - find first set bit in word
diff --git a/include/asm-generic/bitops/generic-non-atomic.h b/include/asm-generic/bitops/generic-non-atomic.h
index 7226488810e5..b85b8a2ac239 100644
--- a/include/asm-generic/bitops/generic-non-atomic.h
+++ b/include/asm-generic/bitops/generic-non-atomic.h
@@ -24,7 +24,7 @@
  * may be that only one operation succeeds.
  */
 static __always_inline void
-generic___set_bit(unsigned int nr, volatile unsigned long *addr)
+generic___set_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
@@ -33,7 +33,7 @@ generic___set_bit(unsigned int nr, volatile unsigned long *addr)
 }
 
 static __always_inline void
-generic___clear_bit(unsigned int nr, volatile unsigned long *addr)
+generic___clear_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
@@ -50,8 +50,8 @@ generic___clear_bit(unsigned int nr, volatile unsigned long *addr)
  * If it's called on the same region of memory simultaneously, the effect
  * may be that only one operation succeeds.
  */
-static __always_inline
-void generic___change_bit(unsigned int nr, volatile unsigned long *addr)
+static __always_inline void
+generic___change_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
@@ -68,8 +68,8 @@ void generic___change_bit(unsigned int nr, volatile unsigned long *addr)
  * If two examples of this operation race, one can appear to succeed
  * but actually fail.  You must protect multiple accesses with a lock.
  */
-static __always_inline int
-generic___test_and_set_bit(unsigned int nr, volatile unsigned long *addr)
+static __always_inline bool
+generic___test_and_set_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
@@ -88,8 +88,8 @@ generic___test_and_set_bit(unsigned int nr, volatile unsigned long *addr)
  * If two examples of this operation race, one can appear to succeed
  * but actually fail.  You must protect multiple accesses with a lock.
  */
-static __always_inline int
-generic___test_and_clear_bit(unsigned int nr, volatile unsigned long *addr)
+static __always_inline bool
+generic___test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
@@ -100,8 +100,8 @@ generic___test_and_clear_bit(unsigned int nr, volatile unsigned long *addr)
 }
 
 /* WARNING: non atomic and it can be reordered! */
-static __always_inline int
-generic___test_and_change_bit(unsigned int nr, volatile unsigned long *addr)
+static __always_inline bool
+generic___test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
@@ -116,8 +116,8 @@ generic___test_and_change_bit(unsigned int nr, volatile unsigned long *addr)
  * @nr: bit number to test
  * @addr: Address to start counting from
  */
-static __always_inline int
-generic_test_bit(unsigned int nr, const volatile unsigned long *addr)
+static __always_inline bool
+generic_test_bit(unsigned long nr, const volatile unsigned long *addr)
 {
 	/*
 	 * Unlike the bitops with the '__' prefix above, this one *is* atomic,
diff --git a/include/asm-generic/bitops/instrumented-non-atomic.h b/include/asm-generic/bitops/instrumented-non-atomic.h
index 7ab1ecc37782..b019f77ef21c 100644
--- a/include/asm-generic/bitops/instrumented-non-atomic.h
+++ b/include/asm-generic/bitops/instrumented-non-atomic.h
@@ -22,7 +22,8 @@
  * region of memory concurrently, the effect may be that only one operation
  * succeeds.
  */
-static __always_inline void __set_bit(long nr, volatile unsigned long *addr)
+static __always_inline void
+__set_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	instrument_write(addr + BIT_WORD(nr), sizeof(long));
 	arch___set_bit(nr, addr);
@@ -37,7 +38,8 @@ static __always_inline void __set_bit(long nr, volatile unsigned long *addr)
  * region of memory concurrently, the effect may be that only one operation
  * succeeds.
  */
-static __always_inline void __clear_bit(long nr, volatile unsigned long *addr)
+static __always_inline void
+__clear_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	instrument_write(addr + BIT_WORD(nr), sizeof(long));
 	arch___clear_bit(nr, addr);
@@ -52,7 +54,8 @@ static __always_inline void __clear_bit(long nr, volatile unsigned long *addr)
  * region of memory concurrently, the effect may be that only one operation
  * succeeds.
  */
-static __always_inline void __change_bit(long nr, volatile unsigned long *addr)
+static __always_inline void
+__change_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	instrument_write(addr + BIT_WORD(nr), sizeof(long));
 	arch___change_bit(nr, addr);
@@ -90,7 +93,8 @@ static __always_inline void __instrument_read_write_bitop(long nr, volatile unsi
  * This operation is non-atomic. If two instances of this operation race, one
  * can appear to succeed but actually fail.
  */
-static __always_inline bool __test_and_set_bit(long nr, volatile unsigned long *addr)
+static __always_inline bool
+__test_and_set_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	__instrument_read_write_bitop(nr, addr);
 	return arch___test_and_set_bit(nr, addr);
@@ -104,7 +108,8 @@ static __always_inline bool __test_and_set_bit(long nr, volatile unsigned long *
  * This operation is non-atomic. If two instances of this operation race, one
  * can appear to succeed but actually fail.
  */
-static __always_inline bool __test_and_clear_bit(long nr, volatile unsigned long *addr)
+static __always_inline bool
+__test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	__instrument_read_write_bitop(nr, addr);
 	return arch___test_and_clear_bit(nr, addr);
@@ -118,7 +123,8 @@ static __always_inline bool __test_and_clear_bit(long nr, volatile unsigned long
  * This operation is non-atomic. If two instances of this operation race, one
  * can appear to succeed but actually fail.
  */
-static __always_inline bool __test_and_change_bit(long nr, volatile unsigned long *addr)
+static __always_inline bool
+__test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	__instrument_read_write_bitop(nr, addr);
 	return arch___test_and_change_bit(nr, addr);
@@ -129,7 +135,8 @@ static __always_inline bool __test_and_change_bit(long nr, volatile unsigned lon
  * @nr: bit number to test
  * @addr: Address to start counting from
  */
-static __always_inline bool test_bit(long nr, const volatile unsigned long *addr)
+static __always_inline bool
+test_bit(unsigned long nr, const volatile unsigned long *addr)
 {
 	instrument_atomic_read(addr + BIT_WORD(nr), sizeof(long));
 	return arch_test_bit(nr, addr);
diff --git a/include/asm-generic/bitops/non-atomic.h b/include/asm-generic/bitops/non-atomic.h
index 23d3abc1e10d..5c37ced343ae 100644
--- a/include/asm-generic/bitops/non-atomic.h
+++ b/include/asm-generic/bitops/non-atomic.h
@@ -5,24 +5,15 @@
 #include <asm-generic/bitops/generic-non-atomic.h>
 
 #define arch___set_bit generic___set_bit
-#define __set_bit arch___set_bit
-
 #define arch___clear_bit generic___clear_bit
-#define __clear_bit arch___clear_bit
-
 #define arch___change_bit generic___change_bit
-#define __change_bit arch___change_bit
 
 #define arch___test_and_set_bit generic___test_and_set_bit
-#define __test_and_set_bit arch___test_and_set_bit
-
 #define arch___test_and_clear_bit generic___test_and_clear_bit
-#define __test_and_clear_bit arch___test_and_clear_bit
-
 #define arch___test_and_change_bit generic___test_and_change_bit
-#define __test_and_change_bit arch___test_and_change_bit
 
 #define arch_test_bit generic_test_bit
-#define test_bit arch_test_bit
+
+#include <asm-generic/bitops/non-instrumented-non-atomic.h>
 
 #endif /* _ASM_GENERIC_BITOPS_NON_ATOMIC_H_ */
diff --git a/include/asm-generic/bitops/non-instrumented-non-atomic.h b/include/asm-generic/bitops/non-instrumented-non-atomic.h
new file mode 100644
index 000000000000..e0fd7bf72a56
--- /dev/null
+++ b/include/asm-generic/bitops/non-instrumented-non-atomic.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_GENERIC_BITOPS_NON_INSTRUMENTED_NON_ATOMIC_H
+#define __ASM_GENERIC_BITOPS_NON_INSTRUMENTED_NON_ATOMIC_H
+
+#define __set_bit		arch___set_bit
+#define __clear_bit		arch___clear_bit
+#define __change_bit		arch___change_bit
+
+#define __test_and_set_bit	arch___test_and_set_bit
+#define __test_and_clear_bit	arch___test_and_clear_bit
+#define __test_and_change_bit	arch___test_and_change_bit
+
+#define test_bit		arch_test_bit
+
+#endif /* __ASM_GENERIC_BITOPS_NON_INSTRUMENTED_NON_ATOMIC_H */
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 7aaed501f768..87087454a288 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -26,12 +26,29 @@ extern unsigned int __sw_hweight16(unsigned int w);
 extern unsigned int __sw_hweight32(unsigned int w);
 extern unsigned long __sw_hweight64(__u64 w);
 
+#include <asm-generic/bitops/generic-non-atomic.h>
+
 /*
  * Include this here because some architectures need generic_ffs/fls in
  * scope
  */
 #include <asm/bitops.h>
 
+/* Check that the bitops prototypes are sane */
+#define __check_bitop_pr(name)						\
+	static_assert(__same_type(arch_##name, generic_##name) &&	\
+		      __same_type(name, generic_##name))
+
+__check_bitop_pr(__set_bit);
+__check_bitop_pr(__clear_bit);
+__check_bitop_pr(__change_bit);
+__check_bitop_pr(__test_and_set_bit);
+__check_bitop_pr(__test_and_clear_bit);
+__check_bitop_pr(__test_and_change_bit);
+__check_bitop_pr(test_bit);
+
+#undef __check_bitop_pr
+
 static inline int get_bitmask_order(unsigned int count)
 {
 	int order;
diff --git a/tools/include/asm-generic/bitops/non-atomic.h b/tools/include/asm-generic/bitops/non-atomic.h
index 7e10c4b50c5d..e5e78e42e57b 100644
--- a/tools/include/asm-generic/bitops/non-atomic.h
+++ b/tools/include/asm-generic/bitops/non-atomic.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_GENERIC_BITOPS_NON_ATOMIC_H_
 #define _ASM_GENERIC_BITOPS_NON_ATOMIC_H_
 
-#include <asm/types.h>
+#include <linux/bits.h>
 
 /**
  * __set_bit - Set a bit in memory
@@ -13,7 +13,8 @@
  * If it's called on the same region of memory simultaneously, the effect
  * may be that only one operation succeeds.
  */
-static inline void __set_bit(int nr, volatile unsigned long *addr)
+static __always_inline void
+__set_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
@@ -21,7 +22,8 @@ static inline void __set_bit(int nr, volatile unsigned long *addr)
 	*p  |= mask;
 }
 
-static inline void __clear_bit(int nr, volatile unsigned long *addr)
+static __always_inline void
+__clear_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
@@ -38,7 +40,8 @@ static inline void __clear_bit(int nr, volatile unsigned long *addr)
  * If it's called on the same region of memory simultaneously, the effect
  * may be that only one operation succeeds.
  */
-static inline void __change_bit(int nr, volatile unsigned long *addr)
+static __always_inline void
+__change_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
@@ -55,7 +58,8 @@ static inline void __change_bit(int nr, volatile unsigned long *addr)
  * If two examples of this operation race, one can appear to succeed
  * but actually fail.  You must protect multiple accesses with a lock.
  */
-static inline int __test_and_set_bit(int nr, volatile unsigned long *addr)
+static __always_inline bool
+__test_and_set_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
@@ -74,7 +78,8 @@ static inline int __test_and_set_bit(int nr, volatile unsigned long *addr)
  * If two examples of this operation race, one can appear to succeed
  * but actually fail.  You must protect multiple accesses with a lock.
  */
-static inline int __test_and_clear_bit(int nr, volatile unsigned long *addr)
+static __always_inline bool
+__test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
@@ -85,8 +90,8 @@ static inline int __test_and_clear_bit(int nr, volatile unsigned long *addr)
 }
 
 /* WARNING: non atomic and it can be reordered! */
-static inline int __test_and_change_bit(int nr,
-					    volatile unsigned long *addr)
+static __always_inline bool
+__test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
@@ -101,7 +106,8 @@ static inline int __test_and_change_bit(int nr,
  * @nr: bit number to test
  * @addr: Address to start counting from
  */
-static inline int test_bit(int nr, const volatile unsigned long *addr)
+static __always_inline bool
+test_bit(unsigned long nr, const volatile unsigned long *addr)
 {
 	return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
 }
-- 
2.36.1

