Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C28BA3EA4EB
	for <lists+linux-arch@lfdr.de>; Thu, 12 Aug 2021 14:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237205AbhHLMwi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Aug 2021 08:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235385AbhHLMwh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Aug 2021 08:52:37 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D3BC061765
        for <linux-arch@vger.kernel.org>; Thu, 12 Aug 2021 05:52:12 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id q16so5847363ioj.0
        for <linux-arch@vger.kernel.org>; Thu, 12 Aug 2021 05:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Zlt92MdplFzYzVCpLUOC1FV/hnjLdYhHb2ubOG+r2Q=;
        b=Tkibcp3B8auckVHGyuXydSmyCVaUjzThulC3h7xIFZwu3NxD3biNZ2Vui8C7D+t+Q4
         ABu1mtfOTQK7rqfNCz3eqoqb/PgnIEuUQPR2T6imuQRYRFULB507b1Gb0lq+r8uwu/yV
         p5MvJJkGDp4T6TwDyLigxH/yBgrdgtGG67psKYi7KPmrlXoIIzmTCkuFsWOFe26y1a54
         cPQvdwnrHMlc+zMdKu6JvsCxtAL0Tnp1Mr/C/BeziiMVz9qypEZtFBU973//kWK7vRd+
         eCiONRnrj9xl0F+5y/8SmRDPaQGYtYDZADG0F4bEA8Tz//2YD+ihfVT0EhLxPaYwN7Ue
         V4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Zlt92MdplFzYzVCpLUOC1FV/hnjLdYhHb2ubOG+r2Q=;
        b=hbSYPAjMi+H8qcpXXjubyeEwRc4yb097m6Dt0Yj2/iBLgeJV83X8nTR+2BXpeRdxxG
         VFy3F800upM0E9Q7KqHj/5Jx5pLHfa6/sdTCN9mYYZu4xzTxJ1dvBCftvHyI5JBTrKtb
         Bjgew3wh7va8ESMLIdZaGJbpwdBTvdNE+WK6apYV+PloIJtqe9VJXVwjlJvFlPKfmhwC
         xsv7B0GK52G7ONk1OGotTvFi8KR8pTF7qdkNamCUyIQnme8LTe9hkWITADLdS7b+8gUG
         zmodRazM9+jjtxhNM8cKf3kL98BvybsWnGetJrlTMTZFHEss0Hfs3xYlaHRSXhXRa7cV
         VVUw==
X-Gm-Message-State: AOAM5323N0Qlj8B1M/8s+9HoeY1R9HZ77HCCJdcUP5WRn8op8fhRS3E1
        iOGTsPWSJ0qBpQ55J+i21i7bav58u/KTcZs8U74=
X-Google-Smtp-Source: ABdhPJyOrWE+BFg8wduShrgvPcporZZqxz8OVX4bfAnED2EbOC/4KFIPauEiz8vQkSOojKhc0C7mUPZPsEMqrJWlgsA=
X-Received: by 2002:a05:6602:48c:: with SMTP id y12mr2965868iov.14.1628772732162;
 Thu, 12 Aug 2021 05:52:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-8-chenhuacai@loongson.cn> <CAK8P3a3FJSX6U9i0KYDKGVgPxi=OnrJJg73d74=KOkbEBoVa+g@mail.gmail.com>
 <YOQ50HDzj0+y00sR@hirez.programming.kicks-ass.net> <CAAhV-H767tTTCpR26x3hNN2BrWDyfe4z6p0gsgS4TSiXLu6=Hw@mail.gmail.com>
 <CAK8P3a0gDhL0SUo-RvR00GAi1cOTox_S759uEC7gr0yLkr=+JQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0gDhL0SUo-RvR00GAi1cOTox_S759uEC7gr0yLkr=+JQ@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 12 Aug 2021 20:51:59 +0800
Message-ID: <CAAhV-H4vT_HC7mDJ0BaHhEujHGJ64OOecJ42NBEFSG6ztFFkzA@mail.gmail.com>
Subject: Re: [PATCH 07/19] LoongArch: Add process management
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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

On Thu, Aug 12, 2021 at 8:30 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Aug 12, 2021 at 1:17 PM Huacai Chen <chenhuacai@gmail.com> wrote:
> > On Tue, Jul 6, 2021 at 7:09 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Tue, Jul 06, 2021 at 12:16:37PM +0200, Arnd Bergmann wrote:
> > > > On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > >
> > > > > +void arch_cpu_idle(void)
> > > > > +{
> > > > > +       local_irq_enable();
> > > > > +       __arch_cpu_idle();
> > > > > +}
> > > >
> > > > This looks racy: What happens if an interrupt is pending and hits before
> > > > entering __arch_cpu_idle()?
> > >
> > > They fix it up in their interrupt handler by moving the IP over the
> > > actual IDLE instruction..
> > >
> > > Still the above is broken in that local_irq_enable() will have all sorts
> > > of tracing, but RCU is disabled at this point, so it is still very much
> > > broken.
> > This is a sad story, the idle instruction cannot execute with irq
> > disabled, we can only copy ugly code from MIPS.
>
> Maybe you can avoid that tracing problem if you move the irq-enable
> and subsequent need_resched() check into the assembler code.
>
> Another option would be to have the actual idle logic implemented
> in firmware that runs at a higher privilege level and provides a
> hypercall interface to the kernel with the normal behavior (
> enter with irq disabled, wait until irq).
We have some problems with trace options enabled before, but it seems
some problems disappear after we refactor the irq/syscall code by
using generic entry code. :)

Huacai.
>
>        Arnd
