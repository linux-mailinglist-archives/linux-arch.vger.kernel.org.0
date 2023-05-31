Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAE47181A3
	for <lists+linux-arch@lfdr.de>; Wed, 31 May 2023 15:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236385AbjEaN2X (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 May 2023 09:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236197AbjEaN2U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 May 2023 09:28:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53082C5;
        Wed, 31 May 2023 06:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=0OKPBc3mt+ezfW70uBbauBPqh/QqcxZBd2GTGmmN3GA=; b=F56ze+VZ1f3mhyQBWTK1kZLCn6
        DLlgkphQzhgklsVG742VjxiOdPtMB2tFaRRj4ss52ZIzg5HDYYF31EK4DXSi/DBDAeVFHjkmrUm0h
        ne6G2EAVd73HH115bh0qIhr/f9oQBI9cuDHH7XFY1y/+Q1FpTMH9h1VOfDocjZ5WggkAfzbIC/6lw
        /R1le7+B6S9xT4fJdC8c/xNvJw5kkcaR6ZulxEdI+j2JZO7YzfdcWmyiXFyEXXqo4vyOHwzhrYeMk
        0nK10XnwacPBKHLyQBVTSJ62ZjRwUYdyes4r9vMpGHQ0Qmitpgvm5rzNtp4HxY1UbL2ndUxA94pCS
        aCNZwNaA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q4LrG-007IJ5-DJ; Wed, 31 May 2023 13:27:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 55AF2300CB5;
        Wed, 31 May 2023 15:27:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8BB1B243B8560; Wed, 31 May 2023 15:27:16 +0200 (CEST)
Message-ID: <20230531132323.587480729@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 31 May 2023 15:08:38 +0200
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
Subject: [PATCH 05/12] percpu: Add {raw,this}_cpu_try_cmpxchg()
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

Add the try_cmpxchg() form to the per-cpu ops.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/asm-generic/percpu.h |  113 +++++++++++++++++++++++++++++++++++++++++--
 include/linux/percpu-defs.h  |   19 +++++++
 2 files changed, 128 insertions(+), 4 deletions(-)

--- a/include/asm-generic/percpu.h
+++ b/include/asm-generic/percpu.h
@@ -89,16 +89,37 @@ do {									\
 	__ret;								\
 })
 
-#define raw_cpu_generic_cmpxchg(pcp, oval, nval)			\
+#define __cpu_fallback_try_cmpxchg(pcp, ovalp, nval, _cmpxchg)		\
+({									\
+	typeof(pcp) __val, __old = *(ovalp);				\
+ 	__val = _cmpxchg(pcp, __old, nval);				\
+	if (__val != __old)						\
+		*(ovalp) = __val;					\
+	__val == __old;							\
+})
+
+#define raw_cpu_generic_try_cmpxchg(pcp, ovalp, nval)			\
 ({									\
 	typeof(pcp) *__p = raw_cpu_ptr(&(pcp));				\
-	typeof(pcp) __ret;						\
-	__ret = *__p;							\
-	if (__ret == (oval))						\
+	typeof(pcp) __val = *__p, __old = *(ovalp);			\
+	bool __ret;							\
+	if (__val == __old) {						\
 		*__p = nval;						\
+		__ret = true;						\
+	} else {							\
+		*(ovalp) = __val;					\
+		__ret = false;						\
+	}								\
 	__ret;								\
 })
 
+#define raw_cpu_generic_cmpxchg(pcp, oval, nval)			\
+({									\
+	typeof(pcp) __old = (oval);					\
+	raw_cpu_generic_try_cmpxchg(pcp, &__old, nval);			\
+	__old;								\
+})
+
 #define raw_cpu_generic_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2) \
 ({									\
 	typeof(pcp1) *__p1 = raw_cpu_ptr(&(pcp1));			\
@@ -170,6 +191,16 @@ do {									\
 	__ret;								\
 })
 
+#define this_cpu_generic_try_cmpxchg(pcp, ovalp, nval)			\
+({									\
+	bool __ret;							\
+	unsigned long __flags;						\
+	raw_local_irq_save(__flags);					\
+	__ret = raw_cpu_generic_try_cmpxchg(pcp, ovalp, nval);		\
+	raw_local_irq_restore(__flags);					\
+	__ret;								\
+})
+
 #define this_cpu_generic_cmpxchg(pcp, oval, nval)			\
 ({									\
 	typeof(pcp) __ret;						\
@@ -282,6 +313,43 @@ do {									\
 #define raw_cpu_xchg_8(pcp, nval)	raw_cpu_generic_xchg(pcp, nval)
 #endif
 
+#ifndef raw_cpu_try_cmpxchg_1
+#ifdef raw_cpu_cmpxchg_1
+#define raw_cpu_try_cmpxchg_1(pcp, ovalp, nval) \
+	__cpu_fallback_try_cmpxchg(pcp, ovalp, nval, raw_cpu_cmpxchg_1)
+#else
+#define raw_cpu_try_cmpxchg_1(pcp, ovalp, nval) \
+	raw_cpu_generic_try_cmpxchg(pcp, ovalp, nval)
+#endif
+#endif
+#ifndef raw_cpu_try_cmpxchg_2
+#ifdef raw_cpu_cmpxchg_2
+#define raw_cpu_try_cmpxchg_2(pcp, ovalp, nval) \
+	__cpu_fallback_try_cmpxchg(pcp, ovalp, nval, raw_cpu_cmpxchg_2)
+#else
+#define raw_cpu_try_cmpxchg_2(pcp, ovalp, nval) \
+	raw_cpu_generic_try_cmpxchg(pcp, ovalp, nval)
+#endif
+#endif
+#ifndef raw_cpu_try_cmpxchg_4
+#ifdef raw_cpu_cmpxchg_4
+#define raw_cpu_try_cmpxchg_4(pcp, ovalp, nval) \
+	__cpu_fallback_try_cmpxchg(pcp, ovalp, nval, raw_cpu_cmpxchg_4)
+#else
+#define raw_cpu_try_cmpxchg_4(pcp, ovalp, nval) \
+	raw_cpu_generic_try_cmpxchg(pcp, ovalp, nval)
+#endif
+#endif
+#ifndef raw_cpu_try_cmpxchg_8
+#ifdef raw_cpu_cmpxchg_8
+#define raw_cpu_try_cmpxchg_8(pcp, ovalp, nval) \
+	__cpu_fallback_try_cmpxchg(pcp, ovalp, nval, raw_cpu_cmpxchg_8)
+#else
+#define raw_cpu_try_cmpxchg_8(pcp, ovalp, nval) \
+	raw_cpu_generic_try_cmpxchg(pcp, ovalp, nval)
+#endif
+#endif
+
 #ifndef raw_cpu_cmpxchg_1
 #define raw_cpu_cmpxchg_1(pcp, oval, nval) \
 	raw_cpu_generic_cmpxchg(pcp, oval, nval)
@@ -407,6 +475,43 @@ do {									\
 #define this_cpu_xchg_8(pcp, nval)	this_cpu_generic_xchg(pcp, nval)
 #endif
 
+#ifndef this_cpu_try_cmpxchg_1
+#ifdef this_cpu_cmpxchg_1
+#define this_cpu_try_cmpxchg_1(pcp, ovalp, nval) \
+	__cpu_fallback_try_cmpxchg(pcp, ovalp, nval, this_cpu_cmpxchg_1)
+#else
+#define this_cpu_try_cmpxchg_1(pcp, ovalp, nval) \
+	this_cpu_generic_try_cmpxchg(pcp, ovalp, nval)
+#endif
+#endif
+#ifndef this_cpu_try_cmpxchg_2
+#ifdef this_cpu_cmpxchg_2
+#define this_cpu_try_cmpxchg_2(pcp, ovalp, nval) \
+	__cpu_fallback_try_cmpxchg(pcp, ovalp, nval, this_cpu_cmpxchg_2)
+#else
+#define this_cpu_try_cmpxchg_2(pcp, ovalp, nval) \
+	this_cpu_generic_try_cmpxchg(pcp, ovalp, nval)
+#endif
+#endif
+#ifndef this_cpu_try_cmpxchg_4
+#ifdef this_cpu_cmpxchg_4
+#define this_cpu_try_cmpxchg_4(pcp, ovalp, nval) \
+	__cpu_fallback_try_cmpxchg(pcp, ovalp, nval, this_cpu_cmpxchg_4)
+#else
+#define this_cpu_try_cmpxchg_4(pcp, ovalp, nval) \
+	this_cpu_generic_try_cmpxchg(pcp, ovalp, nval)
+#endif
+#endif
+#ifndef this_cpu_try_cmpxchg_8
+#ifdef this_cpu_cmpxchg_8
+#define this_cpu_try_cmpxchg_8(pcp, ovalp, nval) \
+	__cpu_fallback_try_cmpxchg(pcp, ovalp, nval, this_cpu_cmpxchg_8)
+#else
+#define this_cpu_try_cmpxchg_8(pcp, ovalp, nval) \
+	this_cpu_generic_try_cmpxchg(pcp, ovalp, nval)
+#endif
+#endif
+
 #ifndef this_cpu_cmpxchg_1
 #define this_cpu_cmpxchg_1(pcp, oval, nval) \
 	this_cpu_generic_cmpxchg(pcp, oval, nval)
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -343,6 +343,21 @@ static __always_inline void __this_cpu_p
 	pscr2_ret__;							\
 })
 
+#define __pcpu_size_call_return2bool(stem, variable, ...)		\
+({									\
+	bool pscr2_ret__;						\
+	__verify_pcpu_ptr(&(variable));					\
+	switch(sizeof(variable)) {					\
+	case 1: pscr2_ret__ = stem##1(variable, __VA_ARGS__); break;	\
+	case 2: pscr2_ret__ = stem##2(variable, __VA_ARGS__); break;	\
+	case 4: pscr2_ret__ = stem##4(variable, __VA_ARGS__); break;	\
+	case 8: pscr2_ret__ = stem##8(variable, __VA_ARGS__); break;	\
+	default:							\
+		__bad_size_call_parameter(); break;			\
+	}								\
+	pscr2_ret__;							\
+})
+
 /*
  * Special handling for cmpxchg_double.  cmpxchg_double is passed two
  * percpu variables.  The first has to be aligned to a double word
@@ -426,6 +441,8 @@ do {									\
 #define raw_cpu_xchg(pcp, nval)		__pcpu_size_call_return2(raw_cpu_xchg_, pcp, nval)
 #define raw_cpu_cmpxchg(pcp, oval, nval) \
 	__pcpu_size_call_return2(raw_cpu_cmpxchg_, pcp, oval, nval)
+#define raw_cpu_try_cmpxchg(pcp, ovalp, nval) \
+	__pcpu_size_call_return2bool(raw_cpu_try_cmpxchg_, pcp, ovalp, nval)
 #define raw_cpu_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2) \
 	__pcpu_double_call_return_bool(raw_cpu_cmpxchg_double_, pcp1, pcp2, oval1, oval2, nval1, nval2)
 
@@ -513,6 +530,8 @@ do {									\
 #define this_cpu_xchg(pcp, nval)	__pcpu_size_call_return2(this_cpu_xchg_, pcp, nval)
 #define this_cpu_cmpxchg(pcp, oval, nval) \
 	__pcpu_size_call_return2(this_cpu_cmpxchg_, pcp, oval, nval)
+#define this_cpu_try_cmpxchg(pcp, ovalp, nval) \
+	__pcpu_size_call_return2bool(this_cpu_try_cmpxchg_, pcp, ovalp, nval)
 #define this_cpu_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2) \
 	__pcpu_double_call_return_bool(this_cpu_cmpxchg_double_, pcp1, pcp2, oval1, oval2, nval1, nval2)
 


