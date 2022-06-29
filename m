Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934FF55F347
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jun 2022 04:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiF2CMe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jun 2022 22:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiF2CMd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jun 2022 22:12:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA26A2CE38;
        Tue, 28 Jun 2022 19:12:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 555B461CF6;
        Wed, 29 Jun 2022 02:12:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4246C341CF;
        Wed, 29 Jun 2022 02:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656468751;
        bh=kBeb5Uw/j5cdFGYwRHmMmUlZSMwzxwbpxsSpXCSep3M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LjRWHp6YutpgDlkEoNZbTlTjpLtq3ctkRx2/BPSkYoTyqPyf1vbeUkRYl7aVXaLFe
         nkWK5TljCMJa6ImUJ1mG1/WmeUeaW/s/tRLT1FL5iYuedBygOX5fPBg+AzMAnBAG12
         JVyQGg0Bvm+JvD4/sOfYmzZGdiUKi9JSh5eVPII9OKI9eLWFgVdfaFj3vuWsifYHy2
         6vakrGMTWnYcu6Iv66KFV8qNGEpfG8OFb6v2iielwim9MEUxzmj2b5/hNEbuffPbOd
         +KkqEsQWl+sa0AuPmlfnCyVtIIHoxeDZw5VqT44eybVBx0+t0OJ3NG+/kR1gIQ/J8C
         Q0ySNX33MLQSw==
Received: by mail-vk1-f172.google.com with SMTP id 15so6809250vko.13;
        Tue, 28 Jun 2022 19:12:31 -0700 (PDT)
X-Gm-Message-State: AJIora9fVa1wkGlU1cAD4HD9y3WB2percLKUTeKNTaf+PncQicUUIvPH
        Kk0UiccDWQroqRty5eT+HkeeGTQMpGDiEtgv9XY=
X-Google-Smtp-Source: AGRyM1sDRJWKc6dWVeHElvUlboqPwiwJz5m7zwHa5t+QSM5ZMx0nyhJAV632XFc2O2XkuEmomXUFDLniU28YR8W/XHg=
X-Received: by 2002:ac5:cdcc:0:b0:36c:547d:d9c4 with SMTP id
 u12-20020ac5cdcc000000b0036c547dd9c4mr3761818vkn.2.1656468750514; Tue, 28 Jun
 2022 19:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220628081707.1997728-1-guoren@kernel.org> <20220628081707.1997728-2-guoren@kernel.org>
 <218522c9-97b9-7659-ce31-2dbc4b0c6a60@redhat.com>
In-Reply-To: <218522c9-97b9-7659-ce31-2dbc4b0c6a60@redhat.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 29 Jun 2022 10:12:19 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRBoAZzjWGJ0zAxv0eqBB-G=V3QHmp6+jXyznmuY6LhCQ@mail.gmail.com>
Message-ID: <CAJF2gTRBoAZzjWGJ0zAxv0eqBB-G=V3QHmp6+jXyznmuY6LhCQ@mail.gmail.com>
Subject: Re: [PATCH V7 1/5] asm-generic: ticket-lock: Remove unnecessary atomic_read
To:     Waiman Long <longman@redhat.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 29, 2022 at 2:06 AM Waiman Long <longman@redhat.com> wrote:
>
> On 6/28/22 04:17, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Remove unnecessary atomic_read in arch_spin_value_unlocked(lock),
> > because the value has been in lock. This patch could prevent
> > arch_spin_value_unlocked contend spin_lock data again.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Palmer Dabbelt <palmer@rivosinc.com>
> > ---
> >   include/asm-generic/spinlock.h | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
> > index fdfebcb050f4..f1e4fa100f5a 100644
> > --- a/include/asm-generic/spinlock.h
> > +++ b/include/asm-generic/spinlock.h
> > @@ -84,7 +84,9 @@ static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
> >
> >   static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
> >   {
> > -     return !arch_spin_is_locked(&lock);
> > +     u32 val = lock.counter;
> > +
> > +     return ((val >> 16) == (val & 0xffff));
> >   }
> >
> >   #include <asm/qrwlock.h>
>
> lockref.c is the only current user of arch_spin_value_unlocked(). This
> change is probably OK with this particular use case. Do you have any
> performance data about the improvement due to this change?
I don't have performance data and I just check the asm code, previous
version has an additional unnecessary atomic_read.

About this point, we've talked before, but I & palmer missed that
point when we pick peter's patch again.
https://lore.kernel.org/linux-riscv/YHbmXXvuG442ZDfN@hirez.programming.kicks-ass.net/
----
> > +static __always_inline int ticket_value_unlocked(arch_spinlock_t lock)
> > +{
> > +       return !ticket_is_locked(&lock);
> Are you sure to let ticket_is_locked->atomic_read(lock) again, the
> lock has contained all information?
>
> return lock.tickets.owner == lock.tickets.next;

Yeah, I wrote then the wrong way around. Couldn't be bothered to go back
when I figured it out.
---
It's just a small typo.


>
> You may have to document that we have to revisit that if another use
> case shows up.
>
> Cheers,
> Longman
>


--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
