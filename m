Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC48F3559AD
	for <lists+linux-arch@lfdr.de>; Tue,  6 Apr 2021 18:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346653AbhDFQxV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Apr 2021 12:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346649AbhDFQxU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Apr 2021 12:53:20 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902F4C06174A;
        Tue,  6 Apr 2021 09:53:12 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id h7so11671894qtx.3;
        Tue, 06 Apr 2021 09:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1O6341K+omlIB9wJ2hXLKkbsOLGoNgyMzo2Q8jp14ns=;
        b=FbSNaujCj4GQzt69czEYT9yzhdS82ILA0XySjA6WjU4aT1lYaj3SHxv1vX2vdur6FA
         YTPONs9m8qYw+wIijaGHll5+ej9HxKg+KQFlasntXZAtvkkwMbwniIgts8YWN+JrAH8w
         t36s62MjwnpWse52CNM+le4w4F/04vOQA3nJDDv342SOv74Z/0cWBHZ/gdXD8UNv9bpp
         BXz5kIUkEtqWteih/Slzdl0lXYk3whfXldJhCGinRXTLZRQW7X8u9XyIrFGgg8ywjhjL
         /t5bDygYdKZ/ZR3zXYOZevX0iznuq6YpLkE3K4148KcvXxeVyj5tP0mDaxzX/P41zFxB
         PxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1O6341K+omlIB9wJ2hXLKkbsOLGoNgyMzo2Q8jp14ns=;
        b=a63Bhp6CVKPdC4eCimmOPON56WGevWTKqJpqQEcUBtycOdNGlnR7X5I/ySVT7B7HC8
         r+K3fm18uLqcJQgH5SMMa+B8326MKaDb0HhXkK1Of0sS6WrbEJYWlS5M3ivgq1Wrul/M
         0p50Hu+e5pA2gscpDV1ZFiWz0P1zaw6EnIglym+Pfgpai0sQVjBWFM7M9uXPe7mhUbaV
         TQe7Eo8JOnR8yaB9qtDEfBce5rzDQUnEpeMSaGkBF5ivgewOpd+w60CP4xqCvqKLrM3C
         xzn5Sd01u9pqTfSDSURzCH5UA6XjM+bmp4DOdrFQRJDARVz3DfVE0ycyONjwsqTh+otN
         ZURA==
X-Gm-Message-State: AOAM5307ctOorx7fYHb9V8bvN4hJET5QlsZ1qE11HNKzebXKgXdoAglu
        5/uzPTFRQyaZCTDcVlUy/1sxHgQ4auY=
X-Google-Smtp-Source: ABdhPJyW4+S5F6l2W1agZlUj1gpYEr0Uf+t0W/YgCPZTn1gKNE1/+tdskKTlKeUZn69qOWB+q27VRQ==
X-Received: by 2002:ac8:48c9:: with SMTP id l9mr27015485qtr.45.1617727991808;
        Tue, 06 Apr 2021 09:53:11 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id h9sm14206728qtk.6.2021.04.06.09.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 09:53:11 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 7F86C27C0054;
        Tue,  6 Apr 2021 12:53:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 06 Apr 2021 12:53:10 -0400
X-ME-Sender: <xms:9JFsYMMMB4elRpqW88wslIO0VD_ZuVTszgiLe53m6RtFpubegkKdjw>
    <xme:9JFsYE8MXi0atf2wVteuwUs_we8loq8w63R9a0MILCua2xmzVrjDONtnAkG70Nh2J
    6TEDAN_p0HEj2d89A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudejhedgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepieffvdeitdetheffuddugffggedvjeejieffheeltdeghfehueehteehleeg
    heffnecukfhppedufedurddutdejrddugeejrdduvdeinecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:9JFsYMq4YxOfdEdokTwtHIt8Xs3fdMVumzM05UrAuCb885zHu1qeOQ>
    <xmx:9JFsYG4f2ABAf5xcYkJq3i8ICvFbYvLRcOhmAelzMj2mqBPDUoaonQ>
    <xmx:9JFsYMMiVadePONpSxOFiYg59L0Ic8noXkJMwuZM5NpPxpf-w62L2g>
    <xmx:9pFsYLzWGz8_ImuEDqJ-UV6sD7gYKwTJ_oEj70-Phbq1gZbukxLw1hZzov7S0x96>
Received: from localhost (unknown [131.107.147.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0F9261080066;
        Tue,  6 Apr 2021 12:53:07 -0400 (EDT)
Date:   Wed, 7 Apr 2021 00:51:56 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     guoren@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Anup Patel <anup@brainfault.org>
Subject: Re: [PATCH v6 1/9] locking/qspinlock: Add
 ARCH_USE_QUEUED_SPINLOCKS_XCHG32
Message-ID: <YGyRrBjomDCPOBUd@boqun-archlinux>
References: <1617201040-83905-1-git-send-email-guoren@kernel.org>
 <1617201040-83905-2-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617201040-83905-2-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On Wed, Mar 31, 2021 at 02:30:32PM +0000, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Some architectures don't have sub-word swap atomic instruction,
> they only have the full word's one.
> 
> The sub-word swap only improve the performance when:
> NR_CPUS < 16K
>  *  0- 7: locked byte
>  *     8: pending
>  *  9-15: not used
>  * 16-17: tail index
>  * 18-31: tail cpu (+1)
> 
> The 9-15 bits are wasted to use xchg16 in xchg_tail.
> 
> Please let architecture select xchg16/xchg32 to implement
> xchg_tail.
> 

If the architecture doesn't have sub-word swap atomic, won't it generate
the same/similar code no matter which version xchg_tail() is used? That
is even CONFIG_ARCH_USE_QUEUED_SPINLOCKS_XCHG32=y, xchg_tail() acts
similar to an xchg16() implemented by cmpxchg(), which means we still
don't have forward progress guarantee. So this configuration doesn't
solve the problem.

I think it's OK to introduce this config and don't provide xchg16() for
risc-v. But I don't see the point of converting other architectures to
use it.

Regards,
Boqun

> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Anup Patel <anup@brainfault.org>
> ---
>  kernel/Kconfig.locks       |  3 +++
>  kernel/locking/qspinlock.c | 46 +++++++++++++++++++++-----------------
>  2 files changed, 28 insertions(+), 21 deletions(-)
> 
> diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
> index 3de8fd11873b..d02f1261f73f 100644
> --- a/kernel/Kconfig.locks
> +++ b/kernel/Kconfig.locks
> @@ -239,6 +239,9 @@ config LOCK_SPIN_ON_OWNER
>  config ARCH_USE_QUEUED_SPINLOCKS
>  	bool
>  
> +config ARCH_USE_QUEUED_SPINLOCKS_XCHG32
> +	bool
> +
>  config QUEUED_SPINLOCKS
>  	def_bool y if ARCH_USE_QUEUED_SPINLOCKS
>  	depends on SMP
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index cbff6ba53d56..4bfaa969bd15 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -163,26 +163,6 @@ static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
>  	WRITE_ONCE(lock->locked_pending, _Q_LOCKED_VAL);
>  }
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
>  #else /* _Q_PENDING_BITS == 8 */
>  
>  /**
> @@ -206,6 +186,30 @@ static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
>  {
>  	atomic_add(-_Q_PENDING_VAL + _Q_LOCKED_VAL, &lock->val);
>  }
> +#endif /* _Q_PENDING_BITS == 8 */
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
>  /**
>   * xchg_tail - Put in the new queue tail code word & retrieve previous one
> @@ -236,7 +240,7 @@ static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
>  	}
>  	return old;
>  }
> -#endif /* _Q_PENDING_BITS == 8 */
> +#endif
>  
>  /**
>   * queued_fetch_set_pending_acquire - fetch the whole lock value and set pending
> -- 
> 2.17.1
> 
