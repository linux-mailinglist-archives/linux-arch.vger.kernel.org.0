Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975B068BD41
	for <lists+linux-arch@lfdr.de>; Mon,  6 Feb 2023 13:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjBFMtd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Feb 2023 07:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjBFMtc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Feb 2023 07:49:32 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E374511161;
        Mon,  6 Feb 2023 04:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bcFixH8+YqomwdNAIz5TC0lbv8llOKjCDTzT/15p89Y=; b=gDr6q+UUUvpmalKveY90Z9mKoU
        feL7VIJlC7cOsfPh7TWmPCKxMv/3rZe/BGG7ZoJI8x2UqBwhLbYi85gyj63IbvaRUs4GIiTSO3Pqo
        OVK5BTPq+pLIlLu+H1RxuK8O9yhcxWGvv4PBrGClRiRRzIlOCLrSWoSK80kPb8FC2Z/3vi44br+dz
        QqiszmVInSmiuqpwITmG88XRQlvSb/CZcPEGuI9mtOZ6RJLfuLIgomGZUS1RojJOkp3LECt8WAq3T
        70mP4KpcwQH+siIlqQo8iRSiyKggIkVR5F3EMW/BFFEjqMwd8rtkS5Yyzd0SDfDSezVzpyJz95bd8
        Atrsuu0g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pP0uT-006YgS-2N;
        Mon, 06 Feb 2023 12:47:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ED3B830012F;
        Mon,  6 Feb 2023 13:48:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BCEBF207A0B88; Mon,  6 Feb 2023 13:48:23 +0100 (CET)
Date:   Mon, 6 Feb 2023 13:48:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, dennis@kernel.org,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Heiko Carstens <hca@linux.ibm.com>, gor@linux.ibm.com,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        borntraeger@linux.ibm.com, Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        suravee.suthikulpanit@amd.com, Robin Murphy <robin.murphy@arm.com>,
        dwmw2@infradead.org, Baolu Lu <baolu.lu@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, iommu@lists.linux.dev,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 05/10] percpu: Wire up cmpxchg128
Message-ID: <Y+D3F2pg7X4XFT4r@hirez.programming.kicks-ass.net>
References: <20230202145030.223740842@infradead.org>
 <20230202152655.494373332@infradead.org>
 <24007667-1ff3-4c86-9c17-a361c3f9f072@app.fastmail.com>
 <Y+DjULnIxcPU/rtp@hirez.programming.kicks-ass.net>
 <Y+DvI7ai/wuovjER@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+DvI7ai/wuovjER@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 06, 2023 at 01:14:28PM +0100, Peter Zijlstra wrote:
> On Mon, Feb 06, 2023 at 12:24:00PM +0100, Peter Zijlstra wrote:
> 
> > > Unless I have misunderstood what you are doing, my concerns are
> > > still the same:
> > > 
> > > >  #define this_cpu_cmpxchg(pcp, oval, nval) \
> > > > -	__pcpu_size_call_return2(this_cpu_cmpxchg_, pcp, oval, nval)
> > > > +	__pcpu_size16_call_return2(this_cpu_cmpxchg_, pcp, oval, nval)
> > > >  #define this_cpu_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, 
> > > > nval2) \
> > > >  	__pcpu_double_call_return_bool(this_cpu_cmpxchg_double_, pcp1, pcp2, 
> > > > oval1, oval2, nval1, nval2)
> > > 
> > > Having a variable-length this_cpu_cmpxchg() that turns into cmpxchg128()
> > > and cmpxchg64() even on CPUs where this traps (!X86_FEATURE_CX16) seems
> > > like a bad design to me.
> > > 
> > > I would much prefer fixed-length this_cpu_cmpxchg64()/this_cpu_cmpxchg128()
> > > calls that never trap but fall back to the generic version on CPUs that
> > > are lacking the atomics.
> > 
> > You're thinking acidental usage etc..? Lemme see what I can do.
> 
> So lookng at this I remember why I did it like this, currently 32bit
> archs silently fall back to the generics for most/all 64bit ops.
> 
> And personally I would just as soon drop support for the
> !X86_FEATURE_CX* cpus... :/ Those are some serious museum pieces.
> 
> One problem with silent downgrades like this is that semantics vs NMI
> change, which makes for subtle bugs on said museum pieces.
> 
> Basically, using 64bit percpu ops on 32bit is already somewhat dangerous
> -- wiring up native cmpxchg64 support in that case seemed an
> improvement.
> 
> Anyway... let me get on with doing explicit
> {raw,this}_cpu_cmpxchg{64,128}() thingies.

I only converted x86 and didn't do the automagic downgrade...

Opinions?

---
 arch/x86/include/asm/percpu.h | 11 +++++++----
 include/asm-generic/percpu.h  | 18 ++++++++++++++----
 include/linux/percpu-defs.h   | 20 ++------------------
 mm/slab.h                     |  2 ++
 mm/slub.c                     | 21 +++++++++++----------
 5 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 4c803a1fd0e7..7515e065369b 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -214,7 +214,7 @@ do {									\
 #define percpu_cmpxchg64_op(size, qual, _var, _oval, _nval)		\
 ({									\
 	union {								\
-		typeof(_var) var;					\
+		u64 val;						\
 		struct {						\
 			u32 low, high;					\
 		};							\
@@ -234,15 +234,18 @@ do {									\
 	old__.var;							\
 })
 
-#define raw_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg64_op(8,         , pcp, oval, nval)
-#define this_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg64_op(8, volatile, pcp, oval, nval)
+#define raw_cpu_cmpxchg64(pcp, oval, nval)	percpu_cmpxchg64_op(8,         , pcp, oval, nval)
+#define this_cpu_cmpxchg64(pcp, oval, nval)	percpu_cmpxchg64_op(8, volatile, pcp, oval, nval)
 #endif
 
 #ifdef CONFIG_X86_64
+#define raw_cpu_cmpxchg64(pcp, oval, nval)	percpu_cmpxchg_op(8,         , pcp, oval, nval);
+#define this_cpu_cmpxchg64(pcp, oval, nval)	percpu_cmpxchg_op(8, volatile, pcp, oval, nval);
+
 #define percpu_cmpxchg128_op(size, qual, _var, _oval, _nval)		\
 ({									\
 	union {								\
-		typeof(_var) var;					\
+		u128 var;						\
 		struct {						\
 			u64 low, high;					\
 		};							\
diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
index ad254a20fe68..7da7d1793411 100644
--- a/include/asm-generic/percpu.h
+++ b/include/asm-generic/percpu.h
@@ -274,8 +274,13 @@ do {									\
 #define raw_cpu_cmpxchg_8(pcp, oval, nval) \
 	raw_cpu_generic_cmpxchg(pcp, oval, nval)
 #endif
-#ifndef raw_cpu_cmpxchg_16
-#define raw_cpu_cmpxchg_16(pcp, oval, nval) \
+
+#ifndef raw_cpu_cmpxchg64
+#define raw_cpu_cmpxchg64(pcp, oval, nval) \
+	raw_cpu_generic_cmpxchg(pcp, oval, nval)
+#endif
+#ifndef raw_cpu_cmpxchg128
+#define raw_cpu_cmpxchg128(pcp, oval, nval) \
 	raw_cpu_generic_cmpxchg(pcp, oval, nval)
 #endif
 
@@ -386,8 +391,13 @@ do {									\
 #define this_cpu_cmpxchg_8(pcp, oval, nval) \
 	this_cpu_generic_cmpxchg(pcp, oval, nval)
 #endif
-#ifndef this_cpu_cmpxchg_16
-#define this_cpu_cmpxchg_16(pcp, oval, nval) \
+
+#ifndef this_cpu_cmpxchg64
+#define this_cpu_cmpxchg64(pcp, oval, nval) \
+	this_cpu_generic_cmpxchg(pcp, oval, nval)
+#endif
+#ifndef this_cpu_cmpxchg128
+#define this_cpu_cmpxchg128(pcp, oval, nval) \
 	this_cpu_generic_cmpxchg(pcp, oval, nval)
 #endif
 
diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index fe3c7fc2d411..7cd614a46af4 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -343,22 +343,6 @@ static inline void __this_cpu_preempt_check(const char *op) { }
 	pscr2_ret__;							\
 })
 
-#define __pcpu_size16_call_return2(stem, variable, ...)			\
-({									\
-	typeof(variable) pscr2_ret__;					\
-	__verify_pcpu_ptr(&(variable));					\
-	switch(sizeof(variable)) {					\
-	case 1: pscr2_ret__ = stem##1(variable, __VA_ARGS__); break;	\
-	case 2: pscr2_ret__ = stem##2(variable, __VA_ARGS__); break;	\
-	case 4: pscr2_ret__ = stem##4(variable, __VA_ARGS__); break;	\
-	case 8: pscr2_ret__ = stem##8(variable, __VA_ARGS__); break;	\
-	case 16: pscr2_ret__ = stem##16(variable, __VA_ARGS__); break;	\
-	default:							\
-		__bad_size_call_parameter(); break;			\
-	}								\
-	pscr2_ret__;							\
-})
-
 #define __pcpu_size_call(stem, variable, ...)				\
 do {									\
 	__verify_pcpu_ptr(&(variable));					\
@@ -414,7 +398,7 @@ do {									\
 #define raw_cpu_add_return(pcp, val)	__pcpu_size_call_return2(raw_cpu_add_return_, pcp, val)
 #define raw_cpu_xchg(pcp, nval)		__pcpu_size_call_return2(raw_cpu_xchg_, pcp, nval)
 #define raw_cpu_cmpxchg(pcp, oval, nval) \
-	__pcpu_size16_call_return2(raw_cpu_cmpxchg_, pcp, oval, nval)
+	__pcpu_size_call_return2(raw_cpu_cmpxchg_, pcp, oval, nval)
 #define raw_cpu_sub(pcp, val)		raw_cpu_add(pcp, -(val))
 #define raw_cpu_inc(pcp)		raw_cpu_add(pcp, 1)
 #define raw_cpu_dec(pcp)		raw_cpu_sub(pcp, 1)
@@ -493,7 +477,7 @@ do {									\
 #define this_cpu_add_return(pcp, val)	__pcpu_size_call_return2(this_cpu_add_return_, pcp, val)
 #define this_cpu_xchg(pcp, nval)	__pcpu_size_call_return2(this_cpu_xchg_, pcp, nval)
 #define this_cpu_cmpxchg(pcp, oval, nval) \
-	__pcpu_size16_call_return2(this_cpu_cmpxchg_, pcp, oval, nval)
+	__pcpu_size_call_return2(this_cpu_cmpxchg_, pcp, oval, nval)
 #define this_cpu_sub(pcp, val)		this_cpu_add(pcp, -(typeof(pcp))(val))
 #define this_cpu_inc(pcp)		this_cpu_add(pcp, 1)
 #define this_cpu_dec(pcp)		this_cpu_sub(pcp, 1)
diff --git a/mm/slab.h b/mm/slab.h
index 19e1899673ef..50b5edd6a950 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -25,11 +25,13 @@ typedef union {
 # ifdef system_has_cmpxchg128
 # define system_has_freelist_aba()	system_has_cmpxchg128()
 # define try_cmpxchg_freelist		try_cmpxchg128
+# define this_cpu_cmpxchg_freelist	this_cpu_cmpxchg128
 # endif
 #else /* CONFIG_64BIT */
 # ifdef system_has_cmpxchg64
 # define system_has_freelist_aba()	system_has_cmpxchg64()
 # define try_cmpxchg_freelist		try_cmpxchg64
+# define this_cpu_cmpxchg_freelist	this_cpu_cmpxchg64
 # endif
 #endif /* CONFIG_64BIT */
 
diff --git a/mm/slub.c b/mm/slub.c
index 45f2b28d60e1..35939c5aa28a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -523,17 +523,14 @@ __update_freelist_fast(struct slab *slab,
 		      void *freelist_old, unsigned long counters_old,
 		      void *freelist_new, unsigned long counters_new)
 {
-
-	bool ret = false;
-
-#ifdef system_has_freelist_aba
+#ifdef syste_has_freelist_aba
 	freelist_aba_t old = { .freelist = freelist_old, .counter = counters_old };
 	freelist_aba_t new = { .freelist = freelist_new, .counter = counters_new };
 
-	ret = try_cmpxchg_freelist(&slab->freelist_counter.full, &old.full, new.full);
-#endif /* system_has_freelist_aba */
-
-	return ret;
+	return try_cmpxchg_freelist(&slab->freelist_counter.full, &old.full, new.full);
+#else
+	return false;
+#endif
 }
 
 static inline bool
@@ -3039,11 +3036,15 @@ __update_cpu_freelist_fast(struct kmem_cache *s,
 			   void *freelist_old, void *freelist_new,
 			   unsigned long tid)
 {
+#ifdef system_has_freelist_aba
 	freelist_aba_t old = { .freelist = freelist_old, .counter = tid };
 	freelist_aba_t new = { .freelist = freelist_new, .counter = next_tid(tid) };
 
-	return this_cpu_cmpxchg(s->cpu_slab->freelist_tid.full,
-				old.full, new.full) == old.full;
+	return this_cpu_cmpxchg_freelist(s->cpu_slab->freelist_tid.full,
+					 old.full, new.full) == old.full;
+#else
+	return false;
+#endif
 }
 
 /*
