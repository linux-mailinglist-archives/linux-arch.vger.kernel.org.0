Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA4868EFD1
	for <lists+linux-arch@lfdr.de>; Wed,  8 Feb 2023 14:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjBHNcU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Feb 2023 08:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjBHNcF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Feb 2023 08:32:05 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FCECC34;
        Wed,  8 Feb 2023 05:31:56 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id w5so9219058plg.8;
        Wed, 08 Feb 2023 05:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FrvfwK6Li1OWjx1b8GzWQx8K77xDp8ENwfyOeSPd9eE=;
        b=EM/WtZyy7zF0pIYe4L99sunsP8XxZM/eO8poIB7i3sHk3ST0tgKLmhLI7jStQKKYmV
         7kES7ZGgDg2hKoTZHO3GhBvjKRw0M4IecBt0tAGUJlf5qehtYIx8ic6nA6h835tI5ciK
         lLHW1h0SKwUdcaztW0X/Tkb2BowdVj1rgPXcRfd4aijmFE+WmjCYHncgGCWSKreqNTaK
         mFUGUGDbGrunZCHjDRg8HVyWcswfmWn23REVDlyAjfdOaXXsP8LJWSdQrYWBeOb4JY/V
         JrGlXjWIRynlRTYfXOxDr1Ptrmicg5nFtQtyQ0Qnc+WDrfqBlwH1Qzz9tg+/RnAcuPoV
         Hmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrvfwK6Li1OWjx1b8GzWQx8K77xDp8ENwfyOeSPd9eE=;
        b=HLGUjbA4tGcf9Pj/gRoRY2IrFYr0A2aHHVXCjCZdbZPLbvhsfiwjvuRSYy3M4PaZuQ
         WeRxNW0ROwzniPIAkuonmsm81NYxf5WATDrvXHJupDNHZnQsZB5w7qXCWfRzhJso3Su/
         SX+FF7xho/R3BBUScX7g2YvKQL5Qgctwrj+Zqrs3mA0LUn7MsBFfARVjwSPiNPflQ4km
         NWW4YN61+154dhmvae+YtrFQE4GeQcp3H9JxrKnFSKAjmhknof+XQPD3AZAbFoBW9g0Q
         VYEEzNcCB9/4jhiAcoAnvDb+Eeh8BSubzYqRmHJHkwcUGDa1YmhSxjpsYbjTfVIXESC0
         TSJg==
X-Gm-Message-State: AO0yUKWjyvRXfI3jsQh/a5JUMfTjNhtE8bEmUIJKzzXDfmrqtQrXlaR0
        w8fOO9ThVQEsJGWlnsvRXCE=
X-Google-Smtp-Source: AK7set/UB2qWM4G8zM/I+P0mGi9JRaNyfns6YOWg+uoNSSdSGLCy3SU1veAnml0rqFU7wPROKhBsgg==
X-Received: by 2002:a17:902:f548:b0:199:2f53:4d95 with SMTP id h8-20020a170902f54800b001992f534d95mr7725526plf.50.1675863115434;
        Wed, 08 Feb 2023 05:31:55 -0800 (PST)
Received: from localhost ([2400:8902::f03c:93ff:fe27:642a])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c24600b00189c62eac37sm3576960plg.32.2023.02.08.05.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 05:31:53 -0800 (PST)
Date:   Wed, 8 Feb 2023 13:31:39 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, corbet@lwn.net, will@kernel.org,
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
        roman.gushchin@linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 08/10] slub: Replace cmpxchg_double()
Message-ID: <Y+OkOxpOnRYcI3DS@localhost>
References: <20230202145030.223740842@infradead.org>
 <20230202152655.684926740@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202152655.684926740@infradead.org>
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 02, 2023 at 03:50:38PM +0100, Peter Zijlstra wrote:
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/slub_def.h |   12 ++-
>  mm/slab.h                |   45 +++++++++++++-
>  mm/slub.c                |  142 ++++++++++++++++++++++++++++-------------------
>  3 files changed, 135 insertions(+), 64 deletions(-)
> 
> --- a/include/linux/slub_def.h
> +++ b/include/linux/slub_def.h
> @@ -39,7 +39,8 @@ enum stat_item {
>  	CPU_PARTIAL_FREE,	/* Refill cpu partial on free */
>  	CPU_PARTIAL_NODE,	/* Refill cpu partial from node partial */
>  	CPU_PARTIAL_DRAIN,	/* Drain cpu partial to node partial */
> -	NR_SLUB_STAT_ITEMS };
> +	NR_SLUB_STAT_ITEMS
> +};
>  
>  #ifndef CONFIG_SLUB_TINY
>  /*
> @@ -47,8 +48,13 @@ enum stat_item {
>   * with this_cpu_cmpxchg_double() alignment requirements.
>   */
>  struct kmem_cache_cpu {
> -	void **freelist;	/* Pointer to next available object */
> -	unsigned long tid;	/* Globally unique transaction id */
> +	union {
> +		struct {
> +			void **freelist;	/* Pointer to next available object */
> +			unsigned long tid;	/* Globally unique transaction id */
> +		};
> +		freelist_aba_t freelist_tid;
> +	};
>  	struct slab *slab;	/* The slab from which we are allocating */
>  #ifdef CONFIG_SLUB_CPU_PARTIAL
>  	struct slab *partial;	/* Partially allocated frozen slabs */
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -5,6 +5,34 @@
>   * Internal slab definitions
>   */
>  
> +/*
> + * Freelist pointer and counter to cmpxchg together, avoids the typical ABA
> + * problems with cmpxchg of just a pointer.
> + */
> +typedef union {
> +	struct {
> +		void *freelist;
> +		unsigned long counter;
> +	};
> +#ifdef CONFIG_64BIT
> +	u128 full;
> +#else
> +	u64 full;
> +#endif
> +} freelist_aba_t;
> +
> +#ifdef CONFIG_64BIT
> +# ifdef system_has_cmpxchg128
> +# define system_has_freelist_aba()	system_has_cmpxchg128()
> +# define try_cmpxchg_freelist		try_cmpxchg128
> +# endif
> +#else /* CONFIG_64BIT */
> +# ifdef system_has_cmpxchg64
> +# define system_has_freelist_aba()	system_has_cmpxchg64()
> +# define try_cmpxchg_freelist		try_cmpxchg64
> +# endif
> +#endif /* CONFIG_64BIT */
> +
>  /* Reuses the bits in struct page */
>  struct slab {
>  	unsigned long __page_flags;
> @@ -37,14 +65,21 @@ struct slab {
>  #endif
>  			};
>  			/* Double-word boundary */
> -			void *freelist;		/* first free object */
>  			union {
> -				unsigned long counters;
>  				struct {
> -					unsigned inuse:16;
> -					unsigned objects:15;
> -					unsigned frozen:1;
> +					void *freelist;		/* first free object */
> +					union {
> +						unsigned long counters;
> +						struct {
> +							unsigned inuse:16;
> +							unsigned objects:15;
> +							unsigned frozen:1;
> +						};
> +					};
>  				};
> +#ifdef system_has_freelist_aba
> +				freelist_aba_t freelist_counter;
> +#endif
>  			};
>  		};
>  		struct rcu_head rcu_head;
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -292,7 +292,13 @@ static inline bool kmem_cache_has_cpu_pa
>  /* Poison object */
>  #define __OBJECT_POISON		((slab_flags_t __force)0x80000000U)
>  /* Use cmpxchg_double */
> +
> +#if defined(system_has_freelist_aba) && \
> +    defined(CONFIG_HAVE_ALIGNED_STRUCT_PAGE)
>  #define __CMPXCHG_DOUBLE	((slab_flags_t __force)0x40000000U)
> +#else
> +#define __CMPXCHG_DOUBLE	((slab_flags_t __force)0U)
> +#endif
>  
>  /*
>   * Tracking user of a slab.
> @@ -512,6 +518,43 @@ static __always_inline void slab_unlock(
>  	__bit_spin_unlock(PG_locked, &page->flags);
>  }
>  
> +static inline bool
> +__update_freelist_fast(struct slab *slab,
> +		      void *freelist_old, unsigned long counters_old,
> +		      void *freelist_new, unsigned long counters_new)
> +{
> +
> +	bool ret = false;
> +
> +#ifdef system_has_freelist_aba
> +	freelist_aba_t old = { .freelist = freelist_old, .counter = counters_old };
> +	freelist_aba_t new = { .freelist = freelist_new, .counter = counters_new };
> +
> +	ret = try_cmpxchg_freelist(&slab->freelist_counter.full, &old.full, new.full);
> +#endif /* system_has_freelist_aba */
> +
> +	return ret;
> +}
> +
> +static inline bool
> +__update_freelist_slow(struct slab *slab,
> +		      void *freelist_old, unsigned long counters_old,
> +		      void *freelist_new, unsigned long counters_new)
> +{
> +	bool ret = false;
> +
> +	slab_lock(slab);
> +	if (slab->freelist == freelist_old &&
> +	    slab->counters == counters_old) {
> +		slab->freelist = freelist_new;
> +		slab->counters = counters_new;
> +		ret = true;
> +	}
> +	slab_unlock(slab);
> +
> +	return ret;
> +}
> +
>  /*
>   * Interrupts must be disabled (for the fallback code to work right), typically
>   * by an _irqsave() lock variant. On PREEMPT_RT the preempt_disable(), which is
> @@ -519,33 +562,25 @@ static __always_inline void slab_unlock(
>   * allocation/ free operation in hardirq context. Therefore nothing can
>   * interrupt the operation.
>   */
> -static inline bool __cmpxchg_double_slab(struct kmem_cache *s, struct slab *slab,
> +static inline bool __slab_update_freelist(struct kmem_cache *s, struct slab *slab,
>  		void *freelist_old, unsigned long counters_old,
>  		void *freelist_new, unsigned long counters_new,
>  		const char *n)
>  {
> +	bool ret;
> +
>  	if (USE_LOCKLESS_FAST_PATH())
>  		lockdep_assert_irqs_disabled();
> -#if defined(CONFIG_HAVE_CMPXCHG_DOUBLE) && \
> -    defined(CONFIG_HAVE_ALIGNED_STRUCT_PAGE)
> +
>  	if (s->flags & __CMPXCHG_DOUBLE) {
> -		if (cmpxchg_double(&slab->freelist, &slab->counters,
> -				   freelist_old, counters_old,
> -				   freelist_new, counters_new))
> -			return true;
> -	} else
> -#endif
> -	{
> -		slab_lock(slab);
> -		if (slab->freelist == freelist_old &&
> -					slab->counters == counters_old) {
> -			slab->freelist = freelist_new;
> -			slab->counters = counters_new;
> -			slab_unlock(slab);
> -			return true;
> -		}
> -		slab_unlock(slab);
> +		ret = __update_freelist_fast(slab, freelist_old, counters_old,
> +				            freelist_new, counters_new);
> +	} else {
> +		ret = __update_freelist_slow(slab, freelist_old, counters_old,
> +				            freelist_new, counters_new);
>  	}
> +	if (likely(ret))
> +		return true;
>  
>  	cpu_relax();
>  	stat(s, CMPXCHG_DOUBLE_FAIL);
> @@ -557,36 +592,26 @@ static inline bool __cmpxchg_double_slab
>  	return false;
>  }
>  
> -static inline bool cmpxchg_double_slab(struct kmem_cache *s, struct slab *slab,
> +static inline bool slab_update_freelist(struct kmem_cache *s, struct slab *slab,
>  		void *freelist_old, unsigned long counters_old,
>  		void *freelist_new, unsigned long counters_new,
>  		const char *n)
>  {
> -#if defined(CONFIG_HAVE_CMPXCHG_DOUBLE) && \
> -    defined(CONFIG_HAVE_ALIGNED_STRUCT_PAGE)
> +	bool ret;
> +
>  	if (s->flags & __CMPXCHG_DOUBLE) {
> -		if (cmpxchg_double(&slab->freelist, &slab->counters,
> -				   freelist_old, counters_old,
> -				   freelist_new, counters_new))
> -			return true;
> -	} else
> -#endif
> -	{
> +		ret = __update_freelist_fast(slab, freelist_old, counters_old,
> +				            freelist_new, counters_new);
> +	} else {
>  		unsigned long flags;
>  
>  		local_irq_save(flags);
> -		slab_lock(slab);
> -		if (slab->freelist == freelist_old &&
> -					slab->counters == counters_old) {
> -			slab->freelist = freelist_new;
> -			slab->counters = counters_new;
> -			slab_unlock(slab);
> -			local_irq_restore(flags);
> -			return true;
> -		}
> -		slab_unlock(slab);
> +		ret = __update_freelist_slow(slab, freelist_old, counters_old,
> +				            freelist_new, counters_new);
>  		local_irq_restore(flags);
>  	}
> +	if (likely(ret))
> +		return true;
>  
>  	cpu_relax();
>  	stat(s, CMPXCHG_DOUBLE_FAIL);
> @@ -2229,7 +2254,7 @@ static inline void *acquire_slab(struct
>  	VM_BUG_ON(new.frozen);
>  	new.frozen = 1;
>  
> -	if (!__cmpxchg_double_slab(s, slab,
> +	if (!__slab_update_freelist(s, slab,
>  			freelist, counters,
>  			new.freelist, new.counters,
>  			"acquire_slab"))
> @@ -2555,7 +2580,7 @@ static void deactivate_slab(struct kmem_
>  	}
>  
>  
> -	if (!cmpxchg_double_slab(s, slab,
> +	if (!slab_update_freelist(s, slab,
>  				old.freelist, old.counters,
>  				new.freelist, new.counters,
>  				"unfreezing slab")) {
> @@ -2612,7 +2637,7 @@ static void __unfreeze_partials(struct k
>  
>  			new.frozen = 0;
>  
> -		} while (!__cmpxchg_double_slab(s, slab,
> +		} while (!__slab_update_freelist(s, slab,
>  				old.freelist, old.counters,
>  				new.freelist, new.counters,
>  				"unfreezing slab"));
> @@ -3009,6 +3034,18 @@ static inline bool pfmemalloc_match(stru
>  }
>  
>  #ifndef CONFIG_SLUB_TINY
> +static inline bool
> +__update_cpu_freelist_fast(struct kmem_cache *s,
> +			   void *freelist_old, void *freelist_new,
> +			   unsigned long tid)
> +{
> +	freelist_aba_t old = { .freelist = freelist_old, .counter = tid };
> +	freelist_aba_t new = { .freelist = freelist_new, .counter = next_tid(tid) };
> +
> +	return this_cpu_cmpxchg(s->cpu_slab->freelist_tid.full,
> +				old.full, new.full) == old.full;
> +}
> +
>  /*
>   * Check the slab->freelist and either transfer the freelist to the
>   * per cpu freelist or deactivate the slab.
> @@ -3035,7 +3072,7 @@ static inline void *get_freelist(struct
>  		new.inuse = slab->objects;
>  		new.frozen = freelist != NULL;
>  
> -	} while (!__cmpxchg_double_slab(s, slab,
> +	} while (!__slab_update_freelist(s, slab,
>  		freelist, counters,
>  		NULL, new.counters,
>  		"get_freelist"));
> @@ -3360,11 +3397,7 @@ static __always_inline void *__slab_allo
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
> @@ -3632,7 +3665,7 @@ static void __slab_free(struct kmem_cach
>  			}
>  		}
>  
> -	} while (!cmpxchg_double_slab(s, slab,
> +	} while (!slab_update_freelist(s, slab,
>  		prior, counters,
>  		head, new.counters,
>  		"__slab_free"));
> @@ -3737,11 +3770,7 @@ static __always_inline void do_slab_free
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
> @@ -4505,11 +4534,12 @@ static int kmem_cache_open(struct kmem_c
>  		}
>  	}
>  
> -#if defined(CONFIG_HAVE_CMPXCHG_DOUBLE) && \
> +#if defined(system_has_freelist_aba) && \
>      defined(CONFIG_HAVE_ALIGNED_STRUCT_PAGE)
> -	if (system_has_cmpxchg_double() && (s->flags & SLAB_NO_CMPXCHG) == 0)
> +	if (system_has_freelist_aba() && !(s->flags & SLAB_NO_CMPXCHG)) {
>  		/* Enable fast mode */
>  		s->flags |= __CMPXCHG_DOUBLE;
> +	}
>  #endif
>  
>  	/*

Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks!
