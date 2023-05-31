Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900BA7181BC
	for <lists+linux-arch@lfdr.de>; Wed, 31 May 2023 15:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236474AbjEaN2c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 May 2023 09:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236347AbjEaN2V (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 May 2023 09:28:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E48123;
        Wed, 31 May 2023 06:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=OYq3F8aZwPPC/Y8UsexFdal3aiucmNsqQObmCMz9zjE=; b=LIi2st653mrq+qr82jZjSZoSMu
        b4IdGvoFjlZSfW2/JQDfIQgkhRmizDc+3i69fP7F75A4WAkEYw/JPtYzsJYXvDjOlO3lYqV3CTQG2
        W5QHSm3lF3LRIXC6DORpHYE0GY/d/aV+oN7w/SrBOka2MUxnFUNUBPn6uIzvLTkgZCknrMs9/URJT
        jHAuSX05RfqOvsyIyF/kFoW7hbFpLP/c+WXZHzxrpS37v59bTdQPKeQCwIDOzbrtY2xMJrtSDtp8c
        jQSyhSMxk2M6L9+FSzaQWKUsmX61W6UzXzdaMQ0wKEbO8TRWRg4MO80O6dbE/9Vv3BMgIz9xTSMYB
        XK7W6Mcg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q4LrH-007IJW-3w; Wed, 31 May 2023 13:27:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 55A95300C0E;
        Wed, 31 May 2023 15:27:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 95BD0243B856F; Wed, 31 May 2023 15:27:16 +0200 (CEST)
Message-ID: <20230531132323.722039569@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 31 May 2023 15:08:40 +0200
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
Subject: [PATCH 07/12] percpu: #ifndef __SIZEOF_INT128__
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

Some 64bit architectures do not advertise __SIZEOF_INT128__ on all
supported compiler versions. Notably the HPPA64 only started doing
with GCC-11.

Since the per-cpu ops are universally availably, and
this_cpu_{,try_}cmpxchg128() is expected to be available on all 64bit
architectures a wee bodge is in order.

Sadly, while C reverts to memcpy() for assignment of POD types, it does
not revert to memcmp() for for equality. Therefore frob that manually.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/asm-generic/percpu.h |   56 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/types.h        |    7 +++++
 2 files changed, 63 insertions(+)

--- a/include/asm-generic/percpu.h
+++ b/include/asm-generic/percpu.h
@@ -313,6 +313,35 @@ do {									\
 #define raw_cpu_xchg_8(pcp, nval)	raw_cpu_generic_xchg(pcp, nval)
 #endif
 
+#ifndef __SIZEOF_INT128__
+#define raw_cpu_generic_try_cmpxchg_memcmp(pcp, ovalp, nval)		\
+({									\
+	typeof(pcp) *__p = raw_cpu_ptr(&(pcp));				\
+	typeof(pcp) __val = *__p, __old = *(ovalp);			\
+	bool __ret;							\
+	if (!__builtin_memcmp(&__val, &__old, sizeof(pcp))) {		\
+		*__p = nval;						\
+		__ret = true;						\
+	} else {							\
+		*(ovalp) = __val;					\
+		__ret = false;						\
+	}								\
+	__ret;								\
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
 #ifndef raw_cpu_try_cmpxchg_1
 #ifdef raw_cpu_cmpxchg_1
 #define raw_cpu_try_cmpxchg_1(pcp, ovalp, nval) \
@@ -503,6 +532,33 @@ do {									\
 #define this_cpu_xchg_8(pcp, nval)	this_cpu_generic_xchg(pcp, nval)
 #endif
 
+#ifndef __SIZEOF_INT128__
+#define this_cpu_generic_try_cmpxchg_memcmp(pcp, ovalp, nval)		\
+({									\
+	bool __ret;							\
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
 #ifndef this_cpu_try_cmpxchg_1
 #ifdef this_cpu_cmpxchg_1
 #define this_cpu_try_cmpxchg_1(pcp, ovalp, nval) \
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


