Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4CE72E700
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 17:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242573AbjFMPWO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Jun 2023 11:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbjFMPWN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Jun 2023 11:22:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC490171F;
        Tue, 13 Jun 2023 08:22:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C353F63781;
        Tue, 13 Jun 2023 15:22:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33181C433F2;
        Tue, 13 Jun 2023 15:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686669731;
        bh=A//ADTpJNEvj5sg5K/oNCTDrlTuwFx3q2DsloGFiOhY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JhbB4c1XT5azVk1QDRETMtpcAshUJGmCBa0jLgc29MOBWoZSdAe6g/KwPt9MAeZl2
         x2tXkatNcYYbkN8oGbfXCLejrQIR6un1w/r7YtbFTKhDiJubIL/+MMUZo+S4GkGUVB
         dNgZLoM8cyA/ACEbVfENqpElTZ2V8kZBZyXUwlsfaQlGcCGvxQMojxOqwJGhK5cTlE
         2sfqBtsQJ4oQDW2V6plElkq0mj2tO0QhqcxbLBqAT6tMQ7+M738X4T+2h+hcgHM7X8
         EGWMp3nSjflU8bwiVrB7EXo1OXiFM5ewysMB2lhx7KsPbuD47R4t6NLFjJ1GThBhRL
         73egeATN3Z5jQ==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5149c51fd5bso9487978a12.0;
        Tue, 13 Jun 2023 08:22:11 -0700 (PDT)
X-Gm-Message-State: AC+VfDzhYylAGmDE9PyUnr/cxRQMWcXYbjwNB/rQYIlgipv7B5CtQOM0
        5550LOsTkfbse0ZvlndQKZbartu0r6EKyv+eEdA=
X-Google-Smtp-Source: ACHHUZ6pWZ9l8QvxWkq83acuLujK7zG98RAohbsGYZcecDJOhHoddCHqgHxiXOUIlVkssS/hyomFuVwNQC+uKY09KBI=
X-Received: by 2002:aa7:c50e:0:b0:516:7f02:92c0 with SMTP id
 o14-20020aa7c50e000000b005167f0292c0mr8125021edq.39.1686669729363; Tue, 13
 Jun 2023 08:22:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230529084600.2878130-1-guoren@kernel.org> <20230529084600.2878130-2-guoren@kernel.org>
 <f686f36b-4c09-5099-3ba4-90f87f914654@rivosinc.com>
In-Reply-To: <f686f36b-4c09-5099-3ba4-90f87f914654@rivosinc.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 13 Jun 2023 23:21:57 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQmLvCFhFL6eaNMcz__7Rv4TBBuoDQs288RycFvjMJrjQ@mail.gmail.com>
Message-ID: <CAJF2gTQmLvCFhFL6eaNMcz__7Rv4TBBuoDQs288RycFvjMJrjQ@mail.gmail.com>
Subject: Re: [PATCH -next V12 1/3] riscv: stack: Support HAVE_IRQ_EXIT_ON_IRQ_STACK
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc:     arnd@arndb.de, palmer@rivosinc.com, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, bjorn@kernel.org,
        greentime.hu@sifive.com, vincent.chen@sifive.com,
        andy.chiu@sifive.com, paul.walmsley@sifive.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 13, 2023 at 9:01=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger@riv=
osinc.com> wrote:
>
>
>
> On 29/05/2023 10:45, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Add independent irq stacks for percpu to prevent kernel stack overflows=
.
> > It is also compatible with VMAP_STACK by arch_alloc_vmap_stack.
> >
> > Tested-by: Jisheng Zhang <jszhang@kernel.org>
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Cc: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >   arch/riscv/Kconfig                   |  7 ++++++
> >   arch/riscv/include/asm/irq_stack.h   | 32 +++++++++++++++++++++++++
> >   arch/riscv/include/asm/thread_info.h |  2 ++
> >   arch/riscv/kernel/irq.c              | 33 ++++++++++++++++++++++++++
> >   arch/riscv/kernel/traps.c            | 35 ++++++++++++++++++++++++++-=
-
> >   5 files changed, 107 insertions(+), 2 deletions(-)
> >   create mode 100644 arch/riscv/include/asm/irq_stack.h
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index fa256f2e23c1..44b4c9690f94 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -588,6 +588,13 @@ config FPU
> >
> >         If you don't know what to do here, say Y.
> >
> > +config IRQ_STACKS
> > +     bool "Independent irq stacks" if EXPERT
> > +     default y
> > +     select HAVE_IRQ_EXIT_ON_IRQ_STACK
> > +     help
> > +       Add independent irq stacks for percpu to prevent kernel stack o=
verflows.
> > +
> >   endmenu # "Platform type"
> >
> >   menu "Kernel features"
> > diff --git a/arch/riscv/include/asm/irq_stack.h b/arch/riscv/include/as=
m/irq_stack.h
> > new file mode 100644
> > index 000000000000..b0dcee9a3fa2
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/irq_stack.h
> > @@ -0,0 +1,32 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef _ASM_RISCV_IRQ_STACK_H
> > +#define _ASM_RISCV_IRQ_STACK_H
> > +
> > +#include <linux/bug.h>
> > +#include <linux/gfp.h>
> > +#include <linux/kconfig.h>
> > +#include <linux/vmalloc.h>
> > +#include <linux/pgtable.h>
> > +#include <asm/thread_info.h>
> > +
> > +DECLARE_PER_CPU(ulong *, irq_stack_ptr);
> > +
> > +#ifdef CONFIG_VMAP_STACK
> > +/*
> > + * To ensure that VMAP'd stack overflow detection works correctly, all=
 VMAP'd
> > + * stacks need to have the same alignment.
> > + */
> > +static inline unsigned long *arch_alloc_vmap_stack(size_t stack_size, =
int node)
> > +{
> > +     void *p;
> > +
> > +     BUILD_BUG_ON(!IS_ENABLED(CONFIG_VMAP_STACK));
>
> Hi Guo,
>
> Since this function is already guarded with #ifdef CONFIG_VMAP_STACK, I
> guess this BUILD_BUG_ON() is unnecessary).
Yes, my carelessness. I would remove it in the next version.

>
> Cl=C3=A9ment




--
Best Regards
 Guo Ren
