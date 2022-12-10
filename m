Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667C7648E1F
	for <lists+linux-arch@lfdr.de>; Sat, 10 Dec 2022 11:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiLJKV3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 10 Dec 2022 05:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiLJKV1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 10 Dec 2022 05:21:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DFA22B2F;
        Sat, 10 Dec 2022 02:21:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2796A60B08;
        Sat, 10 Dec 2022 10:21:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8805CC433A1;
        Sat, 10 Dec 2022 10:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670667685;
        bh=KJsvpZ5QOii9zGY2DeG7g2+E/TbzW2Va+I7GS3tMVW8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Im/DIJGyJ7+n1zJ+Kee/HoQJZQRz+qX5u1LytCtJliW4iFmHuzOmDdFoXCjuXCcli
         dp5rA6ZtgA+yEcFtvJMxAa6nHJzdaiBbt/bK1OXmiRZetc4xI6sE+vjJNMScYfK3Zd
         9qvnXQan2Hg0N84SUmASx6kzObgXAJNNQd+IWxBcRdZ2xZFjHYLX+eAH6kH7cQ9ibJ
         XnhpwUnrv6oJ8A6S2J6JAco53vbOOdW9IYNmlwOn0yaK1b2qdq7Zvx15oqxvdY5nQX
         urUYMiYjbK8dSKz9CL9qHfrNRa0IV4lad1lezuMdCYqZ1GJ6e3H2+fgctrFQDs83oS
         0XRaeyp31A7iw==
Received: by mail-ed1-f41.google.com with SMTP id r26so6349833edc.10;
        Sat, 10 Dec 2022 02:21:25 -0800 (PST)
X-Gm-Message-State: ANoB5pmOccZPAnvo14shIYT9MDl5bm+4dTpK+rnNrE7N1Sxua0dJLT1D
        mFn/PKyyAH2YcZmj+LpT1Lv15KWkDkobArxzRdw=
X-Google-Smtp-Source: AA0mqf4dSb/mqggDS34MJFy0MWfBD+0OERWI5TOzPfeP5X3MFbJGo58MTUjo9Zftn1tq+5ze8jwA4ga7DWxRgpiEhsU=
X-Received: by 2002:a05:6402:22db:b0:46c:c16b:b4c4 with SMTP id
 dm27-20020a05640222db00b0046cc16bb4c4mr15461728edb.419.1670667683430; Sat, 10
 Dec 2022 02:21:23 -0800 (PST)
MIME-Version: 1.0
References: <20221208025816.138712-1-guoren@kernel.org> <20221208025816.138712-10-guoren@kernel.org>
 <87o7sew6ey.fsf@all.your.base.are.belong.to.us> <CAJF2gTT1YNubBG_RMzwsWVXk0X0nwQvTM2r5NjRvVN+1x1RHMw@mail.gmail.com>
 <874ju59ftr.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <874ju59ftr.fsf@all.your.base.are.belong.to.us>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 10 Dec 2022 18:21:10 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTp+ruq+hadMTkkxW1XjSNjjv3VDrjRqnRnExntpCzD8A@mail.gmail.com>
Message-ID: <CAJF2gTTp+ruq+hadMTkkxW1XjSNjjv3VDrjRqnRnExntpCzD8A@mail.gmail.com>
Subject: Re: [PATCH -next V10 09/10] riscv: stack: Support HAVE_SOFTIRQ_ON_OWN_STACK
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
        falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mark.rutland@arm.com,
        zouyipeng@huawei.com, bigeasy@linutronix.de,
        David.Laight@aculab.com, chenzhongjin@huawei.com,
        greentime.hu@sifive.com, andy.chiu@sifive.com, ben@decadent.org.uk,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 9, 2022 at 3:50 PM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> wro=
te:
>
> Guo Ren <guoren@kernel.org> writes:
>
> > On Thu, Dec 8, 2022 at 6:12 PM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>=
 wrote:
> >>
> >> guoren@kernel.org writes:
> >>
> >> > From: Guo Ren <guoren@linux.alibaba.com>
> >> >
> >> > Add the HAVE_SOFTIRQ_ON_OWN_STACK feature for the IRQ_STACKS config.=
 The
> >> > irq and softirq use the same independent irq_stack of percpu by time
> >> > division multiplexing.
> >> >
> >> > Tested-by: Jisheng Zhang <jszhang@kernel.org>
> >> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> >> > Signed-off-by: Guo Ren <guoren@kernel.org>
> >> > ---
> >> >  arch/riscv/Kconfig      |  7 ++++---
> >> >  arch/riscv/kernel/irq.c | 33 +++++++++++++++++++++++++++++++++
> >> >  2 files changed, 37 insertions(+), 3 deletions(-)
> >> >
> >> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> >> > index 0a9d4bdc0338..bd4c4ae4cdc9 100644
> >> > --- a/arch/riscv/Kconfig
> >> > +++ b/arch/riscv/Kconfig
> >> > @@ -447,12 +447,13 @@ config FPU
> >> >         If you don't know what to do here, say Y.
> >> >
> >> >  config IRQ_STACKS
> >> > -     bool "Independent irq stacks" if EXPERT
> >> > +     bool "Independent irq & softirq stacks" if EXPERT
> >> >       default y
> >> >       select HAVE_IRQ_EXIT_ON_IRQ_STACK
> >> > +     select HAVE_SOFTIRQ_ON_OWN_STACK
> >>
> >> HAVE_IRQ_EXIT_ON_IRQ_STACK is used by softirq.c Shouldn't that be
> >> selected introduced in this patch, instead of the previous one?
> > This patch depends on the previous one. And the previous one could
> > work separately.
>
> Let me try to be more clear: IRQ_STACKS should be introduced in the
> previous patch, which adds per-cpu stacks to hardirq. This patch adds
> per-cpu stacks for softirq, and the softirq related selects:
>
>  select HAVE_IRQ_EXIT_ON_IRQ_STACK
>  select HAVE_SOFTIRQ_ON_OWN_STACK
>
> Hence, the "HAVE_IRQ_EXIT_ON_IRQ_STACK" select should be part of *this*
> patch, not the previous.
>
> Or am I missing something?
You are right, HAVE_IRQ_EXIT_ON_IRQ_STACK is belong to SOFTIRQ:
static inline void invoke_softirq(void)
{
...
        if (!force_irqthreads() || !__this_cpu_read(ksoftirqd)) {
#ifdef CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK
...
                __do_softirq();
#else
...
                do_softirq_own_stack();
#endif
...
}

I would fix that in the next version.

>
>
> Bj=C3=B6rn



--=20
Best Regards
 Guo Ren
