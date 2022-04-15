Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBB1502DF5
	for <lists+linux-arch@lfdr.de>; Fri, 15 Apr 2022 18:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbiDOQs5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Apr 2022 12:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235567AbiDOQs5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Apr 2022 12:48:57 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3449396A6
        for <linux-arch@vger.kernel.org>; Fri, 15 Apr 2022 09:46:27 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id c12so7515181plr.6
        for <linux-arch@vger.kernel.org>; Fri, 15 Apr 2022 09:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=ItPn/AcYuP2hdhsdSFglkfktyf1iLOm6R95lIRQYTZY=;
        b=JS96M1iHtXQEhUuFoqlaiZ2VRIlhckrTO6Ij+BqZyqgaE8i/vjuqr3iwPAM31Qe1pU
         nVGCc2V86N2/l3lhhwmPjSe+1NSVhGrWzLgz01qOgzQpML3gf0R2zensKqD9EirmUpcE
         keaKxzUHNn1xgI6Ls/PKoYT1oVMsK2wrQheR4OS/uc8dFCOVM6IsONgT2L0PgunTiA35
         5DalFyKEsd6ZwfsEeVL0Cycuepa9OKvPgJQPsWST2LX9Dr2+MNc4Hb4I83m7qtMnvHiK
         Ypti60XVTPZP+yryoYLh3SP85K+fLvWwD5h709bL4SEOMSDO1MXhHVCnYGWETmkkQaqc
         eRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=ItPn/AcYuP2hdhsdSFglkfktyf1iLOm6R95lIRQYTZY=;
        b=KptdTXv759Iv4cHcvYRn/ZbYz3AZo/9K3UPyJ7sPv0AvcVDHdyqPalnU8+1V9fLLZX
         5agpaQx99a5/2vewAWsjViomAtggdJ/z0BdwVfSChIViRjUR8Q/exYOmboyO7iHkCSS9
         bQiiyyWwrZoStVrahM4aliKCrpAipa3n+kvF6/NsEnTzEr3Dmkuv7muKKUwEnnSmwMsf
         7pPRkQXlb6UUq++ZLI+rq/8rleBAj11fEqLkxAFt5WXMpkPWK8NBMk8GwcR02bAS7Civ
         iIie5g1kZcxgFOBbhhWW+mmNRAhoKyqk2XIhsye4ivEJYafxezBWTrw1cibTGfVMFEh/
         5wKw==
X-Gm-Message-State: AOAM531cXENFQdZa2UUYJ7uHDdKoAbOvtsQqgJ++L5+wQ6O9UgmWuuht
        OH26alGRgFL1s6ZJHoJmLgfnaQ==
X-Google-Smtp-Source: ABdhPJyj45WdgDS2kp+bLcsEYoXnZD1J4gN7xaPkEirpU1SwtjNOLeYhYjs838zc/dCSPVG7lSSoPw==
X-Received: by 2002:a17:90b:3882:b0:1cd:41c1:712a with SMTP id mu2-20020a17090b388200b001cd41c1712amr5110813pjb.72.1650041187144;
        Fri, 15 Apr 2022 09:46:27 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id d16-20020a056a00245000b004f7728a4346sm3584771pfj.79.2022.04.15.09.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 09:46:26 -0700 (PDT)
Date:   Fri, 15 Apr 2022 09:46:26 -0700 (PDT)
X-Google-Original-Date: Fri, 15 Apr 2022 09:46:08 PDT (-0700)
Subject:     Re: [PATCH v3 1/7] asm-generic: ticket-lock: New generic ticket-based spinlock
In-Reply-To: <1e26726b-721e-7197-8834-8aff2b4c4bc3@redhat.com>
CC:     Arnd Bergmann <arnd@arndb.de>, heiko@sntech.de, guoren@kernel.org,
        shorne@gmail.com, peterz@infradead.org, mingo@redhat.com,
        Will Deacon <will@kernel.org>, boqun.feng@gmail.com,
        jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, macro@orcam.me.uk,
        Greg KH <gregkh@linuxfoundation.org>,
        sudipm.mukherjee@gmail.com, wangkefeng.wang@huawei.com,
        jszhang@kernel.org, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org, openrisc@lists.librecores.org,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     longman@redhat.com
Message-ID: <mhng-f4d144dd-b6ed-4f3f-bfc3-6dc29fab14e4@palmer-ri-x1c9>
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

On Thu, 14 Apr 2022 18:27:12 PDT (-0700), longman@redhat.com wrote:
> On 4/14/22 18:02, Palmer Dabbelt wrote:
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
>>   include/asm-generic/spinlock.h       | 85 +++++++++++++++++++++++++---
>>   include/asm-generic/spinlock_types.h | 17 ++++++
>>   2 files changed, 94 insertions(+), 8 deletions(-)
>>   create mode 100644 include/asm-generic/spinlock_types.h
>>
>> diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
>> index adaf6acab172..ca829fcb9672 100644
>> --- a/include/asm-generic/spinlock.h
>> +++ b/include/asm-generic/spinlock.h
>> @@ -1,12 +1,81 @@
>>   /* SPDX-License-Identifier: GPL-2.0 */
>> -#ifndef __ASM_GENERIC_SPINLOCK_H
>> -#define __ASM_GENERIC_SPINLOCK_H
>> +
>>   /*
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
>>    */
>> -#ifdef CONFIG_SMP
>> -#error need an architecture specific asm/spinlock.h
>> -#endif
>>
>> -#endif /* __ASM_GENERIC_SPINLOCK_H */
>> +#ifndef __ASM_GENERIC_TICKET_LOCK_H
>> +#define __ASM_GENERIC_TICKET_LOCK_H
> It is not conventional to use a macro name that is different from the
> header file name.

Sorry, that was just a mistake: I renamed the header, but forgot to 
rename the guard.  I'll likely send a v4 due to Boqun's questions, I'll 
fix this as well.

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
>> +static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
>> +{
>> +	u16 *ptr = (u16 *)lock + IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);
>> +	u32 val = atomic_read(lock);
>> +
>> +	smp_store_release(ptr, (u16)val + 1);
>> +}
>> +
>> +static __always_inline int arch_spin_is_locked(arch_spinlock_t *lock)
>> +{
>> +	u32 val = atomic_read(lock);
>> +
>> +	return ((val >> 16) != (val & 0xffff));
>> +}
>> +
>> +static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
>> +{
>> +	u32 val = atomic_read(lock);
>> +
>> +	return (s16)((val >> 16) - (val & 0xffff)) > 1;
>> +}
>> +
>> +static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
>> +{
>> +	return !arch_spin_is_locked(&lock);
>> +}
>> +
>> +#include <asm/qrwlock.h>
>> +
>> +#endif /* __ASM_GENERIC_TICKET_LOCK_H */
>> diff --git a/include/asm-generic/spinlock_types.h b/include/asm-generic/spinlock_types.h
>> new file mode 100644
>> index 000000000000..e56ddb84d030
>> --- /dev/null
>> +++ b/include/asm-generic/spinlock_types.h
>> @@ -0,0 +1,17 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +#ifndef __ASM_GENERIC_TICKET_LOCK_TYPES_H
>> +#define __ASM_GENERIC_TICKET_LOCK_TYPES_H
>> +
>> +#include <linux/types.h>
>> +typedef atomic_t arch_spinlock_t;
>> +
>> +/*
>> + * qrwlock_types depends on arch_spinlock_t, so we must typedef that before the
>> + * include.
>> + */
>> +#include <asm/qrwlock_types.h>
>
> I believe that if you guard the include line by
>
> #ifdef CONFIG_QUEUED_RWLOCK
> #include <asm/qrwlock_types.h>
> #endif
>
> You may not need to do the hack in patch 5.

Yes, and we actually had it that way the first time around (specifically 
the ARCH_USES_QUEUED_RWLOCKS, but IIUC that's the same here).  The goal 
was to avoid adding the ifdef to the asm-generic code and instead keep 
the oddness in arch/riscv, it's only there for that one commit (and just 
so we can split out the spinlock conversion from the rwlock conversion, 
in case there's a bug and these need to be bisected later).

I'd also considered renaming qrwlock* to rwlock*, which would avoid the 
ifdef and make it a touch easier to override the rwlock implementation, 
but that didn't seem useful enough to warrant the diff.  These all seem 
a bit more coupled than I expected them to be (both 
{spin,qrw}lock{,_types}.h and the bits in linux/), I looked into 
cleaning that up a bit but it seemed like too much for just the one 
patch set.

> You can also directly use the <asm-generic/qrwlock_types.h> line without
> importing it to include/asm.

Yes, along with qrwlock.h (which has some unnecessary #include shims in 
a handful of arch dirs).  That's going to make the patch set bigger, 
I'll include it in the v4.

Thanks!
