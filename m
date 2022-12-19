Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5176650F21
	for <lists+linux-arch@lfdr.de>; Mon, 19 Dec 2022 16:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbiLSPqL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Dec 2022 10:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbiLSPpd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Dec 2022 10:45:33 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BABF12AC3;
        Mon, 19 Dec 2022 07:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=QJ923ExDj0XcuShmfE67Q3JbXhYYvsBZdme4aHvNZqo=; b=L1IW8vYeBrUO/INAKwHRRlhJVX
        i/vG9qTUNs+oa6cLvr2/Xu8n10441UAqstaULlYbvtYtvBB8LKp5je0sNowRdtYNbuOsLa4LKS3CY
        ehyeCPRWtvV4hGe0ZB3g6kR8E71kEvMsxxMtQrGDHXor+ViJ0P/iVOtCKziKJj7Si1SEXl6vlANmB
        yYWIS8cHYYC4BX1p6xQ5JmaJ/1KWfoI/zkCuJdzbYjW06InrNLxk+2aKKyhk5GG61r78NF3XKBgq1
        pHVhdDp4lqC8zzJrPRgm38RR7St7UYIkuWJmN6/KKJLCp+ZckgxoC6jHXr9M2Ub80pLF+e7+CCCy0
        TLS8Y1ow==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1p7IIJ-00CeDr-0Z;
        Mon, 19 Dec 2022 15:43:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0DCF930325C;
        Mon, 19 Dec 2022 16:43:10 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7679B20B0F89C; Mon, 19 Dec 2022 16:43:06 +0100 (CET)
Message-ID: <20221219154119.154045458@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 19 Dec 2022 16:35:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org
Cc:     corbet@lwn.net, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, mark.rutland@arm.com,
        catalin.marinas@arm.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, Herbert Xu <herbert@gondor.apana.org.au>,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, joro@8bytes.org, suravee.suthikulpanit@amd.com,
        robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org
Subject: [RFC][PATCH 05/12] arch: Introduce arch_{,try_}_cmpxchg128{,_local}()
References: <20221219153525.632521981@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

For all architectures that currently support cmpxchg_double()
implement the cmpxchg128() family of functions that is basically the
same but with a saner interface.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm64/include/asm/atomic_ll_sc.h |   38 +++++++++++++++++++++++
 arch/arm64/include/asm/atomic_lse.h   |   33 +++++++++++++++++++-
 arch/arm64/include/asm/cmpxchg.h      |   26 ++++++++++++++++
 arch/s390/include/asm/cmpxchg.h       |   33 ++++++++++++++++++++
 arch/x86/include/asm/cmpxchg_32.h     |    3 +
 arch/x86/include/asm/cmpxchg_64.h     |   55 +++++++++++++++++++++++++++++++++-
 6 files changed, 185 insertions(+), 3 deletions(-)

--- a/arch/arm64/include/asm/atomic_ll_sc.h
+++ b/arch/arm64/include/asm/atomic_ll_sc.h
@@ -326,6 +326,44 @@ __CMPXCHG_DBL(   ,        ,  ,         )
 __CMPXCHG_DBL(_mb, dmb ish, l, "memory")
 
 #undef __CMPXCHG_DBL
+
+union __u128_halves {
+	u128 full;
+	struct {
+		u64 low, high;
+	};
+};
+
+#define __CMPXCHG128(name, mb, rel, cl)					\
+static __always_inline u128						\
+__ll_sc__cmpxchg128##name(volatile u128 *ptr, u128 old, u128 new)	\
+{									\
+	union __u128_halves r, o = { .full = (old) },			\
+			       n = { .full = (new) };			\
+									\
+	asm volatile("// __cmpxchg128" #name "\n"			\
+	"	prfm	pstl1strm, %2\n"				\
+	"1:	ldxp	%0, %1, %2\n"					\
+	"	eor	%3, %0, %3\n"					\
+	"	eor	%4, %1, %4\n"					\
+	"	orr	%3, %4, %3\n"					\
+	"	cbnz	%3, 2f\n"					\
+	"	st" #rel "xp	%w3, %5, %6, %2\n"			\
+	"	cbnz	%w3, 1b\n"					\
+	"	" #mb "\n"						\
+	"2:"								\
+	: "=&r" (r.low), "=&r" (r.high), "+Q" (*(unsigned long *)ptr)	\
+	: "r" (o.low), "r" (o.high), "r" (n.low), "r" (n.high)		\
+	: cl);								\
+									\
+	return r.full;							\
+}
+
+__CMPXCHG128(   ,        ,  ,         )
+__CMPXCHG128(_mb, dmb ish, l, "memory")
+
+#undef __CMPXCHG128
+
 #undef K
 
 #endif	/* __ASM_ATOMIC_LL_SC_H */
--- a/arch/arm64/include/asm/atomic_lse.h
+++ b/arch/arm64/include/asm/atomic_lse.h
@@ -151,7 +151,7 @@ __lse_atomic64_fetch_##op##name(s64 i, a
 	"	" #asm_op #mb "	%[i], %[old], %[v]"			\
 	: [v] "+Q" (v->counter),					\
 	  [old] "=r" (old)						\
-	: [i] "r" (i) 							\
+	: [i] "r" (i)							\
 	: cl);								\
 									\
 	return old;							\
@@ -324,4 +324,35 @@ __CMPXCHG_DBL(_mb, al, "memory")
 
 #undef __CMPXCHG_DBL
 
+#define __CMPXCHG128(name, mb, cl...)					\
+static __always_inline u128						\
+__lse__cmpxchg128##name(volatile u128 *ptr, u128 old, u128 new)		\
+{									\
+	union __u128_halves r, o = { .full = (old) },			\
+			       n = { .full = (new) };			\
+	register unsigned long x0 asm ("x0") = o.low;			\
+	register unsigned long x1 asm ("x1") = o.high;			\
+	register unsigned long x2 asm ("x2") = n.low;			\
+	register unsigned long x3 asm ("x3") = n.high;			\
+	register unsigned long x4 asm ("x4") = (unsigned long)ptr;	\
+									\
+	asm volatile(							\
+	__LSE_PREAMBLE							\
+	"	casp" #mb "\t%[old1], %[old2], %[new1], %[new2], %[v]\n"\
+	: [old1] "+&r" (x0), [old2] "+&r" (x1),				\
+	  [v] "+Q" (*(unsigned long *)ptr)				\
+	: [new1] "r" (x2), [new2] "r" (x3), [ptr] "r" (x4),		\
+	  [oldval1] "r" (r.low), [oldval2] "r" (r.high)			\
+	: cl);								\
+									\
+	r.low = x0; r.high = x1;					\
+									\
+	return r.full;							\
+}
+
+__CMPXCHG128(   ,   )
+__CMPXCHG128(_mb, al, "memory")
+
+#undef __CMPXCHG128
+
 #endif	/* __ASM_ATOMIC_LSE_H */
--- a/arch/arm64/include/asm/cmpxchg.h
+++ b/arch/arm64/include/asm/cmpxchg.h
@@ -147,6 +147,19 @@ __CMPXCHG_DBL(_mb)
 
 #undef __CMPXCHG_DBL
 
+#define __CMPXCHG128(name)						\
+static inline long __cmpxchg128##name(volatile u128 *ptr,		\
+				      u128 old, u128 new)		\
+{									\
+	return __lse_ll_sc_body(_cmpxchg128##name,			\
+				ptr, old, new);				\
+}
+
+__CMPXCHG128(   )
+__CMPXCHG128(_mb)
+
+#undef __CMPXCHG128
+
 #define __CMPXCHG_GEN(sfx)						\
 static __always_inline unsigned long __cmpxchg##sfx(volatile void *ptr,	\
 					   unsigned long old,		\
@@ -229,6 +242,19 @@ __CMPXCHG_GEN(_mb)
 	__ret;									\
 })
 
+/* cmpxchg128 */
+#define system_has_cmpxchg128()		1
+
+#define arch_cmpxchg128(ptr, o, n)						\
+({										\
+	__cmpxchg128_mb((ptr), (o), (n));					\
+})
+
+#define arch_cmpxchg128_local(ptr, o, n)					\
+({										\
+	__cmpxchg128((ptr), (o), (n));						\
+})
+
 #define __CMPWAIT_CASE(w, sfx, sz)					\
 static inline void __cmpwait_case_##sz(volatile void *ptr,		\
 				       unsigned long val)		\
--- a/arch/s390/include/asm/cmpxchg.h
+++ b/arch/s390/include/asm/cmpxchg.h
@@ -201,4 +201,37 @@ static __always_inline int __cmpxchg_dou
 			 (unsigned long)(n1), (unsigned long)(n2));	\
 })
 
+#define system_has_cmpxchg128()		1
+
+static __always_inline u128 arch_cmpxchg128(volatile u128 *ptr, u128 old, u128 new)
+{
+	asm volatile(
+		"	cdsg	%[old],%[new],%[ptr]\n"
+		: [old] "+&d" (old)
+		: [new] "d" (new),
+		  [ptr] "QS" (*(unsigned long *)ptr)
+		: "memory", "cc");
+	return old;
+}
+
+static __always_inline bool arch_try_cmpxchg128(volatile u128 *ptr, u128 *oldp, u128 new)
+{
+	u128 old = *oldp;
+	int cc;
+
+	asm volatile(
+		"	cdsg	%[old],%[new],%[ptr]\n"
+		"	ipm	%[cc]\n"
+		"	srl	%[cc],28\n"
+		: [cc] "=&d" (cc), [old] "+&d" (old)
+		: [new] "d" (new),
+		  [ptr] "QS" (*(unsigned long *)ptr)
+		: "memory", "cc");
+
+	if (unlikely(!cc))
+		*oldp = old;
+
+	return likely(cc);
+}
+
 #endif /* __ASM_CMPXCHG_H */
--- a/arch/x86/include/asm/cmpxchg_32.h
+++ b/arch/x86/include/asm/cmpxchg_32.h
@@ -103,6 +103,7 @@ static inline bool __try_cmpxchg64(volat
 
 #endif
 
-#define system_has_cmpxchg_double() boot_cpu_has(X86_FEATURE_CX8)
+#define system_has_cmpxchg_double()	boot_cpu_has(X86_FEATURE_CX8)
+#define system_has_cmpxchg64()		boot_cpu_has(X86_FEATURE_CX8)
 
 #endif /* _ASM_X86_CMPXCHG_32_H */
--- a/arch/x86/include/asm/cmpxchg_64.h
+++ b/arch/x86/include/asm/cmpxchg_64.h
@@ -20,6 +20,59 @@
 	arch_try_cmpxchg((ptr), (po), (n));				\
 })
 
-#define system_has_cmpxchg_double() boot_cpu_has(X86_FEATURE_CX16)
+union __u128_halves {
+	u128 full;
+	struct {
+		u64 low, high;
+	};
+};
+
+static __always_inline u128 arch_cmpxchg128(volatile u128 *ptr, u128 old, u128 new)
+{
+	union __u128_halves o = { .full = old, }, n = { .full = new, };
+
+	asm volatile(LOCK_PREFIX "cmpxchg16b %[ptr]"
+		     : [ptr] "+m" (*ptr),
+		       "+a" (o.low), "+d" (o.high)
+		     : "b" (n.low), "c" (n.high)
+		     : "memory");
+
+	return o.full;
+}
+
+static __always_inline u128 arch_cmpxchg128_local(volatile u128 *ptr, u128 old, u128 new)
+{
+	union __u128_halves o = { .full = old, }, n = { .full = new, };
+
+	asm volatile("cmpxchg16b %[ptr]"
+		     : [ptr] "+m" (*ptr),
+		       "+a" (o.low), "+d" (o.high)
+		     : "b" (n.low), "c" (n.high)
+		     : "memory");
+
+	return o.full;
+}
+
+static __always_inline bool arch_try_cmpxchg128(volatile u128 *ptr, u128 *old, u128 new)
+{
+	union __u128_halves o = { .full = *old, }, n = { .full = new, };
+	bool ret;
+
+	asm volatile(LOCK_PREFIX "cmpxchg16b %[ptr]"
+		     CC_SET(e)
+		     : CC_OUT(e) (ret),
+		       [ptr] "+m" (*ptr),
+		       "+a" (o.low), "+d" (o.high)
+		     : "b" (n.low), "c" (n.high)
+		     : "memory");
+
+	if (unlikely(!ret))
+		*old = o.full;
+
+	return likely(ret);
+}
+
+#define system_has_cmpxchg_double()	boot_cpu_has(X86_FEATURE_CX16)
+#define system_has_cmpxchg128()		boot_cpu_has(X86_FEATURE_CX16)
 
 #endif /* _ASM_X86_CMPXCHG_64_H */


