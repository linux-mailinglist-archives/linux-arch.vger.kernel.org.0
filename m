Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF8AE41FB33
	for <lists+linux-arch@lfdr.de>; Sat,  2 Oct 2021 13:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbhJBLt4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 2 Oct 2021 07:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbhJBLt4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 2 Oct 2021 07:49:56 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC94CC061570;
        Sat,  2 Oct 2021 04:48:10 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id 66so14272784vsd.11;
        Sat, 02 Oct 2021 04:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bSQRibgDnpTqOXZp7vnqZJ1QVyQSI1d0M4GZTbpWPbU=;
        b=W/E1MGjEbSDDZHveDGcgEYVt58pIGf0/RE9j+KpAk4NDuaoWQ9IS7HgGovoyUX8910
         GTdOu0RmK04aLK2JRZpzNgn39vidIk9Kr9Qby6tDKfVo34X52nKRgu3A0JRXhBxYqDis
         yNKvVJKvhe0o4YOzoZrGR5bDqc6S1kj3Uw5tldfK+0hzMW8eF9xA0Zm5oZmJM1iaxXA3
         RULDAeUuP5BDYCTC4XfS9v3R2qw69RMlW9QvaEmKG1oZYB8P0LQu1pPTueghbeNhYU4l
         tVCw/DJFlGrhbkLJibBLm78UlpaaL/AEmGVkcsIVLjY0EHbfqE+2ViiyNFvLFPKPvCl9
         LC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bSQRibgDnpTqOXZp7vnqZJ1QVyQSI1d0M4GZTbpWPbU=;
        b=zrYHuaXoPoVOG77PkzPSU5xIDbGB45lwN003uTa9k+W2mh27D75ndS+0Laqs6Gtba+
         j8WHY3eRU6IFXoto2TCS8vqE7txklMboZGdOyJqQgYHw45UpyWwvR3+g8Z28ghPgDs7M
         kId6XXNYLkr8E7OxK4UanZ3lT0RqpYEtAkmdFDZxEqA0v7KuINR5lbm3C83RDKituwyw
         PsOQn4RaNuFrSZPkp/PKS+b7BWtICb7v/HrF7rkNs5LC0SdPoFsB+SpoKTBLRGgTMH7A
         xXxmEAiIOZvHxxBkmQmWSPWJFikf69fof7992T/mDvw6TamJoFCnOFu6/AoDi6Daip62
         MctQ==
X-Gm-Message-State: AOAM530I/0lSTmp42GgRuKfl5sKPaoueGYia0e7MalF6F5GvW7ysORaq
        QqLYXnN8VBaoE/z/PC89dipFLnMOPnGyk/2a5Wo=
X-Google-Smtp-Source: ABdhPJwRsEo96AY3MSUxRf4j9Wd8RJCHH3n6Q8CjvmcG7cUdh2FNyaWj2sAHEU0GGWIcRqdfBaRR717SOm4gEBp1LtQ=
X-Received: by 2002:a67:cb96:: with SMTP id h22mr7891227vsl.3.1633175289819;
 Sat, 02 Oct 2021 04:48:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210927064300.624279-1-chenhuacai@loongson.cn>
 <20210927064300.624279-8-chenhuacai@loongson.cn> <YVbogd2gihouyWJd@hirez.programming.kicks-ass.net>
In-Reply-To: <YVbogd2gihouyWJd@hirez.programming.kicks-ass.net>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sat, 2 Oct 2021 19:47:58 +0800
Message-ID: <CAAhV-H7MNU7oYMH44hrjFGKQvmDrgbBKAy2e8dfrMWq=bgxBQA@mail.gmail.com>
Subject: Re: [PATCH V4 07/22] LoongArch: Add atomic/locking headers
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Peter,

On Fri, Oct 1, 2021 at 6:54 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Sep 27, 2021 at 02:42:44PM +0800, Huacai Chen wrote:
> > diff --git a/arch/loongarch/include/asm/bitops.h b/arch/loongarch/include/asm/bitops.h
> > new file mode 100644
> > index 000000000000..8b05d9683571
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/bitops.h
> > @@ -0,0 +1,220 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> > + */
> > +#ifndef _ASM_BITOPS_H
> > +#define _ASM_BITOPS_H
> > +
> > +#ifndef _LINUX_BITOPS_H
> > +#error only <linux/bitops.h> can be included directly
> > +#endif
> > +
> > +#include <linux/compiler.h>
> > +#include <linux/types.h>
> > +#include <asm/barrier.h>
> > +#include <asm/byteorder.h>
> > +#include <asm/compiler.h>
> > +#include <asm/cpu-features.h>
> > +
> > +#if _LOONGARCH_SZLONG == 32
> > +#define __LL         "ll.w   "
> > +#define __SC         "sc.w   "
> > +#define __AMADD              "amadd.w        "
> > +#define __AMAND_SYNC "amand_db.w     "
> > +#define __AMOR_SYNC  "amor_db.w      "
> > +#define __AMXOR_SYNC "amxor_db.w     "
> > +#elif _LOONGARCH_SZLONG == 64
> > +#define __LL         "ll.d   "
> > +#define __SC         "sc.d   "
> > +#define __AMADD              "amadd.d        "
> > +#define __AMAND_SYNC "amand_db.d     "
> > +#define __AMOR_SYNC  "amor_db.d      "
> > +#define __AMXOR_SYNC "amxor_db.d     "
> > +#endif
> > +
> > +/*
> > + * set_bit - Atomically set a bit in memory
> > + * @nr: the bit to set
> > + * @addr: the address to start counting from
> > + */
> > +static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
> > +{
> > +     int bit = nr % BITS_PER_LONG;
> > +     volatile unsigned long *m = &addr[BIT_WORD(nr)];
> > +
> > +     __asm__ __volatile__(
> > +     "   " __AMOR_SYNC "$zero, %1, %0        \n"
> > +     : "+ZB" (*m)
> > +     : "r" (1UL << bit)
> > +     : "memory");
> > +}
> > +
> > +/*
> > + * clear_bit - Clears a bit in memory
> > + * @nr: Bit to clear
> > + * @addr: Address to start counting from
> > + */
> > +static inline void clear_bit(unsigned long nr, volatile unsigned long *addr)
> > +{
> > +     int bit = nr % BITS_PER_LONG;
> > +     volatile unsigned long *m = &addr[BIT_WORD(nr)];
> > +
> > +     __asm__ __volatile__(
> > +     "   " __AMAND_SYNC "$zero, %1, %0       \n"
> > +     : "+ZB" (*m)
> > +     : "r" (~(1UL << bit))
> > +     : "memory");
> > +}
> > +
> > +/*
> > + * clear_bit_unlock - Clears a bit in memory
> > + * @nr: Bit to clear
> > + * @addr: Address to start counting from
> > + */
> > +static inline void clear_bit_unlock(unsigned long nr, volatile unsigned long *addr)
> > +{
> > +     clear_bit(nr, addr);
> > +}
> > +
> > +/*
> > + * change_bit - Toggle a bit in memory
> > + * @nr: Bit to change
> > + * @addr: Address to start counting from
> > + */
> > +static inline void change_bit(unsigned long nr, volatile unsigned long *addr)
> > +{
> > +     int bit = nr % BITS_PER_LONG;
> > +     volatile unsigned long *m = &addr[BIT_WORD(nr)];
> > +
> > +     __asm__ __volatile__(
> > +     "   " __AMXOR_SYNC "$zero, %1, %0       \n"
> > +     : "+ZB" (*m)
> > +     : "r" (1UL << bit)
> > +     : "memory");
> > +}
> > +
> > +/*
> > + * test_and_set_bit - Set a bit and return its old value
> > + * @nr: Bit to set
> > + * @addr: Address to count from
> > + */
> > +static inline int test_and_set_bit(unsigned long nr,
> > +     volatile unsigned long *addr)
> > +{
> > +     int bit = nr % BITS_PER_LONG;
> > +     unsigned long res;
> > +     volatile unsigned long *m = &addr[BIT_WORD(nr)];
> > +
> > +     __asm__ __volatile__(
> > +     "   " __AMOR_SYNC "%1, %2, %0       \n"
> > +     : "+ZB" (*m), "=&r" (res)
> > +     : "r" (1UL << bit)
> > +     : "memory");
> > +
> > +     res = res & (1UL << bit);
> > +
> > +     return res != 0;
> > +}
> > +
> > +/*
> > + * test_and_set_bit_lock - Set a bit and return its old value
> > + * @nr: Bit to set
> > + * @addr: Address to count from
> > + */
> > +static inline int test_and_set_bit_lock(unsigned long nr,
> > +     volatile unsigned long *addr)
> > +{
> > +     int bit = nr % BITS_PER_LONG;
> > +     unsigned long res;
> > +     volatile unsigned long *m = &addr[BIT_WORD(nr)];
> > +
> > +     __asm__ __volatile__(
> > +     "   " __AMOR_SYNC "%1, %2, %0       \n"
> > +     : "+ZB" (*m), "=&r" (res)
> > +     : "r" (1UL << bit)
> > +     : "memory");
> > +
> > +     res = res & (1UL << bit);
> > +
> > +     return res != 0;
> > +}
> > +/*
> > + * test_and_clear_bit - Clear a bit and return its old value
> > + * @nr: Bit to clear
> > + * @addr: Address to count from
> > + */
> > +static inline int test_and_clear_bit(unsigned long nr,
> > +     volatile unsigned long *addr)
> > +{
> > +     int bit = nr % BITS_PER_LONG;
> > +     unsigned long res, temp;
> > +     volatile unsigned long *m = &addr[BIT_WORD(nr)];
> > +
> > +     __asm__ __volatile__(
> > +     "   " __AMAND_SYNC "%1, %2, %0      \n"
> > +     : "+ZB" (*m), "=&r" (temp)
> > +     : "r" (~(1UL << bit))
> > +     : "memory");
> > +
> > +     res = temp & (1UL << bit);
> > +
> > +     return res != 0;
> > +}
> > +
> > +/*
> > + * test_and_change_bit - Change a bit and return its old value
> > + * @nr: Bit to change
> > + * @addr: Address to count from
> > + */
> > +static inline int test_and_change_bit(unsigned long nr,
> > +     volatile unsigned long *addr)
> > +{
> > +     int bit = nr % BITS_PER_LONG;
> > +     unsigned long res;
> > +     volatile unsigned long *m = &addr[BIT_WORD(nr)];
> > +
> > +     __asm__ __volatile__(
> > +     "   " __AMXOR_SYNC "%1, %2, %0      \n"
> > +     : "+ZB" (*m), "=&r" (res)
> > +     : "r" (1UL << bit)
> > +     : "memory");
> > +
> > +     res = res & (1UL << bit);
> > +
> > +     return res != 0;
> > +}
>
> Why is asm-generic/bitops/atomic.h not working for you?
It seems that __clear_bit_unlock() needs an additional mb() after the
generic version, all other functions are the same as the generic
version.

Huacai
>
