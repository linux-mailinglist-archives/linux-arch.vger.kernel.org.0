Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3A3710C67
	for <lists+linux-arch@lfdr.de>; Thu, 25 May 2023 14:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241073AbjEYMvI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 May 2023 08:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbjEYMvH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 May 2023 08:51:07 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A100135;
        Thu, 25 May 2023 05:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CbOUeGIPPTYO+RDwR++9bbnSmnxFiSpb24Vrd039RHU=; b=UWh+D7q5fSKs/u+72BHr4FkJ/K
        YoXLj1At4QppxJttqncoojvdUKHXEbmsi+/5zVMXINyDz/0Tqvd9WXg2DrhjaohlsmOUDiPkhH67A
        BuP2MBWCJiXaAw8bERA/Dj4xUQmdAgGlu/50JMrQDQVESmfg1hosRCp6Oh9TZ1PUloeaPtQz5y8hn
        yzLLFmbagcs3vaLCm81whwwKSIOiZnZw0DwAwa1eN9bUsF5VJAhf7cNz+5vNIwf3curZC8WIPImCX
        MyuBWaX1N5vW8Qj+aCkdoGauXJn5hXp8cx4nv0NMrET4P1TT8fIkZIIYV6gV9V8bJ4/10Iwh6Kt8Q
        D+Tp7Naw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q2APn-006XSv-1a;
        Thu, 25 May 2023 12:49:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 30813300338;
        Thu, 25 May 2023 14:49:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BDC19213168E1; Thu, 25 May 2023 14:49:55 +0200 (CEST)
Date:   Thu, 25 May 2023 14:49:55 +0200
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
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v3 05/11] percpu: Wire up cmpxchg128
Message-ID: <20230525124955.GS83892@hirez.programming.kicks-ass.net>
References: <20230515075659.118447996@infradead.org>
 <20230515080554.248739380@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515080554.248739380@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 15, 2023 at 09:57:04AM +0200, Peter Zijlstra wrote:
> In order to replace cmpxchg_double() with the newly minted
> cmpxchg128() family of functions, wire it up in this_cpu_cmpxchg().
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
> --- a/arch/x86/include/asm/percpu.h
> +++ b/arch/x86/include/asm/percpu.h
> @@ -210,6 +210,65 @@ do {									\
>  	(typeof(_var))(unsigned long) pco_old__;			\
>  })
>  
> +#if defined(CONFIG_X86_32) && defined(CONFIG_X86_CMPXCHG64)
> +#define percpu_cmpxchg64_op(size, qual, _var, _oval, _nval)		\
> +({									\
> +	union {								\
> +		u64 var;						\
> +		struct {						\
> +			u32 low, high;					\
> +		};							\
> +	} old__, new__;							\
> +									\
> +	old__.var = _oval;						\
> +	new__.var = _nval;						\
> +									\
> +	asm qual ("cmpxchg8b " __percpu_arg([var])			\
> +		  : [var] "+m" (_var),					\
> +		    "+a" (old__.low),					\
> +		    "+d" (old__.high)					\
> +		  : "b" (new__.low),					\
> +		    "c" (new__.high)					\
> +		  : "memory");						\
> +									\
> +	old__.var;							\
> +})
> +
> +#define raw_cpu_cmpxchg64(pcp, oval, nval)	percpu_cmpxchg64_op(8,         , pcp, oval, nval)
> +#define this_cpu_cmpxchg64(pcp, oval, nval)	percpu_cmpxchg64_op(8, volatile, pcp, oval, nval)
> +#endif
> +
> +#ifdef CONFIG_X86_64
> +#define raw_cpu_cmpxchg64(pcp, oval, nval)	percpu_cmpxchg_op(8,         , pcp, oval, nval);
> +#define this_cpu_cmpxchg64(pcp, oval, nval)	percpu_cmpxchg_op(8, volatile, pcp, oval, nval);
> +
> +#define percpu_cmpxchg128_op(size, qual, _var, _oval, _nval)		\
> +({									\
> +	union {								\
> +		u128 var;						\
> +		struct {						\
> +			u64 low, high;					\
> +		};							\
> +	} old__, new__;							\
> +									\
> +	old__.var = _oval;						\
> +	new__.var = _nval;						\
> +									\
> +	asm qual ("cmpxchg16b " __percpu_arg([var])			\
> +		  : [var] "+m" (_var),					\
> +		    "+a" (old__.low),					\
> +		    "+d" (old__.high)					\
> +		  : "b" (new__.low),					\
> +		    "c" (new__.high)					\
> +		  : "memory");						\
> +									\
> +	old__.var;							\
> +})
> +
> +#define raw_cpu_cmpxchg128(pcp, oval, nval)	percpu_cmpxchg128_op(16,         , pcp, oval, nval)
> +#define this_cpu_cmpxchg128(pcp, oval, nval)	percpu_cmpxchg128_op(16, volatile, pcp, oval, nval)
> +#endif
> +
>  /*
>   * this_cpu_read() makes gcc load the percpu variable every time it is
>   * accessed while this_cpu_read_stable() allows the value to be cached.

Since this_cpu_cmpxchg*() is assumed to always be present (their usage
is not guarded with system_has_cmpxchg*() it needs a fallback for then
the instruction is not present.

The below has been tested with clearcpuid=cx16; adding an obvious defect
in the fallback implemention crashes the kernel, with the code as
presented it boots.

Build tested i386-defconfig.

(the things we do for museum pieces :/)

---
 include/asm/percpu.h |   25 +++++++++++---------
 lib/Makefile         |    3 +-
 lib/cmpxchg16b_emu.S |   43 ++++++++++++++++++++--------------
 lib/cmpxchg8b_emu.S  |   63 +++++++++++++++++++++++++++++++++++++++------------
 4 files changed, 90 insertions(+), 44 deletions(-)

--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -210,7 +210,7 @@ do {									\
 	(typeof(_var))(unsigned long) pco_old__;			\
 })
 
-#if defined(CONFIG_X86_32) && defined(CONFIG_X86_CMPXCHG64)
+#ifdef CONFIG_X86_32
 #define percpu_cmpxchg64_op(size, qual, _var, _oval, _nval)		\
 ({									\
 	union {								\
@@ -223,13 +223,14 @@ do {									\
 	old__.var = _oval;						\
 	new__.var = _nval;						\
 									\
-	asm qual ("cmpxchg8b " __percpu_arg([var])			\
+	asm qual (ALTERNATIVE("leal %P[var], %%esi; call this_cpu_cmpxchg8b_emu", \
+			      "cmpxchg8b " __percpu_arg([var]), X86_FEATURE_CX8) \
 		  : [var] "+m" (_var),					\
 		    "+a" (old__.low),					\
 		    "+d" (old__.high)					\
 		  : "b" (new__.low),					\
 		    "c" (new__.high)					\
-		  : "memory");						\
+		  : "memory", "esi");					\
 									\
 	old__.var;							\
 })
@@ -254,13 +255,14 @@ do {									\
 	old__.var = _oval;						\
 	new__.var = _nval;						\
 									\
-	asm qual ("cmpxchg16b " __percpu_arg([var])			\
+	asm qual (ALTERNATIVE("leaq %P[var], %%rsi; call this_cpu_cmpxchg16b_emu", \
+			      "cmpxchg16b " __percpu_arg([var]), X86_FEATURE_CX16) \
 		  : [var] "+m" (_var),					\
 		    "+a" (old__.low),					\
 		    "+d" (old__.high)					\
 		  : "b" (new__.low),					\
 		    "c" (new__.high)					\
-		  : "memory");						\
+		  : "memory", "rsi");					\
 									\
 	old__.var;							\
 })
@@ -400,12 +402,13 @@ do {									\
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
@@ -15,32 +21,61 @@
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
