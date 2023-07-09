Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD45A74C069
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jul 2023 04:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjGICaj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Jul 2023 22:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGICai (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jul 2023 22:30:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A16E48;
        Sat,  8 Jul 2023 19:30:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39ABF60B33;
        Sun,  9 Jul 2023 02:30:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F75AC433D9;
        Sun,  9 Jul 2023 02:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688869836;
        bh=ExIY4X1/6WBZDcceYJulXe9AXws94ZhD3WBbuCHUE6E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Nac9IehWe3mHd7f4j/uWewTT/i+BFlYKfZ7gn5k9QJ9U3xityI4bJX9ZdXhOhbtn5
         KTThX7ukwtNQCwv8P92YbIzux18NeIqXeNAP0ZSx+StByIr1piST8ZCbolBb1FnO0V
         4TlYUvp27unXCEnzaLZvJTVtFuvWsG9G3LN5Uk+hhA1ztWrWPnRW3e5uliMyOLBVbq
         XQXxCKKt+h8HovFU6s3NRY87n4MApHwoPIutnH0+WQ/HSDbD0KFEc/zfPVamMBdQsF
         +0g+kU/G3mLejCoZnrNCxPwdnfKEnCvJ6zS/xqrJOx9j3u3+1ha9DmRYZ2q48aAI9L
         mJuRm+SKqSf9A==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-9922d6f003cso438056866b.0;
        Sat, 08 Jul 2023 19:30:36 -0700 (PDT)
X-Gm-Message-State: ABy/qLZV5gTxzOkvl427ciWTsEkXXkK68StNRbDW/8r9zM4Q5b5vdEru
        WaXWFgxvPSBOngErmAo8+tEVwSVy0sVX7Bo0ZMI=
X-Google-Smtp-Source: APBJJlF+0ioRn75qNrO9bVL/zSUpGN/gURCXjEqGnwflHc3JbebPSMWPoOFD6j8qvVU2qPB/tccSjcTMfsMyHi84C1U=
X-Received: by 2002:a17:906:4307:b0:992:c5ad:18bc with SMTP id
 j7-20020a170906430700b00992c5ad18bcmr7156335ejm.70.1688869834776; Sat, 08 Jul
 2023 19:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230702025708.784106-1-guoren@kernel.org> <20230704164003.GB83892@hirez.programming.kicks-ass.net>
In-Reply-To: <20230704164003.GB83892@hirez.programming.kicks-ass.net>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 9 Jul 2023 10:30:22 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTc0Gyo=K-0dCW6wu7q=Wq34hgTB69qJ7VSF_KAgKhavA@mail.gmail.com>
Message-ID: <CAJF2gTTc0Gyo=K-0dCW6wu7q=Wq34hgTB69qJ7VSF_KAgKhavA@mail.gmail.com>
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

On Wed, Jul 5, 2023 at 12:40=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Sat, Jul 01, 2023 at 10:57:07PM -0400, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > The irqentry_nmi_enter/exit would force the current context into in_int=
errupt.
> > That would trigger the kernel to dead panic, but the kdb still needs "e=
break" to
> > debug the kernel.
> >
> > Move irqentry_nmi_enter/exit to exception_enter/exit could correct hand=
le_break
> > of the kernel side.
>
> This doesn't explain much if anything :/
>
> I'm confused (probably because I don't know RISC-V very well), what's
> EBREAK and how does it happen?
EBREAK is just an instruction of riscv which would rise breakpoint exceptio=
n.


>
> Specifically, if EBREAK can happen inside an local_irq_disable() region,
> then the below change is actively wrong. Any exception/interrupt that
> can happen while local_irq_disable() must be treated like an NMI.
When the ebreak happend out of local_irq_disable region, but
__nmi_enter forces handle_break() into in_interupt() state. So how
about:

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index f910dfccbf5d..69f7043a98b9 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -18,6 +18,7 @@
 #include <linux/irq.h>
 #include <linux/kexec.h>
 #include <linux/entry-common.h>
+#include <linux/context_tracking.h>

 #include <asm/asm-prototypes.h>
 #include <asm/bug.h>
@@ -285,12 +286,18 @@ asmlinkage __visible __trap_section void
do_trap_break(struct pt_regs *regs)
                handle_break(regs);

                irqentry_exit_to_user_mode(regs);
-       } else {
+       } else if (in_interrupt()){
                irqentry_state_t state =3D irqentry_nmi_enter(regs);

                handle_break(regs);

                irqentry_nmi_exit(regs, state);
+       } else {
+               enum ctx_state prev_state =3D exception_enter();
+
+               handle_break(regs);
+
+               exception_exit(prev_state);
        }
 }


>
> If that makes kdb unhappy, fix kdb.
>
> > Fixes: f0bddf50586d ("riscv: entry: Convert to generic entry")
> > Reported-by: Daniel Thompson <daniel.thompson@linaro.org>
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Cc: stable@vger.kernel.org
> > ---
> >  arch/riscv/kernel/traps.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> > index efc6b649985a..ed0eb9452f9e 100644
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
> > @@ -257,11 +258,11 @@ asmlinkage __visible __trap_section void do_trap_=
break(struct pt_regs *regs)
> >
> >               irqentry_exit_to_user_mode(regs);
> >       } else {
> > -             irqentry_state_t state =3D irqentry_nmi_enter(regs);
> > +             enum ctx_state prev_state =3D exception_enter();
> >
> >               handle_break(regs);
> >
> > -             irqentry_nmi_exit(regs, state);
> > +             exception_exit(prev_state);
> >       }
> >  }
> >
> > --
> > 2.36.1
> >



--
Best Regards
 Guo Ren
