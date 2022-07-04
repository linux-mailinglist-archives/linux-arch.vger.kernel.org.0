Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD367565179
	for <lists+linux-arch@lfdr.de>; Mon,  4 Jul 2022 11:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbiGDJ6K (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Jul 2022 05:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbiGDJ6J (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jul 2022 05:58:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7062DEC9;
        Mon,  4 Jul 2022 02:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Px+ZKe9wAi2SGp+Y/6g7fKEpuudOqTemcnnZ84upXy8=; b=J/H0dEX0q7o0GxYYQ1CPY4uwG4
        veQdZPjrUKZLIzPt4BYfwjbS0U+zUGORZUnwe/nAIVwbzUjZ5Rcc3/OR2taXv/aiplUlOCNc+fN4X
        ZJPoZvfI3JhmfW5whl1MEn48DScYlBAk4XFwNW7UpiTWRjQf7InO/uZOOMp8+z2X0d1jJM9tyc4dp
        QhFROKJUMdYqQdLZOhn0pyXYkiIBKz+iDFmb/qYUIfa7I6CE9AlkvIDivPVXEASS3OdWUTikJcQLP
        WgMZLlG6T6yThW8rue0pP0/5gG8gk8tT1hRJg56z0lZLtAnZeiBZYDPnJA2ZsxvECu9J7/Adredgc
        kjC0K1fA==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8Iq4-00H9wK-Om; Mon, 04 Jul 2022 09:57:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1323630003A;
        Mon,  4 Jul 2022 11:57:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EDF8120295B20; Mon,  4 Jul 2022 11:57:55 +0200 (CEST)
Date:   Mon, 4 Jul 2022 11:57:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     guoren@kernel.org
Cc:     palmer@rivosinc.com, arnd@arndb.de, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V7 4/5] asm-generic: spinlock: Add combo spinlock (ticket
 & queued)
Message-ID: <YsK5o8eiVHeS+7Iw@hirez.programming.kicks-ass.net>
References: <20220628081707.1997728-1-guoren@kernel.org>
 <20220628081707.1997728-5-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628081707.1997728-5-guoren@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 28, 2022 at 04:17:06AM -0400, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Some architecture has a flexible requirement on the type of spinlock.
> Some LL/SC architectures of ISA don't force micro-arch to give a strong
> forward guarantee. Thus different kinds of memory model micro-arch would
> come out in one ISA. The ticket lock is suitable for exclusive monitor
> designed LL/SC micro-arch with limited cores and "!NUMA". The
> queue-spinlock could deal with NUMA/large-scale scenarios with a strong
> forward guarantee designed LL/SC micro-arch.
> 
> So, make the spinlock a combo with feature.
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>  include/asm-generic/spinlock.h | 43 ++++++++++++++++++++++++++++++++--
>  kernel/locking/qspinlock.c     |  2 ++
>  2 files changed, 43 insertions(+), 2 deletions(-)
> 
> diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
> index f41dc7c2b900..a9b43089bf99 100644
> --- a/include/asm-generic/spinlock.h
> +++ b/include/asm-generic/spinlock.h
> @@ -28,34 +28,73 @@
>  #define __ASM_GENERIC_SPINLOCK_H
>  
>  #include <asm-generic/ticket_spinlock.h>
> +#ifdef CONFIG_ARCH_USE_QUEUED_SPINLOCKS
> +#include <linux/jump_label.h>
> +#include <asm-generic/qspinlock.h>
> +
> +DECLARE_STATIC_KEY_TRUE(use_qspinlock_key);
> +#endif
> +
> +#undef arch_spin_is_locked
> +#undef arch_spin_is_contended
> +#undef arch_spin_value_unlocked
> +#undef arch_spin_lock
> +#undef arch_spin_trylock
> +#undef arch_spin_unlock
>  
>  static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
>  {
> -	ticket_spin_lock(lock);
> +#ifdef CONFIG_ARCH_USE_QUEUED_SPINLOCKS
> +	if (static_branch_likely(&use_qspinlock_key))
> +		queued_spin_lock(lock);
> +	else
> +#endif
> +		ticket_spin_lock(lock);
>  }
>  
>  static __always_inline bool arch_spin_trylock(arch_spinlock_t *lock)
>  {
> +#ifdef CONFIG_ARCH_USE_QUEUED_SPINLOCKS
> +	if (static_branch_likely(&use_qspinlock_key))
> +		return queued_spin_trylock(lock);
> +#endif
>  	return ticket_spin_trylock(lock);
>  }
>  
>  static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
>  {
> -	ticket_spin_unlock(lock);
> +#ifdef CONFIG_ARCH_USE_QUEUED_SPINLOCKS
> +	if (static_branch_likely(&use_qspinlock_key))
> +		queued_spin_unlock(lock);
> +	else
> +#endif
> +		ticket_spin_unlock(lock);
>  }
>  
>  static __always_inline int arch_spin_is_locked(arch_spinlock_t *lock)
>  {
> +#ifdef CONFIG_ARCH_USE_QUEUED_SPINLOCKS
> +	if (static_branch_likely(&use_qspinlock_key))
> +		return queued_spin_is_locked(lock);
> +#endif
>  	return ticket_spin_is_locked(lock);
>  }
>  
>  static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
>  {
> +#ifdef CONFIG_ARCH_USE_QUEUED_SPINLOCKS
> +	if (static_branch_likely(&use_qspinlock_key))
> +		return queued_spin_is_contended(lock);
> +#endif
>  	return ticket_spin_is_contended(lock);
>  }
>  
>  static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
>  {
> +#ifdef CONFIG_ARCH_USE_QUEUED_SPINLOCKS
> +	if (static_branch_likely(&use_qspinlock_key))
> +		return queued_spin_value_unlocked(lock);
> +#endif
>  	return ticket_spin_value_unlocked(lock);
>  }

Urggghhhh....

I really don't think you want this in generic code. Also, I'm thinking
any arch that does this wants to make sure it doesn't inline any of this
stuff. That is, said arch must not have ARCH_INLINE_SPIN_*

And if you're going to force things out of line, then I think you can
get better code using static_call().

*shudder*...
