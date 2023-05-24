Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C095970F2D9
	for <lists+linux-arch@lfdr.de>; Wed, 24 May 2023 11:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjEXJeX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 May 2023 05:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjEXJeW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 May 2023 05:34:22 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AD9A1;
        Wed, 24 May 2023 02:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KyV/tS/uN9DzNvQPoG5MMAxe2UuBWYnz6ke7cE6G1wY=; b=nC6jLhXug1y4diFoSQTkvje5KR
        HSD1QlG8SO3q1T+JDKxXq+IlMfgYJDaQ7i7bHwdSKbxsc1MqD1gJdTeKNsIgFVwLNX6DDBZGjtVRb
        MKBZeobJWLqGpbaKIFk6uJnVRCudHgK+Wd+ZPSPTt7amEjPI0BIcViP2iXjtCu6wHmug4YS2CEPgk
        lCvsWBHcU+9gJk2CmiDcf7TpY7jxrns9h9e+tMKuQykDyjuaH++Ji39wKDKsF92bKq7ZYg42fjXCk
        E6KVc0W5rZXwf/wbFS2AGqxSrHJGD7AwxifD6SNSoJNR7tFU/91uNjvSCFKtjJOLOz+bpX42COu48
        7ykdSPMg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1krX-004xKA-0q;
        Wed, 24 May 2023 09:32:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B87553001AE;
        Wed, 24 May 2023 11:32:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0CA772435C811; Wed, 24 May 2023 11:32:47 +0200 (CEST)
Date:   Wed, 24 May 2023 11:32:46 +0200
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
        mpe@ellerman.id.au
Subject: Re: [PATCH v3 08/11] slub: Replace cmpxchg_double()
Message-ID: <20230524093246.GP83892@hirez.programming.kicks-ass.net>
References: <20230515075659.118447996@infradead.org>
 <20230515080554.453785148@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515080554.453785148@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 15, 2023 at 09:57:07AM +0200, Peter Zijlstra wrote:

> @@ -3008,6 +3029,22 @@ static inline bool pfmemalloc_match(stru
>  }
>  
>  #ifndef CONFIG_SLUB_TINY
> +static inline bool
> +__update_cpu_freelist_fast(struct kmem_cache *s,
> +			   void *freelist_old, void *freelist_new,
> +			   unsigned long tid)
> +{
> +#ifdef system_has_freelist_aba
> +	freelist_aba_t old = { .freelist = freelist_old, .counter = tid };
> +	freelist_aba_t new = { .freelist = freelist_new, .counter = next_tid(tid) };
> +
> +	return this_cpu_cmpxchg_freelist(s->cpu_slab->freelist_tid.full,
> +					 old.full, new.full) == old.full;
> +#else
> +	return false;
> +#endif
> +}
> +
>  /*
>   * Check the slab->freelist and either transfer the freelist to the
>   * per cpu freelist or deactivate the slab.
> @@ -3359,11 +3396,7 @@ static __always_inline void *__slab_allo
>  		 * against code executing on this cpu *not* from access by
>  		 * other cpus.
>  		 */
> -		if (unlikely(!this_cpu_cmpxchg_double(
> -				s->cpu_slab->freelist, s->cpu_slab->tid,
> -				object, tid,
> -				next_object, next_tid(tid)))) {
> -
> +		if (unlikely(!__update_cpu_freelist_fast(s, object, next_object, tid))) {
>  			note_cmpxchg_failure("slab_alloc", s, tid);
>  			goto redo;
>  		}
> @@ -3736,11 +3769,7 @@ static __always_inline void do_slab_free
>  
>  		set_freepointer(s, tail_obj, freelist);
>  
> -		if (unlikely(!this_cpu_cmpxchg_double(
> -				s->cpu_slab->freelist, s->cpu_slab->tid,
> -				freelist, tid,
> -				head, next_tid(tid)))) {
> -
> +		if (unlikely(!__update_cpu_freelist_fast(s, freelist, head, tid))) {
>  			note_cmpxchg_failure("slab_free", s, tid);
>  			goto redo;
>  		}

This isn't right; the this_cpu_cmpxchg_double() was unconditional and
relied on the local_irq_save() fallback when no native cmpxchg128 is
present.

The below delta makes things boot again when system_has_cmpxchg128 is
not defined.

I'm going to zap these patches from tip/locking/core for a few days and
fold the below back into the series and let it run through the robots
again.

---
 mm/slab.h | 20 +++++++++++---------
 mm/slub.c |  6 +-----
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 5880c70de3d6..b191bf68e6e0 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -6,36 +6,36 @@
  */
 void __init kmem_cache_init(void);
 
-#ifdef CONFIG_HAVE_ALIGNED_STRUCT_PAGE
 #ifdef CONFIG_64BIT
 # ifdef system_has_cmpxchg128
 # define system_has_freelist_aba()	system_has_cmpxchg128()
 # define try_cmpxchg_freelist		try_cmpxchg128
-# define this_cpu_cmpxchg_freelist	this_cpu_cmpxchg128
-typedef u128 freelist_full_t;
 # endif
+#define this_cpu_cmpxchg_freelist	this_cpu_cmpxchg128
+typedef u128 freelist_full_t;
 #else /* CONFIG_64BIT */
 # ifdef system_has_cmpxchg64
 # define system_has_freelist_aba()	system_has_cmpxchg64()
 # define try_cmpxchg_freelist		try_cmpxchg64
-# define this_cpu_cmpxchg_freelist	this_cpu_cmpxchg64
-typedef u64 freelist_full_t;
 # endif
+#define this_cpu_cmpxchg_freelist	this_cpu_cmpxchg64
+typedef u64 freelist_full_t;
 #endif /* CONFIG_64BIT */
-#endif /* CONFIG_HAVE_ALIGNED_STRUCT_PAGE */
+
+#if defined(system_has_freelist_aba) && !defined(CONFIG_HAVE_ALIGNED_STRUCT_PAGE)
+#undef system_has_freelist_aba
+#endif
 
 /*
  * Freelist pointer and counter to cmpxchg together, avoids the typical ABA
  * problems with cmpxchg of just a pointer.
  */
 typedef union {
-#ifdef system_has_freelist_aba
 	struct {
 		void *freelist;
 		unsigned long counter;
 	};
 	freelist_full_t full;
-#endif
 } freelist_aba_t;
 
 /* Reuses the bits in struct page */
@@ -82,7 +82,9 @@ struct slab {
 						};
 					};
 				};
+#ifdef system_has_freelist_aba
 				freelist_aba_t freelist_counter;
+#endif
 			};
 		};
 		struct rcu_head rcu_head;
@@ -110,7 +112,7 @@ SLAB_MATCH(memcg_data, memcg_data);
 #undef SLAB_MATCH
 static_assert(sizeof(struct slab) <= sizeof(struct page));
 #if defined(system_has_freelist_aba) && defined(CONFIG_SLUB)
-static_assert(IS_ALIGNED(offsetof(struct slab, freelist), 2*sizeof(void *)));
+static_assert(IS_ALIGNED(offsetof(struct slab, freelist), sizeof(freelist_aba_t)));
 #endif
 
 /**
diff --git a/mm/slub.c b/mm/slub.c
index 161b091746b7..af92c770606d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3034,15 +3034,11 @@ __update_cpu_freelist_fast(struct kmem_cache *s,
 			   void *freelist_old, void *freelist_new,
 			   unsigned long tid)
 {
-#ifdef system_has_freelist_aba
 	freelist_aba_t old = { .freelist = freelist_old, .counter = tid };
 	freelist_aba_t new = { .freelist = freelist_new, .counter = next_tid(tid) };
 
 	return this_cpu_cmpxchg_freelist(s->cpu_slab->freelist_tid.full,
 					 old.full, new.full) == old.full;
-#else
-	return false;
-#endif
 }
 
 /*
