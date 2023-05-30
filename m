Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE787716D97
	for <lists+linux-arch@lfdr.de>; Tue, 30 May 2023 21:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjE3TeF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 May 2023 15:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjE3TeE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 May 2023 15:34:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CE6BE;
        Tue, 30 May 2023 12:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4dc8sj3FHzzLhi63BMaL8ARsadXKK6PBMKS8wZ1D+bM=; b=JM7SiKdzfwoBik0AKgxOsdxCpD
        sDgnOT4X96GVp8CNJPJb+VOQVteRUg7rUp37Z51bccNB5PtdZZdFWuUdw496KccyYIcrBvzDCr6Bv
        Y9Jko3S3agioN15y2YYHTWvPLYowFj33IOP2SMXTSAX3jmWiVTemAd+VQ5v3vP1z5MSBp1M6+QMNj
        Yl95WQRRrZI/coCZDx5VKzQpkvp2WzKa6i9icU6WPABaTXb+MamtUc/8gix4iHb9+PGyAKxTFw0YV
        PhcQmCHWi2/I64g8MCskmYk+R7GDeCcI2mbko//pOUA83Bdwaq1ULOdq+hdnfRe4a1X3c5leImvPG
        MPvGP5Ww==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q455b-006ZKF-17; Tue, 30 May 2023 19:33:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9784F300233;
        Tue, 30 May 2023 21:32:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 45294243A9FD8; Tue, 30 May 2023 21:32:58 +0200 (CEST)
Date:   Tue, 30 May 2023 21:32:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org
Cc:     corbet@lwn.net, will@kernel.org, boqun.feng@gmail.com,
        mark.rutland@arm.com, catalin.marinas@arm.com, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, hca@linux.ibm.com, gor@linux.ibm.com,
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
Subject: Re: [PATCH v3 08/11] slub: Replace cmpxchg_double()
Message-ID: <20230530193258.GB211927@hirez.programming.kicks-ass.net>
References: <20230515075659.118447996@infradead.org>
 <20230515080554.453785148@infradead.org>
 <20230524093246.GP83892@hirez.programming.kicks-ass.net>
 <20230530142232.GA200270@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530142232.GA200270@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 30, 2023 at 04:22:32PM +0200, Peter Zijlstra wrote:

> Yet another alternative is using a struct type and an equality function,
> just for this.

The best I could come up with in the regard is the below. It builds on
HPPA64 and x86_64, but I've not ran it yet.

(also, the introduction of this_cpu_try_cmpxchg() should probably be
split out into its own patch)

--- a/include/asm-generic/percpu.h
+++ b/include/asm-generic/percpu.h
@@ -99,6 +99,15 @@ do {									\
 	__ret;								\
 })
 
+#define raw_cpu_generic_try_cmpxchg(pcp, ovalp, nval)			\
+({									\
+	typeof(pcp) __ret, __old = *(ovalp);				\
+	__ret = raw_cpu_cmpxchg(pcp, __old, nval);			\
+	if (!likely(__ret == __old))					\
+		*(ovalp) = __ret;					\
+	likely(__ret == __old);						\
+})
+
 #define __this_cpu_generic_read_nopreempt(pcp)				\
 ({									\
 	typeof(pcp) ___ret;						\
@@ -167,6 +176,15 @@ do {									\
 	__ret;								\
 })
 
+#define this_cpu_generic_try_cmpxchg(pcp, ovalp, nval)			\
+({									\
+	typeof(pcp) __ret, __old = *(ovalp);				\
+	__ret = this_cpu_cmpxchg(pcp, __old, nval);			\
+	if (!likely(__ret == __old))					\
+		*(ovalp) = __ret;					\
+	likely(__ret == __old);						\
+})
+
 #ifndef raw_cpu_read_1
 #define raw_cpu_read_1(pcp)		raw_cpu_generic_read(pcp)
 #endif
@@ -258,6 +276,36 @@ do {									\
 #define raw_cpu_xchg_8(pcp, nval)	raw_cpu_generic_xchg(pcp, nval)
 #endif
 
+#ifndef __SIZEOF_INT128__
+#define raw_cpu_generic_try_cmpxchg_memcmp(pcp, ovalp, nval)		\
+({									\
+	typeof(pcp) *__p = raw_cpu_ptr(&(pcp));				\
+	typeof(pcp) __ret, __old = *(ovalp);				\
+	bool __s;							\
+	__ret = *__p;							\
+	if (!__builtin_memcmp(&__ret, &__old, sizeof(pcp))) {		\
+		*__p = nval;						\
+		__s = true;						\
+	} else {							\
+		*(ovalp) = __ret;					\
+		__s = false;						\
+	}								\
+	__s;								\
+})
+
+#define raw_cpu_generic_cmpxchg_memcmp(pcp, oval, nval)			\
+({									\
+	typeof(pcp) __old = (oval);					\
+	raw_cpu_generic_try_cmpxchg_memcpy(pcp, &__old, nval);		\
+	__old;								\
+})
+
+#define raw_cpu_cmpxchg128(pcp, oval, nval) \
+	raw_cpu_generic_cmpxchg_memcmp(pcp, oval, nval)
+#define raw_cpu_try_cmpxchg128(pcp, ovalp, nval) \
+	raw_cpu_generic_try_cmpxchg_memcmp(pcp, ovalp, nval)
+#endif
+
 #ifndef raw_cpu_cmpxchg_1
 #define raw_cpu_cmpxchg_1(pcp, oval, nval) \
 	raw_cpu_generic_cmpxchg(pcp, oval, nval)
@@ -283,6 +331,31 @@ do {									\
 	raw_cpu_generic_cmpxchg(pcp, oval, nval)
 #endif
 
+#ifndef raw_cpu_try_cmpxchg_1
+#define raw_cpu_try_cmpxchg_1(pcp, ovalp, nval) \
+	raw_cpu_generic_try_cmpxchg(pcp, ovalp, nval)
+#endif
+#ifndef raw_cpu_try_cmpxchg_2
+#define raw_cpu_try_cmpxchg_2(pcp, ovalp, nval) \
+	raw_cpu_generic_try_cmpxchg(pcp, ovalp, nval)
+#endif
+#ifndef raw_cpu_try_cmpxchg_4
+#define raw_cpu_try_cmpxchg_4(pcp, ovalp, nval) \
+	raw_cpu_generic_try_cmpxchg(pcp, ovalp, nval)
+#endif
+#ifndef raw_cpu_try_cmpxchg_8
+#define raw_cpu_try_cmpxchg_8(pcp, ovalp, nval) \
+	raw_cpu_generic_try_cmpxchg(pcp, ovalp, nval)
+#endif
+#ifndef raw_cpu_try_cmpxchg64
+#define raw_cpu_try_cmpxchg64(pcp, ovalp, nval) \
+	raw_cpu_generic_try_cmpxchg(pcp, ovalp, nval)
+#endif
+#ifndef raw_cpu_try_cmpxchg128
+#define raw_cpu_try_cmpxchg128(pcp, ovalp, nval) \
+	raw_cpu_generic_try_cmpxchg(pcp, ovalp, nval)
+#endif
+
 #ifndef this_cpu_read_1
 #define this_cpu_read_1(pcp)		this_cpu_generic_read(pcp)
 #endif
@@ -374,6 +447,33 @@ do {									\
 #define this_cpu_xchg_8(pcp, nval)	this_cpu_generic_xchg(pcp, nval)
 #endif
 
+#ifndef __SIZEOF_INT128__
+#define this_cpu_generic_try_cmpxchg_memcmp(pcp, ovalp, nval)		\
+({									\
+ 	bool __ret;							\
+	unsigned long __flags;						\
+	raw_local_irq_save(__flags);					\
+	__ret = raw_cpu_generic_try_cmpxchg_memcmp(pcp, ovalp, nval);	\
+	raw_local_irq_restore(__flags);					\
+	__ret;								\
+})
+
+#define this_cpu_generic_cmpxchg_memcmp(pcp, oval, nval)		\
+({									\
+	typeof(pcp) __ret;						\
+	unsigned long __flags;						\
+	raw_local_irq_save(__flags);					\
+	__ret = raw_cpu_generic_cmpxchg_memcmp(pcp, oval, nval);	\
+	raw_local_irq_restore(__flags);					\
+	__ret;								\
+})
+
+#define this_cpu_cmpxchg128(pcp, oval, nval) \
+	this_cpu_generic_cmpxchg_memcmp(pcp, oval, nval)
+#define this_cpu_try_cmpxchg128(pcp, ovalp, nval) \
+	this_cpu_generic_try_cmpxchg_memcmp(pcp, ovalp, nval)
+#endif
+
 #ifndef this_cpu_cmpxchg_1
 #define this_cpu_cmpxchg_1(pcp, oval, nval) \
 	this_cpu_generic_cmpxchg(pcp, oval, nval)
@@ -399,4 +499,29 @@ do {									\
 	this_cpu_generic_cmpxchg(pcp, oval, nval)
 #endif
 
+#ifndef this_cpu_try_cmpxchg_1
+#define this_cpu_try_cmpxchg_1(pcp, ovalp, nval) \
+	this_cpu_generic_try_cmpxchg(pcp, ovalp, nval)
+#endif
+#ifndef this_cpu_try_cmpxchg_2
+#define this_cpu_try_cmpxchg_2(pcp, ovalp, nval) \
+	this_cpu_generic_try_cmpxchg(pcp, ovalp, nval)
+#endif
+#ifndef this_cpu_try_cmpxchg_4
+#define this_cpu_try_cmpxchg_4(pcp, ovalp, nval) \
+	this_cpu_generic_try_cmpxchg(pcp, ovalp, nval)
+#endif
+#ifndef this_cpu_try_cmpxchg_8
+#define this_cpu_try_cmpxchg_8(pcp, ovalp, nval) \
+	this_cpu_generic_try_cmpxchg(pcp, ovalp, nval)
+#endif
+#ifndef this_cpu_try_cmpxchg64
+#define this_cpu_try_cmpxchg64(pcp, ovalp, nval) \
+	this_cpu_generic_try_cmpxchg(pcp, ovalp, nval)
+#endif
+#ifndef this_cpu_try_cmpxchg128
+#define this_cpu_try_cmpxchg128(pcp, ovalp, nval) \
+	this_cpu_generic_try_cmpxchg(pcp, ovalp, nval)
+#endif
+
 #endif /* _ASM_GENERIC_PERCPU_H_ */
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -13,6 +13,13 @@
 #ifdef __SIZEOF_INT128__
 typedef __s128 s128;
 typedef __u128 u128;
+#else
+#ifdef CONFIG_64BIT
+/* hack for this_cpu_cmpxchg128 */
+typedef struct {
+	u64 a, b;
+} u128 __attribute__((aligned(16)));
+#endif
 #endif
 
 typedef u32 __kernel_dev_t;
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -11,14 +11,14 @@ void __init kmem_cache_init(void);
 # define system_has_freelist_aba()	system_has_cmpxchg128()
 # define try_cmpxchg_freelist		try_cmpxchg128
 # endif
-#define this_cpu_cmpxchg_freelist	this_cpu_cmpxchg128
+#define this_cpu_try_cmpxchg_freelist	this_cpu_try_cmpxchg128
 typedef u128 freelist_full_t;
 #else /* CONFIG_64BIT */
 # ifdef system_has_cmpxchg64
 # define system_has_freelist_aba()	system_has_cmpxchg64()
 # define try_cmpxchg_freelist		try_cmpxchg64
 # endif
-#define this_cpu_cmpxchg_freelist	this_cpu_cmpxchg64
+#define this_cpu_try_cmpxchg_freelist	this_cpu_try_cmpxchg64
 typedef u64 freelist_full_t;
 #endif /* CONFIG_64BIT */
 
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3037,8 +3037,8 @@ __update_cpu_freelist_fast(struct kmem_c
 	freelist_aba_t old = { .freelist = freelist_old, .counter = tid };
 	freelist_aba_t new = { .freelist = freelist_new, .counter = next_tid(tid) };
 
-	return this_cpu_cmpxchg_freelist(s->cpu_slab->freelist_tid.full,
-					 old.full, new.full) == old.full;
+	return this_cpu_try_cmpxchg_freelist(s->cpu_slab->freelist_tid.full,
+					     &old.full, new.full);
 }
 
 /*
