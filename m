Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A7F4DE5DF
	for <lists+linux-arch@lfdr.de>; Sat, 19 Mar 2022 05:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbiCSED0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Mar 2022 00:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbiCSEDZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 19 Mar 2022 00:03:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CDD17942B;
        Fri, 18 Mar 2022 21:02:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5913EB82158;
        Sat, 19 Mar 2022 04:02:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1168AC340EC;
        Sat, 19 Mar 2022 04:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647662522;
        bh=8s1Rb3BKfk6/ptqrc0ER3So3OgFRqJpX2kh+8F+4PAw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E6EEmc9fVWUkNnvO3SJxBou1tQVbCsA5szsJDUGO0TvDjpa801AoPKaXTbmmrk+te
         mbebj5TpAbmrZTuVVWTDdCsAuoqyVQQzQPcty+rN5xZswSb1WarCVbmdu2JbtX5Tlh
         3/jzEI6UBkFcxjHZ1veM8eX5JQkuxtWa4hqOLHzwJnFFTniku9r/xJQOyEyyHXGvXx
         6O+huf2mR/yh2EnJD7+duSv6mksY3djgwpEynZxaeKlddJg6fHRY1BtBAr1Da1C5g5
         ZuiHuYp1pXPZmt7ytq6nVRq6LEWhAclXqzd0m+O9AffGr5NdyaqI8BGVQo4x/Km1ZW
         DLH29i6xSlWJQ==
Received: by mail-vs1-f53.google.com with SMTP id h126so4623864vsc.13;
        Fri, 18 Mar 2022 21:02:02 -0700 (PDT)
X-Gm-Message-State: AOAM5339bAn3Ceg3w5tOP0FXCYkWNYGM+w+RHL7DzMyvTdow8urkpngX
        4c6TPheQqScj1xg2HsQPsnGgrIQMgEwC1thgwb8=
X-Google-Smtp-Source: ABdhPJzYwDEORAK24zdYpS+W7WS9QwZnB2x8En/tDUrLGIbXr41obp2qynZmnNsN0GZyCgT4ZUzOi6VGwD8Ij8z7Gz4=
X-Received: by 2002:a67:bc05:0:b0:324:eed0:ec29 with SMTP id
 t5-20020a67bc05000000b00324eed0ec29mr586232vsn.2.1647662520935; Fri, 18 Mar
 2022 21:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220318083421.2062259-1-guoren@kernel.org> <mhng-88509dbf-71a1-495a-84a7-3dffef8c77a5@palmer-ri-x1c9>
In-Reply-To: <mhng-88509dbf-71a1-495a-84a7-3dffef8c77a5@palmer-ri-x1c9>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 19 Mar 2022 12:01:49 +0800
X-Gmail-Original-Message-ID: <CAJF2gTShUjTQ=7g3uW8JmPzkZSG0fWKK7fXgAsERSUfrCgzA0w@mail.gmail.com>
Message-ID: <CAJF2gTShUjTQ=7g3uW8JmPzkZSG0fWKK7fXgAsERSUfrCgzA0w@mail.gmail.com>
Subject: Re: [PATCH] csky: Move to generic ticket-spinlock
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Palmer,

On Sat, Mar 19, 2022 at 6:48 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> On Fri, 18 Mar 2022 01:34:21 PDT (-0700), guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > There is no benefit from custom implementation for ticket-spinlock,
> > so move to generic ticket-spinlock for easy maintenance.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Cc: Palmer Dabbelt <palmer@rivosinc.com>
>
> Thanks, one less port to look at ;)
>
> Looks like there were a few comments on the v1, and I wasn't going to
> target this at the upcoming merge window anyway because I wanted to give
Agree, we needn't so hurry.

> the various RISC-V vendors time to test stuff.  LMK if you want me to
> add this to the others, but I was planning on posting a stable tag
> either way so no big deal on my end.
Yes, I hope csky's could be in the series. And I updated V2 with
Arnd's suggestion, please have a look:
https://lore.kernel.org/linux-arch/20220319035457.2214979-1-guoren@kernel.org/T/#t

>
> > ---
> >  arch/csky/include/asm/Kbuild           |  2 +
> >  arch/csky/include/asm/spinlock.h       | 82 +-------------------------
> >  arch/csky/include/asm/spinlock_types.h | 20 +------
> >  3 files changed, 4 insertions(+), 100 deletions(-)
> >
> > diff --git a/arch/csky/include/asm/Kbuild b/arch/csky/include/asm/Kbuild
> > index 904a18a818be..d94434288c31 100644
> > --- a/arch/csky/include/asm/Kbuild
> > +++ b/arch/csky/include/asm/Kbuild
> > @@ -3,6 +3,8 @@ generic-y += asm-offsets.h
> >  generic-y += extable.h
> >  generic-y += gpio.h
> >  generic-y += kvm_para.h
> > +generic-y += ticket-lock.h
> > +generic-y += ticket-lock-types.h
> >  generic-y += qrwlock.h
> >  generic-y += user.h
> >  generic-y += vmlinux.lds.h
> > diff --git a/arch/csky/include/asm/spinlock.h b/arch/csky/include/asm/spinlock.h
> > index 69f5aa249c5f..8bc179ba0d8d 100644
> > --- a/arch/csky/include/asm/spinlock.h
> > +++ b/arch/csky/include/asm/spinlock.h
> > @@ -3,87 +3,7 @@
> >  #ifndef __ASM_CSKY_SPINLOCK_H
> >  #define __ASM_CSKY_SPINLOCK_H
> >
> > -#include <linux/spinlock_types.h>
> > -#include <asm/barrier.h>
> > -
> > -/*
> > - * Ticket-based spin-locking.
> > - */
> > -static inline void arch_spin_lock(arch_spinlock_t *lock)
> > -{
> > -     arch_spinlock_t lockval;
> > -     u32 ticket_next = 1 << TICKET_NEXT;
> > -     u32 *p = &lock->lock;
> > -     u32 tmp;
> > -
> > -     asm volatile (
> > -             "1:     ldex.w          %0, (%2) \n"
> > -             "       mov             %1, %0   \n"
> > -             "       add             %0, %3   \n"
> > -             "       stex.w          %0, (%2) \n"
> > -             "       bez             %0, 1b   \n"
> > -             : "=&r" (tmp), "=&r" (lockval)
> > -             : "r"(p), "r"(ticket_next)
> > -             : "cc");
> > -
> > -     while (lockval.tickets.next != lockval.tickets.owner)
> > -             lockval.tickets.owner = READ_ONCE(lock->tickets.owner);
> > -
> > -     smp_mb();
> > -}
> > -
> > -static inline int arch_spin_trylock(arch_spinlock_t *lock)
> > -{
> > -     u32 tmp, contended, res;
> > -     u32 ticket_next = 1 << TICKET_NEXT;
> > -     u32 *p = &lock->lock;
> > -
> > -     do {
> > -             asm volatile (
> > -             "       ldex.w          %0, (%3)   \n"
> > -             "       movi            %2, 1      \n"
> > -             "       rotli           %1, %0, 16 \n"
> > -             "       cmpne           %1, %0     \n"
> > -             "       bt              1f         \n"
> > -             "       movi            %2, 0      \n"
> > -             "       add             %0, %0, %4 \n"
> > -             "       stex.w          %0, (%3)   \n"
> > -             "1:                                \n"
> > -             : "=&r" (res), "=&r" (tmp), "=&r" (contended)
> > -             : "r"(p), "r"(ticket_next)
> > -             : "cc");
> > -     } while (!res);
> > -
> > -     if (!contended)
> > -             smp_mb();
> > -
> > -     return !contended;
> > -}
> > -
> > -static inline void arch_spin_unlock(arch_spinlock_t *lock)
> > -{
> > -     smp_mb();
> > -     WRITE_ONCE(lock->tickets.owner, lock->tickets.owner + 1);
> > -}
> > -
> > -static inline int arch_spin_value_unlocked(arch_spinlock_t lock)
> > -{
> > -     return lock.tickets.owner == lock.tickets.next;
> > -}
> > -
> > -static inline int arch_spin_is_locked(arch_spinlock_t *lock)
> > -{
> > -     return !arch_spin_value_unlocked(READ_ONCE(*lock));
> > -}
> > -
> > -static inline int arch_spin_is_contended(arch_spinlock_t *lock)
> > -{
> > -     struct __raw_tickets tickets = READ_ONCE(lock->tickets);
> > -
> > -     return (tickets.next - tickets.owner) > 1;
> > -}
> > -#define arch_spin_is_contended       arch_spin_is_contended
> > -
> > +#include <asm/ticket-lock.h>
> >  #include <asm/qrwlock.h>
> >
> >  #endif /* __ASM_CSKY_SPINLOCK_H */
> > diff --git a/arch/csky/include/asm/spinlock_types.h b/arch/csky/include/asm/spinlock_types.h
> > index db87a12c3827..0bb7f6022a3b 100644
> > --- a/arch/csky/include/asm/spinlock_types.h
> > +++ b/arch/csky/include/asm/spinlock_types.h
> > @@ -3,25 +3,7 @@
> >  #ifndef __ASM_CSKY_SPINLOCK_TYPES_H
> >  #define __ASM_CSKY_SPINLOCK_TYPES_H
> >
> > -#ifndef __LINUX_SPINLOCK_TYPES_RAW_H
> > -# error "please don't include this file directly"
> > -#endif
> > -
> > -#define TICKET_NEXT  16
> > -
> > -typedef struct {
> > -     union {
> > -             u32 lock;
> > -             struct __raw_tickets {
> > -                     /* little endian */
> > -                     u16 owner;
> > -                     u16 next;
> > -             } tickets;
> > -     };
> > -} arch_spinlock_t;
> > -
> > -#define __ARCH_SPIN_LOCK_UNLOCKED    { { 0 } }
> > -
> > +#include <asm/ticket-lock-types.h>
> >  #include <asm-generic/qrwlock_types.h>
> >
> >  #endif /* __ASM_CSKY_SPINLOCK_TYPES_H */



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
