Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9403EA35F
	for <lists+linux-arch@lfdr.de>; Thu, 12 Aug 2021 13:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236781AbhHLLSG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Aug 2021 07:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236732AbhHLLSF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Aug 2021 07:18:05 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4882C061798
        for <linux-arch@vger.kernel.org>; Thu, 12 Aug 2021 04:17:38 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id d22so7793589ioy.11
        for <linux-arch@vger.kernel.org>; Thu, 12 Aug 2021 04:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2sQr7vmtUINEa0XKlK/vdTFId1lazwJ8I153LpJr+Lw=;
        b=agCS/MX3aDzpwCyfD0wZXU6uRRybvE2jMODPJXLCQmDC/GgJ2T3gJfgdjF94QO5MEK
         CVr2s+BSnnv/RQ35HdOkDi/l1PMGMNsreUyAPoHH9qn8kzhflwSoaUG2AAEVHkU2IhVJ
         8syu8PV/DEFE0xcag22dbqORJLyB6WskMyK56oJ2Ad5BbkiVRTP1AuhucbSkYAv1K4VG
         jmCCtl4t054SCppeYGppFTftbKKGtnRPmTLpnVWjuYIF3AbFiDJCOVa8FBEzeDmRF6NR
         hgvPUa2kdy8PcU0PDqlXS2Sd8+FHcO///Fo9w5ubIbGkn1HjPWUOaGWBL/KtQ8BdmuUf
         emeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2sQr7vmtUINEa0XKlK/vdTFId1lazwJ8I153LpJr+Lw=;
        b=fIHIoFQ1qnsEtNd3JepfOja+KJVX1VBfJRC5SLuj7QosAIELAj4nm9vYoq8qmzBBst
         vYSAsJsQv5qht5nEzGnYUOpgsWAX0unHxKWHvIwBBhbrZl/bqBCvg9SGYFEaNEdL4jIj
         wY6giZcxYpGgMKpf2Wve0rwodZGnyl9pIa5Korh9quth7Ul4WiSYRHUqu9e+/UFqm+9u
         k3xQLX13fxoiRLXHGVKqtB3abuXqN0jXbuOJDl5TS8gv1qpKqhaNFGDugRev8VJ8gR7S
         h3gyokBCH8aPT6gzfY3o3bPSrTbQQWGb0sU2+B8R87n6vXUz0Xo+rV0KZJtS6GEfmw/F
         9JSQ==
X-Gm-Message-State: AOAM532BfZxtBc0l6+9Z9d3yPbrSnBIZyUK64bEXP+SYdoPOxSk+nzXP
        7rhdZ3psOiyCf/zikvQ9lQsQdEaGSqOPpZvxxtw=
X-Google-Smtp-Source: ABdhPJyiYkIIbkDaCUMEphd/WrPdFAyvJ8zYH8wPBwdwSouNDnaw67j15T7FeOsgPug+UaTRtJgL40HinFdadwswepY=
X-Received: by 2002:a05:6602:48c:: with SMTP id y12mr2673303iov.14.1628767058357;
 Thu, 12 Aug 2021 04:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-8-chenhuacai@loongson.cn> <CAK8P3a3FJSX6U9i0KYDKGVgPxi=OnrJJg73d74=KOkbEBoVa+g@mail.gmail.com>
 <YOQ50HDzj0+y00sR@hirez.programming.kicks-ass.net>
In-Reply-To: <YOQ50HDzj0+y00sR@hirez.programming.kicks-ass.net>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 12 Aug 2021 19:17:26 +0800
Message-ID: <CAAhV-H767tTTCpR26x3hNN2BrWDyfe4z6p0gsgS4TSiXLu6=Hw@mail.gmail.com>
Subject: Re: [PATCH 07/19] LoongArch: Add process management
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
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

Hi, Peter and Arnd,

On Tue, Jul 6, 2021 at 7:09 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jul 06, 2021 at 12:16:37PM +0200, Arnd Bergmann wrote:
> > On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > > +void arch_cpu_idle(void)
> > > +{
> > > +       local_irq_enable();
> > > +       __arch_cpu_idle();
> > > +}
> >
> > This looks racy: What happens if an interrupt is pending and hits before
> > entering __arch_cpu_idle()?
>
> They fix it up in their interrupt handler by moving the IP over the
> actual IDLE instruction..
>
> Still the above is broken in that local_irq_enable() will have all sorts
> of tracing, but RCU is disabled at this point, so it is still very much
> broken.
This is a sad story, the idle instruction cannot execute with irq
disabled, we can only copy ugly code from MIPS.

Huacai
