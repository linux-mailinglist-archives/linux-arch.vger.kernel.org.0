Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90884688252
	for <lists+linux-arch@lfdr.de>; Thu,  2 Feb 2023 16:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbjBBPbN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Feb 2023 10:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbjBBPbM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Feb 2023 10:31:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91F27E6FA;
        Thu,  2 Feb 2023 07:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=SmAZMxmhVzZFpMcgEk2xjJ9SlIW4an+wqq1Ku13zd8I=; b=h4vsppu3IFznffLowHKrwukDM3
        slWQ9lk2uwAZd19UeQ8IiP6R82RdPP/jl2f/J2Bp9b69mzYayvhTYAstyqu4YM7w/Qm7aRexqb8Fi
        fQKtWH0QhG0NPqA0vENbIPMnhqB/F+DW1yTsK/SNLBxsZ+l2DuNJkFsE0R/fqfkzGDR1VH/zOyBr/
        kbyhWQHhXJ87Z+BFddWkPvPlDnD0qTMm+8fW+KHQw4EYkzITpu27WO8OztfpCgecLHKf25790kYjx
        VZRNEjKgQFWHaeZeahaKB/xNAXWZznALwCoy0s/Ne5hgd7KBKy/fdMMjB/r6uKcIQbSkov2P0s+5k
        KGDjPJfg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNbW4-00DV2d-2S; Thu, 02 Feb 2023 15:28:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3BA2B3021E2;
        Thu,  2 Feb 2023 16:28:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 93E3223F31FBB; Thu,  2 Feb 2023 16:28:40 +0100 (CET)
Message-ID: <20230202152655.494373332@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 02 Feb 2023 15:50:35 +0100
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
Subject: [PATCH v2 05/10] percpu: Wire up cmpxchg128
References: <20230202145030.223740842@infradead.org>
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

In order to replace cmpxchg_double() with the newly minted
cmpxchg128() family of functions, wire it up in this_cpu_cmpxchg().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm64/include/asm/percpu.h |   21 +++++++++++++++
 arch/s390/include/asm/percpu.h  |   17 ++++++++++++
 arch/x86/include/asm/percpu.h   |   56 ++++++++++++++++++++++++++++++++++++++++
 include/asm-generic/percpu.h    |    8 +++++
 include/linux/percpu-defs.h     |   20 ++++++++++++--
 5 files changed, 120 insertions(+), 2 deletions(-)

--- a/arch/arm64/include/asm/percpu.h
+++ b/arch/arm64/include/asm/percpu.h
@@ -140,6 +140,10 @@ PERCPU_RET_OP(add, add, ldadd)
  * re-enabling preemption for preemptible kernels, but doing that in a way
  * which builds inside a module would mean messing directly with the preempt
  * count. If you do this, peterz and tglx will hunt you down.
+ *
+ * Not to mention it'll break the actual preemption model for missing a
+ * preemption point when TIF_NEED_RESCHED gets set while preemption is
+ * disabled.
  */
 #define this_cpu_cmpxchg_double_8(ptr1, ptr2, o1, o2, n1, n2)		\
 ({									\
@@ -240,6 +244,23 @@ PERCPU_RET_OP(add, add, ldadd)
 #define this_cpu_cmpxchg_8(pcp, o, n)	\
 	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
 
+#define this_cpu_cmpxchg_16(pcp, o, n)					\
+({									\
+	typedef typeof(pcp) pcp_op_T__;					\
+	union {								\
+		pcp_op_T__ pot;						\
+		u128 val;						\
+	} old__, new__, ret__;						\
+	pcp_op_T__ *ptr__;						\
+	old__.pot = o;							\
+	new__.pot = n;							\
+	preempt_disable_notrace();					\
+	ptr__ = raw_cpu_ptr(&(pcp));					\
+	ret__.val = cmpxchg128_local((void *)ptr__, old__.val, new__.val); \
+	preempt_enable_notrace();					\
+	ret__.pot;							\
+})
+
 #ifdef __KVM_NVHE_HYPERVISOR__
 extern unsigned long __hyp_per_cpu_offset(unsigned int cpu);
 #define __per_cpu_offset
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -148,6 +148,23 @@
 #define this_cpu_cmpxchg_4(pcp, oval, nval) arch_this_cpu_cmpxchg(pcp, oval, nval)
 #define this_cpu_cmpxchg_8(pcp, oval, nval) arch_this_cpu_cmpxchg(pcp, oval, nval)
 
+#define this_cpu_cmpxchg_16(pcp, oval, nval)				\
+({									\
+	typedef typeof(pcp) pcp_op_T__;					\
+	union {								\
+		pcp_op_T__ pot;						\
+		u128 val;						\
+	} old__, new__, ret__;						\
+	pcp_op_T__ *ptr__;						\
+	old__.pot = oval;						\
+	new__.pot = nval;						\
+	preempt_disable_notrace();					\
+	ptr__ = raw_cpu_ptr(&(pcp));					\
+	ret__.val = cmpxchg128((void *)ptr__, old__.val, new__.val);	\
+	preempt_enable_notrace();					\
+	ret__.pot;							\
+})
+
 #define arch_this_cpu_xchg(pcp, nval)					\
 ({									\
 	typeof(pcp) *ptr__;						\
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -210,6 +210,62 @@ do {									\
 	(typeof(_var))(unsigned long) pco_old__;			\
 })
 
+#if defined(CONFIG_X86_32) && defined(CONFIG_X86_CMPXCHG64)
+#define percpu_cmpxchg64_op(size, qual, _var, _oval, _nval)		\
+({									\
+	union {								\
+		typeof(_var) var;					\
+		struct {						\
+			u32 low, high;					\
+		};							\
+	} old__, new__;							\
+									\
+	old__.var = _oval;						\
+	new__.var = _nval;						\
+									\
+	asm qual ("cmpxchg8b " __percpu_arg([var])			\
+		  : [var] "+m" (_var),					\
+		    "+a" (old__.low),					\
+		    "+d" (old__.high)					\
+		  : "b" (new__.low),					\
+		    "c" (new__.high)					\
+		  : "memory");						\
+									\
+	old__.var;							\
+})
+
+#define raw_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg64_op(8,         , pcp, oval, nval)
+#define this_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg64_op(8, volatile, pcp, oval, nval)
+#endif
+
+#ifdef CONFIG_X86_64
+#define percpu_cmpxchg128_op(size, qual, _var, _oval, _nval)		\
+({									\
+	union {								\
+		typeof(_var) var;					\
+		struct {						\
+			u64 low, high;					\
+		};							\
+	} old__, new__;							\
+									\
+	old__.var = _oval;						\
+	new__.var = _nval;						\
+									\
+	asm qual ("cmpxchg16b " __percpu_arg([var])			\
+		  : [var] "+m" (_var),					\
+		    "+a" (old__.low),					\
+		    "+d" (old__.high)					\
+		  : "b" (new__.low),					\
+		    "c" (new__.high)					\
+		  : "memory");						\
+									\
+	old__.var;							\
+})
+
+#define raw_cpu_cmpxchg_16(pcp, oval, nval)	percpu_cmpxchg128_op(16,         , pcp, oval, nval)
+#define this_cpu_cmpxchg_16(pcp, oval, nval)	percpu_cmpxchg128_op(16, volatile, pcp, oval, nval)
+#endif
+
 /*
  * this_cpu_read() makes gcc load the percpu variable every time it is
  * accessed while this_cpu_read_stable() allows the value to be cached.
--- a/include/asm-generic/percpu.h
+++ b/include/asm-generic/percpu.h
@@ -298,6 +298,10 @@ do {									\
 #define raw_cpu_cmpxchg_8(pcp, oval, nval) \
 	raw_cpu_generic_cmpxchg(pcp, oval, nval)
 #endif
+#ifndef raw_cpu_cmpxchg_16
+#define raw_cpu_cmpxchg_16(pcp, oval, nval) \
+	raw_cpu_generic_cmpxchg(pcp, oval, nval)
+#endif
 
 #ifndef raw_cpu_cmpxchg_double_1
 #define raw_cpu_cmpxchg_double_1(pcp1, pcp2, oval1, oval2, nval1, nval2) \
@@ -423,6 +427,10 @@ do {									\
 #define this_cpu_cmpxchg_8(pcp, oval, nval) \
 	this_cpu_generic_cmpxchg(pcp, oval, nval)
 #endif
+#ifndef this_cpu_cmpxchg_16
+#define this_cpu_cmpxchg_16(pcp, oval, nval) \
+	this_cpu_generic_cmpxchg(pcp, oval, nval)
+#endif
 
 #ifndef this_cpu_cmpxchg_double_1
 #define this_cpu_cmpxchg_double_1(pcp1, pcp2, oval1, oval2, nval1, nval2) \
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -343,6 +343,22 @@ static inline void __this_cpu_preempt_ch
 	pscr2_ret__;							\
 })
 
+#define __pcpu_size16_call_return2(stem, variable, ...)			\
+({									\
+	typeof(variable) pscr2_ret__;					\
+	__verify_pcpu_ptr(&(variable));					\
+	switch(sizeof(variable)) {					\
+	case 1: pscr2_ret__ = stem##1(variable, __VA_ARGS__); break;	\
+	case 2: pscr2_ret__ = stem##2(variable, __VA_ARGS__); break;	\
+	case 4: pscr2_ret__ = stem##4(variable, __VA_ARGS__); break;	\
+	case 8: pscr2_ret__ = stem##8(variable, __VA_ARGS__); break;	\
+	case 16: pscr2_ret__ = stem##16(variable, __VA_ARGS__); break;	\
+	default:							\
+		__bad_size_call_parameter(); break;			\
+	}								\
+	pscr2_ret__;							\
+})
+
 /*
  * Special handling for cmpxchg_double.  cmpxchg_double is passed two
  * percpu variables.  The first has to be aligned to a double word
@@ -425,7 +441,7 @@ do {									\
 #define raw_cpu_add_return(pcp, val)	__pcpu_size_call_return2(raw_cpu_add_return_, pcp, val)
 #define raw_cpu_xchg(pcp, nval)		__pcpu_size_call_return2(raw_cpu_xchg_, pcp, nval)
 #define raw_cpu_cmpxchg(pcp, oval, nval) \
-	__pcpu_size_call_return2(raw_cpu_cmpxchg_, pcp, oval, nval)
+	__pcpu_size16_call_return2(raw_cpu_cmpxchg_, pcp, oval, nval)
 #define raw_cpu_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2) \
 	__pcpu_double_call_return_bool(raw_cpu_cmpxchg_double_, pcp1, pcp2, oval1, oval2, nval1, nval2)
 
@@ -512,7 +528,7 @@ do {									\
 #define this_cpu_add_return(pcp, val)	__pcpu_size_call_return2(this_cpu_add_return_, pcp, val)
 #define this_cpu_xchg(pcp, nval)	__pcpu_size_call_return2(this_cpu_xchg_, pcp, nval)
 #define this_cpu_cmpxchg(pcp, oval, nval) \
-	__pcpu_size_call_return2(this_cpu_cmpxchg_, pcp, oval, nval)
+	__pcpu_size16_call_return2(this_cpu_cmpxchg_, pcp, oval, nval)
 #define this_cpu_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2) \
 	__pcpu_double_call_return_bool(this_cpu_cmpxchg_double_, pcp1, pcp2, oval1, oval2, nval1, nval2)
 


