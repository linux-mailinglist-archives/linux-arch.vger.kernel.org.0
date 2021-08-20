Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC15D3F257B
	for <lists+linux-arch@lfdr.de>; Fri, 20 Aug 2021 06:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhHTEBQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Aug 2021 00:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhHTEBQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Aug 2021 00:01:16 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769D3C061575
        for <linux-arch@vger.kernel.org>; Thu, 19 Aug 2021 21:00:39 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id i13so8173833ilm.11
        for <linux-arch@vger.kernel.org>; Thu, 19 Aug 2021 21:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eHrGFALJnq+wOGk10qDBSQRIdGxOwlYnu+mKyyL4VA0=;
        b=Y9NoF55O5VxXHpOlOOttLs9yoWhh6saSzdcCoSqLaskO0r3u7iLK+mkQCU/iqho2Y0
         ciI68CHPMnRAufEHf1gB48tySMjxeCTwg064HcQ6Dqew0khbZeATiCtFt0n3zGEYTAeV
         t5f1fRpDi7Qosh5TrvcPvyklqFXEraz2CN7U3iL6qU1U5WP5LFG0zyQNt+TfD/O7naVF
         ok5pppTBbrXCfHRZyNYj8Xc2dEsZqi5fmLRauiJfwNtNFG7L1iX8Me9s2T/5PceUjyl5
         pPupMHOo+E8nT6zeb64eF+ioMRJ26P+3sJtU+4XGWDB60tBLvtPo5JbZswYBhRgjvi5A
         aAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eHrGFALJnq+wOGk10qDBSQRIdGxOwlYnu+mKyyL4VA0=;
        b=ZNDGW1CVgfEscBHrHSMcz+mQ8yM2w6gZd3BgTUWuazaadV4fK44bqcGu+vXSblQJjx
         HnoAWl2lnExnLfoyeIEGWkCF2BkDzK3ERB/KosXyQSBDgCkSdQDFR5qMmqrlLJNodPjD
         toexC0TA8ezOhmY2y7Xyg7WYWOTHj2SJrdtIz0SNEbpQSRoUdKegVlsJmGDmOqgR1dWP
         SdbEi3VHiRPfMtk0Zo9KosmH+wMYdCo8LwpV4oF8DR0RQa84QGN/tvtWLr1N27/BGs/o
         iWo8XSvW9kTyMtFT2ESzzJqLGxFI9F72g6dClU+jPR8jircOUpqMdIobRjr2DBCG6xJ2
         slxA==
X-Gm-Message-State: AOAM533gaJiz93FSHtauizVBg9VG6ihI/u3xMjL3mxyHiJACjQ+GzF8Q
        lBegLdY//s8BsfdlGWApZpFu55bip5qSxdVcoAU=
X-Google-Smtp-Source: ABdhPJx5FtrAUvr1LWlxwsJrapIXHHB0gjN6nREC2fsevOXiAbVDbxlCMeOouJLZ59GhMkrY1qka2QgqQ4BAdyHZCJQ=
X-Received: by 2002:a92:cc0d:: with SMTP id s13mr11538130ilp.95.1629432038966;
 Thu, 19 Aug 2021 21:00:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-5-chenhuacai@loongson.cn> <CAK8P3a357Xgs7mdsP-NCmu5ukVqMHtV1Andte6vO1mEr2qoqbQ@mail.gmail.com>
 <CAAhV-H5byhzBLbw3ASk=-8Xvkws8SS4eS_0Q5EyhXuzUdM1=sQ@mail.gmail.com>
 <CAK8P3a2bq3p25dfhUEiTe57-i5SKwXJAEZ18=tpbXijqMrDpYQ@mail.gmail.com>
 <CAAhV-H45GFoFz1csEJigCN_QiCvq68__0BXrmDcsQFK6Nr17Aw@mail.gmail.com>
 <CAK8P3a15rj_vH2FN12+UVZ=YfPDTEJ_cN0PoNfyYFSz8KSOvzg@mail.gmail.com>
 <CAAhV-H5r7HBhepc-N_Qmr=Vdy-5nHg-0ZvFK-nVY2eFzYqpR5A@mail.gmail.com>
 <CAK8P3a1vMCHihjnu2wZsz0_JXhXr_pg0mN_x-b1X754BptReeA@mail.gmail.com>
 <CAAhV-H664mY-vQubEMX0yHdwHfH9kDrp6W=zHJvTE+yi31GpyQ@mail.gmail.com>
 <CAK8P3a0KLjGrfRnKQxCvULdL3PpMWCyjpx-tzcW1W5qqfiMbMw@mail.gmail.com>
 <CAAhV-H6rPc1qyoE6FRpUQs1GS_K+xASHu_q5o-yT13eu7DKzVQ@mail.gmail.com> <CAK8P3a1LMY+KschuMfLoXB1qXMcTLVWeP+s41sCfQMFdRujQjQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1LMY+KschuMfLoXB1qXMcTLVWeP+s41sCfQMFdRujQjQ@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Fri, 20 Aug 2021 12:00:27 +0800
Message-ID: <CAAhV-H64k25rVqGrYJ4wZxQEQ0jp=TRcUZA+Co8JoL1epBBwVg@mail.gmail.com>
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

On Wed, Aug 18, 2021 at 5:38 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Aug 16, 2021 at 6:10 AM Huacai Chen <chenhuacai@gmail.com> wrote:
> > On Sun, Aug 15, 2021 at 4:56 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> > > > #ifdef CONFIG_PAGE_SIZE_16KB
> > > > #define PGD_ORDER               0
> > > > #define PUD_ORDER               aieeee_attempt_to_allocate_pud
> > > > #define PMD_ORDER               0
> > > > #define PTE_ORDER               0
> > > > #endif
> > >
> > > This doesn't seem to make sense at all however: it looks like you have
> > > three levels of 16KB page tables, so you get 47 bits, not 40. This
> > > means you waste 99% of the available address space when you
> > > run this kernel on a CPU that is able to access the entire space.
> > Emm, this "waste" seems harmless. :)
>
> It's not actively harmful, just silly to offer the 4/11/11/14 option that is
> never the ideal choice given the alternatives of
>
> * 11/11/11/14: normal 16K 3level, but up to 47 bits if supported by CPU
> * 11/11/14: 16K 2level, just dropping the top level for 36-bit TASK_SIZE
> * 13/13/14: 16K 2level, fewer levels with larger PGD/PMD
> * 10/9/9/12: normal 4K 3level, same # of levels, better memory usage
>
> > > > #ifdef CONFIG_PAGE_SIZE_64KB
> > > > #define PGD_ORDER               0
> > > > #define PUD_ORDER               aieeee_attempt_to_allocate_pud
> > > > #define PMD_ORDER               0
> > > > #define PTE_ORDER               0
> > > > #endif
> > > > #endif
> > >
> > > I suppose you can't ever have more than 48 bits? Otherwise this option
> > > would give you 55 bits of address space.
> >
> > We will have 56bits CPU in future, and then we will add a VA_BITS_56 config.
>
> Right, so same as above: why not make this VA_BITS_55 already and fall
> back to 40 or 48 bits on current CPUs
>
> > > > Since 40 and 48 is the most popular VABITS of LoongArch hardware, and
> > > > LoongArch has a software-managed TLB, it seems "define page table
> > > > layout depends on kernel VABITS" is more natural for LoongArch.
> > >
> > > How common are Loongarch64 CPUs that limit the virtual address space
> > > to 40 bits instead of the full 48 bits? What is the purpose of limiting the
> > > CPU this way?
> > We have some low-end 64bits CPU whose VA is 40bits, this can reduce
> > the internal address bus width, so save some hardware cost and
> > complexity.
>
> Ok. So I could understand making CONFIG_VA_BITS_40 hardcode the
> VA size at compile time, but if you always support the fallback to any
> size at runtime, just allow using the high addresses.
Define a larger VA_BITS and fallback to a smaller one (TASKSIZE64) if
hardware doesn't support it? If so, there will be a problem: we should
define a 4-level page table, but the fallback only needs a 2-level or
3-level page table.

Huacai
>
>        Arnd
