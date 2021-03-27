Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E72F34B8FB
	for <lists+linux-arch@lfdr.de>; Sat, 27 Mar 2021 19:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhC0SoO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Mar 2021 14:44:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42606 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230127AbhC0Sny (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sat, 27 Mar 2021 14:43:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616870634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hfHNZcjhdGk5rFhqOZayvcQKCZrifZd2giGyChxT48Y=;
        b=ib9wHNFm3mOZE9vyb09GX5LxctH1omqGGzKHGXGGtW7dZjzcA4X165F6WNxL3i+fR73389
        tXXZ3/4dg9q149o4mZrEw92wJeL0MmCtxCsq7PPvghDUQQxQhnF4CdR0IXKJheQnWL1QgS
        iuqSBDQnY7bsM/wPsJ3h73qv4zLeQ5w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-KTtps0L0MseR04IzHmlZFQ-1; Sat, 27 Mar 2021 14:43:50 -0400
X-MC-Unique: KTtps0L0MseR04IzHmlZFQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF5451084C83;
        Sat, 27 Mar 2021 18:43:47 +0000 (UTC)
Received: from llong.remote.csb (ovpn-112-10.rdu2.redhat.com [10.10.112.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8471E10013D6;
        Sat, 27 Mar 2021 18:43:46 +0000 (UTC)
Subject: Re: [PATCH v4 3/4] locking/qspinlock: Add
 ARCH_USE_QUEUED_SPINLOCKS_XCHG32
To:     guoren@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Anup Patel <anup@brainfault.org>
References: <1616868399-82848-1-git-send-email-guoren@kernel.org>
 <1616868399-82848-4-git-send-email-guoren@kernel.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <b6466a43-6fb3-dc47-e0ef-d493e0930ab2@redhat.com>
Date:   Sat, 27 Mar 2021 14:43:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <1616868399-82848-4-git-send-email-guoren@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/27/21 2:06 PM, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Some architectures don't have sub-word swap atomic instruction,
> they only have the full word's one.
>
> The sub-word swap only improve the performance when:
> NR_CPUS < 16K
>   *  0- 7: locked byte
>   *     8: pending
>   *  9-15: not used
>   * 16-17: tail index
>   * 18-31: tail cpu (+1)
>
> The 9-15 bits are wasted to use xchg16 in xchg_tail.
>
> Please let architecture select xchg16/xchg32 to implement
> xchg_tail.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Anup Patel <anup@brainfault.org>
> ---
>   kernel/Kconfig.locks       |  3 +++
>   kernel/locking/qspinlock.c | 44 +++++++++++++++++++++-----------------
>   2 files changed, 27 insertions(+), 20 deletions(-)
>
> diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
> index 3de8fd11873b..d02f1261f73f 100644
> --- a/kernel/Kconfig.locks
> +++ b/kernel/Kconfig.locks
> @@ -239,6 +239,9 @@ config LOCK_SPIN_ON_OWNER
>   config ARCH_USE_QUEUED_SPINLOCKS
>   	bool
>   
> +config ARCH_USE_QUEUED_SPINLOCKS_XCHG32
> +	bool
> +
>   config QUEUED_SPINLOCKS
>   	def_bool y if ARCH_USE_QUEUED_SPINLOCKS
>   	depends on SMP
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index cbff6ba53d56..54de0632c6a8 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -163,26 +163,6 @@ static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
>   	WRITE_ONCE(lock->locked_pending, _Q_LOCKED_VAL);
>   }
>   
> -/*
> - * xchg_tail - Put in the new queue tail code word & retrieve previous one
> - * @lock : Pointer to queued spinlock structure
> - * @tail : The new queue tail code word
> - * Return: The previous queue tail code word
> - *
> - * xchg(lock, tail), which heads an address dependency
> - *
> - * p,*,* -> n,*,* ; prev = xchg(lock, node)
> - */
> -static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
> -{
> -	/*
> -	 * We can use relaxed semantics since the caller ensures that the
> -	 * MCS node is properly initialized before updating the tail.
> -	 */
> -	return (u32)xchg_relaxed(&lock->tail,
> -				 tail >> _Q_TAIL_OFFSET) << _Q_TAIL_OFFSET;
> -}
> -
>   #else /* _Q_PENDING_BITS == 8 */
>   
>   /**
> @@ -206,6 +186,30 @@ static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
>   {
>   	atomic_add(-_Q_PENDING_VAL + _Q_LOCKED_VAL, &lock->val);
>   }
> +#endif
> +
> +#if _Q_PENDING_BITS == 8 && !defined(CONFIG_ARCH_USE_QUEUED_SPINLOCKS_XCHG32)
> +/*
> + * xchg_tail - Put in the new queue tail code word & retrieve previous one
> + * @lock : Pointer to queued spinlock structure
> + * @tail : The new queue tail code word
> + * Return: The previous queue tail code word
> + *
> + * xchg(lock, tail), which heads an address dependency
> + *
> + * p,*,* -> n,*,* ; prev = xchg(lock, node)
> + */
> +static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
> +{
> +	/*
> +	 * We can use relaxed semantics since the caller ensures that the
> +	 * MCS node is properly initialized before updating the tail.
> +	 */
> +	return (u32)xchg_relaxed(&lock->tail,
> +				 tail >> _Q_TAIL_OFFSET) << _Q_TAIL_OFFSET;
> +}
> +
> +#else
>   
>   /**
>    * xchg_tail - Put in the new queue tail code word & retrieve previous one

I don't have any problem adding a 
CONFIG_ARCH_USE_QUEUED_SPINLOCKS_XCHG32 config option to control that.

One minor nit:

#endif /* _Q_PENDING_BITS == 8 */

You should probably remove the comment at the trailing end of the 
corresponding "#endif" as it is now wrong.

Cheers,
Longman

