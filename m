Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1331D7026CD
	for <lists+linux-arch@lfdr.de>; Mon, 15 May 2023 10:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240033AbjEOIHn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 May 2023 04:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238643AbjEOIHb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 May 2023 04:07:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFF71738;
        Mon, 15 May 2023 01:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=A512lmdZ5mu+BsxXuNhkbi41aEPQspSS2JnnTxvGyYs=; b=oExTQSqYYsszhfdd1ylxeG6Q6a
        tG+d+I5HsF7cIpvCdFkNzi543XG1LNV7upSjhuLCTeHoQtkIqE1s4RRIOaAckIGvkm5Oryhf142XL
        LhN3/umz0XmDOUxaMFls5DCRmjf38fycbdxzwI48qvCv8QSvCS1reHFBKHmNnsXXZygD3Ygpe/x28
        QXWWWfWquxFT5aJynme5K7e9jcFTyZlADDy4RDwJSIxMdcShS+XcLkh0Ppy0gFczCWd9MIhu3RcHN
        jQT1+d8loKxnQaJeBZXMi87o9/Mn2j+Qur//DsCEwMzzg/2PQt/VmqMZrBOEjnIeaxQZnsZqk9gr9
        xMzDSeiQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pyTDl-003HUa-Jl; Mon, 15 May 2023 08:06:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8DFA5303434;
        Mon, 15 May 2023 10:06:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D522D202FCEA9; Mon, 15 May 2023 10:06:10 +0200 (CEST)
Message-ID: <20230515080554.589824283@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 15 May 2023 09:57:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org
Cc:     corbet@lwn.net, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, mark.rutland@arm.com,
        catalin.marinas@arm.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, joro@8bytes.org, suravee.suthikulpanit@amd.com,
        robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        iommu@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: [PATCH v3 10/11] arch: Remove cmpxchg_double
References: <20230515075659.118447996@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

No moar users, remove the monster.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 Documentation/core-api/this_cpu_ops.rst    |    2 -
 arch/arm64/include/asm/atomic_ll_sc.h      |   33 ----------------
 arch/arm64/include/asm/atomic_lse.h        |   36 ------------------
 arch/arm64/include/asm/cmpxchg.h           |   46 -----------------------
 arch/arm64/include/asm/percpu.h            |   10 -----
 arch/s390/include/asm/cmpxchg.h            |   34 -----------------
 arch/s390/include/asm/percpu.h             |   18 ---------
 arch/x86/include/asm/cmpxchg.h             |   25 ------------
 arch/x86/include/asm/cmpxchg_32.h          |    1 
 arch/x86/include/asm/cmpxchg_64.h          |    1 
 arch/x86/include/asm/percpu.h              |   41 --------------------
 include/asm-generic/percpu.h               |   58 -----------------------------
 include/linux/atomic/atomic-instrumented.h |   17 --------
 include/linux/percpu-defs.h                |   38 -------------------
 scripts/atomic/gen-atomic-instrumented.sh  |   15 ++-----
 15 files changed, 5 insertions(+), 370 deletions(-)

--- a/Documentation/core-api/this_cpu_ops.rst
+++ b/Documentation/core-api/this_cpu_ops.rst
@@ -53,7 +53,6 @@ are defined. These operations can be use
 	this_cpu_add_return(pcp, val)
 	this_cpu_xchg(pcp, nval)
 	this_cpu_cmpxchg(pcp, oval, nval)
-	this_cpu_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2)
 	this_cpu_sub(pcp, val)
 	this_cpu_inc(pcp)
 	this_cpu_dec(pcp)
@@ -242,7 +241,6 @@ modifies the variable, then RMW actions
 	__this_cpu_add_return(pcp, val)
 	__this_cpu_xchg(pcp, nval)
 	__this_cpu_cmpxchg(pcp, oval, nval)
-	__this_cpu_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2)
 	__this_cpu_sub(pcp, val)
 	__this_cpu_inc(pcp)
 	__this_cpu_dec(pcp)
--- a/arch/arm64/include/asm/atomic_ll_sc.h
+++ b/arch/arm64/include/asm/atomic_ll_sc.h
@@ -294,39 +294,6 @@ __CMPXCHG_CASE( ,  ,  mb_, 64, dmb ish,
 
 #undef __CMPXCHG_CASE
 
-#define __CMPXCHG_DBL(name, mb, rel, cl)				\
-static __always_inline long						\
-__ll_sc__cmpxchg_double##name(unsigned long old1,			\
-				      unsigned long old2,		\
-				      unsigned long new1,		\
-				      unsigned long new2,		\
-				      volatile void *ptr)		\
-{									\
-	unsigned long tmp, ret;						\
-									\
-	asm volatile("// __cmpxchg_double" #name "\n"			\
-	"	prfm	pstl1strm, %2\n"				\
-	"1:	ldxp	%0, %1, %2\n"					\
-	"	eor	%0, %0, %3\n"					\
-	"	eor	%1, %1, %4\n"					\
-	"	orr	%1, %0, %1\n"					\
-	"	cbnz	%1, 2f\n"					\
-	"	st" #rel "xp	%w0, %5, %6, %2\n"			\
-	"	cbnz	%w0, 1b\n"					\
-	"	" #mb "\n"						\
-	"2:"								\
-	: "=&r" (tmp), "=&r" (ret), "+Q" (*(__uint128_t *)ptr)		\
-	: "r" (old1), "r" (old2), "r" (new1), "r" (new2)		\
-	: cl);								\
-									\
-	return ret;							\
-}
-
-__CMPXCHG_DBL(   ,        ,  ,         )
-__CMPXCHG_DBL(_mb, dmb ish, l, "memory")
-
-#undef __CMPXCHG_DBL
-
 union __u128_halves {
 	u128 full;
 	struct {
--- a/arch/arm64/include/asm/atomic_lse.h
+++ b/arch/arm64/include/asm/atomic_lse.h
@@ -281,42 +281,6 @@ __CMPXCHG_CASE(x,  ,  mb_, 64, al, "memo
 
 #undef __CMPXCHG_CASE
 
-#define __CMPXCHG_DBL(name, mb, cl...)					\
-static __always_inline long						\
-__lse__cmpxchg_double##name(unsigned long old1,				\
-					 unsigned long old2,		\
-					 unsigned long new1,		\
-					 unsigned long new2,		\
-					 volatile void *ptr)		\
-{									\
-	unsigned long oldval1 = old1;					\
-	unsigned long oldval2 = old2;					\
-	register unsigned long x0 asm ("x0") = old1;			\
-	register unsigned long x1 asm ("x1") = old2;			\
-	register unsigned long x2 asm ("x2") = new1;			\
-	register unsigned long x3 asm ("x3") = new2;			\
-	register unsigned long x4 asm ("x4") = (unsigned long)ptr;	\
-									\
-	asm volatile(							\
-	__LSE_PREAMBLE							\
-	"	casp" #mb "\t%[old1], %[old2], %[new1], %[new2], %[v]\n"\
-	"	eor	%[old1], %[old1], %[oldval1]\n"			\
-	"	eor	%[old2], %[old2], %[oldval2]\n"			\
-	"	orr	%[old1], %[old1], %[old2]"			\
-	: [old1] "+&r" (x0), [old2] "+&r" (x1),				\
-	  [v] "+Q" (*(__uint128_t *)ptr)				\
-	: [new1] "r" (x2), [new2] "r" (x3), [ptr] "r" (x4),		\
-	  [oldval1] "r" (oldval1), [oldval2] "r" (oldval2)		\
-	: cl);								\
-									\
-	return x0;							\
-}
-
-__CMPXCHG_DBL(   ,   )
-__CMPXCHG_DBL(_mb, al, "memory")
-
-#undef __CMPXCHG_DBL
-
 #define __CMPXCHG128(name, mb, cl...)					\
 static __always_inline u128						\
 __lse__cmpxchg128##name(volatile u128 *ptr, u128 old, u128 new)		\
--- a/arch/arm64/include/asm/cmpxchg.h
+++ b/arch/arm64/include/asm/cmpxchg.h
@@ -130,22 +130,6 @@ __CMPXCHG_CASE(mb_, 64)
 
 #undef __CMPXCHG_CASE
 
-#define __CMPXCHG_DBL(name)						\
-static inline long __cmpxchg_double##name(unsigned long old1,		\
-					 unsigned long old2,		\
-					 unsigned long new1,		\
-					 unsigned long new2,		\
-					 volatile void *ptr)		\
-{									\
-	return __lse_ll_sc_body(_cmpxchg_double##name, 			\
-				old1, old2, new1, new2, ptr);		\
-}
-
-__CMPXCHG_DBL(   )
-__CMPXCHG_DBL(_mb)
-
-#undef __CMPXCHG_DBL
-
 #define __CMPXCHG128(name)						\
 static inline u128 __cmpxchg128##name(volatile u128 *ptr,		\
 				      u128 old, u128 new)		\
@@ -211,36 +195,6 @@ __CMPXCHG_GEN(_mb)
 #define arch_cmpxchg64			arch_cmpxchg
 #define arch_cmpxchg64_local		arch_cmpxchg_local
 
-/* cmpxchg_double */
-#define system_has_cmpxchg_double()     1
-
-#define __cmpxchg_double_check(ptr1, ptr2)					\
-({										\
-	if (sizeof(*(ptr1)) != 8)						\
-		BUILD_BUG();							\
-	VM_BUG_ON((unsigned long *)(ptr2) - (unsigned long *)(ptr1) != 1);	\
-})
-
-#define arch_cmpxchg_double(ptr1, ptr2, o1, o2, n1, n2)				\
-({										\
-	int __ret;								\
-	__cmpxchg_double_check(ptr1, ptr2);					\
-	__ret = !__cmpxchg_double_mb((unsigned long)(o1), (unsigned long)(o2),	\
-				     (unsigned long)(n1), (unsigned long)(n2),	\
-				     ptr1);					\
-	__ret;									\
-})
-
-#define arch_cmpxchg_double_local(ptr1, ptr2, o1, o2, n1, n2)			\
-({										\
-	int __ret;								\
-	__cmpxchg_double_check(ptr1, ptr2);					\
-	__ret = !__cmpxchg_double((unsigned long)(o1), (unsigned long)(o2),	\
-				  (unsigned long)(n1), (unsigned long)(n2),	\
-				  ptr1);					\
-	__ret;									\
-})
-
 /* cmpxchg128 */
 #define system_has_cmpxchg128()		1
 
--- a/arch/arm64/include/asm/percpu.h
+++ b/arch/arm64/include/asm/percpu.h
@@ -145,16 +145,6 @@ PERCPU_RET_OP(add, add, ldadd)
  * preemption point when TIF_NEED_RESCHED gets set while preemption is
  * disabled.
  */
-#define this_cpu_cmpxchg_double_8(ptr1, ptr2, o1, o2, n1, n2)		\
-({									\
-	int __ret;							\
-	preempt_disable_notrace();					\
-	__ret = cmpxchg_double_local(	raw_cpu_ptr(&(ptr1)),		\
-					raw_cpu_ptr(&(ptr2)),		\
-					o1, o2, n1, n2);		\
-	preempt_enable_notrace();					\
-	__ret;								\
-})
 
 #define _pcp_protect(op, pcp, ...)					\
 ({									\
--- a/arch/s390/include/asm/cmpxchg.h
+++ b/arch/s390/include/asm/cmpxchg.h
@@ -190,40 +190,6 @@ static __always_inline unsigned long __c
 #define arch_cmpxchg_local	arch_cmpxchg
 #define arch_cmpxchg64_local	arch_cmpxchg
 
-#define system_has_cmpxchg_double()	1
-
-static __always_inline int __cmpxchg_double(unsigned long p1, unsigned long p2,
-					    unsigned long o1, unsigned long o2,
-					    unsigned long n1, unsigned long n2)
-{
-	union register_pair old = { .even = o1, .odd = o2, };
-	union register_pair new = { .even = n1, .odd = n2, };
-	int cc;
-
-	asm volatile(
-		"	cdsg	%[old],%[new],%[ptr]\n"
-		"	ipm	%[cc]\n"
-		"	srl	%[cc],28\n"
-		: [cc] "=&d" (cc), [old] "+&d" (old.pair)
-		: [new] "d" (new.pair),
-		  [ptr] "QS" (*(unsigned long *)p1), "Q" (*(unsigned long *)p2)
-		: "memory", "cc");
-	return !cc;
-}
-
-#define arch_cmpxchg_double(p1, p2, o1, o2, n1, n2)			\
-({									\
-	typeof(p1) __p1 = (p1);						\
-	typeof(p2) __p2 = (p2);						\
-									\
-	BUILD_BUG_ON(sizeof(*(p1)) != sizeof(long));			\
-	BUILD_BUG_ON(sizeof(*(p2)) != sizeof(long));			\
-	VM_BUG_ON((unsigned long)((__p1) + 1) != (unsigned long)(__p2));\
-	__cmpxchg_double((unsigned long)__p1, (unsigned long)__p2,	\
-			 (unsigned long)(o1), (unsigned long)(o2),	\
-			 (unsigned long)(n1), (unsigned long)(n2));	\
-})
-
 #define system_has_cmpxchg128()		1
 
 static __always_inline u128 arch_cmpxchg128(volatile u128 *ptr, u128 old, u128 new)
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -180,24 +180,6 @@
 #define this_cpu_xchg_4(pcp, nval) arch_this_cpu_xchg(pcp, nval)
 #define this_cpu_xchg_8(pcp, nval) arch_this_cpu_xchg(pcp, nval)
 
-#define arch_this_cpu_cmpxchg_double(pcp1, pcp2, o1, o2, n1, n2)	    \
-({									    \
-	typeof(pcp1) *p1__;						    \
-	typeof(pcp2) *p2__;						    \
-	int ret__;							    \
-									    \
-	preempt_disable_notrace();					    \
-	p1__ = raw_cpu_ptr(&(pcp1));					    \
-	p2__ = raw_cpu_ptr(&(pcp2));					    \
-	ret__ = __cmpxchg_double((unsigned long)p1__, (unsigned long)p2__,  \
-				 (unsigned long)(o1), (unsigned long)(o2),  \
-				 (unsigned long)(n1), (unsigned long)(n2)); \
-	preempt_enable_notrace();					    \
-	ret__;								    \
-})
-
-#define this_cpu_cmpxchg_double_8 arch_this_cpu_cmpxchg_double
-
 #include <asm-generic/percpu.h>
 
 #endif /* __ARCH_S390_PERCPU__ */
--- a/arch/x86/include/asm/cmpxchg.h
+++ b/arch/x86/include/asm/cmpxchg.h
@@ -239,29 +239,4 @@ extern void __add_wrong_size(void)
 #define __xadd(ptr, inc, lock)	__xchg_op((ptr), (inc), xadd, lock)
 #define xadd(ptr, inc)		__xadd((ptr), (inc), LOCK_PREFIX)
 
-#define __cmpxchg_double(pfx, p1, p2, o1, o2, n1, n2)			\
-({									\
-	bool __ret;							\
-	__typeof__(*(p1)) __old1 = (o1), __new1 = (n1);			\
-	__typeof__(*(p2)) __old2 = (o2), __new2 = (n2);			\
-	BUILD_BUG_ON(sizeof(*(p1)) != sizeof(long));			\
-	BUILD_BUG_ON(sizeof(*(p2)) != sizeof(long));			\
-	VM_BUG_ON((unsigned long)(p1) % (2 * sizeof(long)));		\
-	VM_BUG_ON((unsigned long)((p1) + 1) != (unsigned long)(p2));	\
-	asm volatile(pfx "cmpxchg%c5b %1"				\
-		     CC_SET(e)						\
-		     : CC_OUT(e) (__ret),				\
-		       "+m" (*(p1)), "+m" (*(p2)),			\
-		       "+a" (__old1), "+d" (__old2)			\
-		     : "i" (2 * sizeof(long)),				\
-		       "b" (__new1), "c" (__new2));			\
-	__ret;								\
-})
-
-#define arch_cmpxchg_double(p1, p2, o1, o2, n1, n2) \
-	__cmpxchg_double(LOCK_PREFIX, p1, p2, o1, o2, n1, n2)
-
-#define arch_cmpxchg_double_local(p1, p2, o1, o2, n1, n2) \
-	__cmpxchg_double(, p1, p2, o1, o2, n1, n2)
-
 #endif	/* ASM_X86_CMPXCHG_H */
--- a/arch/x86/include/asm/cmpxchg_32.h
+++ b/arch/x86/include/asm/cmpxchg_32.h
@@ -103,7 +103,6 @@ static inline bool __try_cmpxchg64(volat
 
 #endif
 
-#define system_has_cmpxchg_double()	boot_cpu_has(X86_FEATURE_CX8)
 #define system_has_cmpxchg64()		boot_cpu_has(X86_FEATURE_CX8)
 
 #endif /* _ASM_X86_CMPXCHG_32_H */
--- a/arch/x86/include/asm/cmpxchg_64.h
+++ b/arch/x86/include/asm/cmpxchg_64.h
@@ -81,7 +81,6 @@ static __always_inline bool arch_try_cmp
 	return __arch_try_cmpxchg128(ptr, oldp, new,);
 }
 
-#define system_has_cmpxchg_double()	boot_cpu_has(X86_FEATURE_CX16)
 #define system_has_cmpxchg128()		boot_cpu_has(X86_FEATURE_CX16)
 
 #endif /* _ASM_X86_CMPXCHG_64_H */
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -349,23 +349,6 @@ do {									\
 #define this_cpu_cmpxchg_2(pcp, oval, nval)	percpu_cmpxchg_op(2, volatile, pcp, oval, nval)
 #define this_cpu_cmpxchg_4(pcp, oval, nval)	percpu_cmpxchg_op(4, volatile, pcp, oval, nval)
 
-#ifdef CONFIG_X86_CMPXCHG64
-#define percpu_cmpxchg8b_double(pcp1, pcp2, o1, o2, n1, n2)		\
-({									\
-	bool __ret;							\
-	typeof(pcp1) __o1 = (o1), __n1 = (n1);				\
-	typeof(pcp2) __o2 = (o2), __n2 = (n2);				\
-	asm volatile("cmpxchg8b "__percpu_arg(1)			\
-		     CC_SET(z)						\
-		     : CC_OUT(z) (__ret), "+m" (pcp1), "+m" (pcp2), "+a" (__o1), "+d" (__o2) \
-		     : "b" (__n1), "c" (__n2));				\
-	__ret;								\
-})
-
-#define raw_cpu_cmpxchg_double_4	percpu_cmpxchg8b_double
-#define this_cpu_cmpxchg_double_4	percpu_cmpxchg8b_double
-#endif /* CONFIG_X86_CMPXCHG64 */
-
 /*
  * Per cpu atomic 64 bit operations are only available under 64 bit.
  * 32 bit must fall back to generic operations.
@@ -388,30 +371,6 @@ do {									\
 #define this_cpu_add_return_8(pcp, val)		percpu_add_return_op(8, volatile, pcp, val)
 #define this_cpu_xchg_8(pcp, nval)		percpu_xchg_op(8, volatile, pcp, nval)
 #define this_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(8, volatile, pcp, oval, nval)
-
-/*
- * Pretty complex macro to generate cmpxchg16 instruction.  The instruction
- * is not supported on early AMD64 processors so we must be able to emulate
- * it in software.  The address used in the cmpxchg16 instruction must be
- * aligned to a 16 byte boundary.
- */
-#define percpu_cmpxchg16b_double(pcp1, pcp2, o1, o2, n1, n2)		\
-({									\
-	bool __ret;							\
-	typeof(pcp1) __o1 = (o1), __n1 = (n1);				\
-	typeof(pcp2) __o2 = (o2), __n2 = (n2);				\
-	alternative_io("leaq %P1,%%rsi\n\tcall this_cpu_cmpxchg16b_emu\n\t", \
-		       "cmpxchg16b " __percpu_arg(1) "\n\tsetz %0\n\t",	\
-		       X86_FEATURE_CX16,				\
-		       ASM_OUTPUT2("=a" (__ret), "+m" (pcp1),		\
-				   "+m" (pcp2), "+d" (__o2)),		\
-		       "b" (__n1), "c" (__n2), "a" (__o1) : "rsi");	\
-	__ret;								\
-})
-
-#define raw_cpu_cmpxchg_double_8	percpu_cmpxchg16b_double
-#define this_cpu_cmpxchg_double_8	percpu_cmpxchg16b_double
-
 #endif
 
 static __always_inline bool x86_this_cpu_constant_test_bit(unsigned int nr,
--- a/include/asm-generic/percpu.h
+++ b/include/asm-generic/percpu.h
@@ -99,19 +99,6 @@ do {									\
 	__ret;								\
 })
 
-#define raw_cpu_generic_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2) \
-({									\
-	typeof(pcp1) *__p1 = raw_cpu_ptr(&(pcp1));			\
-	typeof(pcp2) *__p2 = raw_cpu_ptr(&(pcp2));			\
-	int __ret = 0;							\
-	if (*__p1 == (oval1) && *__p2  == (oval2)) {			\
-		*__p1 = nval1;						\
-		*__p2 = nval2;						\
-		__ret = 1;						\
-	}								\
-	(__ret);							\
-})
-
 #define __this_cpu_generic_read_nopreempt(pcp)				\
 ({									\
 	typeof(pcp) ___ret;						\
@@ -180,17 +167,6 @@ do {									\
 	__ret;								\
 })
 
-#define this_cpu_generic_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2)	\
-({									\
-	int __ret;							\
-	unsigned long __flags;						\
-	raw_local_irq_save(__flags);					\
-	__ret = raw_cpu_generic_cmpxchg_double(pcp1, pcp2,		\
-			oval1, oval2, nval1, nval2);			\
-	raw_local_irq_restore(__flags);					\
-	__ret;								\
-})
-
 #ifndef raw_cpu_read_1
 #define raw_cpu_read_1(pcp)		raw_cpu_generic_read(pcp)
 #endif
@@ -307,23 +283,6 @@ do {									\
 	raw_cpu_generic_cmpxchg(pcp, oval, nval)
 #endif
 
-#ifndef raw_cpu_cmpxchg_double_1
-#define raw_cpu_cmpxchg_double_1(pcp1, pcp2, oval1, oval2, nval1, nval2) \
-	raw_cpu_generic_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2)
-#endif
-#ifndef raw_cpu_cmpxchg_double_2
-#define raw_cpu_cmpxchg_double_2(pcp1, pcp2, oval1, oval2, nval1, nval2) \
-	raw_cpu_generic_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2)
-#endif
-#ifndef raw_cpu_cmpxchg_double_4
-#define raw_cpu_cmpxchg_double_4(pcp1, pcp2, oval1, oval2, nval1, nval2) \
-	raw_cpu_generic_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2)
-#endif
-#ifndef raw_cpu_cmpxchg_double_8
-#define raw_cpu_cmpxchg_double_8(pcp1, pcp2, oval1, oval2, nval1, nval2) \
-	raw_cpu_generic_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2)
-#endif
-
 #ifndef this_cpu_read_1
 #define this_cpu_read_1(pcp)		this_cpu_generic_read(pcp)
 #endif
@@ -440,21 +399,4 @@ do {									\
 	this_cpu_generic_cmpxchg(pcp, oval, nval)
 #endif
 
-#ifndef this_cpu_cmpxchg_double_1
-#define this_cpu_cmpxchg_double_1(pcp1, pcp2, oval1, oval2, nval1, nval2) \
-	this_cpu_generic_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2)
-#endif
-#ifndef this_cpu_cmpxchg_double_2
-#define this_cpu_cmpxchg_double_2(pcp1, pcp2, oval1, oval2, nval1, nval2) \
-	this_cpu_generic_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2)
-#endif
-#ifndef this_cpu_cmpxchg_double_4
-#define this_cpu_cmpxchg_double_4(pcp1, pcp2, oval1, oval2, nval1, nval2) \
-	this_cpu_generic_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2)
-#endif
-#ifndef this_cpu_cmpxchg_double_8
-#define this_cpu_cmpxchg_double_8(pcp1, pcp2, oval1, oval2, nval1, nval2) \
-	this_cpu_generic_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2)
-#endif
-
 #endif /* _ASM_GENERIC_PERCPU_H_ */
--- a/include/linux/atomic/atomic-instrumented.h
+++ b/include/linux/atomic/atomic-instrumented.h
@@ -2234,21 +2234,6 @@ atomic_long_dec_if_positive(atomic_long_
 	arch_try_cmpxchg128_local(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
 
-#define cmpxchg_double(ptr, ...) \
-({ \
-	typeof(ptr) __ai_ptr = (ptr); \
-	kcsan_mb(); \
-	instrument_atomic_read_write(__ai_ptr, 2 * sizeof(*__ai_ptr)); \
-	arch_cmpxchg_double(__ai_ptr, __VA_ARGS__); \
-})
-
-
-#define cmpxchg_double_local(ptr, ...) \
-({ \
-	typeof(ptr) __ai_ptr = (ptr); \
-	instrument_atomic_read_write(__ai_ptr, 2 * sizeof(*__ai_ptr)); \
-	arch_cmpxchg_double_local(__ai_ptr, __VA_ARGS__); \
-})
 
 #endif /* _LINUX_ATOMIC_INSTRUMENTED_H */
-// 82d1be694fab30414527d0877c29fa75ed5a0b74
+// 3611991b015450e119bcd7417a9431af7f3ba13c
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -343,33 +343,6 @@ static __always_inline void __this_cpu_p
 	pscr2_ret__;							\
 })
 
-/*
- * Special handling for cmpxchg_double.  cmpxchg_double is passed two
- * percpu variables.  The first has to be aligned to a double word
- * boundary and the second has to follow directly thereafter.
- * We enforce this on all architectures even if they don't support
- * a double cmpxchg instruction, since it's a cheap requirement, and it
- * avoids breaking the requirement for architectures with the instruction.
- */
-#define __pcpu_double_call_return_bool(stem, pcp1, pcp2, ...)		\
-({									\
-	bool pdcrb_ret__;						\
-	__verify_pcpu_ptr(&(pcp1));					\
-	BUILD_BUG_ON(sizeof(pcp1) != sizeof(pcp2));			\
-	VM_BUG_ON((unsigned long)(&(pcp1)) % (2 * sizeof(pcp1)));	\
-	VM_BUG_ON((unsigned long)(&(pcp2)) !=				\
-		  (unsigned long)(&(pcp1)) + sizeof(pcp1));		\
-	switch(sizeof(pcp1)) {						\
-	case 1: pdcrb_ret__ = stem##1(pcp1, pcp2, __VA_ARGS__); break;	\
-	case 2: pdcrb_ret__ = stem##2(pcp1, pcp2, __VA_ARGS__); break;	\
-	case 4: pdcrb_ret__ = stem##4(pcp1, pcp2, __VA_ARGS__); break;	\
-	case 8: pdcrb_ret__ = stem##8(pcp1, pcp2, __VA_ARGS__); break;	\
-	default:							\
-		__bad_size_call_parameter(); break;			\
-	}								\
-	pdcrb_ret__;							\
-})
-
 #define __pcpu_size_call(stem, variable, ...)				\
 do {									\
 	__verify_pcpu_ptr(&(variable));					\
@@ -426,9 +399,6 @@ do {									\
 #define raw_cpu_xchg(pcp, nval)		__pcpu_size_call_return2(raw_cpu_xchg_, pcp, nval)
 #define raw_cpu_cmpxchg(pcp, oval, nval) \
 	__pcpu_size_call_return2(raw_cpu_cmpxchg_, pcp, oval, nval)
-#define raw_cpu_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2) \
-	__pcpu_double_call_return_bool(raw_cpu_cmpxchg_double_, pcp1, pcp2, oval1, oval2, nval1, nval2)
-
 #define raw_cpu_sub(pcp, val)		raw_cpu_add(pcp, -(val))
 #define raw_cpu_inc(pcp)		raw_cpu_add(pcp, 1)
 #define raw_cpu_dec(pcp)		raw_cpu_sub(pcp, 1)
@@ -488,11 +458,6 @@ do {									\
 	raw_cpu_cmpxchg(pcp, oval, nval);				\
 })
 
-#define __this_cpu_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2) \
-({	__this_cpu_preempt_check("cmpxchg_double");			\
-	raw_cpu_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2);	\
-})
-
 #define __this_cpu_sub(pcp, val)	__this_cpu_add(pcp, -(typeof(pcp))(val))
 #define __this_cpu_inc(pcp)		__this_cpu_add(pcp, 1)
 #define __this_cpu_dec(pcp)		__this_cpu_sub(pcp, 1)
@@ -513,9 +478,6 @@ do {									\
 #define this_cpu_xchg(pcp, nval)	__pcpu_size_call_return2(this_cpu_xchg_, pcp, nval)
 #define this_cpu_cmpxchg(pcp, oval, nval) \
 	__pcpu_size_call_return2(this_cpu_cmpxchg_, pcp, oval, nval)
-#define this_cpu_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2) \
-	__pcpu_double_call_return_bool(this_cpu_cmpxchg_double_, pcp1, pcp2, oval1, oval2, nval1, nval2)
-
 #define this_cpu_sub(pcp, val)		this_cpu_add(pcp, -(typeof(pcp))(val))
 #define this_cpu_inc(pcp)		this_cpu_add(pcp, 1)
 #define this_cpu_dec(pcp)		this_cpu_sub(pcp, 1)
--- a/scripts/atomic/gen-atomic-instrumented.sh
+++ b/scripts/atomic/gen-atomic-instrumented.sh
@@ -84,7 +84,6 @@ gen_xchg()
 {
 	local xchg="$1"; shift
 	local order="$1"; shift
-	local mult="$1"; shift
 
 	kcsan_barrier=""
 	if [ "${xchg%_local}" = "${xchg}" ]; then
@@ -104,8 +103,8 @@ cat <<EOF
 EOF
 [ -n "$kcsan_barrier" ] && printf "\t${kcsan_barrier}; \\\\\n"
 cat <<EOF
-	instrument_atomic_read_write(__ai_ptr, ${mult}sizeof(*__ai_ptr)); \\
-	instrument_read_write(__ai_oldp, ${mult}sizeof(*__ai_oldp)); \\
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \\
+	instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \\
 	arch_${xchg}${order}(__ai_ptr, __ai_oldp, __VA_ARGS__); \\
 })
 EOF
@@ -168,22 +167,16 @@ done
 
 for xchg in "xchg" "cmpxchg" "cmpxchg64" "cmpxchg128" "try_cmpxchg" "try_cmpxchg64" "try_cmpxchg128"; do
 	for order in "" "_acquire" "_release" "_relaxed"; do
-		gen_xchg "${xchg}" "${order}" ""
+		gen_xchg "${xchg}" "${order}"
 		printf "\n"
 	done
 done
 
 for xchg in "cmpxchg_local" "cmpxchg64_local" "cmpxchg128_local" "sync_cmpxchg" "try_cmpxchg_local" "try_cmpxchg64_local" "try_cmpxchg128_local"; do
-	gen_xchg "${xchg}" "" ""
+	gen_xchg "${xchg}" ""
 	printf "\n"
 done
 
-gen_xchg "cmpxchg_double" "" "2 * "
-
-printf "\n\n"
-
-gen_xchg "cmpxchg_double_local" "" "2 * "
-
 cat <<EOF
 
 #endif /* _LINUX_ATOMIC_INSTRUMENTED_H */


