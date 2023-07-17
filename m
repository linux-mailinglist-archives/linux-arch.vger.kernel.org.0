Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7A57568CA
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jul 2023 18:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjGQQOg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Jul 2023 12:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjGQQOX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Jul 2023 12:14:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A916010E3;
        Mon, 17 Jul 2023 09:14:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C5BA61153;
        Mon, 17 Jul 2023 16:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A259DC43397;
        Mon, 17 Jul 2023 16:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689610457;
        bh=Sx44thNjRKhLP9P5+or0VlNLH7j5C5I07ogs5/16HhY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T80r1gPbXjv1SoRVNtZ7HW9NItzws0okoDQBuQEbaeOo3VBY+9GQ8qWSpRT5mMLEk
         n65oQS6Sm6H/4UxywXaocN/LNB8vaeNQ1CQ+8OUs5Ke/YL8gIbktTjKe/EVrHECAHy
         3HMTD9R6rdXzMnbXPCJYHlUvp1oS+QjXru7blRzLu6e8e4XuDfmmBriUCxBOjsKCvq
         S0m+k6ERQEPs+ftiZFthFTBhDUYvxAny+jbaFR3BtmgcvsL16VUvrYfVJPgWr5u6K3
         MBt3Uxpms6QbZLAQpMP8RItQwnXZ9GG6sNAlxvjv3EWb8HQ32Pw6lDTNv9t9h5ls5U
         OzJUm6TbHM7Lg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4fb5bcb9a28so7365980e87.3;
        Mon, 17 Jul 2023 09:14:17 -0700 (PDT)
X-Gm-Message-State: ABy/qLbI718QoeGWzNqImWlNbJTsZHBLcKHsf1L327MqrzB09cnh7Np+
        VdRSdQqNMLR7PW+wRFvv+aGGC28TfkhBPNprRm0=
X-Google-Smtp-Source: APBJJlGSRK/NccnTlgPIrL/sVQ3Gt+l6oXdva756uEn+PlB77r9xvayYmDWddY+owMdYJMgTGcAOq61mjkUYKNA4wIg=
X-Received: by 2002:a19:8c44:0:b0:4fb:8de9:ac13 with SMTP id
 i4-20020a198c44000000b004fb8de9ac13mr8170427lfj.23.1689610455595; Mon, 17 Jul
 2023 09:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230702025708.784106-1-guoren@kernel.org> <20230704164003.GB83892@hirez.programming.kicks-ass.net>
 <CAJF2gTTc0Gyo=K-0dCW6wu7q=Wq34hgTB69qJ7VSF_KAgKhavA@mail.gmail.com>
 <20230710080152.GA3028865@hirez.programming.kicks-ass.net>
 <CAJF2gTTt23iSDG_m4ihPhXhYDrz3Xnih=KGLx_ayBLbzPqaTaQ@mail.gmail.com> <20230717104508.GF4253@hirez.programming.kicks-ass.net>
In-Reply-To: <20230717104508.GF4253@hirez.programming.kicks-ass.net>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 18 Jul 2023 00:14:03 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQDVq0zedQ+55oX=gGSqb5OkDUoN1ipVu8RUQ5U_e=a9Q@mail.gmail.com>
Message-ID: <CAJF2gTQDVq0zedQ+55oX=gGSqb5OkDUoN1ipVu8RUQ5U_e=a9Q@mail.gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 17, 2023 at 6:45=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Jul 17, 2023 at 07:33:25AM +0800, Guo Ren wrote:
> > On Mon, Jul 10, 2023 at 4:02=E2=80=AFPM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> > >
> > > On Sun, Jul 09, 2023 at 10:30:22AM +0800, Guo Ren wrote:
> > > > On Wed, Jul 5, 2023 at 12:40=E2=80=AFAM Peter Zijlstra <peterz@infr=
adead.org> wrote:
> > > > >
> > > > > On Sat, Jul 01, 2023 at 10:57:07PM -0400, guoren@kernel.org wrote=
:
> > > > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > > > >
> > > > > > The irqentry_nmi_enter/exit would force the current context int=
o in_interrupt.
> > > > > > That would trigger the kernel to dead panic, but the kdb still =
needs "ebreak" to
> > > > > > debug the kernel.
> > > > > >
> > > > > > Move irqentry_nmi_enter/exit to exception_enter/exit could corr=
ect handle_break
> > > > > > of the kernel side.
> > > > >
> > > > > This doesn't explain much if anything :/
> > > > >
> > > > > I'm confused (probably because I don't know RISC-V very well), wh=
at's
> > > > > EBREAK and how does it happen?
> > > > EBREAK is just an instruction of riscv which would rise breakpoint =
exception.
> > > >
> > > >
> > > > >
> > > > > Specifically, if EBREAK can happen inside an local_irq_disable() =
region,
> > > > > then the below change is actively wrong. Any exception/interrupt =
that
> > > > > can happen while local_irq_disable() must be treated like an NMI.
> > > > When the ebreak happend out of local_irq_disable region, but
> > > > __nmi_enter forces handle_break() into in_interupt() state. So how
> > >
> > > And why is that a problem? I think I'm missing something fundamental
> > > here...
> > The irqentry_nmi_enter() would force the current context to get
> > in_interrupt=3Dtrue, although ebreak happens in the context which is
> > in_interrupt=3Dfalse.
> > A lot of checking codes, such as:
> >         if (in_interrupt())
> >                 panic("Fatal exception in interrupt");
>
> Why would you do that?!?
>
> Are you're trying to differentiate between an exception and an
> interrupt?
>
> You *could* have ebreak in an interrupt, right? So why panic the machine
> if that happens?

Do you mean the below patch? Yes, it could fix up.

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index f910dfccbf5d..92899db6696b 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -85,8 +85,6 @@ void die(struct pt_regs *regs, const char *str)
        spin_unlock_irqrestore(&die_lock, flags);
        oops_exit();

-       if (in_interrupt())
-               panic("Fatal exception in interrupt");
        if (panic_on_oops)
                panic("Fatal exception");
        if (ret !=3D NOTIFY_STOP)
diff --git a/kernel/exit.c b/kernel/exit.c
index edb50b4c9972..a46a1aef66ce 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -940,8 +940,6 @@ void __noreturn make_task_dead(int signr)
        struct task_struct *tsk =3D current;
        unsigned int limit;

-       if (unlikely(in_interrupt()))
-               panic("Aiee, killing interrupt handler!");
        if (unlikely(!tsk->pid))
                panic("Attempted to kill the idle task!");

But how does x86 deal with it without kernel/exit.c modifcation?

>
> > It would make the kernel panic, but we don't panic; we want back to the=
 shell.
> > eg:
> > echo BUG > /sys/kernel/debug/provoke-crash/DIRECT
>
>
>


--=20
Best Regards
 Guo Ren
