Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5663EBFF9
	for <lists+linux-arch@lfdr.de>; Sat, 14 Aug 2021 04:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236562AbhHNCwd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Aug 2021 22:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236697AbhHNCwW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 Aug 2021 22:52:22 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BECC0612A6
        for <linux-arch@vger.kernel.org>; Fri, 13 Aug 2021 19:51:03 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id f11so15790271ioj.3
        for <linux-arch@vger.kernel.org>; Fri, 13 Aug 2021 19:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/k4IC91UdyV0w+9HxmCenInkbLpplso+m7Ec80qRbGQ=;
        b=axj4TwgXz1SHacnZ64jbZ7NRm6Mb05eJUgIjC69bJDnDrX7nenWeC6MkikGHRyEyuo
         ooTYbZxWak1mpYB8T9ncTXxUG4qMDZzykdOJ/6LDy9vP5UBYNiT56G0c+tMM7y9QZw6r
         1nl61oWBMS4I94aaiBYMdJBnLeoYa2j+itoMQ/r3+vd8lLNmKpJwb3+SB2Kqa3PxnMjO
         Kp02x85JAYy8dxKPoIvecgDcv16HlF9ZVWIR7GH+iXQEZz5Aogi/8LNxAhhObH1nlyxO
         7oF0zEu/1FKDXTlKfACm2nm8Q9XpBtjD4ResLLmMmtUZ1AUc6K1tdoWQkMscytn+GImE
         FqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/k4IC91UdyV0w+9HxmCenInkbLpplso+m7Ec80qRbGQ=;
        b=a+aA8+NHSaWftZTIqV+58c/wI5kb4nv4XzwvIgguDkE0KHIxXoXmGbFAws+2SpVbv/
         c5UfkLnRDxphN/1BwWF1aVIhlYXOXFLZG0zrGK4ZuS5d7m4UqPwymvtswljeyZSxridJ
         xPQA/I5yls833ZtdMdPzb/U12WP8R0b+f/G2pz72whKdhLHhrR2y0yKsVIn0n823vjcY
         FXmAzCp+tb9p3WFgrDJWhk2igs9MK958oobPuhj08SnUYMEqvtteLnSZ1EZMDJewDHLE
         LCU+Kl/BVG4zVD6C14BvVQ+mUAVKOEsmpbdorXaC1jCCmIPIPSni1ajhr6G9NYBrwtGf
         yZQQ==
X-Gm-Message-State: AOAM531Wz8pYJG3ITl1FsqfnhniMSFnxMdgsftWSvKTXoybNDEPxpTjL
        v+NITx6FVYZWHMA8FoNYC2Tx/xwl2RC5jGHvMX+lCjQXZYqzHQ==
X-Google-Smtp-Source: ABdhPJxg9aUUizud4oRiEQ1x/HkpSbFTwsh2rnBhHmxqpAqR9UnsFwcy4yVIxzMRxv1A2rm9bKXfAcAgB6/ukGLMcXw=
X-Received: by 2002:a6b:e010:: with SMTP id z16mr4366527iog.94.1628909463112;
 Fri, 13 Aug 2021 19:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-5-chenhuacai@loongson.cn> <CAK8P3a357Xgs7mdsP-NCmu5ukVqMHtV1Andte6vO1mEr2qoqbQ@mail.gmail.com>
 <CAAhV-H5byhzBLbw3ASk=-8Xvkws8SS4eS_0Q5EyhXuzUdM1=sQ@mail.gmail.com>
 <CAK8P3a2bq3p25dfhUEiTe57-i5SKwXJAEZ18=tpbXijqMrDpYQ@mail.gmail.com>
 <CAAhV-H45GFoFz1csEJigCN_QiCvq68__0BXrmDcsQFK6Nr17Aw@mail.gmail.com>
 <CAK8P3a15rj_vH2FN12+UVZ=YfPDTEJ_cN0PoNfyYFSz8KSOvzg@mail.gmail.com>
 <CAAhV-H5r7HBhepc-N_Qmr=Vdy-5nHg-0ZvFK-nVY2eFzYqpR5A@mail.gmail.com> <CAK8P3a1vMCHihjnu2wZsz0_JXhXr_pg0mN_x-b1X754BptReeA@mail.gmail.com>
In-Reply-To: <CAK8P3a1vMCHihjnu2wZsz0_JXhXr_pg0mN_x-b1X754BptReeA@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sat, 14 Aug 2021 10:50:51 +0800
Message-ID: <CAAhV-H664mY-vQubEMX0yHdwHfH9kDrp6W=zHJvTE+yi31GpyQ@mail.gmail.com>
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

On Fri, Aug 13, 2021 at 5:08 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Aug 13, 2021 at 10:14 AM Huacai Chen <chenhuacai@gmail.com> wrote:
> > On Fri, Aug 13, 2021 at 3:05 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > I still don't see what is special about 40 and 48. From what I can tell,
> > > you have two constraints: the maximum address space size for
> > > the kernel configuration based on the page size and number of
> > > page table levels, and the capabilities of the CPU as described
> > > in the CPUCFG1 register.
> > >
> > > What is the point of introducing an arbitrary third compile-time
> > > limit here rather than calculating it from the page page size?
> >
> > So your problem is why we should provide two configurations VA40 and
> > VA48? This is derived from MIPS of course, but I found that RISC-V and
> > ARM64 also provide VA BITS configuration.
>
> The difference is that on arm64 and riscv, the CONFIG_VA_BITS
> configuration is directly derived from the page table layout.
>
> E.g. when using 16K pages on arm64, you have the choice between
> 47 bits and 36 bits, while your method would apparently force going
> to 40 bits and either waste most of the theoretically available address
> space, or require three-level tables even if you only need 36 bits.
>
After some thinking, I found that ARM64 is "define kernel VABITS
depends on page table layout", and MIPS (also LoongArch) is "define
page table layout depends on kernel VABITS". So you can see:

#ifdef CONFIG_VA_BITS_40
#ifdef CONFIG_PAGE_SIZE_4KB
#define PGD_ORDER               1
#define PUD_ORDER               aieeee_attempt_to_allocate_pud
#define PMD_ORDER               0
#define PTE_ORDER               0
#endif
#ifdef CONFIG_PAGE_SIZE_16KB
#define PGD_ORDER               0
#define PUD_ORDER               aieeee_attempt_to_allocate_pud
#define PMD_ORDER               0
#define PTE_ORDER               0
#endif
#ifdef CONFIG_PAGE_SIZE_64KB
#define PGD_ORDER               0
#define PUD_ORDER               aieeee_attempt_to_allocate_pud
#define PMD_ORDER               aieeee_attempt_to_allocate_pmd
#define PTE_ORDER               0
#endif
#endif

#ifdef CONFIG_VA_BITS_48
#ifdef CONFIG_PAGE_SIZE_4KB
#define PGD_ORDER               0
#define PUD_ORDER               0
#define PMD_ORDER               0
#define PTE_ORDER               0
#endif
#ifdef CONFIG_PAGE_SIZE_16KB
#define PGD_ORDER               1
#define PUD_ORDER               aieeee_attempt_to_allocate_pud
#define PMD_ORDER               0
#define PTE_ORDER               0
#endif
#ifdef CONFIG_PAGE_SIZE_64KB
#define PGD_ORDER               0
#define PUD_ORDER               aieeee_attempt_to_allocate_pud
#define PMD_ORDER               0
#define PTE_ORDER               0
#endif
#endif

Since 40 and 48 is the most popular VABITS of LoongArch hardware, and
LoongArch has a software-managed TLB, it seems "define page table
layout depends on kernel VABITS" is more natural for LoongArch.

Huacai
>         Arnd
