Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5B970F3D4
	for <lists+linux-arch@lfdr.de>; Wed, 24 May 2023 12:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjEXKNQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 May 2023 06:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbjEXKNO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 May 2023 06:13:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D478F;
        Wed, 24 May 2023 03:13:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 06883223C1;
        Wed, 24 May 2023 10:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684923191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/ve4/TtYTb+xjne8MK5462M47xa5SsY8B2FkwW34+Ec=;
        b=J854jhGb1iler25PD7IsLRhDY4qoNhjLVAy1/X25dxY5NIvulnv6l5hExoBxGabJwFyDN2
        NtV6g1YcuEl6ruTvP88ymkpxRTHoCn0BVUvAOTmkCoZ9AwY1e9k1t94YkXMYx9xiS9PUiw
        Yuh7KrysetiKHjdZq0ICvFqn8qChoMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684923191;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/ve4/TtYTb+xjne8MK5462M47xa5SsY8B2FkwW34+Ec=;
        b=8PPtdtNJ/oSkIBJ1FkAulBoYKRBsmhFmFPjHKM7RavKLfxQz/S+ayzKm2bWdeCdLTnCg1b
        YjnkN1s0fBFUg5Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 45D9B13425;
        Wed, 24 May 2023 10:13:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OFd2EDbjbWTwGgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 24 May 2023 10:13:10 +0000
Message-ID: <d2e02a4e-2a73-7b07-1bfb-ddf3f2a53ff1@suse.cz>
Date:   Wed, 24 May 2023 12:13:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 08/11] slub: Replace cmpxchg_double()
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
        linux-crypto@vger.kernel.org, sfr@canb.auug.org.au,
        mpe@ellerman.id.au
References: <20230515075659.118447996@infradead.org>
 <20230515080554.453785148@infradead.org>
 <20230524093246.GP83892@hirez.programming.kicks-ass.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230524093246.GP83892@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/24/23 11:32, Peter Zijlstra wrote:
> On Mon, May 15, 2023 at 09:57:07AM +0200, Peter Zijlstra wrote:
> 
>> @@ -3008,6 +3029,22 @@ static inline bool pfmemalloc_match(stru
>>  }
>>  
>>  #ifndef CONFIG_SLUB_TINY
>> +static inline bool
>> +__update_cpu_freelist_fast(struct kmem_cache *s,
>> +			   void *freelist_old, void *freelist_new,
>> +			   unsigned long tid)
>> +{
>> +#ifdef system_has_freelist_aba
>> +	freelist_aba_t old = { .freelist = freelist_old, .counter = tid };
>> +	freelist_aba_t new = { .freelist = freelist_new, .counter = next_tid(tid) };
>> +
>> +	return this_cpu_cmpxchg_freelist(s->cpu_slab->freelist_tid.full,
>> +					 old.full, new.full) == old.full;
>> +#else
>> +	return false;
>> +#endif
>> +}
>> +
>>  /*
>>   * Check the slab->freelist and either transfer the freelist to the
>>   * per cpu freelist or deactivate the slab.
>> @@ -3359,11 +3396,7 @@ static __always_inline void *__slab_allo
>>  		 * against code executing on this cpu *not* from access by
>>  		 * other cpus.
>>  		 */
>> -		if (unlikely(!this_cpu_cmpxchg_double(
>> -				s->cpu_slab->freelist, s->cpu_slab->tid,
>> -				object, tid,
>> -				next_object, next_tid(tid)))) {
>> -
>> +		if (unlikely(!__update_cpu_freelist_fast(s, object, next_object, tid))) {
>>  			note_cmpxchg_failure("slab_alloc", s, tid);
>>  			goto redo;
>>  		}
>> @@ -3736,11 +3769,7 @@ static __always_inline void do_slab_free
>>  
>>  		set_freepointer(s, tail_obj, freelist);
>>  
>> -		if (unlikely(!this_cpu_cmpxchg_double(
>> -				s->cpu_slab->freelist, s->cpu_slab->tid,
>> -				freelist, tid,
>> -				head, next_tid(tid)))) {
>> -
>> +		if (unlikely(!__update_cpu_freelist_fast(s, freelist, head, tid))) {
>>  			note_cmpxchg_failure("slab_free", s, tid);
>>  			goto redo;
>>  		}
> 
> This isn't right; the this_cpu_cmpxchg_double() was unconditional and
> relied on the local_irq_save() fallback when no native cmpxchg128 is
> present.
> 
> The below delta makes things boot again when system_has_cmpxchg128 is
> not defined.

Right, that should do.

> I'm going to zap these patches from tip/locking/core for a few days and
> fold the below back into the series and let it run through the robots
> again.

I noticed some comments in mm/slub.c still mention "cmpxchg_double", dunno
how much you want to clean it right now or can be postponed. Also some sysfs
stats files for CONFIG_SLUB_STATS (not widely used) which we probably might
try renaming without breaking anyone, but it's not guaranteed.

