Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276B07181B0
	for <lists+linux-arch@lfdr.de>; Wed, 31 May 2023 15:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236433AbjEaN20 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 May 2023 09:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236330AbjEaN2V (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 May 2023 09:28:21 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760A612E;
        Wed, 31 May 2023 06:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=iOoLCL15Lkqusyj683d7QtsgXbn6vbNrDVP1qYk8vVg=; b=Q+4qUo/0gXEAXjPbpQyNIIqvEh
        kjEGNk0ljWZ9MChbj8TcT5wWJlI7fyolz8aXLp7afGfbtmKvuh5texHuol2FFPc/BFLMIGaaXVNYz
        n0EkQ+NXc8ix3CcraX2ZQxht3IbiyDSMoaaq+Qqm5a/EG/DDCNhXI73AgUJK3I4daoxH+dJBjWHyz
        eM9YvNvDd8eszZB1eMcUPBXuLuZLs1Zkp/PEFE3wYw/UvZpvTaa1O6ftlpoSXG4GLAv3P+xSm2e0j
        Pp8sfVF7Z5X/h6J93s1K8E6FQQ14zcNfW0R1yKU5I/1qxkQ2WBcdqjbPSucwee3zzwS6V/rIDS6Im
        DJYU1zvA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4LrF-00FTCX-2N;
        Wed, 31 May 2023 13:27:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F0CD03003E1;
        Wed, 31 May 2023 15:27:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 83785243B69E8; Wed, 31 May 2023 15:27:16 +0200 (CEST)
Message-ID: <20230531132323.452120708@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 31 May 2023 15:08:36 +0200
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
        linux-crypto@vger.kernel.org, sfr@canb.auug.org.au,
        mpe@ellerman.id.au, James.Bottomley@hansenpartnership.com,
        deller@gmx.de, linux-parisc@vger.kernel.org
Subject: [PATCH 03/12] arch: Introduce arch_{,try_}_cmpxchg128{,_local}()
References: <20230531130833.635651916@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

For all architectures that currently support cmpxchg_double()
implement the cmpxchg128() family of functions that is basically the
same but with a saner interface.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/atomic_ll_sc.h |   41 +++++++++++++++++++++
 arch/arm64/include/asm/atomic_lse.h   |   31 ++++++++++++++++
 arch/arm64/include/asm/cmpxchg.h      |   26 +++++++++++++
 arch/s390/include/asm/cmpxchg.h       |   14 +++++++
 arch/x86/include/asm/cmpxchg_32.h     |    3 +
 arch/x86/include/asm/cmpxchg_64.h     |   64 +++++++++++++++++++++++++++++++++-
 6 files changed, 177 insertions(+), 2 deletions(-)

--- a/arch/arm64/include/asm/atomic_ll_sc.h
+++ b/arch/arm64/include/asm/atomic_ll_sc.h
@@ -326,6 +326,47 @@ __CMPXCHG_DBL(   ,        ,  ,         )
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
+#define __CMPXCHG128(name, mb, rel, cl...)                             \
+static __always_inline u128						\
+__ll_sc__cmpxchg128##name(volatile u128 *ptr, u128 old, u128 new)	\
+{									\
+	union __u128_halves r, o = { .full = (old) },			\
+			       n = { .full = (new) };			\
+       unsigned int tmp;                                               \
+									\
+	asm volatile("// __cmpxchg128" #name "\n"			\
+       "       prfm    pstl1strm, %[v]\n"                              \
+       "1:     ldxp    %[rl], %[rh], %[v]\n"                           \
+       "       cmp     %[rl], %[ol]\n"                                 \
+       "       ccmp    %[rh], %[oh], 0, eq\n"                          \
+       "       b.ne    2f\n"                                           \
+       "       st" #rel "xp    %w[tmp], %[nl], %[nh], %[v]\n"          \
+       "       cbnz    %w[tmp], 1b\n"                                  \
+	"	" #mb "\n"						\
+	"2:"								\
+       : [v] "+Q" (*(u128 *)ptr),                                      \
+         [rl] "=&r" (r.low), [rh] "=&r" (r.high),                      \
+         [tmp] "=&r" (tmp)                                             \
+       : [ol] "r" (o.low), [oh] "r" (o.high),                          \
+         [nl] "r" (n.low), [nh] "r" (n.high)                           \
+       : "cc", ##cl);                                                  \
+									\
+	return r.full;							\
+}
+
+__CMPXCHG128(   ,        ,  )
+__CMPXCHG128(_mb, dmb ish, l, "memory")
+
+#undef __CMPXCHG128
+
 #undef K
 
 #endif	/* __ASM_ATOMIC_LL_SC_H */
--- a/arch/arm64/include/asm/atomic_lse.h
+++ b/arch/arm64/include/asm/atomic_lse.h
@@ -317,4 +317,35 @@ __CMPXCHG_DBL(_mb, al, "memory")
 
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
+	  [v] "+Q" (*(u128 *)ptr)					\
+	: [new1] "r" (x2), [new2] "r" (x3), [ptr] "r" (x4),		\
+	  [oldval1] "r" (o.low), [oldval2] "r" (o.high)			\
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
@@ -146,6 +146,19 @@ __CMPXCHG_DBL(_mb)
 
 #undef __CMPXCHG_DBL
 
+#define __CMPXCHG128(name)						\
+static inline u128 __cmpxchg128##name(volatile u128 *ptr,		\
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
@@ -228,6 +241,19 @@ __CMPXCHG_GEN(_mb)
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
@@ -224,4 +224,18 @@ static __always_inline int __cmpxchg_dou
 			 (unsigned long)(n1), (unsigned long)(n2));	\
 })
 
+#define system_has_cmpxchg128()		1
+
+static __always_inline u128 arch_cmpxchg128(volatile u128 *ptr, u128 old, u128 new)
+{
+	asm volatile(
+		"	cdsg	%[old],%[new],%[ptr]\n"
+		: [old] "+d" (old), [ptr] "+QS" (*ptr)
+		: [new] "d" (new)
+		: "memory", "cc");
+	return old;
+}
+
+#define arch_cmpxchg128		arch_cmpxchg128
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
@@ -20,6 +20,68 @@
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
+#define __arch_cmpxchg128(_ptr, _old, _new, _lock)			\
+({									\
+	union __u128_halves o = { .full = (_old), },			\
+			    n = { .full = (_new), };			\
+									\
+	asm volatile(_lock "cmpxchg16b %[ptr]"				\
+		     : [ptr] "+m" (*(_ptr)),				\
+		       "+a" (o.low), "+d" (o.high)			\
+		     : "b" (n.low), "c" (n.high)			\
+		     : "memory");					\
+									\
+	o.full;								\
+})
+
+static __always_inline u128 arch_cmpxchg128(volatile u128 *ptr, u128 old, u128 new)
+{
+	return __arch_cmpxchg128(ptr, old, new, LOCK_PREFIX);
+}
+
+static __always_inline u128 arch_cmpxchg128_local(volatile u128 *ptr, u128 old, u128 new)
+{
+	return __arch_cmpxchg128(ptr, old, new,);
+}
+
+#define __arch_try_cmpxchg128(_ptr, _oldp, _new, _lock)			\
+({									\
+	union __u128_halves o = { .full = *(_oldp), },			\
+			    n = { .full = (_new), };			\
+	bool ret;							\
+									\
+	asm volatile(_lock "cmpxchg16b %[ptr]"				\
+		     CC_SET(e)						\
+		     : CC_OUT(e) (ret),					\
+		       [ptr] "+m" (*ptr),				\
+		       "+a" (o.low), "+d" (o.high)			\
+		     : "b" (n.low), "c" (n.high)			\
+		     : "memory");					\
+									\
+	if (unlikely(!ret))						\
+		*(_oldp) = o.full;					\
+									\
+	likely(ret);							\
+})
+
+static __always_inline bool arch_try_cmpxchg128(volatile u128 *ptr, u128 *oldp, u128 new)
+{
+	return __arch_try_cmpxchg128(ptr, oldp, new, LOCK_PREFIX);
+}
+
+static __always_inline bool arch_try_cmpxchg128_local(volatile u128 *ptr, u128 *oldp, u128 new)
+{
+	return __arch_try_cmpxchg128(ptr, oldp, new,);
+}
+
+#define system_has_cmpxchg_double()	boot_cpu_has(X86_FEATURE_CX16)
+#define system_has_cmpxchg128()		boot_cpu_has(X86_FEATURE_CX16)
 
 #endif /* _ASM_X86_CMPXCHG_64_H */


