Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2AD70F5C1
	for <lists+linux-arch@lfdr.de>; Wed, 24 May 2023 13:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjEXL6a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 May 2023 07:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjEXL63 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 May 2023 07:58:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEB3135;
        Wed, 24 May 2023 04:58:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 802D622168;
        Wed, 24 May 2023 11:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684929505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rH18iBwWnn9zYEQ2bRQgcgXCwVXM3ls6ER1KLLT/r60=;
        b=WMTRqdgWgo5Xv1JGWXGXa/4leJ+kA3Fr2EvuxoJ+Aqe6NU5zbCpx8cdBkJRqivz3zlmCI8
        fYweNr+iUlPQUznzgqAE9D1FG4L+KMokWqHKNGTedF59FJDkPiQa49qcPJoEz7QSNuY/TE
        11uKzpPFgkG44/ySFC88vJeQKALxzNA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684929505;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rH18iBwWnn9zYEQ2bRQgcgXCwVXM3ls6ER1KLLT/r60=;
        b=5OLIE73rOKr/k1ojPtkzX/HPu5nXWbAb/WgNuvY9KLod1eci7r+KTUnNLWeyZDjI8HJPtV
        go+jXuaQCYw1m7Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F3D0D13425;
        Wed, 24 May 2023 11:58:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cu/HOuD7bWSZVgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 24 May 2023 11:58:24 +0000
Message-ID: <18c33bf0-0c7e-7584-5149-33cf77b50b8a@suse.cz>
Date:   Wed, 24 May 2023 13:58:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 09/11] mm/slub: Fold slab_update_freelist()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        torvalds@linux-foundation.org
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
        Andrew Morton <akpm@linux-foundation.org>,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        iommu@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-crypto@vger.kernel.org
References: <20230515075659.118447996@infradead.org>
 <20230515080554.520976397@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230515080554.520976397@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/15/23 09:57, Peter Zijlstra wrote:
> The two functions slab_update_freelist() and __slab_update_freelist()
> are nearly identical, fold and add a boolean argument and rely on
> constant propagation.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Something like that has been tried before and the result:
https://lore.kernel.org/all/CAHk-=wiJLqL2cUhJbvpyPQpkbVOu1rVSzgO2=S2jC55hneLtfQ@mail.gmail.com/

Your parameter is not called 'locked' but 'irq_save' which is better, but
that's just one detail.

After your refactoring in 08/11 which puts most of the code into
__update_freelist_fast() and _slow() I'd say the result is not so bad already.

BTW I have some suspicion that some SLUB code is based on assumptions that
are no longer true these days. IIRC I've seen some microbenchmark results a
while ago that showed that disabling/enabling irqs is surprisingly (to me)
very cheap today, so maybe it's not so useful to keep doing the
this_cpu_cmpxchg128 for the struct kmem_cache_cpu operations (less so for
struct slab cmpxchg128 where actually different cpus may be involved). But
it needs a closer look.

> ---
>  mm/slub.c |   80 +++++++++++++++++++++-----------------------------------------
>  1 file changed, 28 insertions(+), 52 deletions(-)
> 
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -559,53 +559,29 @@ __update_freelist_slow(struct slab *slab
>   * allocation/ free operation in hardirq context. Therefore nothing can
>   * interrupt the operation.
>   */
> -static inline bool __slab_update_freelist(struct kmem_cache *s, struct slab *slab,
> -		void *freelist_old, unsigned long counters_old,
> -		void *freelist_new, unsigned long counters_new,
> -		const char *n)
> +static __always_inline
> +bool slab_update_freelist(struct kmem_cache *s, struct slab *slab,
> +			  void *freelist_old, unsigned long counters_old,
> +			  void *freelist_new, unsigned long counters_new,
> +			  bool irq_save, const char *n)
>  {
>  	bool ret;
>  
> -	if (USE_LOCKLESS_FAST_PATH())
> +	if (!irq_save && USE_LOCKLESS_FAST_PATH())
>  		lockdep_assert_irqs_disabled();
>  
>  	if (s->flags & __CMPXCHG_DOUBLE) {
>  		ret = __update_freelist_fast(slab, freelist_old, counters_old,
>  				            freelist_new, counters_new);
>  	} else {
> -		ret = __update_freelist_slow(slab, freelist_old, counters_old,
> -				            freelist_new, counters_new);
> -	}
> -	if (likely(ret))
> -		return true;
> -
> -	cpu_relax();
> -	stat(s, CMPXCHG_DOUBLE_FAIL);
> -
> -#ifdef SLUB_DEBUG_CMPXCHG
> -	pr_info("%s %s: cmpxchg double redo ", n, s->name);
> -#endif
> -
> -	return false;
> -}
> -
> -static inline bool slab_update_freelist(struct kmem_cache *s, struct slab *slab,
> -		void *freelist_old, unsigned long counters_old,
> -		void *freelist_new, unsigned long counters_new,
> -		const char *n)
> -{
> -	bool ret;
> -
> -	if (s->flags & __CMPXCHG_DOUBLE) {
> -		ret = __update_freelist_fast(slab, freelist_old, counters_old,
> -				            freelist_new, counters_new);
> -	} else {
>  		unsigned long flags;
>  
> -		local_irq_save(flags);
> +		if (irq_save)
> +			local_irq_save(flags);
>  		ret = __update_freelist_slow(slab, freelist_old, counters_old,
>  				            freelist_new, counters_new);
> -		local_irq_restore(flags);
> +		if (irq_save)
> +			local_irq_restore(flags);
>  	}
>  	if (likely(ret))
>  		return true;
> @@ -2250,10 +2226,10 @@ static inline void *acquire_slab(struct
>  	VM_BUG_ON(new.frozen);
>  	new.frozen = 1;
>  
> -	if (!__slab_update_freelist(s, slab,
> -			freelist, counters,
> -			new.freelist, new.counters,
> -			"acquire_slab"))
> +	if (!slab_update_freelist(s, slab,
> +				  freelist, counters,
> +				  new.freelist, new.counters,
> +				  false, "acquire_slab"))
>  		return NULL;
>  
>  	remove_partial(n, slab);
> @@ -2577,9 +2553,9 @@ static void deactivate_slab(struct kmem_
>  
>  
>  	if (!slab_update_freelist(s, slab,
> -				old.freelist, old.counters,
> -				new.freelist, new.counters,
> -				"unfreezing slab")) {
> +				  old.freelist, old.counters,
> +				  new.freelist, new.counters,
> +				  true, "unfreezing slab")) {
>  		if (mode == M_PARTIAL)
>  			spin_unlock_irqrestore(&n->list_lock, flags);
>  		goto redo;
> @@ -2633,10 +2609,10 @@ static void __unfreeze_partials(struct k
>  
>  			new.frozen = 0;
>  
> -		} while (!__slab_update_freelist(s, slab,
> -				old.freelist, old.counters,
> -				new.freelist, new.counters,
> -				"unfreezing slab"));
> +		} while (!slab_update_freelist(s, slab,
> +					       old.freelist, old.counters,
> +					       new.freelist, new.counters,
> +					       false, "unfreezing slab"));
>  
>  		if (unlikely(!new.inuse && n->nr_partial >= s->min_partial)) {
>  			slab->next = slab_to_discard;
> @@ -3072,10 +3048,10 @@ static inline void *get_freelist(struct
>  		new.inuse = slab->objects;
>  		new.frozen = freelist != NULL;
>  
> -	} while (!__slab_update_freelist(s, slab,
> -		freelist, counters,
> -		NULL, new.counters,
> -		"get_freelist"));
> +	} while (!slab_update_freelist(s, slab,
> +				       freelist, counters,
> +				       NULL, new.counters,
> +				       false, "get_freelist"));
>  
>  	return freelist;
>  }
> @@ -3666,9 +3642,9 @@ static void __slab_free(struct kmem_cach
>  		}
>  
>  	} while (!slab_update_freelist(s, slab,
> -		prior, counters,
> -		head, new.counters,
> -		"__slab_free"));
> +				       prior, counters,
> +				       head, new.counters,
> +				       true, "__slab_free"));
>  
>  	if (likely(!n)) {
>  
> 
> 

