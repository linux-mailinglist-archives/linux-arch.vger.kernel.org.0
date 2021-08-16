Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6292E3ECD7B
	for <lists+linux-arch@lfdr.de>; Mon, 16 Aug 2021 06:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbhHPELZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Aug 2021 00:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhHPELW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Aug 2021 00:11:22 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBC1C061764
        for <linux-arch@vger.kernel.org>; Sun, 15 Aug 2021 21:10:51 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id h1so21107123iol.9
        for <linux-arch@vger.kernel.org>; Sun, 15 Aug 2021 21:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/PM7/XOjE1sP5b2LqrzrNYIA2jOsmBuoK13W4o0NU4w=;
        b=spOGDyswKeQlZQgXKiE1I2Jnw5KPFOhWTsx//2Un2J4TOh2McKdpn3ZWPnWPpxRoUT
         od/jurrzbHlrMjG8/rdeyOcCqySrMqi2ikPgtgfvtqqHGHs/IwJjdfG7LPb7tRqlMqj2
         tfiL3+qUC99RgQyYZzKgqlgMppuKQCwZ12EyQBTyPdGX4+/IS3t/M7KtpGh8HzdLxGxy
         TrOPc0w9wYhDd2ggYQ3BK2R21AaYUoHwSFrleNPhsz8waNAbNUHVprsSfxsR7Sjpdscw
         VoMTeuaiD9LnlED2zerq8iOdN15IssB+5lQRO0l9rnxBHRZHEG+PoayS1aw41CrQUaLT
         j2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/PM7/XOjE1sP5b2LqrzrNYIA2jOsmBuoK13W4o0NU4w=;
        b=RI0BvHFGawKby/r2U/6EWNgpCgMrfKvzPKwpz8VjD3NppT94Ty7Ao48UcRKg2RbzxZ
         L0DmpdqXgS7zC5VM+Sl5yGplgUQWpnoT1BzDVwPCpnPIxUebjpVpfUfc5w43bwo3LwFX
         fnSNsCQdCgNnqNv85lcU2HaMfXfytlALAWeKUYpX9sZwtkiFUOpbmzvuBqo6KscgC8gv
         6ZaifwJexdg6SC0hMBxTz+qWRaSjXwH8yV3vdaqrOyBKn7WlDxj0imhXs0dtgktSCOjV
         J54AQezc0YPmbpEXT735y3km53p6Jlowm4Deinwlfo4XbZJq08IPhVu3jCN7uea1ekaX
         qOSg==
X-Gm-Message-State: AOAM530o2sTSc8ojXGL6nIiOyRSVw7niD2clNJaNJl/tVBtZdJfxl1DZ
        pu5HGqou/XU5hGn+Hdgavr/lhFjAgDadxycXPWrBra9VdPU=
X-Google-Smtp-Source: ABdhPJxptHFwgvjga5tOnDhSX/Hflo3jzM7jniZ0C9ESRzFSVMC4kVY1cMLWJOgTkbF9iPqzoieyoN/woQZAn83tMG8=
X-Received: by 2002:a02:2348:: with SMTP id u69mr13537394jau.141.1629087050623;
 Sun, 15 Aug 2021 21:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-5-chenhuacai@loongson.cn> <CAK8P3a357Xgs7mdsP-NCmu5ukVqMHtV1Andte6vO1mEr2qoqbQ@mail.gmail.com>
 <CAAhV-H5byhzBLbw3ASk=-8Xvkws8SS4eS_0Q5EyhXuzUdM1=sQ@mail.gmail.com>
 <CAK8P3a2bq3p25dfhUEiTe57-i5SKwXJAEZ18=tpbXijqMrDpYQ@mail.gmail.com>
 <CAAhV-H45GFoFz1csEJigCN_QiCvq68__0BXrmDcsQFK6Nr17Aw@mail.gmail.com>
 <CAK8P3a15rj_vH2FN12+UVZ=YfPDTEJ_cN0PoNfyYFSz8KSOvzg@mail.gmail.com>
 <CAAhV-H5r7HBhepc-N_Qmr=Vdy-5nHg-0ZvFK-nVY2eFzYqpR5A@mail.gmail.com>
 <CAK8P3a1vMCHihjnu2wZsz0_JXhXr_pg0mN_x-b1X754BptReeA@mail.gmail.com>
 <CAAhV-H664mY-vQubEMX0yHdwHfH9kDrp6W=zHJvTE+yi31GpyQ@mail.gmail.com> <CAK8P3a0KLjGrfRnKQxCvULdL3PpMWCyjpx-tzcW1W5qqfiMbMw@mail.gmail.com>
In-Reply-To: <CAK8P3a0KLjGrfRnKQxCvULdL3PpMWCyjpx-tzcW1W5qqfiMbMw@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Mon, 16 Aug 2021 12:10:38 +0800
Message-ID: <CAAhV-H6rPc1qyoE6FRpUQs1GS_K+xASHu_q5o-yT13eu7DKzVQ@mail.gmail.com>
Subject: Re: [PATCH 04/19] LoongArch: Add common headers
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Arnd,

On Sun, Aug 15, 2021 at 4:56 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sat, Aug 14, 2021 at 4:50 AM Huacai Chen <chenhuacai@gmail.com> wrote:
> > On Fri, Aug 13, 2021 at 5:08 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > After some thinking, I found that ARM64 is "define kernel VABITS
> > depends on page table layout", and MIPS (also LoongArch) is "define
> > page table layout depends on kernel VABITS". So you can see:
> >
> > #ifdef CONFIG_VA_BITS_40
> > #ifdef CONFIG_PAGE_SIZE_4KB
> > #define PGD_ORDER               1
> > #define PUD_ORDER               aieeee_attempt_to_allocate_pud
> > #define PMD_ORDER               0
> > #define PTE_ORDER               0
> > #endif
>
> I have no idea what aieeee_attempt_to_allocate_pud means, but
> this part seems fine.
It just used to avoid kernel use PUD_ORDER.

>
> > #ifdef CONFIG_PAGE_SIZE_16KB
> > #define PGD_ORDER               0
> > #define PUD_ORDER               aieeee_attempt_to_allocate_pud
> > #define PMD_ORDER               0
> > #define PTE_ORDER               0
> > #endif
>
> This doesn't seem to make sense at all however: it looks like you have
> three levels of 16KB page tables, so you get 47 bits, not 40. This
> means you waste 99% of the available address space when you
> run this kernel on a CPU that is able to access the entire space.
Emm, this "waste" seems harmless. :)

>
> > #ifdef CONFIG_PAGE_SIZE_64KB
> > #define PGD_ORDER               0
> > #define PUD_ORDER               aieeee_attempt_to_allocate_pud
> > #define PMD_ORDER               aieeee_attempt_to_allocate_pmd
> > #define PTE_ORDER               0
> > #endif
> > #endif
>
> Similarly, here it seems you get 42 bits.
>
> > #ifdef CONFIG_VA_BITS_48
> > #ifdef CONFIG_PAGE_SIZE_4KB
> > #define PGD_ORDER               0
> > #define PUD_ORDER               0
> > #define PMD_ORDER               0
> > #define PTE_ORDER               0
> > #endif
> > #ifdef CONFIG_PAGE_SIZE_16KB
> > #define PGD_ORDER               1
> > #define PUD_ORDER               aieeee_attempt_to_allocate_pud
> > #define PMD_ORDER               0
> > #define PTE_ORDER               0
> > #endif
>
> This again looks reasonable, though I don't see why you care about
> having the extra pgd_order here, instead of just going with
> 47 bits.
>
> > #ifdef CONFIG_PAGE_SIZE_64KB
> > #define PGD_ORDER               0
> > #define PUD_ORDER               aieeee_attempt_to_allocate_pud
> > #define PMD_ORDER               0
> > #define PTE_ORDER               0
> > #endif
> > #endif
>
> I suppose you can't ever have more than 48 bits? Otherwise this option
> would give you 55 bits of address space.
We will have 56bits CPU in future, and then we will add a VA_BITS_56 config.

>
> > Since 40 and 48 is the most popular VABITS of LoongArch hardware, and
> > LoongArch has a software-managed TLB, it seems "define page table
> > layout depends on kernel VABITS" is more natural for LoongArch.
>
> How common are Loongarch64 CPUs that limit the virtual address space
> to 40 bits instead of the full 48 bits? What is the purpose of limiting the
> CPU this way?
We have some low-end 64bits CPU whose VA is 40bits, this can reduce
the internal address bus width, so save some hardware cost and
complexity.

Huacai
>
>        Arnd
