Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E49411E424
	for <lists+linux-arch@lfdr.de>; Fri, 13 Dec 2019 13:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfLMM4n (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Dec 2019 07:56:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46220 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfLMM4n (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 Dec 2019 07:56:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fWjlDQlwIoBg7I4Z9XSj9pI9UUWfLrkzsxAziGh6H/M=; b=iQu8Ss5CvIW0fiJBxMLgkD1jm
        yz+ajnmICV4TjIDDgyjd7PjqlmuUEvwzpxv4iI6JOc4i4t2KIec0epVoJTyvbUHEiqpxM6AJ+Xt05
        sKMlHGiYwJk4ddTqnO404xiUWfpw8tXg1eqIYVKvSm4e0J/vOrP4MaT79qCHrwdyRKW34PUesKBVP
        u/FrqqKsWXFJr9rj6glrIgaha27VGjLLX/VvZx6keNKxpAzE9YM5ANFtm2gDn8hL2KCBjRWD1jabQ
        sRW9rFRq/ySsD5jIc8sZQIUccKV4JWAI1eusNTtWdFHf/Ti/SiaUpwv58KDQc+kuAmMRc9g/B9vAp
        wYyfUNA/g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifkUX-0002Gq-OV; Fri, 13 Dec 2019 12:56:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 385E5305FFF;
        Fri, 13 Dec 2019 13:54:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EC16A20121961; Fri, 13 Dec 2019 13:56:18 +0100 (CET)
Date:   Fri, 13 Dec 2019 13:56:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>, dja@axtens.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-arch <linux-arch@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
Message-ID: <20191213125618.GD2844@hirez.programming.kicks-ass.net>
References: <20191212080105.GV2844@hirez.programming.kicks-ass.net>
 <20191212100756.GA11317@willie-the-truck>
 <20191212104610.GW2827@hirez.programming.kicks-ass.net>
 <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
 <20191212180634.GA19020@willie-the-truck>
 <CAHk-=whRxB0adkz+V7SQC8Ac_rr_YfaPY8M2mFDfJP2FFBNz8A@mail.gmail.com>
 <20191212193401.GB19020@willie-the-truck>
 <20191212202157.GD11457@worktop.programming.kicks-ass.net>
 <20191212205338.GB11802@worktop.programming.kicks-ass.net>
 <20191213104706.xnpqaehmtean3mkd@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213104706.xnpqaehmtean3mkd@ltop.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 13, 2019 at 11:47:06AM +0100, Luc Van Oostenryck wrote:
> On Thu, Dec 12, 2019 at 09:53:38PM +0100, Peter Zijlstra wrote:
> > Now, looking at the current GCC source:
> > 
> >   https://github.com/gcc-mirror/gcc/blob/97d7270f894395e513667a031a0c309d1819d05e/gcc/c/c-parser.c#L3707
> > 
> > it seems that __typeof__() is supposed to strip all qualifiers from
> > _Atomic types. That lead me to try:
> > 
> > 	typeof(_Atomic typeof(p)) __p = (p);
> > 
> > But alas, I still get the same junk you got for ool_store_release() :/
> 
> I was checking this to see if Sparse was ready to support this.
> I was a bit surprised because at first sigth GCC was doing as
> it claims (typeof striping const & volatile on _Atomic types)
> but your exampe wasn't working. But it's working if an
> intermediate var is used:
> 	_Atomic typeof(p) tmp;
> 	typeof(tmp) __p = (p);
> or, uglier but probably more practical:
> 	typeof(({_Atomic typeof(p) tmp; })) __p = (p);
> 
> Go figure!

Excellent! I had to change it to something like:

#define unqual_typeof(x)    typeof(({_Atomic typeof(x) ___x __maybe_unused; ___x; }))

but that does indeed work!

Now I suppose we should wrap that in a symbol that indicates our
compiler does indeed support _Atomic, otherwise things will come apart.

That is, my gcc-4.6 doesn't seem to have it, while gcc-4.8 does, which
is exactly the range that needs the daft READ_ONCE() construct, how
convenient :/

Something a little like this perhaps?

---

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 7d9cc5ec4971..c389af602da8 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -75,9 +75,9 @@ static inline unsigned long array_index_mask_nospec(unsigned long idx,
 
 #define __smp_store_release(p, v)					\
 do {									\
-	typeof(p) __p = (p);						\
-	union { typeof(*p) __val; char __c[1]; } __u =			\
-		{ .__val = (__force typeof(*p)) (v) };			\
+	unqual_typeof(p) __p = (p);					\
+	union { unqual_typeof(*p) __val; char __c[1]; } __u =	\
+		{ .__val = (__force unqual_typeof(*p)) (v) };	\
 	compiletime_assert_atomic_type(*p);				\
 	kasan_check_write(__p, sizeof(*p));				\
 	switch (sizeof(*p)) {						\
@@ -110,8 +110,8 @@ do {									\
 
 #define __smp_load_acquire(p)						\
 ({									\
-	union { typeof(*p) __val; char __c[1]; } __u;			\
-	typeof(p) __p = (p);						\
+	union { unqual_typeof(*p) __val; char __c[1]; } __u;		\
+	unqual_typeof(p) __p = (p);					\
 	compiletime_assert_atomic_type(*p);				\
 	kasan_check_read(__p, sizeof(*p));				\
 	switch (sizeof(*p)) {						\
@@ -141,8 +141,8 @@ do {									\
 
 #define smp_cond_load_relaxed(ptr, cond_expr)				\
 ({									\
-	typeof(ptr) __PTR = (ptr);					\
-	typeof(*ptr) VAL;						\
+	unqual_typeof(ptr) __PTR = (ptr);				\
+	unqual_typeof(*ptr) VAL;					\
 	for (;;) {							\
 		VAL = READ_ONCE(*__PTR);				\
 		if (cond_expr)						\
@@ -154,8 +154,8 @@ do {									\
 
 #define smp_cond_load_acquire(ptr, cond_expr)				\
 ({									\
-	typeof(ptr) __PTR = (ptr);					\
-	typeof(*ptr) VAL;						\
+	unqual_typeof(ptr) __PTR = (ptr);				\
+	unqual_typeof(*ptr) VAL;					\
 	for (;;) {							\
 		VAL = smp_load_acquire(__PTR);				\
 		if (cond_expr)						\
diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 85b28eb80b11..dd5bb055f5ab 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -228,8 +228,8 @@ do {									\
  */
 #ifndef smp_cond_load_relaxed
 #define smp_cond_load_relaxed(ptr, cond_expr) ({		\
-	typeof(ptr) __PTR = (ptr);				\
-	typeof(*ptr) VAL;					\
+	unqual_typeof(ptr) __PTR = (ptr);			\
+	unqual_typeof(*ptr) VAL;				\
 	for (;;) {						\
 		VAL = READ_ONCE(*__PTR);			\
 		if (cond_expr)					\
@@ -250,7 +250,7 @@ do {									\
  */
 #ifndef smp_cond_load_acquire
 #define smp_cond_load_acquire(ptr, cond_expr) ({		\
-	typeof(*ptr) _val;					\
+	unqual_typeof(*ptr) _val;				\
 	_val = smp_cond_load_relaxed(ptr, cond_expr);		\
 	smp_acquire__after_ctrl_dep();				\
 	_val;							\
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 0eb2a1cc411d..15fd7ea3882a 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -179,3 +179,10 @@
 #endif
 
 #define __no_fgcse __attribute__((optimize("-fno-gcse")))
+
+#if GCC_VERSION < 40800
+/*
+ * GCC-4.6 doesn't support _Atomic, which is required to strip qualifiers.
+ */
+#define unqual_typeof(x)	typeof(x)
+#endif
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index ad8c76144a3c..9736993f2ba1 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -279,7 +279,7 @@ void __write_once_size(volatile void *p, void *res, int size)
 
 #define __READ_ONCE(x, check)						\
 ({									\
-	union { typeof(x) __val; char __c[1]; } __u;			\
+	union { unqual_typeof(x) __val; char __c[1]; } __u;		\
 	if (check)							\
 		__read_once_size(&(x), __u.__c, sizeof(x));		\
 	else								\
@@ -302,12 +302,12 @@ unsigned long read_word_at_a_time(const void *addr)
 	return *(unsigned long *)addr;
 }
 
-#define WRITE_ONCE(x, val) \
-({							\
-	union { typeof(x) __val; char __c[1]; } __u =	\
-		{ .__val = (__force typeof(x)) (val) }; \
-	__write_once_size(&(x), __u.__c, sizeof(x));	\
-	__u.__val;					\
+#define WRITE_ONCE(x, val)					\
+({								\
+	union { unqual_typeof(x) __val; char __c[1]; } __u =	\
+		{ .__val = (__force unqual_typeof(x)) (val) };	\
+	__write_once_size(&(x), __u.__c, sizeof(x));		\
+	__u.__val;						\
 })
 
 #include <linux/kcsan.h>
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 72393a8c1a6c..fe8012c54251 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -243,4 +243,11 @@ struct ftrace_likely_data {
 #define __diag_error(compiler, version, option, comment) \
 	__diag_ ## compiler(version, error, option)
 
+#ifndef unqual_typeof
+/*
+ * GCC __typeof__() strips all qualifiers from _Atomic types.
+ */
+#define unqual_typeof(x)	typeof(({_Atomic typeof(x) ___x __maybe_unused; ___x; }))
+#endif
+
 #endif /* __LINUX_COMPILER_TYPES_H */
