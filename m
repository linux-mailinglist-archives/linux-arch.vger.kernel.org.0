Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAA43D8B96
	for <lists+linux-arch@lfdr.de>; Wed, 28 Jul 2021 12:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbhG1KRD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jul 2021 06:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbhG1KRC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jul 2021 06:17:02 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16DCC061757
        for <linux-arch@vger.kernel.org>; Wed, 28 Jul 2021 03:17:00 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id l126so2316671ioa.12
        for <linux-arch@vger.kernel.org>; Wed, 28 Jul 2021 03:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z6hRWpZ78wbXvPLe7seihYElF19Rbq1YOoOpz7HjqhU=;
        b=bwLuB2V5H1LuGQi/fT1RngnqmblipQg3gpoWwLf0VubE1/ScEa9fbgNLOzjz2VnPyq
         Pf5ArkLrbsplq2COWwMut53IWj0Xu4Ro5SgkP0LGOhrr8Rd+nm3aa/g28af9vvZGnIMZ
         2o+C53/P73Q/gMVM8uNuMbk6yiCc+gU8/+JiQxVnSuHq4wfQ3XRGDUhSRY77WHjximG5
         bmqtYOBrxbLV50KM9is80HFcQptaAb/BUus7SBv3db8P/8T51BvPsTdoXzMRS59hHn8z
         ZbksLnII0sSQk6q0yGsRENqFaS/vUj/XGBSy56/9LKW7AnZgGfNd7+M10MSzcPlRBqEE
         P4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z6hRWpZ78wbXvPLe7seihYElF19Rbq1YOoOpz7HjqhU=;
        b=G0zGx2hBtC4YGEZ/ISam+IWRvtI47+TbQ9RcyldZ/Q+ZBUWGUH1C86rF4NV42lg6m/
         4+b4ETkngAZogxrzz259An7nzJoviStQ5uii90ifHmINMUCjFmmyGZ4T89b2hFvppj1i
         CnBAMJbTZ7cJ9Ra2NEL4tqq4hqTEyv2uKKd7eNHLdjHXGLQBZCigkuvpmX7sfEIcR9B+
         x8bobU/nfPPytxuQRxBj0P1cqK9F9DlbT/oEtcpWk+h68tMloXGF8JcppXNDERiQZbPU
         9C4Pzk1X3IQdLk99Tvoy35IWFcNxIV1U4RWlDnzZu5C3mfFg4NRanDtF0wFRcjS9i+WI
         UXEw==
X-Gm-Message-State: AOAM531d1Dm9+tFW03DHtFGMlT0fSXDEFOAQvx6sOjyTaFRflSP4KgHT
        ZOiafSfdps5JOucGacTYlRJ3UK01bEoiHCTCVwU=
X-Google-Smtp-Source: ABdhPJwOrQyY+ezeMbXDRhxwhzXFsEOngZuqVZL3A8UQVp+ThE7dTANPk+fYKiPDweGslkBoeCF0cxz22KSAd5EpX4Y=
X-Received: by 2002:a6b:510c:: with SMTP id f12mr22500609iob.59.1627467420438;
 Wed, 28 Jul 2021 03:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-7-chenhuacai@loongson.cn> <YOQ5UBa0xYf7kAjg@hirez.programming.kicks-ass.net>
 <1625665981.7hbs7yesxx.astroid@bobo.none> <YQATv/MahhrKUu8Z@hirez.programming.kicks-ass.net>
 <CAK8P3a1RduCKfRG34hf-Aia8n_2pThZ-s0D-m+qABMs2o3=bMw@mail.gmail.com>
In-Reply-To: <CAK8P3a1RduCKfRG34hf-Aia8n_2pThZ-s0D-m+qABMs2o3=bMw@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Wed, 28 Jul 2021 18:16:49 +0800
Message-ID: <CAAhV-H5bfYc849Z2QGkztxfPQ7V-ZkHOhS8gbqA0k3=8teTCGA@mail.gmail.com>
Subject: Re: [PATCH 06/19] LoongArch: Add exception/interrupt handling
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        David Airlie <airlied@linux.ie>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Arnd and Peter,

On Tue, Jul 27, 2021 at 11:08 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Jul 27, 2021 at 4:10 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > On Wed, Jul 07, 2021 at 11:56:37PM +1000, Nicholas Piggin wrote:
> > > >> +/*
> > > >> + * Common Vectored Interrupt
> > > >> + * Complete the register saves and invoke the do_vi() handler
> > > >> + */
> > > >> +SYM_FUNC_START(except_vec_vi_handler)
> > > >> +  la      t1, __arch_cpu_idle
> > > >> +  LONG_L  t0, sp, PT_EPC
> > > >> +  /* 32 byte rollback region */
> > > >> +  ori     t0, t0, 0x1f
> > > >> +  xori    t0, t0, 0x1f
> > > >> +  bne     t0, t1, 1f
> > > >> +  LONG_S  t0, sp, PT_EPC
> > > >
> > > > Seriously, you're having your interrupt handler recover from the idle
> > > > race? On a *new* architecture?
> > >
> > > It's heavily derived from MIPS (does that make the wholesale replacement
> > > of arch/mips copyright headers a bit questionable?).
> > >
> > > I don't think it's such a bad trick though -- restartable sequences
> > > before they were cool. It can let you save an irq disable in some
> > > cases (depending on the arch of course).
> >
> > In this case you're making *every* interrupt slower. Simply adding a new
> > idle instruction, one that can be called with interrupts disabled and
> > will terminate on a pending interrupt, would've solved the issues much
> > nicer and reclaimed the cycles spend on this restart trick.
>
> Are we actually sure that loongarch /needs/ this version?
>
> The code was clearly copied from the mips default r4k_wait()
> function, but mips also has this one:
>
> /*
>  * This variant is preferable as it allows testing need_resched and going to
>  * sleep depending on the outcome atomically.  Unfortunately the "It is
>  * implementation-dependent whether the pipeline restarts when a non-enabled
>  * interrupt is requested" restriction in the MIPS32/MIPS64 architecture makes
>  * using this version a gamble.
>  */
> void __cpuidle r4k_wait_irqoff(void)
> {
>         if (!need_resched())
>                 __asm__(
>                 "       .set    push            \n"
>                 "       .set    arch=r4000      \n"
>                 "       wait                    \n"
>                 "       .set    pop             \n");
>         raw_local_irq_enable();
> }
>
>         case CPU_LOONGSON64:
>                 if ((c->processor_id & (PRID_IMP_MASK | PRID_REV_MASK)) >=
>                                 (PRID_IMP_LOONGSON_64C |
> PRID_REV_LOONGSON3A_R2_0) ||
>                                 (c->processor_id & PRID_IMP_MASK) ==
> PRID_IMP_LOONGSON_64R)
>                         cpu_wait = r4k_wait;
> ...
>                 cpu_wait = r4k_wait;
>                 if (read_c0_config7() & MIPS_CONF7_WII)
>                         cpu_wait = r4k_wait_irqoff;
>                 if (cpu_has_mips_r6) {
>                         cpu_wait = r4k_wait_irqoff;
>
> So a lot of the newer mips variants already get the fixed
> version. Maybe the hardware developers fixed it without telling
> the kernel people about it?
Very very unfortunately, the idle instruction of LoongArch cannot
executed with irq disabled. In other word, LoongArch should use a
variant like r4k_wait(), not r4k_wait_irqoff().

Huacai
>
>          Arnd
