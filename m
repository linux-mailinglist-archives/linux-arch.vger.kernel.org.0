Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C157650F29
	for <lists+linux-arch@lfdr.de>; Mon, 19 Dec 2022 16:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbiLSPqY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Dec 2022 10:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbiLSPpd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Dec 2022 10:45:33 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B8413CF8;
        Mon, 19 Dec 2022 07:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=EGvEEhj67bxGYwjZSrZRnMP7nFcuILVLo/TJsg7wp70=; b=XTpDGZcOneyi2jU6pOMWNGxSrG
        Tdqw3sx7AG1vT1ne1fXNaPNp/c69+TrAS0VOUR9s5qT2xIXABRaivHmARLOPbnJq0jzG+7GWUEiE4
        eO1FkjNo5cUP4B8MZTqFLdIr08eD9muQ0B3AXs0KOvBV3UbV3RCW3i/O7OXSbm86entb2bwh0I9fN
        D5sLZ8446vFcqxVt8ybKuHmZk9Lw7DXjhJh5Qg3IyC7Yy85C812g45O996HpRXURZMlMLfklLD21p
        LvziG6s731SVNOgX+uqOircga46FxYtSbIOBEecUmbyboFFKGW/xwGhoUzyXfAUnoDpZ3INrhuGol
        Y+kXACug==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1p7III-00CeDq-39;
        Mon, 19 Dec 2022 15:43:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0EB5F303382;
        Mon, 19 Dec 2022 16:43:10 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8676D20B0F899; Mon, 19 Dec 2022 16:43:06 +0100 (CET)
Message-ID: <20221219154119.286760562@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 19 Dec 2022 16:35:32 +0100
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
Subject: [RFC][PATCH 07/12] percpu: Wire up cmpxchg128
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

In order to replace cmpxchg_double() with the newly minted
cmpxchg128() family of functions, wire it up in this_cpu_cmpxchg().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm64/include/asm/percpu.h |   24 ++++++++++++++++++
 arch/s390/include/asm/percpu.h  |   20 +++++++++++++++
 arch/x86/include/asm/percpu.h   |   52 ++++++++++++++++++++++++++++++++++++++++
 include/asm-generic/percpu.h    |    8 ++++++
 include/linux/percpu-defs.h     |   20 +++++++++++++--
 5 files changed, 122 insertions(+), 2 deletions(-)

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
@@ -240,6 +244,26 @@ PERCPU_RET_OP(add, add, ldadd)
 #define this_cpu_cmpxchg_8(pcp, o, n)	\
 	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
 
+#define __pcpu_cast_128(_exp, _val)					\
+	_Generic((_exp),						\
+		 u128: (_val),						\
+		 s128: (_val),						\
+		 default: (unsigned long)(_val))
+
+#define this_cpu_cmpxchg_16(pcp, o, n)					\
+({									\
+	u128 old__ = __pcpu_cast_128((o), (o));				\
+	u128 new__ = __pcpu_cast_128((n), (n));				\
+	typedef typeof(pcp) pcp_op_T__;					\
+	pcp_op_T__ *ptr__;						\
+	u128 ret__;							\
+	preempt_disable_notrace();					\
+	ptr__ = raw_cpu_ptr(&(pcp));					\
+	ret__ = cmpxchg128_local((void *)ptr__, old__, new__);		\
+	preempt_enable_notrace();					\
+	(typeof(pcp))__pcpu_cast_128(*ptr__, ret__);			\
+})
+
 #ifdef __KVM_NVHE_HYPERVISOR__
 extern unsigned long __hyp_per_cpu_offset(unsigned int cpu);
 #define __per_cpu_offset
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -148,6 +148,26 @@
 #define this_cpu_cmpxchg_4(pcp, oval, nval) arch_this_cpu_cmpxchg(pcp, oval, nval)
 #define this_cpu_cmpxchg_8(pcp, oval, nval) arch_this_cpu_cmpxchg(pcp, oval, nval)
 
+#define __pcpu_cast_128(_exp, _val)					\
+	_Generic((_exp),						\
+		 u128: (_val),						\
+		 s128: (_val),						\
+		 default: (unsigned long)(_val))
+
+#define this_cpu_cmpxchg_16(pcp, oval, nval)				\
+({									\
+	u128 old__ = __pcpu_cast_128((nval), (nval));			\
+	u128 new__ = __pcpu_cast_128((oval), (oval));			\
+	typedef typeof(pcp) pcp_op_T__;					\
+	pcp_op_T__ *ptr__;						\
+	u128 ret__;							\
+	preempt_disable_notrace();					\
+	ptr__ = raw_cpu_ptr(&(pcp));					\
+	ret__ = cmpxchg128((void *)ptr__, old__, new__);		\
+	preempt_enable_notrace();					\
+	(typeof(pcp))__pcpu_cast_128(*ptr__, ret__);			\
+})
+
 #define arch_this_cpu_xchg(pcp, nval)					\
 ({									\
 	typeof(pcp) *ptr__;						\
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -210,6 +210,58 @@ do {									\
 	(typeof(_var))(unsigned long) pco_old__;			\
 })
 
+#if defined(CONFIG_X86_32) && defined(CONFIG_X86_CMPXCHG64)
+#define __pcpu_cast_64(_exp, _val)					\
+	_Generic((_exp),						\
+		 u64: (_val),						\
+		 s64: (_val),						\
+		 default: (unsigned long)(_val))
+
+#define percpu_cmpxchg64_op(size, qual, _var, _oval, _nval)		\
+({									\
+	__pcpu_type_##size pco_old__ = __pcpu_cast_64((_oval), (_oval));\
+	__pcpu_type_##size pco_new__ = __pcpu_cast_64((_nval), (_nval));\
+	asm qual ("cmpxchg8b " __percpu_arg([var])			\
+		  : [var] "+m" (_var),					\
+		    "+A" (pco_old__)					\
+		  : "b" ((u32)pco_new__), "c" ((u32)(pco_new__ >> 32))	\
+		  : "memory");						\
+	(typeof(_var))__pcpu_cast_64(_var, pco_old__);			\
+})
+
+#define raw_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg64_op(8,         , pcp, oval, nval)
+#define this_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg64_op(8, volatile, pcp, oval, nval)
+#endif
+
+#ifdef CONFIG_X86_64
+#define __pcpu_cast_128(_exp, _val)					\
+	_Generic((_exp),						\
+		 u128: (_val),						\
+		 s128: (_val),						\
+		 default: (unsigned long)(_val))
+
+#define percpu_cmpxchg128_op(size, qual, _var, _oval, _nval)		\
+({									\
+	union __u128_halves pco_old__ = {				\
+		.full = __pcpu_cast_128((_oval), (_oval))		\
+	};								\
+	union __u128_halves pco_new__ = {				\
+		.full = __pcpu_cast_128((_nval), (_nval))		\
+	};								\
+	asm qual ("cmpxchg16b " __percpu_arg([var])			\
+		  : [var] "+m" (_var),					\
+		    "+a" (pco_old__.low),				\
+		    "+d" (pco_old__.high)				\
+		  : "b" (pco_new__.low),				\
+		    "c" (pco_new__.high)				\
+		  : "memory");						\
+	(typeof(_var))__pcpu_cast_128(_var, pco_old__.full);		\
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
 


