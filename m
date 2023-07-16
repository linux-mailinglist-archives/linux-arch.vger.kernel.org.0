Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5EA07558A6
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jul 2023 01:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjGPXdl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 16 Jul 2023 19:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGPXdl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 16 Jul 2023 19:33:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6A3D1;
        Sun, 16 Jul 2023 16:33:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9840160EE9;
        Sun, 16 Jul 2023 23:33:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2567C43395;
        Sun, 16 Jul 2023 23:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689550419;
        bh=Ja9IYjqwNzmeISofK1hhZQkSnGHcbD0jYQgPpeuxanI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KPedHonJ+1xUSpZC+ZJSrhK2jIwbYYKVbiPMKpYSv4IL0MiL6siOsXnqw+/xzA7+q
         lfvdor5Cbw2vewFsyp34mOQLyiQtZTC2tusnrYIhlc1EGfBd/+VxBh3fD67SMuNLso
         pV8S+REUQIE5/NFGCVLMhr7hi0oSOGkNvw+eRDAwHYuu+cQ5hTV1aaTsjWeN8tE5na
         PC2lUeWK6tLqdR5XvGETNXi56UsoXGWCsUoiTsh3GLekmJ/1nkcJIJt5yhpPZKGHjn
         wWeaZJuNM5gJWC9ksjdpXZcc64tIX21zGaxmoEqcxpnF9N2zgZMwMl44QfnJ0l9tY9
         RtrRsd8lABtWg==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so8115760a12.0;
        Sun, 16 Jul 2023 16:33:38 -0700 (PDT)
X-Gm-Message-State: ABy/qLZQxX+wY34Wd2i2cDJEr7tqrDOxYVIygcV0osdI2EW85AbD1vNk
        v8F3BDK0xL30BJtT1WkO1pjEqgOm4wDo0OeRbcw=
X-Google-Smtp-Source: APBJJlEcBvXJxvd+KrBJuk0Vi8K5mZ3tcQx3JefAFzqKUbu1AoQrNc3PHaoeV7oErHoCHJMGuTnhuYfeFD4/gBGxpk0=
X-Received: by 2002:a05:6402:524e:b0:51d:cf7b:c9f0 with SMTP id
 t14-20020a056402524e00b0051dcf7bc9f0mr11056350edd.12.1689550417039; Sun, 16
 Jul 2023 16:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230702025708.784106-1-guoren@kernel.org> <20230704164003.GB83892@hirez.programming.kicks-ass.net>
 <CAJF2gTTc0Gyo=K-0dCW6wu7q=Wq34hgTB69qJ7VSF_KAgKhavA@mail.gmail.com> <20230710080152.GA3028865@hirez.programming.kicks-ass.net>
In-Reply-To: <20230710080152.GA3028865@hirez.programming.kicks-ass.net>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 17 Jul 2023 07:33:25 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTt23iSDG_m4ihPhXhYDrz3Xnih=KGLx_ayBLbzPqaTaQ@mail.gmail.com>
Message-ID: <CAJF2gTTt23iSDG_m4ihPhXhYDrz3Xnih=KGLx_ayBLbzPqaTaQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: entry: Fixup do_trap_break from kernel side
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        luto@kernel.org, conor.dooley@microchip.com, heiko@sntech.de,
        jszhang@kernel.org, lazyparser@gmail.com, falcon@tinylab.org,
        chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, mark.rutland@arm.com, bjorn@kernel.org,
        palmer@dabbelt.com, bjorn@rivosinc.com, daniel.thompson@linaro.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, stable@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
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

On Mon, Jul 10, 2023 at 4:02=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Sun, Jul 09, 2023 at 10:30:22AM +0800, Guo Ren wrote:
> > On Wed, Jul 5, 2023 at 12:40=E2=80=AFAM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> > >
> > > On Sat, Jul 01, 2023 at 10:57:07PM -0400, guoren@kernel.org wrote:
> > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > >
> > > > The irqentry_nmi_enter/exit would force the current context into in=
_interrupt.
> > > > That would trigger the kernel to dead panic, but the kdb still need=
s "ebreak" to
> > > > debug the kernel.
> > > >
> > > > Move irqentry_nmi_enter/exit to exception_enter/exit could correct =
handle_break
> > > > of the kernel side.
> > >
> > > This doesn't explain much if anything :/
> > >
> > > I'm confused (probably because I don't know RISC-V very well), what's
> > > EBREAK and how does it happen?
> > EBREAK is just an instruction of riscv which would rise breakpoint exce=
ption.
> >
> >
> > >
> > > Specifically, if EBREAK can happen inside an local_irq_disable() regi=
on,
> > > then the below change is actively wrong. Any exception/interrupt that
> > > can happen while local_irq_disable() must be treated like an NMI.
> > When the ebreak happend out of local_irq_disable region, but
> > __nmi_enter forces handle_break() into in_interupt() state. So how
>
> And why is that a problem? I think I'm missing something fundamental
> here...
The irqentry_nmi_enter() would force the current context to get
in_interrupt=3Dtrue, although ebreak happens in the context which is
in_interrupt=3Dfalse.
A lot of checking codes, such as:
        if (in_interrupt())
                panic("Fatal exception in interrupt");
It would make the kernel panic, but we don't panic; we want back to the she=
ll.
eg:
echo BUG > /sys/kernel/debug/provoke-crash/DIRECT

>
> > about:
> >
> > diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> > index f910dfccbf5d..69f7043a98b9 100644
> > --- a/arch/riscv/kernel/traps.c
> > +++ b/arch/riscv/kernel/traps.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/irq.h>
> >  #include <linux/kexec.h>
> >  #include <linux/entry-common.h>
> > +#include <linux/context_tracking.h>
> >
> >  #include <asm/asm-prototypes.h>
> >  #include <asm/bug.h>
> > @@ -285,12 +286,18 @@ asmlinkage __visible __trap_section void
> > do_trap_break(struct pt_regs *regs)
> >                 handle_break(regs);
> >
> >                 irqentry_exit_to_user_mode(regs);
> > -       } else {
> > +       } else if (in_interrupt()){
> >                 irqentry_state_t state =3D irqentry_nmi_enter(regs);
> >
> >                 handle_break(regs);
> >
> >                 irqentry_nmi_exit(regs, state);
> > +       } else {
> > +               enum ctx_state prev_state =3D exception_enter();
> > +
> > +               handle_break(regs);
> > +
> > +               exception_exit(prev_state);
> >         }
> >  }
>
> That's wrong. If you want to make it conditional, you have to look at
> !(regs->status & SR_IE) (that's the interrupt enable flag of the
> interrupted context, right?)
>
> When you hit an EBREAK when IRQs were disabled, you must be NMI like.
>
> But making it conditional like this makes it really hard to write a
> handler though, it basically must assume it will be NMI contetx (because
> it can't know) so there is no point in sometimes not doing NMI context.






--=20
Best Regards
 Guo Ren
