Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE3D5023BF
	for <lists+linux-arch@lfdr.de>; Fri, 15 Apr 2022 07:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239182AbiDOFWo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Apr 2022 01:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242440AbiDOFWg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Apr 2022 01:22:36 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEDB53E19
        for <linux-arch@vger.kernel.org>; Thu, 14 Apr 2022 22:20:05 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id n22so6208629pfa.0
        for <linux-arch@vger.kernel.org>; Thu, 14 Apr 2022 22:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=qRxjR8ix0vuqYl+JIAKzCjGTL7lI31+t1CslgYvhvOo=;
        b=LlgBV7yufxnp6RGBHA9JMOgJJArOuwSk8Gkc6OVzvARE+63wJR5VjT2odFawJ/sXgq
         owbqrgBO/HlAdelA+6G+u1q3pVP5xGD6Xp8T+Q2+DBePvAw5viHlW4KyfBqAE5Byfz7w
         /gaKiHLiKrFVmm7wFVyIjMpBgpxN8uCpY9qV/m3FBbDyL7KpFL/91u3X64dbn+8FAQzP
         Ovu9+3KQ8SiQWw3IrEMVExPjF5pDe+uJ4TNLzhxWcc+vEcp0W/9JTOF77yjNEaA8QNG0
         U/Lw1j6AYpVQAN+mh8Zfx6wyyiumiakYKrTQMwaYwH6ErnR6Z2GLpEQUmI4APvKlAVwG
         g9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=qRxjR8ix0vuqYl+JIAKzCjGTL7lI31+t1CslgYvhvOo=;
        b=uwi4rZ08Pf/5WwJQF9zw6z3g2rffz2ZXY6PrDlSaoHfjM5PVovp9dxGJqePy36e65C
         RUri0n8L9sbH1+GQoRY3KFLS4CkHN3MKutoojqk1Ud7+0Ac/K7X2ylLltCI3Q/pKUJzy
         XwmYagIvT/OGMbdj7qsAGC85heRbJoeGzo836N2XptsmS8F9btLSncdw9lYfvt8oO4z7
         QW8RkvU0tsfVAsDLPaj223PnWYKawvzbT2sqWE93fXSqPNVomMh5oO4kqHqznmY9BF4f
         wFlUmtbxjbeSYVZ8uNQIFLVTp0dR0kwSJaKsvIXRS4TZFKD/U/HF3Jk9jTu7DLAtvHvS
         75tQ==
X-Gm-Message-State: AOAM532tGQ1YAe9tcKU6/+uck/VACpRqSmV0sGstB4R2+6ys+7QDvaGk
        neTV85934FmfEK47EPJjNeh25g==
X-Google-Smtp-Source: ABdhPJzw6B3I43JcoA4j2cCHTED3SaHmvYc3O0wt9aRvIAGa+jNkWcumUX6otCfAWo5ctSfAQM99DA==
X-Received: by 2002:a63:f405:0:b0:3a2:8b3d:a5a8 with SMTP id g5-20020a63f405000000b003a28b3da5a8mr1789010pgi.204.1650000004984;
        Thu, 14 Apr 2022 22:20:04 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id p3-20020a056a000b4300b004faee36ea56sm1503939pfo.155.2022.04.14.22.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 22:20:04 -0700 (PDT)
Date:   Thu, 14 Apr 2022 22:20:04 -0700 (PDT)
X-Google-Original-Date: Thu, 14 Apr 2022 22:16:31 PDT (-0700)
Subject:     Re: [PATCH v3 1/7] asm-generic: ticket-lock: New generic ticket-based spinlock
In-Reply-To: <YljFyY7acyRDBmK7@tardis>
CC:     Arnd Bergmann <arnd@arndb.de>, heiko@sntech.de, guoren@kernel.org,
        shorne@gmail.com, peterz@infradead.org, mingo@redhat.com,
        Will Deacon <will@kernel.org>, longman@redhat.com,
        jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, macro@orcam.me.uk,
        Greg KH <gregkh@linuxfoundation.org>,
        sudipm.mukherjee@gmail.com, wangkefeng.wang@huawei.com,
        jszhang@kernel.org, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org, openrisc@lists.librecores.org,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     boqun.feng@gmail.com
Message-ID: <mhng-78fec320-bd16-4774-9e24-2e5c0ce33121@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 14 Apr 2022 18:09:29 PDT (-0700), boqun.feng@gmail.com wrote:
> Hi,
>
> On Thu, Apr 14, 2022 at 03:02:08PM -0700, Palmer Dabbelt wrote:
>> From: Peter Zijlstra <peterz@infradead.org>
>> 
>> This is a simple, fair spinlock.  Specifically it doesn't have all the
>> subtle memory model dependencies that qspinlock has, which makes it more
>> suitable for simple systems as it is more likely to be correct.  It is
>> implemented entirely in terms of standard atomics and thus works fine
>> without any arch-specific code.
>> 
>> This replaces the existing asm-generic/spinlock.h, which just errored
>> out on SMP systems.
>> 
>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>> ---
>>  include/asm-generic/spinlock.h       | 85 +++++++++++++++++++++++++---
>>  include/asm-generic/spinlock_types.h | 17 ++++++
>>  2 files changed, 94 insertions(+), 8 deletions(-)
>>  create mode 100644 include/asm-generic/spinlock_types.h
>> 
>> diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
>> index adaf6acab172..ca829fcb9672 100644
>> --- a/include/asm-generic/spinlock.h
>> +++ b/include/asm-generic/spinlock.h
>> @@ -1,12 +1,81 @@
>>  /* SPDX-License-Identifier: GPL-2.0 */
>> -#ifndef __ASM_GENERIC_SPINLOCK_H
>> -#define __ASM_GENERIC_SPINLOCK_H
>> +
>>  /*
>> - * You need to implement asm/spinlock.h for SMP support. The generic
>> - * version does not handle SMP.
>> + * 'Generic' ticket-lock implementation.
>> + *
>> + * It relies on atomic_fetch_add() having well defined forward progress
>> + * guarantees under contention. If your architecture cannot provide this, stick
>> + * to a test-and-set lock.
>> + *
>> + * It also relies on atomic_fetch_add() being safe vs smp_store_release() on a
>> + * sub-word of the value. This is generally true for anything LL/SC although
>> + * you'd be hard pressed to find anything useful in architecture specifications
>> + * about this. If your architecture cannot do this you might be better off with
>> + * a test-and-set.
>> + *
>> + * It further assumes atomic_*_release() + atomic_*_acquire() is RCpc and hence
>> + * uses atomic_fetch_add() which is SC to create an RCsc lock.
>> + *
>> + * The implementation uses smp_cond_load_acquire() to spin, so if the
>> + * architecture has WFE like instructions to sleep instead of poll for word
>> + * modifications be sure to implement that (see ARM64 for example).
>> + *
>>   */
>> -#ifdef CONFIG_SMP
>> -#error need an architecture specific asm/spinlock.h
>> -#endif
>>  
>> -#endif /* __ASM_GENERIC_SPINLOCK_H */
>> +#ifndef __ASM_GENERIC_TICKET_LOCK_H
>> +#define __ASM_GENERIC_TICKET_LOCK_H
>> +
>> +#include <linux/atomic.h>
>> +#include <asm-generic/spinlock_types.h>
>> +
>> +static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
>> +{
>> +	u32 val = atomic_fetch_add(1<<16, lock); /* SC, gives us RCsc */
>> +	u16 ticket = val >> 16;
>> +
>> +	if (ticket == (u16)val)
>> +		return;
>> +
>> +	atomic_cond_read_acquire(lock, ticket == (u16)VAL);
>
> Looks like my follow comment is missing:
>
> 	https://lore.kernel.org/lkml/YjM+P32I4fENIqGV@boqun-archlinux/
>
> Basically, I suggested that 1) instead of "SC", use "fully-ordered" as
> that's a complete definition in our atomic API ("RCsc" is fine), 2)
> introduce a RCsc atomic_cond_read_acquire() or add a full barrier here
> to make arch_spin_lock() RCsc otherwise arch_spin_lock() is RCsc on
> fastpath but RCpc on slowpath.

Sorry about that, now that you mention it I remember seeing that comment 
but I guess I dropped it somehow -- I've been down a bunch of other 
RISC-V memory model rabbit holes lately, so I guess this just got lost 
in the shuffle.

I'm not really a memory model person, so I'm a bit confused here, but 
IIUC the issue is that there's only an RCpc ordering between the 
store_release that publishes the baker's ticket and the customer's spin 
to obtain a contested lock.  Thus we could see RCpc-legal accesses 
before the atomic_cond_read_acquire().

That's where I get a bit lost: the atomic_fetch_add() is RCsc, so the 
offending accesses are bounded to remain within arch_spin_lock().  I'm 
not sure how that lines up with the LKMM requirements, which I always 
see expressed in terms of the entire lock being RCsc (specifically with 
unlock->lock reordering weirdness, which the fully ordered AMO seems to 
prevent here).

That's kind of just a curiosity, though, so assuming we need some 
stronger ordering here I sort of considered this

    diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
    index ca829fcb9672..bf4e6050b9b2 100644
    --- a/include/asm-generic/spinlock.h
    +++ b/include/asm-generic/spinlock.h
    @@ -14,7 +14,7 @@
      * a test-and-set.
      *
      * It further assumes atomic_*_release() + atomic_*_acquire() is RCpc and hence
    - * uses atomic_fetch_add() which is SC to create an RCsc lock.
    + * uses atomic_fetch_add_rcsc() which is RCsc to create an RCsc lock.
      *
      * The implementation uses smp_cond_load_acquire() to spin, so if the
      * architecture has WFE like instructions to sleep instead of poll for word
    @@ -30,13 +30,13 @@
    
     static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
     {
    	u32 val = atomic_fetch_add(1<<16, lock);
     	u16 ticket = val >> 16;
    
     	if (ticket == (u16)val)
     		return;
    
    -	atomic_cond_read_acquire(lock, ticket == (u16)VAL);
    +	atomic_cond_read_rcsc(lock, ticket == (u16)VAL);
     }
    
     static __always_inline bool arch_spin_trylock(arch_spinlock_t *lock)

but that smells a bit awkward: it's not really that the access is RCsc, 
it's that the whole lock is, and the RCsc->branch->RCpc is just kind of 
screaming for arch-specific optimizations.  I think we either end up 
with some sort of "atomic_*_for_tspinlock" or a "mb_*_for_tspinlock", 
both of which seem very specific.

That, or we just run with the fence until someone has a concrete way to 
do it faster.  I don't know OpenRISC or C-SKY, but IIUC the full fence 
is free on RISC-V: our smp_cond_read_acquire() only emits read accesses, 
ends in a "fence r,r", and is proceeded by a full smp_mb() from 
atomic_fetch_add().  So I'd lean towards the much simpler

    diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
    index ca829fcb9672..08e3400a104f 100644
    --- a/include/asm-generic/spinlock.h
    +++ b/include/asm-generic/spinlock.h
    @@ -14,7 +14,9 @@
      * a test-and-set.
      *
      * It further assumes atomic_*_release() + atomic_*_acquire() is RCpc and hence
    - * uses atomic_fetch_add() which is SC to create an RCsc lock.
    + * uses atomic_fetch_add() which is RCsc to create an RCsc hot path, along with
    + * a full fence after the spin to upgrade the otherwise-RCpc
    + * atomic_cond_read_acquire().
      *
      * The implementation uses smp_cond_load_acquire() to spin, so if the
      * architecture has WFE like instructions to sleep instead of poll for word
    @@ -30,13 +32,22 @@
    
     static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
     {
    -	u32 val = atomic_fetch_add(1<<16, lock); /* SC, gives us RCsc */
    +	u32 val = atomic_fetch_add(1<<16, lock);
     	u16 ticket = val >> 16;
    
     	if (ticket == (u16)val)
     		return;
    
    +	/*
    +	 * atomic_cond_read_acquire() is RCpc, but rather than defining a
    +	 * custom cond_read_rcsc() here we just emit a full fence.  We only
    +	 * need the prior reads before subsequent writes ordering from
    +	 * smb_mb(), but as atomic_cond_read_acquire() just emits reads and we
    +	 * have no outstanding writes due to the atomic_fetch_add() the extra
    +	 * orderings are free.
    +	 */
     	atomic_cond_read_acquire(lock, ticket == (u16)VAL);
    +	smp_mb();
     }
    
     static __always_inline bool arch_spin_trylock(arch_spinlock_t *lock)

I'm also now worried about trylock, but am too far down this rabbit hole 
to try and figure out how try maps between locks and cmpxchg.  This is 
all way too complicated to squash in, though, so I'll definitely plan on 
a v4.

> Regards,
> Boqun
>
>> +}
>> +
>> +static __always_inline bool arch_spin_trylock(arch_spinlock_t *lock)
>> +{
>> +	u32 old = atomic_read(lock);
>> +
>> +	if ((old >> 16) != (old & 0xffff))
>> +		return false;
>> +
>> +	return atomic_try_cmpxchg(lock, &old, old + (1<<16)); /* SC, for RCsc */
>> +}
>> +
> [...]
