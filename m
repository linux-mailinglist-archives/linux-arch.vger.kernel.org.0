Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F0250201F
	for <lists+linux-arch@lfdr.de>; Fri, 15 Apr 2022 03:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348420AbiDOB3v (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Apr 2022 21:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348404AbiDOB3u (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Apr 2022 21:29:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24CBD70926
        for <linux-arch@vger.kernel.org>; Thu, 14 Apr 2022 18:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649986042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=38ilKsA+Bz5y6ZbyDlwPueFS6EFR/hQD87Mrty+58Zw=;
        b=VBKabU8Ubxiww//6mA44QE4DuhM3D25KudmShbel+WKrxHGmiPApjtvAQ3+jDp7J87hcc4
        g954odDkNNsaL7YufD4FjhJZZHfvYZSBVKC9WXYpHpFFRVFFx+ewsOozDsvwbWz+ohNEqq
        Y3waOKpLE9c5YCUjNzxlFATHNQOEeac=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-IFhh3HIZNkiHc7ebYSdlzA-1; Thu, 14 Apr 2022 21:27:17 -0400
X-MC-Unique: IFhh3HIZNkiHc7ebYSdlzA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A4C9800B21;
        Fri, 15 Apr 2022 01:27:16 +0000 (UTC)
Received: from [10.22.18.93] (unknown [10.22.18.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 43B00111D78E;
        Fri, 15 Apr 2022 01:27:12 +0000 (UTC)
Message-ID: <1e26726b-721e-7197-8834-8aff2b4c4bc3@redhat.com>
Date:   Thu, 14 Apr 2022 21:27:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/7] asm-generic: ticket-lock: New generic ticket-based
 spinlock
Content-Language: en-US
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        Arnd Bergmann <arnd@arndb.de>, heiko@sntech.de,
        guoren@kernel.org, shorne@gmail.com
Cc:     peterz@infradead.org, mingo@redhat.com,
        Will Deacon <will@kernel.org>, boqun.feng@gmail.com,
        jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        macro@orcam.me.uk, Greg KH <gregkh@linuxfoundation.org>,
        sudipm.mukherjee@gmail.com, wangkefeng.wang@huawei.com,
        jszhang@kernel.org, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org, openrisc@lists.librecores.org,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
References: <20220414220214.24556-1-palmer@rivosinc.com>
 <20220414220214.24556-2-palmer@rivosinc.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220414220214.24556-2-palmer@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/14/22 18:02, Palmer Dabbelt wrote:
> From: Peter Zijlstra <peterz@infradead.org>
>
> This is a simple, fair spinlock.  Specifically it doesn't have all the
> subtle memory model dependencies that qspinlock has, which makes it more
> suitable for simple systems as it is more likely to be correct.  It is
> implemented entirely in terms of standard atomics and thus works fine
> without any arch-specific code.
>
> This replaces the existing asm-generic/spinlock.h, which just errored
> out on SMP systems.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>   include/asm-generic/spinlock.h       | 85 +++++++++++++++++++++++++---
>   include/asm-generic/spinlock_types.h | 17 ++++++
>   2 files changed, 94 insertions(+), 8 deletions(-)
>   create mode 100644 include/asm-generic/spinlock_types.h
>
> diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
> index adaf6acab172..ca829fcb9672 100644
> --- a/include/asm-generic/spinlock.h
> +++ b/include/asm-generic/spinlock.h
> @@ -1,12 +1,81 @@
>   /* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef __ASM_GENERIC_SPINLOCK_H
> -#define __ASM_GENERIC_SPINLOCK_H
> +
>   /*
> - * You need to implement asm/spinlock.h for SMP support. The generic
> - * version does not handle SMP.
> + * 'Generic' ticket-lock implementation.
> + *
> + * It relies on atomic_fetch_add() having well defined forward progress
> + * guarantees under contention. If your architecture cannot provide this, stick
> + * to a test-and-set lock.
> + *
> + * It also relies on atomic_fetch_add() being safe vs smp_store_release() on a
> + * sub-word of the value. This is generally true for anything LL/SC although
> + * you'd be hard pressed to find anything useful in architecture specifications
> + * about this. If your architecture cannot do this you might be better off with
> + * a test-and-set.
> + *
> + * It further assumes atomic_*_release() + atomic_*_acquire() is RCpc and hence
> + * uses atomic_fetch_add() which is SC to create an RCsc lock.
> + *
> + * The implementation uses smp_cond_load_acquire() to spin, so if the
> + * architecture has WFE like instructions to sleep instead of poll for word
> + * modifications be sure to implement that (see ARM64 for example).
> + *
>    */
> -#ifdef CONFIG_SMP
> -#error need an architecture specific asm/spinlock.h
> -#endif
>   
> -#endif /* __ASM_GENERIC_SPINLOCK_H */
> +#ifndef __ASM_GENERIC_TICKET_LOCK_H
> +#define __ASM_GENERIC_TICKET_LOCK_H
It is not conventional to use a macro name that is different from the 
header file name.
> +
> +#include <linux/atomic.h>
> +#include <asm-generic/spinlock_types.h>
> +
> +static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
> +{
> +	u32 val = atomic_fetch_add(1<<16, lock); /* SC, gives us RCsc */
> +	u16 ticket = val >> 16;
> +
> +	if (ticket == (u16)val)
> +		return;
> +
> +	atomic_cond_read_acquire(lock, ticket == (u16)VAL);
> +}
> +
> +static __always_inline bool arch_spin_trylock(arch_spinlock_t *lock)
> +{
> +	u32 old = atomic_read(lock);
> +
> +	if ((old >> 16) != (old & 0xffff))
> +		return false;
> +
> +	return atomic_try_cmpxchg(lock, &old, old + (1<<16)); /* SC, for RCsc */
> +}
> +
> +static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
> +{
> +	u16 *ptr = (u16 *)lock + IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);
> +	u32 val = atomic_read(lock);
> +
> +	smp_store_release(ptr, (u16)val + 1);
> +}
> +
> +static __always_inline int arch_spin_is_locked(arch_spinlock_t *lock)
> +{
> +	u32 val = atomic_read(lock);
> +
> +	return ((val >> 16) != (val & 0xffff));
> +}
> +
> +static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
> +{
> +	u32 val = atomic_read(lock);
> +
> +	return (s16)((val >> 16) - (val & 0xffff)) > 1;
> +}
> +
> +static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
> +{
> +	return !arch_spin_is_locked(&lock);
> +}
> +
> +#include <asm/qrwlock.h>
> +
> +#endif /* __ASM_GENERIC_TICKET_LOCK_H */
> diff --git a/include/asm-generic/spinlock_types.h b/include/asm-generic/spinlock_types.h
> new file mode 100644
> index 000000000000..e56ddb84d030
> --- /dev/null
> +++ b/include/asm-generic/spinlock_types.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __ASM_GENERIC_TICKET_LOCK_TYPES_H
> +#define __ASM_GENERIC_TICKET_LOCK_TYPES_H
> +
> +#include <linux/types.h>
> +typedef atomic_t arch_spinlock_t;
> +
> +/*
> + * qrwlock_types depends on arch_spinlock_t, so we must typedef that before the
> + * include.
> + */
> +#include <asm/qrwlock_types.h>

I believe that if you guard the include line by

#ifdef CONFIG_QUEUED_RWLOCK
#include <asm/qrwlock_types.h>
#endif

You may not need to do the hack in patch 5.

You can also directly use the <asm-generic/qrwlock_types.h> line without 
importing it to include/asm.

Cheers,
Longman

