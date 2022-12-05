Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D29964379C
	for <lists+linux-arch@lfdr.de>; Mon,  5 Dec 2022 23:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiLEWEY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Dec 2022 17:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiLEWEX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Dec 2022 17:04:23 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABA4D7D
        for <linux-arch@vger.kernel.org>; Mon,  5 Dec 2022 14:04:22 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id ud5so1822347ejc.4
        for <linux-arch@vger.kernel.org>; Mon, 05 Dec 2022 14:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s9lc01aCxQTSJwdx7RUodm3mRi7nxix9tLqZdF2sFQo=;
        b=aONPpMB54y9faDQtvFnc8RfGe22FaOc9EcPYO6fH7m77YVH34zckI4t5zwJFj2LPRn
         Wkef5GGEyBWRC7xgGNpgQnmwZDF2SV92UI4D6e7b+RJUE1vAX0IxZG+LgpP/x8o9BXXg
         nUOwE/IbaYsl/mFyI2fEa/IGMYruiQ0JMSEC7pcUSspfqAg9/lpQ7y34sTgCHQIMJp7V
         kXmzmqkireW08op7Lbio2kEZk5kpdURtD0VVwmV7LQz5JJEY8ALGnE9DAKIY0/G1VQXB
         9BbDhI4C13tyVy1WCti4TlRQj/6RxdmBkStRc/GQalqTQh59k4xCpBKaWEdVNN4kyu4u
         w0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s9lc01aCxQTSJwdx7RUodm3mRi7nxix9tLqZdF2sFQo=;
        b=pvoL1PZO9BOVIvbyaHV60fPeEF9qO12H/shoRVwg+qmT3CTdCZ2BeQmGJYig18Jemq
         sXvb1N03amXoektivSwmRcI9Cp53RRxjv5RNrwWsegRQQmX0XWIjvgpb6SuMYhYP0//F
         Y/OWOFQU0jeLfOB5g72HoXOXOhdmI6kiWADqEhYDFZawwYatdIYEruFkhiUFBylFt0kn
         sSH63JiaKEQDwP3Fd4G6gNKI83Xea70xlYxWDCB6of7V27JKXqmefVuPCqFAxJhCD0uA
         y+2foADTh9xOEseYvTX/jj6qUOPDkn4jkg5vZhtsri+IpOuDk17KVzSyNjpfk0hZOaKY
         qcAw==
X-Gm-Message-State: ANoB5pn8J7oGw50aaPXTWVLYSPKwstHCngpwRraCBD+gCwBN4+zSdWFp
        LPy2obUoG7KJ1R4URk+mfN9hJBaSBPibO4+VP3p1Tg==
X-Google-Smtp-Source: AA0mqf6pvPdZ4FTJxIRInbmyU3P5Gysoxv0jzItR7ncFVPN8Th1XmEH6dUBNagCD4TWu62MM3uaWessrJIPBqKHoXeo=
X-Received: by 2002:a17:906:a198:b0:7b4:bc42:3b44 with SMTP id
 s24-20020a170906a19800b007b4bc423b44mr64679643ejy.101.1670277860575; Mon, 05
 Dec 2022 14:04:20 -0800 (PST)
MIME-Version: 1.0
References: <20221203215535.208948-1-geomatsi@gmail.com> <20221203215535.208948-4-geomatsi@gmail.com>
 <CALE4mHrrxTJaQ5YYZamS9GmNhGopiUA3jk5+iw1XAn=8=XT=fg@mail.gmail.com> <Y45TuQUQiDsH2cJ1@curiosity>
In-Reply-To: <Y45TuQUQiDsH2cJ1@curiosity>
From:   Andrew Bresticker <abrestic@rivosinc.com>
Date:   Mon, 5 Dec 2022 17:04:09 -0500
Message-ID: <CALE4mHpf8obcfiWEvstBMycTWYur0JoNeAYMNn5r=q-gdb6ZXQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 3/3] riscv: hw-breakpoints: add more trigger controls
To:     Sergey Matyukevich <geomatsi@gmail.com>
Cc:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 5, 2022 at 3:25 PM Sergey Matyukevich <geomatsi@gmail.com> wrote:
>
> Hi Andrew,
>
>
> > Hi Sergey,
> >
> > On Sat, Dec 3, 2022 at 4:55 PM Sergey Matyukevich <geomatsi@gmail.com> wrote:
> > >
> > > From: Sergey Matyukevich <sergey.matyukevich@syntacore.com>
> > >
> > > RISC-V SBI Debug Trigger extension proposal defines multiple functions
> > > to control debug triggers. The pair of install/uninstall functions was
> > > enough to implement ptrace interface for user-space debug. This patch
> > > implements kernel wrappers for start/update/stop SBI functions. The
> > > intended users of these control wrappers are kgdb and kernel modules
> > > that make use of kernel-wide hardware breakpoints and watchpoints.
> > >
> > > Signed-off-by: Sergey Matyukevich <sergey.matyukevich@syntacore.com>
> >
> > <snip>
> >
> > > diff --git a/arch/riscv/include/asm/hw_breakpoint.h b/arch/riscv/include/asm/hw_breakpoint.h
> > > index 5bb3b55cd464..afc59f8e034e 100644
> > > --- a/arch/riscv/include/asm/hw_breakpoint.h
> > > +++ b/arch/riscv/include/asm/hw_breakpoint.h
> > > @@ -137,6 +137,9 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
> > >  int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
> > >                                     unsigned long val, void *data);
> > >
> > > +void arch_enable_hw_breakpoint(struct perf_event *bp);
> > > +void arch_update_hw_breakpoint(struct perf_event *bp);
> > > +void arch_disable_hw_breakpoint(struct perf_event *bp);
> > >  int arch_install_hw_breakpoint(struct perf_event *bp);
> > >  void arch_uninstall_hw_breakpoint(struct perf_event *bp);
> > >  void hw_breakpoint_pmu_read(struct perf_event *bp);
> > > @@ -153,5 +156,17 @@ static inline void clear_ptrace_hw_breakpoint(struct task_struct *tsk)
> > >  {
> > >  }
> > >
> > > +void arch_enable_hw_breakpoint(struct perf_event *bp)
> > > +{
> > > +}
> > > +
> > > +void arch_update_hw_breakpoint(struct perf_event *bp)
> > > +{
> > > +}
> > > +
> > > +void arch_disable_hw_breakpoint(struct perf_event *bp)
> > > +{
> > > +}
> >
> > I don't see any references to {enable,update,disable}_hw_breakpoint in
> > common kernel code, nor do any other architectures define these
> > functions. Who are the intended users? Do we even need them for kgdb
> > on RISC-V?
>
> SBI Debug Trigger extension proposal defines more functions than just
> install/uninstall required for ptrace hw-breakpoints API. So this patch
> is an attempt to expose some additional SBI features to the rest of the
> kernel.

Got it. IMHO it's generally best not to add dead code unless a user
for it is imminent. It's harder to review something if you don't know
exactly how it'll be used.

> For instance, I have been using these stop/update/start functions for
> managing kernel-wide hw-breakpoints when experimenting with a sample
> module from samples/hw_breakpoint. It can be convenient to modify a
> breakpoint or watchpoint when it fires, e.g. to perform single-step
> before proceeding execution. Full-fledged unregister/register cycle is
> not suitable for this task. And this is where disable/update/enable
> sequence can help.
>
> I haven't yet tried to implement hw-breakpoint support in RISC-V kgdb,
> so I don't know for sure if these custom calls are needed there.
>
> > > diff --git a/arch/riscv/kernel/hw_breakpoint.c b/arch/riscv/kernel/hw_breakpoint.c
> > > index 8eddf512cd03..ca7df02830c2 100644
> > > --- a/arch/riscv/kernel/hw_breakpoint.c
> > > +++ b/arch/riscv/kernel/hw_breakpoint.c
> > > @@ -2,6 +2,7 @@
> > >
> > >  #include <linux/hw_breakpoint.h>
> > >  #include <linux/perf_event.h>
> > > +#include <linux/spinlock.h>
> > >  #include <linux/percpu.h>
> > >  #include <linux/kdebug.h>
> > >
> > > @@ -9,6 +10,8 @@
> > >
> > >  /* bps/wps currently set on each debug trigger for each cpu */
> > >  static DEFINE_PER_CPU(struct perf_event *, bp_per_reg[HBP_NUM_MAX]);
> > > +static DEFINE_PER_CPU(unsigned long, msg_lock_flags);
> > > +static DEFINE_PER_CPU(raw_spinlock_t, msg_lock);
> >
> > I'm not sure I understand the point of this per-CPU spinlock. Just
> > disable preemption (and interrupts, if necessary).
> >
> > Also, arch_{install,uninstall}_hw_breakpoint are already expected to
> > be called from atomic context; is the intention here that they be
> > callable from outside atomic context?
>
> These additional locsk are not needed for install/uninstall pair due to
> the reason that you mentioned: those calls are called by kernel event
> core in atomic context with ctx->lock held. These locks are needed only
> to make sure that new 'arch_update_hw_breakpoint' function can use the
> same message buffers as install/uninstall.

Sure, but you can achieve the same by disabling preemption. No need
for an actual spinlock.

-Andrew

>
> Regards,
> Sergey
