Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8083F397D
	for <lists+linux-arch@lfdr.de>; Sat, 21 Aug 2021 10:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbhHUIRy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 21 Aug 2021 04:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbhHUIRs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 21 Aug 2021 04:17:48 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C641C061575
        for <linux-arch@vger.kernel.org>; Sat, 21 Aug 2021 01:17:09 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id i7so15295614iow.1
        for <linux-arch@vger.kernel.org>; Sat, 21 Aug 2021 01:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Cs7sjRSMZhIH3zoMGmleQcDUMRVb41/98HuNbOapDA=;
        b=gXHdJwj/2CEW4yAdYMroDCsdSXlE/A0qgoBOB7UQgpXFBoIwr0VEfjLZQtXFJdlh1o
         k1u9YeJugeKce3G485+mtom5IHUpWPqOFOBXXBr97EU7j73F7wNIekle3KHJQ5X+ze8E
         S2xMaGvDtdEI5Z3Gy5dLBUchI71XAbYENjBj2zAZqFU7VnPeHpPAqcJWCCWPv1PjnnTj
         llwZlSU033wvkd9Y/IKbLyu34fGoLj6oAELUIoR5bFJNSNUUtmVf6w4oQHzUwXUsUeSg
         gw8cPzPzhQ0Nee1kWDO+c8cOMCVFa2sipk61mwr0+O0QXACzVHMz8axoEzms7M7X4mFq
         wP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Cs7sjRSMZhIH3zoMGmleQcDUMRVb41/98HuNbOapDA=;
        b=srfiH5bRCibh97phfKlJAhcb1LsIg+z6e7xaRkjO2Y7lmg+yFmPh8BNXQE//c4p1GW
         Y2uLperpIZzE8xlPRThpr/XSi+Ajnv3CS3LNjQUCLX5Z+3aM4xM6LLTtdsgQk7j4GaWi
         1gKwwmkYu2hSOkhojOLacXpXK4CKlLU+ETFh5pStrJj9usPthHHG8OqaxqU+LfOUlra3
         Ktwkeu9hHATN6ldLYL3+Y6GZssySQRviDTPqHnMDPIku36Mpn40y8IsWTVikhbWB6yz+
         lgtZx/Xg4LMNs6xSdIOTCtV+d/0JlUpUqbLz/20iKwSMpn0nyZNIDom6OwhbsPph/Tph
         0LHg==
X-Gm-Message-State: AOAM5300o4QRdrEZiDKzoZwosUGtijqnGo2VjwUcqZYJGyuGLdj8BVPo
        3DRxJ6/2Q6S/zSKN1M5MxvsBNGVP9frrAD0t5TQ=
X-Google-Smtp-Source: ABdhPJxXgnjCoIW95PhkxVQnAtbdbp7DZne7KQuXCEI9RC7iWhQnlH1SFW7NpKWnOlyszO1U5Lt6c9MaQFif460En6Y=
X-Received: by 2002:a5d:97d0:: with SMTP id k16mr19504802ios.38.1629533828547;
 Sat, 21 Aug 2021 01:17:08 -0700 (PDT)
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
 <CAAhV-H6rPc1qyoE6FRpUQs1GS_K+xASHu_q5o-yT13eu7DKzVQ@mail.gmail.com>
 <CAK8P3a1LMY+KschuMfLoXB1qXMcTLVWeP+s41sCfQMFdRujQjQ@mail.gmail.com>
 <CAAhV-H64k25rVqGrYJ4wZxQEQ0jp=TRcUZA+Co8JoL1epBBwVg@mail.gmail.com> <CAK8P3a0HZGv-uL=QOGkVxsRUEre49j+wZ1L4TtF0MJx-4qKBaQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0HZGv-uL=QOGkVxsRUEre49j+wZ1L4TtF0MJx-4qKBaQ@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sat, 21 Aug 2021 16:16:56 +0800
Message-ID: <CAAhV-H5wS6TeioW3wKt0ndpxtfceZrkM_L7mH+3U4Uya8CGSxg@mail.gmail.com>
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

On Fri, Aug 20, 2021 at 3:55 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Aug 20, 2021 at 6:00 AM Huacai Chen <chenhuacai@gmail.com> wrote:
> > On Wed, Aug 18, 2021 at 5:38 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > How common are Loongarch64 CPUs that limit the virtual address space
> > > > > to 40 bits instead of the full 48 bits? What is the purpose of limiting the
> > > > > CPU this way?
> > > > We have some low-end 64bits CPU whose VA is 40bits, this can reduce
> > > > the internal address bus width, so save some hardware cost and
> > > > complexity.
> > >
> > > Ok. So I could understand making CONFIG_VA_BITS_40 hardcode the
> > > VA size at compile time, but if you always support the fallback to any
> > > size at runtime, just allow using the high addresses.
> > Define a larger VA_BITS and fallback to a smaller one (TASKSIZE64) if
> > hardware doesn't support it? If so, there will be a problem: we should
> > define a 4-level page table, but the fallback only needs a 2-level or
> > 3-level page table.
>
> The number of levels is usually hardcoded based on the configuration,
> though I think at least x86 and s390 have code to do this dynamically,
> either depending on the CPU capability, or the largest address used
> in a task.
>
> The easiest example to replicate would be arch/arm64, which lets you
> pick the page size first, and then offers different VA_BITS options that
> depend on this page size.
>
> Another method is to have a single 'choice' statement in Kconfig that
> simply enumerates all the sensible options, such as
>
> 4K-3level (39 bits)
> 4K-4level (48 bits)
> 4K-5level (56 bits)
> 16K-2level (36 bits)
> 16K-3level (47 bits)
> 64K-2level (42 bits)
> 64K-3level (55 bits)
>
> You might prefer to offer the order-1 PGD versions of these to get
> to 40/48/56 bits instead of 39/47/55, or just offer both alternatives.
Use combination option is a good idea, thanks.

Huacai
>
>        Arnd
