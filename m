Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B019D7181C2
	for <lists+linux-arch@lfdr.de>; Wed, 31 May 2023 15:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236479AbjEaN2e (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 May 2023 09:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236367AbjEaN2W (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 May 2023 09:28:22 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00005C0;
        Wed, 31 May 2023 06:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Mf2DqF9+qmlB3aVgKTie/uCFSNlIvgxgU+h4eBbbVoE=; b=CWkbaVBPzKtpsr2a1a2hRuIWEs
        Y5SENCjjcw/5P2q7aD0YPbYmEcry3JvUsXvX2MYf6pIsJUqb4xvEWiVL/tnJHZJuX451RigPl5KMW
        YwMVH6eB6iOiwq0g+j7J4cB9lRQWnAXxpoNeE6u3/W6XOD6c2u6v02ClQGQsuCxWDFQGDLpgmyN60
        QM3Mj7YF17Jk3on8SLT4R1wBDE62+16g+RASLcbdicYRSr/9AvauqZuLkzWIUYmGs+2amCY3YESy1
        ZqlJ0GMxo7MyoJpGk0tIbeBwkiywbJX9YkqZLxrFdoUfwEBe7sCbBhHioUurtNYVpKH1IyJqfkupR
        TWIkrlBg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4LrG-00FTCb-1J;
        Wed, 31 May 2023 13:27:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 55A6630084B;
        Wed, 31 May 2023 15:27:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 901F5243B856E; Wed, 31 May 2023 15:27:16 +0200 (CEST)
Message-ID: <20230531132323.654945124@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 31 May 2023 15:08:39 +0200
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
Subject: [PATCH 06/12] percpu: Wire up cmpxchg128
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

In order to replace cmpxchg_double() with the newly minted
cmpxchg128() family of functions, wire it up in this_cpu_cmpxchg().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm64/include/asm/percpu.h |   20 ++++++++++
 arch/s390/include/asm/percpu.h  |   16 ++++++++
 arch/x86/include/asm/percpu.h   |   74 ++++++++++++++++++++++++++++++++++++----
 arch/x86/lib/Makefile           |    3 +
 arch/x86/lib/cmpxchg16b_emu.S   |   43 +++++++++++++----------
 arch/x86/lib/cmpxchg8b_emu.S    |   67 ++++++++++++++++++++++++++++--------
 include/asm-generic/percpu.h    |   56 ++++++++++++++++++++++++++++++
 7 files changed, 240 insertions(+), 39 deletions(-)

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
@@ -240,6 +244,22 @@ PERCPU_RET_OP(add, add, ldadd)
 #define this_cpu_cmpxchg_8(pcp, o, n)	\
 	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
 
+#define this_cpu_cmpxchg64(pcp, o, n)	this_cpu_cmpxchg_8(pcp, o, n)
+
+#define this_cpu_cmpxchg128(pcp, o, n)					\
+({									\
+	typedef typeof(pcp) pcp_op_T__;					\
+	u128 old__, new__, ret__;					\
+	pcp_op_T__ *ptr__;						\
+	old__ = o;							\
+	new__ = n;							\
+	preempt_disable_notrace();					\
+	ptr__ = raw_cpu_ptr(&(pcp));					\
+	ret__ = cmpxchg128_local((void *)ptr__, old__, new__);		\
+	preempt_enable_notrace();					\
+	ret__;								\
+})
+
 #ifdef __KVM_NVHE_HYPERVISOR__
 extern unsigned long __hyp_per_cpu_offset(unsigned int cpu);
 #define __per_cpu_offset
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -148,6 +148,22 @@
 #define this_cpu_cmpxchg_4(pcp, oval, nval) arch_this_cpu_cmpxchg(pcp, oval, nval)
 #define this_cpu_cmpxchg_8(pcp, oval, nval) arch_this_cpu_cmpxchg(pcp, oval, nval)
 
+#define this_cpu_cmpxchg64(pcp, o, n)	this_cpu_cmpxchg_8(pcp, o, n)
+
+#define this_cpu_cmpxchg128(pcp, oval, nval)				\
+({									\
+	typedef typeof(pcp) pcp_op_T__;					\
+	u128 old__, new__, ret__;					\
+	pcp_op_T__ *ptr__;						\
+	old__ = oval;							\
+	new__ = nval;							\
+	preempt_disable_notrace();					\
+	ptr__ = raw_cpu_ptr(&(pcp));					\
+	ret__ = cmpxchg128((void *)ptr__, old__, new__);		\
+	preempt_enable_notrace();					\
+	ret__;								\
+})
+
 #define arch_this_cpu_xchg(pcp, nval)					\
 ({									\
 	typeof(pcp) *ptr__;						\
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -210,6 +210,67 @@ do {									\
 	(typeof(_var))(unsigned long) pco_old__;			\
 })
 
+#if defined(CONFIG_X86_32) && !defined(CONFIG_UML)
+#define percpu_cmpxchg64_op(size, qual, _var, _oval, _nval)		\
+({									\
+	union {								\
+		u64 var;						\
+		struct {						\
+			u32 low, high;					\
+		};							\
+	} old__, new__;							\
+									\
+	old__.var = _oval;						\
+	new__.var = _nval;						\
+									\
+	asm qual (ALTERNATIVE("leal %P[var], %%esi; call this_cpu_cmpxchg8b_emu", \
+			      "cmpxchg8b " __percpu_arg([var]), X86_FEATURE_CX8) \
+		  : [var] "+m" (_var),					\
+		    "+a" (old__.low),					\
+		    "+d" (old__.high)					\
+		  : "b" (new__.low),					\
+		    "c" (new__.high)					\
+		  : "memory", "esi");					\
+									\
+	old__.var;							\
+})
+
+#define raw_cpu_cmpxchg64(pcp, oval, nval)	percpu_cmpxchg64_op(8,         , pcp, oval, nval)
+#define this_cpu_cmpxchg64(pcp, oval, nval)	percpu_cmpxchg64_op(8, volatile, pcp, oval, nval)
+#endif
+
+#ifdef CONFIG_X86_64
+#define raw_cpu_cmpxchg64(pcp, oval, nval)	percpu_cmpxchg_op(8,         , pcp, oval, nval);
+#define this_cpu_cmpxchg64(pcp, oval, nval)	percpu_cmpxchg_op(8, volatile, pcp, oval, nval);
+
+#define percpu_cmpxchg128_op(size, qual, _var, _oval, _nval)		\
+({									\
+	union {								\
+		u128 var;						\
+		struct {						\
+			u64 low, high;					\
+		};							\
+	} old__, new__;							\
+									\
+	old__.var = _oval;						\
+	new__.var = _nval;						\
+									\
+	asm qual (ALTERNATIVE("leaq %P[var], %%rsi; call this_cpu_cmpxchg16b_emu", \
+			      "cmpxchg16b " __percpu_arg([var]), X86_FEATURE_CX16) \
+		  : [var] "+m" (_var),					\
+		    "+a" (old__.low),					\
+		    "+d" (old__.high)					\
+		  : "b" (new__.low),					\
+		    "c" (new__.high)					\
+		  : "memory", "rsi");					\
+									\
+	old__.var;							\
+})
+
+#define raw_cpu_cmpxchg128(pcp, oval, nval)	percpu_cmpxchg128_op(16,         , pcp, oval, nval)
+#define this_cpu_cmpxchg128(pcp, oval, nval)	percpu_cmpxchg128_op(16, volatile, pcp, oval, nval)
+#endif
+
 /*
  * this_cpu_read() makes gcc load the percpu variable every time it is
  * accessed while this_cpu_read_stable() allows the value to be cached.
@@ -341,12 +402,13 @@ do {									\
 	bool __ret;							\
 	typeof(pcp1) __o1 = (o1), __n1 = (n1);				\
 	typeof(pcp2) __o2 = (o2), __n2 = (n2);				\
-	alternative_io("leaq %P1,%%rsi\n\tcall this_cpu_cmpxchg16b_emu\n\t", \
-		       "cmpxchg16b " __percpu_arg(1) "\n\tsetz %0\n\t",	\
-		       X86_FEATURE_CX16,				\
-		       ASM_OUTPUT2("=a" (__ret), "+m" (pcp1),		\
-				   "+m" (pcp2), "+d" (__o2)),		\
-		       "b" (__n1), "c" (__n2), "a" (__o1) : "rsi");	\
+	asm volatile (ALTERNATIVE("leaq %P1, %%rsi; call this_cpu_cmpxchg16b_emu", \
+				  "cmpxchg16b " __percpu_arg(1), X86_FEATURE_CX16) \
+			     "setz %0"					\
+			     : "=a" (__ret), "+m" (pcp1)		\
+			     : "b" (__n1), "c" (__n2),			\
+			       "a" (__o1), "d" (__o2)			\
+			     : "memory", "rsi");			\
 	__ret;								\
 })
 
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -61,8 +61,9 @@ ifeq ($(CONFIG_X86_32),y)
         lib-y += strstr_32.o
         lib-y += string_32.o
         lib-y += memmove_32.o
+        lib-y += cmpxchg8b_emu.o
 ifneq ($(CONFIG_X86_CMPXCHG64),y)
-        lib-y += cmpxchg8b_emu.o atomic64_386_32.o
+        lib-y += atomic64_386_32.o
 endif
 else
         obj-y += iomap_copy_64.o
--- a/arch/x86/lib/cmpxchg16b_emu.S
+++ b/arch/x86/lib/cmpxchg16b_emu.S
@@ -1,47 +1,54 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 #include <linux/linkage.h>
 #include <asm/percpu.h>
+#include <asm/processor-flags.h>
 
 .text
 
 /*
+ * Emulate 'cmpxchg16b %gs:(%rsi)'
+ *
  * Inputs:
  * %rsi : memory location to compare
  * %rax : low 64 bits of old value
  * %rdx : high 64 bits of old value
  * %rbx : low 64 bits of new value
  * %rcx : high 64 bits of new value
- * %al  : Operation successful
+ *
+ * Notably this is not LOCK prefixed and is not safe against NMIs
  */
 SYM_FUNC_START(this_cpu_cmpxchg16b_emu)
 
-#
-# Emulate 'cmpxchg16b %gs:(%rsi)' except we return the result in %al not
-# via the ZF.  Caller will access %al to get result.
-#
-# Note that this is only useful for a cpuops operation.  Meaning that we
-# do *not* have a fully atomic operation but just an operation that is
-# *atomic* on a single cpu (as provided by the this_cpu_xx class of
-# macros).
-#
 	pushfq
 	cli
 
-	cmpq PER_CPU_VAR((%rsi)), %rax
-	jne .Lnot_same
-	cmpq PER_CPU_VAR(8(%rsi)), %rdx
-	jne .Lnot_same
+	/* if (*ptr == old) */
+	cmpq	PER_CPU_VAR(0(%rsi)), %rax
+	jne	.Lnot_same
+	cmpq	PER_CPU_VAR(8(%rsi)), %rdx
+	jne	.Lnot_same
+
+	/* *ptr = new */
+	movq	%rbx, PER_CPU_VAR(0(%rsi))
+	movq	%rcx, PER_CPU_VAR(8(%rsi))
 
-	movq %rbx, PER_CPU_VAR((%rsi))
-	movq %rcx, PER_CPU_VAR(8(%rsi))
+	/* set ZF in EFLAGS to indicate success */
+	orl	$X86_EFLAGS_ZF, (%rsp)
 
 	popfq
-	mov $1, %al
 	RET
 
 .Lnot_same:
+	/* *ptr != old */
+
+	/* old = *ptr */
+	movq	PER_CPU_VAR(0(%rsi)), %rax
+	movq	PER_CPU_VAR(8(%rsi)), %rdx
+
+	/* clear ZF in EFLAGS to indicate failure */
+	andl	$(~X86_EFLAGS_ZF), (%rsp)
+
 	popfq
-	xor %al,%al
 	RET
 
 SYM_FUNC_END(this_cpu_cmpxchg16b_emu)
--- a/arch/x86/lib/cmpxchg8b_emu.S
+++ b/arch/x86/lib/cmpxchg8b_emu.S
@@ -2,10 +2,16 @@
 
 #include <linux/linkage.h>
 #include <asm/export.h>
+#include <asm/percpu.h>
+#include <asm/processor-flags.h>
 
 .text
 
+#ifndef CONFIG_X86_CMPXCHG64
+
 /*
+ * Emulate 'cmpxchg8b (%esi)' on UP
+ *
  * Inputs:
  * %esi : memory location to compare
  * %eax : low 32 bits of old value
@@ -15,32 +21,65 @@
  */
 SYM_FUNC_START(cmpxchg8b_emu)
 
-#
-# Emulate 'cmpxchg8b (%esi)' on UP except we don't
-# set the whole ZF thing (caller will just compare
-# eax:edx with the expected value)
-#
 	pushfl
 	cli
 
-	cmpl  (%esi), %eax
-	jne .Lnot_same
-	cmpl 4(%esi), %edx
-	jne .Lhalf_same
+	cmpl	0(%esi), %eax
+	jne	.Lnot_same
+	cmpl	4(%esi), %edx
+	jne	.Lnot_same
+
+	movl	%ebx, 0(%esi)
+	movl	%ecx, 4(%esi)
 
-	movl %ebx,  (%esi)
-	movl %ecx, 4(%esi)
+	orl	$X86_EFLAGS_ZF, (%esp)
 
 	popfl
 	RET
 
 .Lnot_same:
-	movl  (%esi), %eax
-.Lhalf_same:
-	movl 4(%esi), %edx
+	movl	0(%esi), %eax
+	movl	4(%esi), %edx
+
+	andl	$(~X86_EFLAGS_ZF), (%esp)
 
 	popfl
 	RET
 
 SYM_FUNC_END(cmpxchg8b_emu)
 EXPORT_SYMBOL(cmpxchg8b_emu)
+
+#endif
+
+#ifndef CONFIG_UML
+
+SYM_FUNC_START(this_cpu_cmpxchg8b_emu)
+
+	pushfl
+	cli
+
+	cmpl	PER_CPU_VAR(0(%esi)), %eax
+	jne	.Lnot_same2
+	cmpl	PER_CPU_VAR(4(%esi)), %edx
+	jne	.Lnot_same2
+
+	movl	%ebx, PER_CPU_VAR(0(%esi))
+	movl	%ecx, PER_CPU_VAR(4(%esi))
+
+	orl	$X86_EFLAGS_ZF, (%esp)
+
+	popfl
+	RET
+
+.Lnot_same2:
+	movl	PER_CPU_VAR(0(%esi)), %eax
+	movl	PER_CPU_VAR(4(%esi)), %edx
+
+	andl	$(~X86_EFLAGS_ZF), (%esp)
+
+	popfl
+	RET
+
+SYM_FUNC_END(this_cpu_cmpxchg8b_emu)
+
+#endif
--- a/include/asm-generic/percpu.h
+++ b/include/asm-generic/percpu.h
@@ -350,6 +350,25 @@ do {									\
 #endif
 #endif
 
+#ifndef raw_cpu_try_cmpxchg64
+#ifdef raw_cpu_cmpxchg64
+#define raw_cpu_try_cmpxchg64(pcp, ovalp, nval) \
+	__cpu_fallback_try_cmpxchg(pcp, ovalp, nval, raw_cpu_cmpxchg64)
+#else
+#define raw_cpu_try_cmpxchg64(pcp, ovalp, nval) \
+	raw_cpu_generic_try_cmpxchg(pcp, ovalp, nval)
+#endif
+#endif
+#ifndef raw_cpu_try_cmpxchg128
+#ifdef raw_cpu_cmpxchg128
+#define raw_cpu_try_cmpxchg128(pcp, ovalp, nval) \
+	__cpu_fallback_try_cmpxchg(pcp, ovalp, nval, raw_cpu_cmpxchg128)
+#else
+#define raw_cpu_try_cmpxchg128(pcp, ovalp, nval) \
+	raw_cpu_generic_try_cmpxchg(pcp, ovalp, nval)
+#endif
+#endif
+
 #ifndef raw_cpu_cmpxchg_1
 #define raw_cpu_cmpxchg_1(pcp, oval, nval) \
 	raw_cpu_generic_cmpxchg(pcp, oval, nval)
@@ -367,6 +386,15 @@ do {									\
 	raw_cpu_generic_cmpxchg(pcp, oval, nval)
 #endif
 
+#ifndef raw_cpu_cmpxchg64
+#define raw_cpu_cmpxchg64(pcp, oval, nval) \
+	raw_cpu_generic_cmpxchg(pcp, oval, nval)
+#endif
+#ifndef raw_cpu_cmpxchg128
+#define raw_cpu_cmpxchg128(pcp, oval, nval) \
+	raw_cpu_generic_cmpxchg(pcp, oval, nval)
+#endif
+
 #ifndef raw_cpu_cmpxchg_double_1
 #define raw_cpu_cmpxchg_double_1(pcp1, pcp2, oval1, oval2, nval1, nval2) \
 	raw_cpu_generic_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2)
@@ -512,6 +540,25 @@ do {									\
 #endif
 #endif
 
+#ifndef this_cpu_try_cmpxchg64
+#ifdef this_cpu_cmpxchg64
+#define this_cpu_try_cmpxchg64(pcp, ovalp, nval) \
+	__cpu_fallback_try_cmpxchg(pcp, ovalp, nval, this_cpu_cmpxchg64)
+#else
+#define this_cpu_try_cmpxchg64(pcp, ovalp, nval) \
+	this_cpu_generic_try_cmpxchg(pcp, ovalp, nval)
+#endif
+#endif
+#ifndef this_cpu_try_cmpxchg128
+#ifdef this_cpu_cmpxchg128
+#define this_cpu_try_cmpxchg128(pcp, ovalp, nval) \
+	__cpu_fallback_try_cmpxchg(pcp, ovalp, nval, this_cpu_cmpxchg128)
+#else
+#define this_cpu_try_cmpxchg128(pcp, ovalp, nval) \
+	this_cpu_generic_try_cmpxchg(pcp, ovalp, nval)
+#endif
+#endif
+
 #ifndef this_cpu_cmpxchg_1
 #define this_cpu_cmpxchg_1(pcp, oval, nval) \
 	this_cpu_generic_cmpxchg(pcp, oval, nval)
@@ -529,6 +576,15 @@ do {									\
 	this_cpu_generic_cmpxchg(pcp, oval, nval)
 #endif
 
+#ifndef this_cpu_cmpxchg64
+#define this_cpu_cmpxchg64(pcp, oval, nval) \
+	this_cpu_generic_cmpxchg(pcp, oval, nval)
+#endif
+#ifndef this_cpu_cmpxchg128
+#define this_cpu_cmpxchg128(pcp, oval, nval) \
+	this_cpu_generic_cmpxchg(pcp, oval, nval)
+#endif
+
 #ifndef this_cpu_cmpxchg_double_1
 #define this_cpu_cmpxchg_double_1(pcp1, pcp2, oval1, oval2, nval1, nval2) \
 	this_cpu_generic_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2)


