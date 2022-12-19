Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1B9650F27
	for <lists+linux-arch@lfdr.de>; Mon, 19 Dec 2022 16:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbiLSPqY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Dec 2022 10:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiLSPpc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Dec 2022 10:45:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A994313F34;
        Mon, 19 Dec 2022 07:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=wYWf/6rFD/HTF6iXeYomE1fwdD9WYUdD1TmCeycYrdc=; b=Ok+W64ZxfwZpDsrf9CXSHPYK0h
        I6SL5Z2AIcqGg7qtbahx3ygvP+yDl3hCzMKCe+4ecyC6I/mFyduGdyhWQrU7BTaPc9aDFcpHLOXlH
        cbLTk5WibKaAvN3kfNlfjolGtji/pdnI6Ja5JtV2Q387gaBBdGgO5CfK4Vm1/MzkuoTzB1HsrUpvd
        zFGz+v2PV3pdYCIsDzG4MU5E676AYo55K30T8PLAWiYVU35lcFfetSFLkve3O101sZijZmU3N3p3w
        O9q8qTmUA4IoKbBWg128vEdtWEsLMqqB4aTiVxBT7zheUDZLbwk4tmzx3dkKgEltN9+VZI9TgG4st
        Bx1HKCWw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p7IIU-000qwu-6N; Mon, 19 Dec 2022 15:43:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1989A30339C;
        Mon, 19 Dec 2022 16:43:10 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A6BDB20B0F8A0; Mon, 19 Dec 2022 16:43:06 +0100 (CET)
Message-ID: <20221219154119.550996611@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 19 Dec 2022 16:35:36 +0100
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
Subject: [RFC][PATCH 11/12] slub: Replace cmpxchg_double()
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


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/slub_def.h |   12 ++-
 mm/slab.h                |   41 +++++++++++--
 mm/slub.c                |  146 ++++++++++++++++++++++++++++-------------------
 3 files changed, 135 insertions(+), 64 deletions(-)

--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -39,15 +39,21 @@ enum stat_item {
 	CPU_PARTIAL_FREE,	/* Refill cpu partial on free */
 	CPU_PARTIAL_NODE,	/* Refill cpu partial from node partial */
 	CPU_PARTIAL_DRAIN,	/* Drain cpu partial to node partial */
-	NR_SLUB_STAT_ITEMS };
+	NR_SLUB_STAT_ITEMS
+};
 
 /*
  * When changing the layout, make sure freelist and tid are still compatible
  * with this_cpu_cmpxchg_double() alignment requirements.
  */
 struct kmem_cache_cpu {
-	void **freelist;	/* Pointer to next available object */
-	unsigned long tid;	/* Globally unique transaction id */
+	union {
+		struct {
+			void **freelist;	/* Pointer to next available object */
+			unsigned long tid;	/* Globally unique transaction id */
+		};
+		freelist_aba_t freelist_tid;
+	};
 	struct slab *slab;	/* The slab from which we are allocating */
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 	struct slab *partial;	/* Partially allocated frozen slabs */
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -5,6 +5,32 @@
  * Internal slab definitions
  */
 
+/*
+ * Freelist pointer and counter to cmpxchg together, avoids the typical ABA
+ * problems with cmpxchg of just a pointer.
+ */
+typedef union {
+	struct {
+		void *freelist;
+		unsigned long counter;
+	};
+#ifdef CONFIG_64BIT
+	u128 full;
+#else
+	u64 full;
+#endif
+} freelist_aba_t;
+
+#ifdef CONFIG_64BIT
+# ifdef system_has_cmpxchg128
+# define system_has_freelist_aba() system_has_cmpxchg128()
+# endif
+#else /* CONFIG_64BIT */
+# ifdef system_has_cmpxchg64
+# define system_has_freelist_aba() system_has_cmpxchg64()
+# endif
+#endif /* CONFIG_64BIT */
+
 /* Reuses the bits in struct page */
 struct slab {
 	unsigned long __page_flags;
@@ -34,14 +60,19 @@ struct slab {
 	};
 	struct kmem_cache *slab_cache;
 	/* Double-word boundary */
-	void *freelist;		/* first free object */
 	union {
-		unsigned long counters;
 		struct {
-			unsigned inuse:16;
-			unsigned objects:15;
-			unsigned frozen:1;
+			void *freelist;		/* first free object */
+			union {
+				unsigned long counters;
+				struct {
+					unsigned inuse:16;
+					unsigned objects:15;
+					unsigned frozen:1;
+				};
+			};
 		};
+		freelist_aba_t freelist_counter;
 	};
 	unsigned int __unused;
 
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -280,7 +280,13 @@ static inline bool kmem_cache_has_cpu_pa
 /* Poison object */
 #define __OBJECT_POISON		((slab_flags_t __force)0x80000000U)
 /* Use cmpxchg_double */
+
+#if defined(system_has_freelist_aba) && \
+    defined(CONFIG_HAVE_ALIGNED_STRUCT_PAGE)
 #define __CMPXCHG_DOUBLE	((slab_flags_t __force)0x40000000U)
+#else
+#define __CMPXCHG_DOUBLE	((slab_flags_t __force)0U)
+#endif
 
 /*
  * Tracking user of a slab.
@@ -496,6 +502,47 @@ static __always_inline void slab_unlock(
 	__bit_spin_unlock(PG_locked, &page->flags);
 }
 
+static inline bool
+__update_freelist_fast(struct slab *slab,
+		      void *freelist_old, unsigned long counters_old,
+		      void *freelist_new, unsigned long counters_new)
+{
+
+	bool ret = false;
+
+#ifdef system_has_freelist_aba
+	freelist_aba_t old = { .freelist = freelist_old, .counter = counters_old };
+	freelist_aba_t new = { .freelist = freelist_new, .counter = counters_new };
+
+#ifdef CONFIG_64BIT
+	ret = try_cmpxchg128(&slab->freelist_counter.full, &old.full, new.full);
+#else
+	ret = try_cmpxchg64(&slab->freelist_counter.full, &old.full, new.full);
+#endif
+#endif /* system_has_freelist_aba */
+
+	return ret;
+}
+
+static inline bool
+__update_freelist_slow(struct slab *slab,
+		      void *freelist_old, unsigned long counters_old,
+		      void *freelist_new, unsigned long counters_new)
+{
+	bool ret = false;
+
+	slab_lock(slab);
+	if (slab->freelist == freelist_old &&
+	    slab->counters == counters_old) {
+		slab->freelist = freelist_new;
+		slab->counters = counters_new;
+		ret = true;
+	}
+	slab_unlock(slab);
+
+	return ret;
+}
+
 /*
  * Interrupts must be disabled (for the fallback code to work right), typically
  * by an _irqsave() lock variant. On PREEMPT_RT the preempt_disable(), which is
@@ -503,33 +550,25 @@ static __always_inline void slab_unlock(
  * allocation/ free operation in hardirq context. Therefore nothing can
  * interrupt the operation.
  */
-static inline bool __cmpxchg_double_slab(struct kmem_cache *s, struct slab *slab,
+static inline bool __slab_update_freelist(struct kmem_cache *s, struct slab *slab,
 		void *freelist_old, unsigned long counters_old,
 		void *freelist_new, unsigned long counters_new,
 		const char *n)
 {
+	bool ret;
+
 	if (USE_LOCKLESS_FAST_PATH())
 		lockdep_assert_irqs_disabled();
-#if defined(CONFIG_HAVE_CMPXCHG_DOUBLE) && \
-    defined(CONFIG_HAVE_ALIGNED_STRUCT_PAGE)
+
 	if (s->flags & __CMPXCHG_DOUBLE) {
-		if (cmpxchg_double(&slab->freelist, &slab->counters,
-				   freelist_old, counters_old,
-				   freelist_new, counters_new))
-			return true;
-	} else
-#endif
-	{
-		slab_lock(slab);
-		if (slab->freelist == freelist_old &&
-					slab->counters == counters_old) {
-			slab->freelist = freelist_new;
-			slab->counters = counters_new;
-			slab_unlock(slab);
-			return true;
-		}
-		slab_unlock(slab);
+		ret = __update_freelist_fast(slab, freelist_old, counters_old,
+				            freelist_new, counters_new);
+	} else {
+		ret = __update_freelist_slow(slab, freelist_old, counters_old,
+				            freelist_new, counters_new);
 	}
+	if (likely(ret))
+		return true;
 
 	cpu_relax();
 	stat(s, CMPXCHG_DOUBLE_FAIL);
@@ -541,36 +580,26 @@ static inline bool __cmpxchg_double_slab
 	return false;
 }
 
-static inline bool cmpxchg_double_slab(struct kmem_cache *s, struct slab *slab,
+static inline bool slab_update_freelist(struct kmem_cache *s, struct slab *slab,
 		void *freelist_old, unsigned long counters_old,
 		void *freelist_new, unsigned long counters_new,
 		const char *n)
 {
-#if defined(CONFIG_HAVE_CMPXCHG_DOUBLE) && \
-    defined(CONFIG_HAVE_ALIGNED_STRUCT_PAGE)
+	bool ret;
+
 	if (s->flags & __CMPXCHG_DOUBLE) {
-		if (cmpxchg_double(&slab->freelist, &slab->counters,
-				   freelist_old, counters_old,
-				   freelist_new, counters_new))
-			return true;
-	} else
-#endif
-	{
+		ret = __update_freelist_fast(slab, freelist_old, counters_old,
+				            freelist_new, counters_new);
+	} else {
 		unsigned long flags;
 
 		local_irq_save(flags);
-		slab_lock(slab);
-		if (slab->freelist == freelist_old &&
-					slab->counters == counters_old) {
-			slab->freelist = freelist_new;
-			slab->counters = counters_new;
-			slab_unlock(slab);
-			local_irq_restore(flags);
-			return true;
-		}
-		slab_unlock(slab);
+		ret = __update_freelist_slow(slab, freelist_old, counters_old,
+				            freelist_new, counters_new);
 		local_irq_restore(flags);
 	}
+	if (likely(ret))
+		return true;
 
 	cpu_relax();
 	stat(s, CMPXCHG_DOUBLE_FAIL);
@@ -2168,7 +2197,7 @@ static inline void *acquire_slab(struct
 	VM_BUG_ON(new.frozen);
 	new.frozen = 1;
 
-	if (!__cmpxchg_double_slab(s, slab,
+	if (!__slab_update_freelist(s, slab,
 			freelist, counters,
 			new.freelist, new.counters,
 			"acquire_slab"))
@@ -2500,7 +2529,7 @@ static void deactivate_slab(struct kmem_
 	}
 
 
-	if (!cmpxchg_double_slab(s, slab,
+	if (!slab_update_freelist(s, slab,
 				old.freelist, old.counters,
 				new.freelist, new.counters,
 				"unfreezing slab")) {
@@ -2561,7 +2590,7 @@ static void __unfreeze_partials(struct k
 
 			new.frozen = 0;
 
-		} while (!__cmpxchg_double_slab(s, slab,
+		} while (!__slab_update_freelist(s, slab,
 				old.freelist, old.counters,
 				new.freelist, new.counters,
 				"unfreezing slab"));
@@ -3022,7 +3051,7 @@ static inline void *get_freelist(struct
 		new.inuse = slab->objects;
 		new.frozen = freelist != NULL;
 
-	} while (!__cmpxchg_double_slab(s, slab,
+	} while (!__slab_update_freelist(s, slab,
 		freelist, counters,
 		NULL, new.counters,
 		"get_freelist"));
@@ -3295,6 +3324,18 @@ static __always_inline void maybe_wipe_o
 			0, sizeof(void *));
 }
 
+static inline bool
+__update_cpu_freelist_fast(struct kmem_cache *s,
+			   void *freelist_old, void *freelist_new,
+			   unsigned long tid)
+{
+	freelist_aba_t old = { .freelist = freelist_old, .counter = tid };
+	freelist_aba_t new = { .freelist = freelist_new, .counter = next_tid(tid) };
+
+	return this_cpu_cmpxchg(s->cpu_slab->freelist_tid.full,
+				old.full, new.full) == old.full;
+}
+
 /*
  * Inlined fastpath so that allocation functions (kmalloc, kmem_cache_alloc)
  * have the fastpath folded into their functions. So no function call
@@ -3379,11 +3420,7 @@ static __always_inline void *slab_alloc_
 		 * against code executing on this cpu *not* from access by
 		 * other cpus.
 		 */
-		if (unlikely(!this_cpu_cmpxchg_double(
-				s->cpu_slab->freelist, s->cpu_slab->tid,
-				object, tid,
-				next_object, next_tid(tid)))) {
-
+		if (unlikely(!__update_cpu_freelist_fast(s, object, next_object, tid))) {
 			note_cmpxchg_failure("slab_alloc", s, tid);
 			goto redo;
 		}
@@ -3517,7 +3554,7 @@ static void __slab_free(struct kmem_cach
 			}
 		}
 
-	} while (!cmpxchg_double_slab(s, slab,
+	} while (!slab_update_freelist(s, slab,
 		prior, counters,
 		head, new.counters,
 		"__slab_free"));
@@ -3621,11 +3658,7 @@ static __always_inline void do_slab_free
 
 		set_freepointer(s, tail_obj, freelist);
 
-		if (unlikely(!this_cpu_cmpxchg_double(
-				s->cpu_slab->freelist, s->cpu_slab->tid,
-				freelist, tid,
-				head, next_tid(tid)))) {
-
+		if (unlikely(!__update_cpu_freelist_fast(s, freelist, head, tid))) {
 			note_cmpxchg_failure("slab_free", s, tid);
 			goto redo;
 		}
@@ -4319,11 +4352,12 @@ static int kmem_cache_open(struct kmem_c
 		}
 	}
 
-#if defined(CONFIG_HAVE_CMPXCHG_DOUBLE) && \
+#if defined(system_has_freelist_aba) && \
     defined(CONFIG_HAVE_ALIGNED_STRUCT_PAGE)
-	if (system_has_cmpxchg_double() && (s->flags & SLAB_NO_CMPXCHG) == 0)
+	if (system_has_freelist_aba() && !(s->flags & SLAB_NO_CMPXCHG)) {
 		/* Enable fast mode */
 		s->flags |= __CMPXCHG_DOUBLE;
+	}
 #endif
 
 	/*


