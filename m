Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9F45465D3
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jun 2022 13:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349337AbiFJLgE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Jun 2022 07:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349347AbiFJLf4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jun 2022 07:35:56 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513E871D89;
        Fri, 10 Jun 2022 04:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654860947; x=1686396947;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AYTz2ZEvfXsrmkeIzG3A4eRqbcCrtn4EyV4lentgEeg=;
  b=hBZ4QJ6I9uvfFtyaU+7gH+gbhHnPSWPC+rRMmFkXb2ZRcazeYnmL6oCr
   60/HnwLalipcRORNAOMmTFtb4umHTBCnves9/kXhJf5Nv0M+TCtazlc/7
   PghsjN/K1L4GV1g4vvniZe9ehlnCodgT4Q0HdjqxD9aC9SWAbFL3DEmBt
   G2ftPg7bvjsgmQE4mR9ppqkWtNO7O741Y9rIg945VvdYqqsg0Dp7OpDih
   lpEuDgDapmVQmPZheZqlgE7RIlzHIz+eeJbphU54WJCsIMtU3PQ/7/7xL
   nrirSuLDURNYh9ERxJVwkyyLZQ9kzmCoJRzSlFsQag+6DduXyQIal8bAZ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="277637649"
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="277637649"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 04:35:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="760475547"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga005.jf.intel.com with ESMTP; 10 Jun 2022 04:35:29 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 25ABZKil030333;
        Fri, 10 Jun 2022 12:35:27 +0100
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] bitops: wrap non-atomic bitops with a transparent macro
Date:   Fri, 10 Jun 2022 13:34:26 +0200
Message-Id: <20220610113427.908751-6-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610113427.908751-1-alexandr.lobakin@intel.com>
References: <20220610113427.908751-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In preparation for altering the non-atomic bitops with a macro, wrap
them in a transparent definition. This requires prepending one more
'_' to their names in order to be able to do that seamlessly.
sparc32 already has the triple-underscored functions, so I had to
rename them ('___' -> 'sp32_').

Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 arch/alpha/include/asm/bitops.h               | 14 +++++-----
 arch/hexagon/include/asm/bitops.h             | 16 +++++------
 arch/ia64/include/asm/bitops.h                | 26 ++++++++---------
 arch/m68k/include/asm/bitops.h                | 14 +++++-----
 arch/sh/include/asm/bitops-op32.h             | 22 +++++++--------
 arch/sparc/include/asm/bitops_32.h            | 18 ++++++------
 arch/sparc/lib/atomic32.c                     | 12 ++++----
 .../bitops/instrumented-non-atomic.h          | 28 +++++++++----------
 include/asm-generic/bitops/non-atomic.h       | 14 +++++-----
 include/linux/bitops.h                        | 18 +++++++++++-
 tools/include/asm-generic/bitops/non-atomic.h | 24 ++++++++--------
 tools/include/linux/bitops.h                  | 16 +++++++++++
 12 files changed, 127 insertions(+), 95 deletions(-)

diff --git a/arch/alpha/include/asm/bitops.h b/arch/alpha/include/asm/bitops.h
index 381ad2eae4b4..e7d119826062 100644
--- a/arch/alpha/include/asm/bitops.h
+++ b/arch/alpha/include/asm/bitops.h
@@ -47,7 +47,7 @@ set_bit(unsigned long nr, volatile void * addr)
  * WARNING: non atomic version.
  */
 static __always_inline void
-__set_bit(unsigned long nr, volatile unsigned long *addr)
+___set_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	int *m = ((int *) addr) + (nr >> 5);
 
@@ -83,7 +83,7 @@ clear_bit_unlock(unsigned long nr, volatile void * addr)
  * WARNING: non atomic version.
  */
 static __always_inline void
-__clear_bit(unsigned long nr, volatile unsigned long *addr)
+___clear_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	int *m = ((int *) addr) + (nr >> 5);
 
@@ -119,7 +119,7 @@ change_bit(unsigned long nr, volatile void * addr)
  * WARNING: non atomic version.
  */
 static __always_inline void
-__change_bit(unsigned long nr, volatile unsigned long *addr)
+___change_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	int *m = ((int *) addr) + (nr >> 5);
 
@@ -187,7 +187,7 @@ test_and_set_bit_lock(unsigned long nr, volatile void *addr)
  * WARNING: non atomic version.
  */
 static __always_inline bool
-__test_and_set_bit(unsigned long nr, volatile unsigned long *addr)
+___test_and_set_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	unsigned long mask = 1 << (nr & 0x1f);
 	int *m = ((int *) addr) + (nr >> 5);
@@ -231,7 +231,7 @@ test_and_clear_bit(unsigned long nr, volatile void * addr)
  * WARNING: non atomic version.
  */
 static __always_inline bool
-__test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
+___test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	unsigned long mask = 1 << (nr & 0x1f);
 	int *m = ((int *) addr) + (nr >> 5);
@@ -273,7 +273,7 @@ test_and_change_bit(unsigned long nr, volatile void * addr)
  * WARNING: non atomic version.
  */
 static __always_inline bool
-__test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
+___test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	unsigned long mask = 1 << (nr & 0x1f);
 	int *m = ((int *) addr) + (nr >> 5);
@@ -284,7 +284,7 @@ __test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
 }
 
 static __always_inline bool
-test_bit(unsigned long nr, const volatile unsigned long *addr)
+_test_bit(unsigned long nr, const volatile unsigned long *addr)
 {
 	return (1UL & (((const int *) addr)[nr >> 5] >> (nr & 31))) != 0UL;
 }
diff --git a/arch/hexagon/include/asm/bitops.h b/arch/hexagon/include/asm/bitops.h
index a3bfe3a8d4b7..37144f8e0b0c 100644
--- a/arch/hexagon/include/asm/bitops.h
+++ b/arch/hexagon/include/asm/bitops.h
@@ -128,44 +128,44 @@ static inline void change_bit(int nr, volatile void *addr)
  *
  */
 static __always_inline void
-__clear_bit(unsigned long nr, volatile unsigned long *addr)
+___clear_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	test_and_clear_bit(nr, addr);
 }
 
 static __always_inline void
-__set_bit(unsigned long nr, volatile unsigned long *addr)
+___set_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	test_and_set_bit(nr, addr);
 }
 
 static __always_inline void
-__change_bit(unsigned long nr, volatile unsigned long *addr)
+___change_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	test_and_change_bit(nr, addr);
 }
 
 /*  Apparently, at least some of these are allowed to be non-atomic  */
 static __always_inline bool
-__test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
+___test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	return test_and_clear_bit(nr, addr);
 }
 
 static __always_inline bool
-__test_and_set_bit(unsigned long nr, volatile unsigned long *addr)
+___test_and_set_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	return test_and_set_bit(nr, addr);
 }
 
 static __always_inline bool
-__test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
+___test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	return test_and_change_bit(nr, addr);
 }
 
 static __always_inline bool
-test_bit(unsigned long nr, const volatile unsigned long *addr)
+_test_bit(unsigned long nr, const volatile unsigned long *addr)
 {
 	int retval;
 
@@ -179,7 +179,7 @@ test_bit(unsigned long nr, const volatile unsigned long *addr)
 	return retval;
 }
 
-#define __test_bit(nr, addr) test_bit(nr, addr)
+#define __test_bit(nr, addr) _test_bit(nr, addr)
 
 /*
  * ffz - find first zero in word.
diff --git a/arch/ia64/include/asm/bitops.h b/arch/ia64/include/asm/bitops.h
index 4267a217a503..3cb231fb0283 100644
--- a/arch/ia64/include/asm/bitops.h
+++ b/arch/ia64/include/asm/bitops.h
@@ -53,7 +53,7 @@ set_bit (int nr, volatile void *addr)
 }
 
 /**
- * __set_bit - Set a bit in memory
+ * ___set_bit - Set a bit in memory
  * @nr: the bit to set
  * @addr: the address to start counting from
  *
@@ -62,7 +62,7 @@ set_bit (int nr, volatile void *addr)
  * may be that only one operation succeeds.
  */
 static __always_inline void
-__set_bit(unsigned long nr, volatile unsigned long *addr)
+___set_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	*((__u32 *) addr + (nr >> 5)) |= (1 << (nr & 31));
 }
@@ -135,7 +135,7 @@ __clear_bit_unlock(int nr, void *addr)
 }
 
 /**
- * __clear_bit - Clears a bit in memory (non-atomic version)
+ * ___clear_bit - Clears a bit in memory (non-atomic version)
  * @nr: the bit to clear
  * @addr: the address to start counting from
  *
@@ -144,7 +144,7 @@ __clear_bit_unlock(int nr, void *addr)
  * may be that only one operation succeeds.
  */
 static __always_inline void
-__clear_bit(unsigned long nr, volatile unsigned long *addr)
+___clear_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	*((__u32 *) addr + (nr >> 5)) &= ~(1 << (nr & 31));
 }
@@ -175,7 +175,7 @@ change_bit (int nr, volatile void *addr)
 }
 
 /**
- * __change_bit - Toggle a bit in memory
+ * ___change_bit - Toggle a bit in memory
  * @nr: the bit to toggle
  * @addr: the address to start counting from
  *
@@ -184,7 +184,7 @@ change_bit (int nr, volatile void *addr)
  * may be that only one operation succeeds.
  */
 static __always_inline void
-__change_bit(unsigned long nr, volatile unsigned long *addr)
+___change_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	*((__u32 *) addr + (nr >> 5)) ^= (1 << (nr & 31));
 }
@@ -224,7 +224,7 @@ test_and_set_bit (int nr, volatile void *addr)
 #define test_and_set_bit_lock test_and_set_bit
 
 /**
- * __test_and_set_bit - Set a bit and return its old value
+ * ___test_and_set_bit - Set a bit and return its old value
  * @nr: Bit to set
  * @addr: Address to count from
  *
@@ -233,7 +233,7 @@ test_and_set_bit (int nr, volatile void *addr)
  * but actually fail.  You must protect multiple accesses with a lock.
  */
 static __always_inline bool
-__test_and_set_bit(unsigned long nr, volatile unsigned long *addr)
+___test_and_set_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	__u32 *p = (__u32 *) addr + (nr >> 5);
 	__u32 m = 1 << (nr & 31);
@@ -269,7 +269,7 @@ test_and_clear_bit (int nr, volatile void *addr)
 }
 
 /**
- * __test_and_clear_bit - Clear a bit and return its old value
+ * ___test_and_clear_bit - Clear a bit and return its old value
  * @nr: Bit to clear
  * @addr: Address to count from
  *
@@ -278,7 +278,7 @@ test_and_clear_bit (int nr, volatile void *addr)
  * but actually fail.  You must protect multiple accesses with a lock.
  */
 static __always_inline bool
-__test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
+___test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	__u32 *p = (__u32 *) addr + (nr >> 5);
 	__u32 m = 1 << (nr & 31);
@@ -314,14 +314,14 @@ test_and_change_bit (int nr, volatile void *addr)
 }
 
 /**
- * __test_and_change_bit - Change a bit and return its old value
+ * ___test_and_change_bit - Change a bit and return its old value
  * @nr: Bit to change
  * @addr: Address to count from
  *
  * This operation is non-atomic and can be reordered.
  */
 static __always_inline bool
-__test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
+___test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	__u32 old, bit = (1 << (nr & 31));
 	__u32 *m = (__u32 *) addr + (nr >> 5);
@@ -332,7 +332,7 @@ __test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
 }
 
 static __always_inline bool
-test_bit(unsigned long nr, const volatile unsigned long *addr)
+_test_bit(unsigned long nr, const volatile unsigned long *addr)
 {
 	return 1 & (((const volatile __u32 *) addr)[nr >> 5] >> (nr & 31));
 }
diff --git a/arch/m68k/include/asm/bitops.h b/arch/m68k/include/asm/bitops.h
index 9d44bd4713cb..ed08c9d9c547 100644
--- a/arch/m68k/include/asm/bitops.h
+++ b/arch/m68k/include/asm/bitops.h
@@ -66,7 +66,7 @@ static inline void bfset_mem_set_bit(int nr, volatile unsigned long *vaddr)
 #endif
 
 static __always_inline void
-__set_bit(unsigned long nr, volatile unsigned long *addr)
+___set_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	set_bit(nr, addr);
 }
@@ -109,7 +109,7 @@ static inline void bfclr_mem_clear_bit(int nr, volatile unsigned long *vaddr)
 #endif
 
 static __always_inline void
-__clear_bit(unsigned long nr, volatile unsigned long *addr)
+___clear_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	clear_bit(nr, addr);
 }
@@ -152,13 +152,13 @@ static inline void bfchg_mem_change_bit(int nr, volatile unsigned long *vaddr)
 #endif
 
 static __always_inline void
-__change_bit(unsigned long nr, volatile unsigned long *addr)
+___change_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	change_bit(nr, addr);
 }
 
 static __always_inline bool
-test_bit(unsigned long nr, const volatile unsigned long *addr)
+_test_bit(unsigned long nr, const volatile unsigned long *addr)
 {
 	return (addr[nr >> 5] & (1UL << (nr & 31))) != 0;
 }
@@ -212,7 +212,7 @@ static inline int bfset_mem_test_and_set_bit(int nr,
 #endif
 
 static __always_inline bool
-__test_and_set_bit(unsigned long nr, volatile unsigned long *addr)
+___test_and_set_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	return test_and_set_bit(nr, addr);
 }
@@ -265,7 +265,7 @@ static inline int bfclr_mem_test_and_clear_bit(int nr,
 #endif
 
 static __always_inline bool
-__test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
+___test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	return test_and_clear_bit(nr, addr);
 }
@@ -318,7 +318,7 @@ static inline int bfchg_mem_test_and_change_bit(int nr,
 #endif
 
 static __always_inline bool
-__test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
+___test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	return test_and_change_bit(nr, addr);
 }
diff --git a/arch/sh/include/asm/bitops-op32.h b/arch/sh/include/asm/bitops-op32.h
index dcd85866a394..24b8a809c1b9 100644
--- a/arch/sh/include/asm/bitops-op32.h
+++ b/arch/sh/include/asm/bitops-op32.h
@@ -19,7 +19,7 @@
 #endif
 
 static __always_inline void
-__set_bit(unsigned long nr, volatile unsigned long *addr)
+___set_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	if (__builtin_constant_p(nr)) {
 		__asm__ __volatile__ (
@@ -37,7 +37,7 @@ __set_bit(unsigned long nr, volatile unsigned long *addr)
 }
 
 static __always_inline void
-__clear_bit(unsigned long nr, volatile unsigned long *addr)
+___clear_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	if (__builtin_constant_p(nr)) {
 		__asm__ __volatile__ (
@@ -56,7 +56,7 @@ __clear_bit(unsigned long nr, volatile unsigned long *addr)
 }
 
 /**
- * __change_bit - Toggle a bit in memory
+ * ___change_bit - Toggle a bit in memory
  * @nr: the bit to change
  * @addr: the address to start counting from
  *
@@ -65,7 +65,7 @@ __clear_bit(unsigned long nr, volatile unsigned long *addr)
  * may be that only one operation succeeds.
  */
 static __always_inline void
-__change_bit(unsigned long nr, volatile unsigned long *addr)
+___change_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	if (__builtin_constant_p(nr)) {
 		__asm__ __volatile__ (
@@ -84,7 +84,7 @@ __change_bit(unsigned long nr, volatile unsigned long *addr)
 }
 
 /**
- * __test_and_set_bit - Set a bit and return its old value
+ * ___test_and_set_bit - Set a bit and return its old value
  * @nr: Bit to set
  * @addr: Address to count from
  *
@@ -93,7 +93,7 @@ __change_bit(unsigned long nr, volatile unsigned long *addr)
  * but actually fail.  You must protect multiple accesses with a lock.
  */
 static __always_inline bool
-__test_and_set_bit(unsigned long nr, volatile unsigned long *addr)
+___test_and_set_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
@@ -104,7 +104,7 @@ __test_and_set_bit(unsigned long nr, volatile unsigned long *addr)
 }
 
 /**
- * __test_and_clear_bit - Clear a bit and return its old value
+ * ___test_and_clear_bit - Clear a bit and return its old value
  * @nr: Bit to clear
  * @addr: Address to count from
  *
@@ -113,7 +113,7 @@ __test_and_set_bit(unsigned long nr, volatile unsigned long *addr)
  * but actually fail.  You must protect multiple accesses with a lock.
  */
 static __always_inline bool
-__test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
+___test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
@@ -125,7 +125,7 @@ __test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
 
 /* WARNING: non atomic and it can be reordered! */
 static __always_inline bool
-__test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
+___test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
@@ -136,12 +136,12 @@ __test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
 }
 
 /**
- * test_bit - Determine whether a bit is set
+ * _test_bit - Determine whether a bit is set
  * @nr: bit number to test
  * @addr: Address to start counting from
  */
 static __always_inline bool
-test_bit(unsigned long nr, const volatile unsigned long *addr)
+_test_bit(unsigned long nr, const volatile unsigned long *addr)
 {
 	return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
 }
diff --git a/arch/sparc/include/asm/bitops_32.h b/arch/sparc/include/asm/bitops_32.h
index 889afa9f990f..3448c191b484 100644
--- a/arch/sparc/include/asm/bitops_32.h
+++ b/arch/sparc/include/asm/bitops_32.h
@@ -19,9 +19,9 @@
 #error only <linux/bitops.h> can be included directly
 #endif
 
-unsigned long ___set_bit(unsigned long *addr, unsigned long mask);
-unsigned long ___clear_bit(unsigned long *addr, unsigned long mask);
-unsigned long ___change_bit(unsigned long *addr, unsigned long mask);
+unsigned long sp32___set_bit(unsigned long *addr, unsigned long mask);
+unsigned long sp32___clear_bit(unsigned long *addr, unsigned long mask);
+unsigned long sp32___change_bit(unsigned long *addr, unsigned long mask);
 
 /*
  * Set bit 'nr' in 32-bit quantity at address 'addr' where bit '0'
@@ -36,7 +36,7 @@ static inline int test_and_set_bit(unsigned long nr, volatile unsigned long *add
 	ADDR = ((unsigned long *) addr) + (nr >> 5);
 	mask = 1 << (nr & 31);
 
-	return ___set_bit(ADDR, mask) != 0;
+	return sp32___set_bit(ADDR, mask) != 0;
 }
 
 static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
@@ -46,7 +46,7 @@ static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
 	ADDR = ((unsigned long *) addr) + (nr >> 5);
 	mask = 1 << (nr & 31);
 
-	(void) ___set_bit(ADDR, mask);
+	(void) sp32___set_bit(ADDR, mask);
 }
 
 static inline int test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
@@ -56,7 +56,7 @@ static inline int test_and_clear_bit(unsigned long nr, volatile unsigned long *a
 	ADDR = ((unsigned long *) addr) + (nr >> 5);
 	mask = 1 << (nr & 31);
 
-	return ___clear_bit(ADDR, mask) != 0;
+	return sp32___clear_bit(ADDR, mask) != 0;
 }
 
 static inline void clear_bit(unsigned long nr, volatile unsigned long *addr)
@@ -66,7 +66,7 @@ static inline void clear_bit(unsigned long nr, volatile unsigned long *addr)
 	ADDR = ((unsigned long *) addr) + (nr >> 5);
 	mask = 1 << (nr & 31);
 
-	(void) ___clear_bit(ADDR, mask);
+	(void) sp32___clear_bit(ADDR, mask);
 }
 
 static inline int test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
@@ -76,7 +76,7 @@ static inline int test_and_change_bit(unsigned long nr, volatile unsigned long *
 	ADDR = ((unsigned long *) addr) + (nr >> 5);
 	mask = 1 << (nr & 31);
 
-	return ___change_bit(ADDR, mask) != 0;
+	return sp32___change_bit(ADDR, mask) != 0;
 }
 
 static inline void change_bit(unsigned long nr, volatile unsigned long *addr)
@@ -86,7 +86,7 @@ static inline void change_bit(unsigned long nr, volatile unsigned long *addr)
 	ADDR = ((unsigned long *) addr) + (nr >> 5);
 	mask = 1 << (nr & 31);
 
-	(void) ___change_bit(ADDR, mask);
+	(void) sp32___change_bit(ADDR, mask);
 }
 
 #include <asm-generic/bitops/non-atomic.h>
diff --git a/arch/sparc/lib/atomic32.c b/arch/sparc/lib/atomic32.c
index 8b81d0f00c97..cf80d1ae352b 100644
--- a/arch/sparc/lib/atomic32.c
+++ b/arch/sparc/lib/atomic32.c
@@ -120,7 +120,7 @@ void arch_atomic_set(atomic_t *v, int i)
 }
 EXPORT_SYMBOL(arch_atomic_set);
 
-unsigned long ___set_bit(unsigned long *addr, unsigned long mask)
+unsigned long sp32___set_bit(unsigned long *addr, unsigned long mask)
 {
 	unsigned long old, flags;
 
@@ -131,9 +131,9 @@ unsigned long ___set_bit(unsigned long *addr, unsigned long mask)
 
 	return old & mask;
 }
-EXPORT_SYMBOL(___set_bit);
+EXPORT_SYMBOL(sp32___set_bit);
 
-unsigned long ___clear_bit(unsigned long *addr, unsigned long mask)
+unsigned long sp32___clear_bit(unsigned long *addr, unsigned long mask)
 {
 	unsigned long old, flags;
 
@@ -144,9 +144,9 @@ unsigned long ___clear_bit(unsigned long *addr, unsigned long mask)
 
 	return old & mask;
 }
-EXPORT_SYMBOL(___clear_bit);
+EXPORT_SYMBOL(sp32___clear_bit);
 
-unsigned long ___change_bit(unsigned long *addr, unsigned long mask)
+unsigned long sp32___change_bit(unsigned long *addr, unsigned long mask)
 {
 	unsigned long old, flags;
 
@@ -157,7 +157,7 @@ unsigned long ___change_bit(unsigned long *addr, unsigned long mask)
 
 	return old & mask;
 }
-EXPORT_SYMBOL(___change_bit);
+EXPORT_SYMBOL(sp32___change_bit);
 
 unsigned long __cmpxchg_u32(volatile u32 *ptr, u32 old, u32 new)
 {
diff --git a/include/asm-generic/bitops/instrumented-non-atomic.h b/include/asm-generic/bitops/instrumented-non-atomic.h
index b019f77ef21c..988a3bbfba34 100644
--- a/include/asm-generic/bitops/instrumented-non-atomic.h
+++ b/include/asm-generic/bitops/instrumented-non-atomic.h
@@ -14,7 +14,7 @@
 #include <linux/instrumented.h>
 
 /**
- * __set_bit - Set a bit in memory
+ * ___set_bit - Set a bit in memory
  * @nr: the bit to set
  * @addr: the address to start counting from
  *
@@ -23,14 +23,14 @@
  * succeeds.
  */
 static __always_inline void
-__set_bit(unsigned long nr, volatile unsigned long *addr)
+___set_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	instrument_write(addr + BIT_WORD(nr), sizeof(long));
 	arch___set_bit(nr, addr);
 }
 
 /**
- * __clear_bit - Clears a bit in memory
+ * ___clear_bit - Clears a bit in memory
  * @nr: the bit to clear
  * @addr: the address to start counting from
  *
@@ -39,14 +39,14 @@ __set_bit(unsigned long nr, volatile unsigned long *addr)
  * succeeds.
  */
 static __always_inline void
-__clear_bit(unsigned long nr, volatile unsigned long *addr)
+___clear_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	instrument_write(addr + BIT_WORD(nr), sizeof(long));
 	arch___clear_bit(nr, addr);
 }
 
 /**
- * __change_bit - Toggle a bit in memory
+ * ___change_bit - Toggle a bit in memory
  * @nr: the bit to change
  * @addr: the address to start counting from
  *
@@ -55,7 +55,7 @@ __clear_bit(unsigned long nr, volatile unsigned long *addr)
  * succeeds.
  */
 static __always_inline void
-__change_bit(unsigned long nr, volatile unsigned long *addr)
+___change_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	instrument_write(addr + BIT_WORD(nr), sizeof(long));
 	arch___change_bit(nr, addr);
@@ -86,7 +86,7 @@ static __always_inline void __instrument_read_write_bitop(long nr, volatile unsi
 }
 
 /**
- * __test_and_set_bit - Set a bit and return its old value
+ * ___test_and_set_bit - Set a bit and return its old value
  * @nr: Bit to set
  * @addr: Address to count from
  *
@@ -94,14 +94,14 @@ static __always_inline void __instrument_read_write_bitop(long nr, volatile unsi
  * can appear to succeed but actually fail.
  */
 static __always_inline bool
-__test_and_set_bit(unsigned long nr, volatile unsigned long *addr)
+___test_and_set_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	__instrument_read_write_bitop(nr, addr);
 	return arch___test_and_set_bit(nr, addr);
 }
 
 /**
- * __test_and_clear_bit - Clear a bit and return its old value
+ * ___test_and_clear_bit - Clear a bit and return its old value
  * @nr: Bit to clear
  * @addr: Address to count from
  *
@@ -109,14 +109,14 @@ __test_and_set_bit(unsigned long nr, volatile unsigned long *addr)
  * can appear to succeed but actually fail.
  */
 static __always_inline bool
-__test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
+___test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	__instrument_read_write_bitop(nr, addr);
 	return arch___test_and_clear_bit(nr, addr);
 }
 
 /**
- * __test_and_change_bit - Change a bit and return its old value
+ * ___test_and_change_bit - Change a bit and return its old value
  * @nr: Bit to change
  * @addr: Address to count from
  *
@@ -124,19 +124,19 @@ __test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
  * can appear to succeed but actually fail.
  */
 static __always_inline bool
-__test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
+___test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	__instrument_read_write_bitop(nr, addr);
 	return arch___test_and_change_bit(nr, addr);
 }
 
 /**
- * test_bit - Determine whether a bit is set
+ * _test_bit - Determine whether a bit is set
  * @nr: bit number to test
  * @addr: Address to start counting from
  */
 static __always_inline bool
-test_bit(unsigned long nr, const volatile unsigned long *addr)
+_test_bit(unsigned long nr, const volatile unsigned long *addr)
 {
 	instrument_atomic_read(addr + BIT_WORD(nr), sizeof(long));
 	return arch_test_bit(nr, addr);
diff --git a/include/asm-generic/bitops/non-atomic.h b/include/asm-generic/bitops/non-atomic.h
index a05bc090a6a3..23c7c16c6e88 100644
--- a/include/asm-generic/bitops/non-atomic.h
+++ b/include/asm-generic/bitops/non-atomic.h
@@ -6,24 +6,24 @@
 #include <asm/types.h>
 
 #define arch___set_bit generic___set_bit
-#define __set_bit arch___set_bit
+#define ___set_bit arch___set_bit
 
 #define arch___clear_bit generic___clear_bit
-#define __clear_bit arch___clear_bit
+#define ___clear_bit arch___clear_bit
 
 #define arch___change_bit generic___change_bit
-#define __change_bit arch___change_bit
+#define ___change_bit arch___change_bit
 
 #define arch___test_and_set_bit generic___test_and_set_bit
-#define __test_and_set_bit arch___test_and_set_bit
+#define ___test_and_set_bit arch___test_and_set_bit
 
 #define arch___test_and_clear_bit generic___test_and_clear_bit
-#define __test_and_clear_bit arch___test_and_clear_bit
+#define ___test_and_clear_bit arch___test_and_clear_bit
 
 #define arch___test_and_change_bit generic___test_and_change_bit
-#define __test_and_change_bit arch___test_and_change_bit
+#define ___test_and_change_bit arch___test_and_change_bit
 
 #define arch_test_bit generic_test_bit
-#define test_bit arch_test_bit
+#define _test_bit arch_test_bit
 
 #endif /* _ASM_GENERIC_BITOPS_NON_ATOMIC_H_ */
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 51c22b8667b4..753f98e0dcf5 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -26,8 +26,24 @@ extern unsigned int __sw_hweight16(unsigned int w);
 extern unsigned int __sw_hweight32(unsigned int w);
 extern unsigned long __sw_hweight64(__u64 w);
 
+/*
+ * Defined here because those may be needed by architecture-specific static
+ * inlines.
+ */
+
 #include <asm-generic/bitops/generic-non-atomic.h>
 
+#define bitop(op, nr, addr)						\
+	op(nr, addr)
+
+#define __set_bit(nr, addr)		bitop(___set_bit, nr, addr)
+#define __clear_bit(nr, addr)		bitop(___clear_bit, nr, addr)
+#define __change_bit(nr, addr)		bitop(___change_bit, nr, addr)
+#define __test_and_set_bit(nr, addr)	bitop(___test_and_set_bit, nr, addr)
+#define __test_and_clear_bit(nr, addr)	bitop(___test_and_clear_bit, nr, addr)
+#define __test_and_change_bit(nr, addr)	bitop(___test_and_change_bit, nr, addr)
+#define test_bit(nr, addr)		bitop(_test_bit, nr, addr)
+
 /*
  * Include this here because some architectures need generic_ffs/fls in
  * scope
@@ -38,7 +54,7 @@ extern unsigned long __sw_hweight64(__u64 w);
 #define __check_bitop_pr(name)						\
 	static_assert(__same_type(const_##name, generic_##name) &&	\
 		      __same_type(arch_##name, generic_##name) &&	\
-		      __same_type(name, generic_##name))
+		      __same_type(_##name, generic_##name))
 
 __check_bitop_pr(__set_bit);
 __check_bitop_pr(__clear_bit);
diff --git a/tools/include/asm-generic/bitops/non-atomic.h b/tools/include/asm-generic/bitops/non-atomic.h
index e5e78e42e57b..0c472a833408 100644
--- a/tools/include/asm-generic/bitops/non-atomic.h
+++ b/tools/include/asm-generic/bitops/non-atomic.h
@@ -5,7 +5,7 @@
 #include <linux/bits.h>
 
 /**
- * __set_bit - Set a bit in memory
+ * ___set_bit - Set a bit in memory
  * @nr: the bit to set
  * @addr: the address to start counting from
  *
@@ -14,7 +14,7 @@
  * may be that only one operation succeeds.
  */
 static __always_inline void
-__set_bit(unsigned long nr, volatile unsigned long *addr)
+___set_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
@@ -23,7 +23,7 @@ __set_bit(unsigned long nr, volatile unsigned long *addr)
 }
 
 static __always_inline void
-__clear_bit(unsigned long nr, volatile unsigned long *addr)
+___clear_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
@@ -32,7 +32,7 @@ __clear_bit(unsigned long nr, volatile unsigned long *addr)
 }
 
 /**
- * __change_bit - Toggle a bit in memory
+ * ___change_bit - Toggle a bit in memory
  * @nr: the bit to change
  * @addr: the address to start counting from
  *
@@ -41,7 +41,7 @@ __clear_bit(unsigned long nr, volatile unsigned long *addr)
  * may be that only one operation succeeds.
  */
 static __always_inline void
-__change_bit(unsigned long nr, volatile unsigned long *addr)
+___change_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
@@ -50,7 +50,7 @@ __change_bit(unsigned long nr, volatile unsigned long *addr)
 }
 
 /**
- * __test_and_set_bit - Set a bit and return its old value
+ * ___test_and_set_bit - Set a bit and return its old value
  * @nr: Bit to set
  * @addr: Address to count from
  *
@@ -59,7 +59,7 @@ __change_bit(unsigned long nr, volatile unsigned long *addr)
  * but actually fail.  You must protect multiple accesses with a lock.
  */
 static __always_inline bool
-__test_and_set_bit(unsigned long nr, volatile unsigned long *addr)
+___test_and_set_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
@@ -70,7 +70,7 @@ __test_and_set_bit(unsigned long nr, volatile unsigned long *addr)
 }
 
 /**
- * __test_and_clear_bit - Clear a bit and return its old value
+ * ___test_and_clear_bit - Clear a bit and return its old value
  * @nr: Bit to clear
  * @addr: Address to count from
  *
@@ -79,7 +79,7 @@ __test_and_set_bit(unsigned long nr, volatile unsigned long *addr)
  * but actually fail.  You must protect multiple accesses with a lock.
  */
 static __always_inline bool
-__test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
+___test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
@@ -91,7 +91,7 @@ __test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
 
 /* WARNING: non atomic and it can be reordered! */
 static __always_inline bool
-__test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
+___test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
@@ -102,12 +102,12 @@ __test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
 }
 
 /**
- * test_bit - Determine whether a bit is set
+ * _test_bit - Determine whether a bit is set
  * @nr: bit number to test
  * @addr: Address to start counting from
  */
 static __always_inline bool
-test_bit(unsigned long nr, const volatile unsigned long *addr)
+_test_bit(unsigned long nr, const volatile unsigned long *addr)
 {
 	return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
 }
diff --git a/tools/include/linux/bitops.h b/tools/include/linux/bitops.h
index 5fca38fe1ba8..f18683b95ea6 100644
--- a/tools/include/linux/bitops.h
+++ b/tools/include/linux/bitops.h
@@ -25,6 +25,22 @@ extern unsigned int __sw_hweight16(unsigned int w);
 extern unsigned int __sw_hweight32(unsigned int w);
 extern unsigned long __sw_hweight64(__u64 w);
 
+/*
+ * Defined here because those may be needed by architecture-specific static
+ * inlines.
+ */
+
+#define bitop(op, nr, addr)						\
+	op(nr, addr)
+
+#define __set_bit(nr, addr)		bitop(___set_bit, nr, addr)
+#define __clear_bit(nr, addr)		bitop(___clear_bit, nr, addr)
+#define __change_bit(nr, addr)		bitop(___change_bit, nr, addr)
+#define __test_and_set_bit(nr, addr)	bitop(___test_and_set_bit, nr, addr)
+#define __test_and_clear_bit(nr, addr)	bitop(___test_and_clear_bit, nr, addr)
+#define __test_and_change_bit(nr, addr)	bitop(___test_and_change_bit, nr, addr)
+#define test_bit(nr, addr)		bitop(_test_bit, nr, addr)
+
 /*
  * Include this here because some architectures need generic_ffs/fls in
  * scope
-- 
2.36.1

