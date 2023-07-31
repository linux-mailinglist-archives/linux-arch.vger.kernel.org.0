Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45535768A17
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jul 2023 04:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjGaClH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 30 Jul 2023 22:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjGaClH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 30 Jul 2023 22:41:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430FD10D7;
        Sun, 30 Jul 2023 19:40:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B999260E0A;
        Mon, 31 Jul 2023 02:40:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2817FC433C8;
        Mon, 31 Jul 2023 02:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690771251;
        bh=J0ZdN6k+NXscFIa7xVIKz/qaVIETu93UOxamXbBvn2o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AJTp3ft/1lYJCYw86qMq7cQ63uMTMGhxjoq3jOE9P1+oSPudfBtKDO2sS2RApnVx1
         /eVcB9vFYhumKtBsHk7+wwxvFt4zn1Hg4lZ88BUtnpgJodb7jnRrrXGUlzv0ccqN6G
         Vv8NJ70nv2rpQjx03sBBfP2aExCqq2kwnJ1eC94id/CVzqhx4+TzZvurTO1uPdzYK+
         dsgpBCCb8PprfgDzDW3zl53okqTMdcvyvaruKdXNs0LnIU56lBQaklelAXAXypRbqR
         QZ7Avok5fwmDvaQ5QQYKSlyRRFeLCg/Z/9Cgeg5Qm/p/n3N2kgem0k9b+AL399lAmT
         gXr1oQyIBS5pg==
Date:   Sun, 30 Jul 2023 22:40:40 -0400
From:   Guo Ren <guoren@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     David.Laight@aculab.com, will@kernel.org, peterz@infradead.org,
        mingo@redhat.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] asm-generic: ticket-lock: Optimize
 arch_spin_value_unlocked
Message-ID: <ZMcfKFWWUC0hI2kM@gmail.com>
References: <20230719070001.795010-1-guoren@kernel.org>
 <0e39d62d-44bc-731e-471e-4df621b4cdd5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e39d62d-44bc-731e-471e-4df621b4cdd5@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jul 22, 2023 at 10:07:19PM -0400, Waiman Long wrote:
> On 7/19/23 03:00, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> > 
> > Using arch_spinlock_is_locked would cause another unnecessary memory
> > access to the contended value. Although it won't cause a significant
> > performance gap in most architectures, the arch_spin_value_unlocked
> > argument contains enough information. Thus, remove unnecessary
> > atomic_read in arch_spin_value_unlocked().
> 
> AFAICS, only one memory access is needed for the current
> arch_spinlock_is_locked(). So your description isn't quite right. OTOH,
Okay, I would improve it. Here means "arch_spin_value_unlocked using
arch_spinlock_is_locked" would cause "an" unnecessary ...

> caller of arch_spin_value_unlocked() could benefit from this change.
> Currently, the only caller is lockref.
Thx for comment, I would add it in the commit msg.

New version is here:
https://lore.kernel.org/linux-riscv/20230731023308.3748432-1-guoren@kernel.org/

> 
> Other than that, the patch looks good to me.
> 
> Cheers,
> Longman
> 
> > 
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Cc: David Laight <David.Laight@ACULAB.COM>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > ---
> > Changelog:
> > This patch is separate from:
> > https://lore.kernel.org/linux-riscv/20220808071318.3335746-1-guoren@kernel.org/
> > 
> > Peter & David have commented on it:
> > https://lore.kernel.org/linux-riscv/YsK4Z9w0tFtgkni8@hirez.programming.kicks-ass.net/
> > ---
> >   include/asm-generic/spinlock.h | 16 +++++++++-------
> >   1 file changed, 9 insertions(+), 7 deletions(-)
> > 
> > diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
> > index fdfebcb050f4..90803a826ba0 100644
> > --- a/include/asm-generic/spinlock.h
> > +++ b/include/asm-generic/spinlock.h
> > @@ -68,11 +68,18 @@ static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
> >   	smp_store_release(ptr, (u16)val + 1);
> >   }
> > +static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
> > +{
> > +	u32 val = lock.counter;
> > +
> > +	return ((val >> 16) == (val & 0xffff));
> > +}
> > +
> >   static __always_inline int arch_spin_is_locked(arch_spinlock_t *lock)
> >   {
> > -	u32 val = atomic_read(lock);
> > +	arch_spinlock_t val = READ_ONCE(*lock);
> > -	return ((val >> 16) != (val & 0xffff));
> > +	return !arch_spin_value_unlocked(val);
> >   }
> >   static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
> > @@ -82,11 +89,6 @@ static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
> >   	return (s16)((val >> 16) - (val & 0xffff)) > 1;
> >   }
> > -static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
> > -{
> > -	return !arch_spin_is_locked(&lock);
> > -}
> > -
> >   #include <asm/qrwlock.h>
> >   #endif /* __ASM_GENERIC_SPINLOCK_H */
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
