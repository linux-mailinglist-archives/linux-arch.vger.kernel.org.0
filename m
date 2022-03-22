Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484E04E4576
	for <lists+linux-arch@lfdr.de>; Tue, 22 Mar 2022 18:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239852AbiCVRuD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Mar 2022 13:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239872AbiCVRuC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Mar 2022 13:50:02 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADFB25C77
        for <linux-arch@vger.kernel.org>; Tue, 22 Mar 2022 10:48:34 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id t2so18757231pfj.10
        for <linux-arch@vger.kernel.org>; Tue, 22 Mar 2022 10:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=pHpgWnyA+4cksK2jdnSyO1l2xWVlwD/uKJzOgotnJTA=;
        b=m7fQ/X6bXpyvPl4juhvAFLBJuX1Y42anKo16WZ0Ojz3R2+Z9CpTm/6llMEgIpNtnro
         2ZzYBgJuk2F+e26jMsk2pwJ7v0RhWWAVfghpLnpTdpFucYO8ncj2QRNjwUfN43nbCPTS
         qHDEFs6mpYyNBbnkfmF2H9EhpUE/89ojloLvDmWc0W+0WRQzrbMvSMRwL+5HPUZaqJxu
         BqA2Bn0VeC4oJsqO3pYNRISeahC8dyhsivSa+DDBv/axlUxaLrn/P8K5S5GwtkYO6Ry6
         0COuu5Cy6qaf0mXozXCn1wF6p+At2JBb9+xzhShvrgtl8BidWp7Jjwbc6p0MYtx5q7oN
         eeog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=pHpgWnyA+4cksK2jdnSyO1l2xWVlwD/uKJzOgotnJTA=;
        b=N79UTxNsT0vBDtYiyhOt4yEBRp8pe56XIMU4KlfGTMb/PMaK9Ga/EovWcNb8oKdRLH
         3v3LtTc7+C6LzZhe9PA0ESsnU0e9tac2S6A1KnNOvX3t6MaGNqGMbCW1qXt9VbueFDKE
         qcOErznK3W1LUJ5LHgvPBGesSqHODNDNkSXpid+oe6reg5jS6zoVs4KsHLH2AuKunMc8
         VAG/7jxjqWS5M/7AZ8LWNcBvh2x+F7B2WjpN+DuhJ0YGRutlcQ83mqWkLtSl2F/ooxiI
         iz6erEKw/tdYdqVUK5EkTSz1W1/tsUvE0AqVixHvk1jqILbW00b9OXGKzx5mig1SAw5w
         FOMg==
X-Gm-Message-State: AOAM532V2xQvD/7jQUmnoOU7VuDQulAnxs45gU0kUNfKBT2E1HlOm5WP
        HQFw7MBlmKF8ZqQlU29wv70NNA==
X-Google-Smtp-Source: ABdhPJwsrDQOZo0FtmYLlIizrEgq6CCc9WybkQ6yKegPcKzZT73TPxy8MmY1MlGxrqHQXfUguCBPyQ==
X-Received: by 2002:a05:6a00:815:b0:4f6:ee04:30af with SMTP id m21-20020a056a00081500b004f6ee0430afmr29866834pfk.15.1647971313454;
        Tue, 22 Mar 2022 10:48:33 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id w24-20020a639358000000b00385fcbf8e55sm1138666pgm.28.2022.03.22.10.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 10:48:32 -0700 (PDT)
Date:   Tue, 22 Mar 2022 10:48:32 -0700 (PDT)
X-Google-Original-Date: Tue, 22 Mar 2022 10:48:31 PDT (-0700)
Subject:     Re: [PATCH] csky: Move to generic ticket-spinlock
In-Reply-To: <CAJF2gTShUjTQ=7g3uW8JmPzkZSG0fWKK7fXgAsERSUfrCgzA0w@mail.gmail.com>
CC:     linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, guoren@linux.alibaba.com
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     guoren@kernel.org
Message-ID: <mhng-382a4c87-1d59-43ba-b567-06c6eb94843e@palmer-ri-x1c9>
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

On Fri, 18 Mar 2022 21:01:49 PDT (-0700), guoren@kernel.org wrote:
> Hi Palmer,
>
> On Sat, Mar 19, 2022 at 6:48 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>>
>> On Fri, 18 Mar 2022 01:34:21 PDT (-0700), guoren@kernel.org wrote:
>> > From: Guo Ren <guoren@linux.alibaba.com>
>> >
>> > There is no benefit from custom implementation for ticket-spinlock,
>> > so move to generic ticket-spinlock for easy maintenance.
>> >
>> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>> > Cc: Palmer Dabbelt <palmer@rivosinc.com>
>>
>> Thanks, one less port to look at ;)
>>
>> Looks like there were a few comments on the v1, and I wasn't going to
>> target this at the upcoming merge window anyway because I wanted to give
> Agree, we needn't so hurry.
>
>> the various RISC-V vendors time to test stuff.  LMK if you want me to
>> add this to the others, but I was planning on posting a stable tag
>> either way so no big deal on my end.
> Yes, I hope csky's could be in the series. And I updated V2 with
> Arnd's suggestion, please have a look:
> https://lore.kernel.org/linux-arch/20220319035457.2214979-1-guoren@kernel.org/T/#t

Thanks, I'll include the csky stuff next time I re-spin this.

Looks like there's been some other comments from folks that didn't make 
your v2, most notably the SOB lines which makes this a bit funny.  I'm 
also not sure I like merging the two RISC-V patches together, as they'd 
be nice to be able to test on their own.

I'll go poke around with this some once I'm a bit father into the merge 
window.  I think we can both keep Arnd's generic header idea and let 
folks mix/match spin/rw lock flavors, which might also help with some of 
the other ports.


>
>>
>> > ---
>> >  arch/csky/include/asm/Kbuild           |  2 +
>> >  arch/csky/include/asm/spinlock.h       | 82 +-------------------------
>> >  arch/csky/include/asm/spinlock_types.h | 20 +------
>> >  3 files changed, 4 insertions(+), 100 deletions(-)
>> >
>> > diff --git a/arch/csky/include/asm/Kbuild b/arch/csky/include/asm/Kbuild
>> > index 904a18a818be..d94434288c31 100644
>> > --- a/arch/csky/include/asm/Kbuild
>> > +++ b/arch/csky/include/asm/Kbuild
>> > @@ -3,6 +3,8 @@ generic-y += asm-offsets.h
>> >  generic-y += extable.h
>> >  generic-y += gpio.h
>> >  generic-y += kvm_para.h
>> > +generic-y += ticket-lock.h
>> > +generic-y += ticket-lock-types.h
>> >  generic-y += qrwlock.h
>> >  generic-y += user.h
>> >  generic-y += vmlinux.lds.h
>> > diff --git a/arch/csky/include/asm/spinlock.h b/arch/csky/include/asm/spinlock.h
>> > index 69f5aa249c5f..8bc179ba0d8d 100644
>> > --- a/arch/csky/include/asm/spinlock.h
>> > +++ b/arch/csky/include/asm/spinlock.h
>> > @@ -3,87 +3,7 @@
>> >  #ifndef __ASM_CSKY_SPINLOCK_H
>> >  #define __ASM_CSKY_SPINLOCK_H
>> >
>> > -#include <linux/spinlock_types.h>
>> > -#include <asm/barrier.h>
>> > -
>> > -/*
>> > - * Ticket-based spin-locking.
>> > - */
>> > -static inline void arch_spin_lock(arch_spinlock_t *lock)
>> > -{
>> > -     arch_spinlock_t lockval;
>> > -     u32 ticket_next = 1 << TICKET_NEXT;
>> > -     u32 *p = &lock->lock;
>> > -     u32 tmp;
>> > -
>> > -     asm volatile (
>> > -             "1:     ldex.w          %0, (%2) \n"
>> > -             "       mov             %1, %0   \n"
>> > -             "       add             %0, %3   \n"
>> > -             "       stex.w          %0, (%2) \n"
>> > -             "       bez             %0, 1b   \n"
>> > -             : "=&r" (tmp), "=&r" (lockval)
>> > -             : "r"(p), "r"(ticket_next)
>> > -             : "cc");
>> > -
>> > -     while (lockval.tickets.next != lockval.tickets.owner)
>> > -             lockval.tickets.owner = READ_ONCE(lock->tickets.owner);
>> > -
>> > -     smp_mb();
>> > -}
>> > -
>> > -static inline int arch_spin_trylock(arch_spinlock_t *lock)
>> > -{
>> > -     u32 tmp, contended, res;
>> > -     u32 ticket_next = 1 << TICKET_NEXT;
>> > -     u32 *p = &lock->lock;
>> > -
>> > -     do {
>> > -             asm volatile (
>> > -             "       ldex.w          %0, (%3)   \n"
>> > -             "       movi            %2, 1      \n"
>> > -             "       rotli           %1, %0, 16 \n"
>> > -             "       cmpne           %1, %0     \n"
>> > -             "       bt              1f         \n"
>> > -             "       movi            %2, 0      \n"
>> > -             "       add             %0, %0, %4 \n"
>> > -             "       stex.w          %0, (%3)   \n"
>> > -             "1:                                \n"
>> > -             : "=&r" (res), "=&r" (tmp), "=&r" (contended)
>> > -             : "r"(p), "r"(ticket_next)
>> > -             : "cc");
>> > -     } while (!res);
>> > -
>> > -     if (!contended)
>> > -             smp_mb();
>> > -
>> > -     return !contended;
>> > -}
>> > -
>> > -static inline void arch_spin_unlock(arch_spinlock_t *lock)
>> > -{
>> > -     smp_mb();
>> > -     WRITE_ONCE(lock->tickets.owner, lock->tickets.owner + 1);
>> > -}
>> > -
>> > -static inline int arch_spin_value_unlocked(arch_spinlock_t lock)
>> > -{
>> > -     return lock.tickets.owner == lock.tickets.next;
>> > -}
>> > -
>> > -static inline int arch_spin_is_locked(arch_spinlock_t *lock)
>> > -{
>> > -     return !arch_spin_value_unlocked(READ_ONCE(*lock));
>> > -}
>> > -
>> > -static inline int arch_spin_is_contended(arch_spinlock_t *lock)
>> > -{
>> > -     struct __raw_tickets tickets = READ_ONCE(lock->tickets);
>> > -
>> > -     return (tickets.next - tickets.owner) > 1;
>> > -}
>> > -#define arch_spin_is_contended       arch_spin_is_contended
>> > -
>> > +#include <asm/ticket-lock.h>
>> >  #include <asm/qrwlock.h>
>> >
>> >  #endif /* __ASM_CSKY_SPINLOCK_H */
>> > diff --git a/arch/csky/include/asm/spinlock_types.h b/arch/csky/include/asm/spinlock_types.h
>> > index db87a12c3827..0bb7f6022a3b 100644
>> > --- a/arch/csky/include/asm/spinlock_types.h
>> > +++ b/arch/csky/include/asm/spinlock_types.h
>> > @@ -3,25 +3,7 @@
>> >  #ifndef __ASM_CSKY_SPINLOCK_TYPES_H
>> >  #define __ASM_CSKY_SPINLOCK_TYPES_H
>> >
>> > -#ifndef __LINUX_SPINLOCK_TYPES_RAW_H
>> > -# error "please don't include this file directly"
>> > -#endif
>> > -
>> > -#define TICKET_NEXT  16
>> > -
>> > -typedef struct {
>> > -     union {
>> > -             u32 lock;
>> > -             struct __raw_tickets {
>> > -                     /* little endian */
>> > -                     u16 owner;
>> > -                     u16 next;
>> > -             } tickets;
>> > -     };
>> > -} arch_spinlock_t;
>> > -
>> > -#define __ARCH_SPIN_LOCK_UNLOCKED    { { 0 } }
>> > -
>> > +#include <asm/ticket-lock-types.h>
>> >  #include <asm-generic/qrwlock_types.h>
>> >
>> >  #endif /* __ASM_CSKY_SPINLOCK_TYPES_H */
