Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2DA365CB97
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jan 2023 02:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234260AbjADBk4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Jan 2023 20:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbjADBky (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Jan 2023 20:40:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5114DB4;
        Tue,  3 Jan 2023 17:40:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25B6B614F9;
        Wed,  4 Jan 2023 01:40:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FBFBC433A1;
        Wed,  4 Jan 2023 01:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672796452;
        bh=4+YCVSlmS1xGxI66GjUsM1FciiRv5pR0ZH+g1/QKoos=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hF5inMd2JJa2s9C62pR/YMr3UcBLXs7OeFvbq1rlqV4Hz2x+8e5Q4ylkoJuFXSBua
         l0EegukYO5PjZe3Bj0DNsVywqQp169cpPLPxQsG01l/SYZOkInqb5SjUa2XZfNgGz4
         xPgK0x52pl6YC2zKaWszZb0R2dGiLNXiekoU7tEB9WfJ0S1g0KM81yBediPfvM4vpW
         nD77GSaDTq0XngKa7M+oyu4b1mFkkDgOQ6tFmpBbM4UIVICZNhd34fmZtUz5xcCxOO
         0oMYAcrFNTXRv+UDs+64ibDK99VwHZXYL00c9dHg+DCPrUNDZemUYULK4k7Cb26H3B
         S1DXIMNIizfrA==
Received: by mail-ej1-f50.google.com with SMTP id tz12so79279912ejc.9;
        Tue, 03 Jan 2023 17:40:52 -0800 (PST)
X-Gm-Message-State: AFqh2kpaIFSWguqRCL13VIb6ImBZmBtOkzzYTgxWsLdr+ZJLa51WOIWr
        XJ1RvFaOfmw+iWbOBVLwGSB+PtgD8jqK4XOM7a4=
X-Google-Smtp-Source: AMrXdXuguKZK0xV2EbDa692rlZxWl3jbDoL9vGT6mVExfffLZNxoo/dIejOpWwEoJqQtPyJfzfwjMbyJ83re0sVpEew=
X-Received: by 2002:a17:906:308a:b0:7c0:f7b0:fbbb with SMTP id
 10-20020a170906308a00b007c0f7b0fbbbmr4720616ejv.266.1672796450559; Tue, 03
 Jan 2023 17:40:50 -0800 (PST)
MIME-Version: 1.0
References: <20230103033531.2011112-1-guoren@kernel.org> <20230103033531.2011112-4-guoren@kernel.org>
 <36314eb6-e41d-30b9-9ac4-12b88a108b7b@ghiti.fr>
In-Reply-To: <36314eb6-e41d-30b9-9ac4-12b88a108b7b@ghiti.fr>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 4 Jan 2023 09:40:38 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTSretKkJGNV7Y6iJboPuAWUQ=to=RPA8_-Nz8dnufGAg@mail.gmail.com>
Message-ID: <CAJF2gTTSretKkJGNV7Y6iJboPuAWUQ=to=RPA8_-Nz8dnufGAg@mail.gmail.com>
Subject: Re: [PATCH -next V12 3/7] riscv: entry: Add noinstr to prevent
 instrumentation inserted
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
        falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, mark.rutland@arm.com, ben@decadent.org.uk,
        bjorn@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
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

On Tue, Jan 3, 2023 at 5:12 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> Hi Guo,
>
> On 1/3/23 04:35, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Without noinstr the compiler is free to insert instrumentation (think
> > all the k*SAN, KCov, GCov, ftrace etc..) which can call code we're not
> > yet ready to run this early in the entry path, for instance it could
> > rely on RCU which isn't on yet, or expect lockdep state. (by peterz)
> >
> > Link: https://lore.kernel.org/linux-riscv/YxcQ6NoPf3AH0EXe@hirez.progra=
mming.kicks-ass.net/
> > Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Tested-by: Jisheng Zhang <jszhang@kernel.org>
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >   arch/riscv/kernel/traps.c | 4 ++--
> >   arch/riscv/mm/fault.c     | 2 +-
> >   2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> > index 549bde5c970a..96ec76c54ff2 100644
> > --- a/arch/riscv/kernel/traps.c
> > +++ b/arch/riscv/kernel/traps.c
> > @@ -95,9 +95,9 @@ static void do_trap_error(struct pt_regs *regs, int s=
igno, int code,
> >   }
> >
> >   #if defined(CONFIG_XIP_KERNEL) && defined(CONFIG_RISCV_ALTERNATIVE)
> > -#define __trap_section               __section(".xip.traps")
> > +#define __trap_section __noinstr_section(".xip.traps")
> >   #else
> > -#define __trap_section
> > +#define __trap_section noinstr
> >   #endif
> >   #define DO_ERROR_INFO(name, signo, code, str)                        =
       \
> >   asmlinkage __visible __trap_section void name(struct pt_regs *regs) \
> > diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> > index d86f7cebd4a7..b26f68eac61c 100644
> > --- a/arch/riscv/mm/fault.c
> > +++ b/arch/riscv/mm/fault.c
> > @@ -204,7 +204,7 @@ static inline bool access_error(unsigned long cause=
, struct vm_area_struct *vma)
> >    * This routine handles page faults.  It determines the address and t=
he
> >    * problem, and then passes it off to one of the appropriate routines=
.
> >    */
> > -asmlinkage void do_page_fault(struct pt_regs *regs)
> > +asmlinkage void noinstr do_page_fault(struct pt_regs *regs)
>
>
> (I dug the archive but can't find the series before v4, so sorry if it
> was already answered)
>
> I think we should not disable the instrumentation of those trap handlers
> as at least profiling them with ftrace would provide valuable
> information (and gcov would be nice too): why do we need to do that? A
> trap very early in the boot process is not recoverable anyway.
Everything that calls irqentry_enter() should be noinstr, and this
patch prepares for the next generic_entry convert.

eg:
asmlinkage void noinstr do_page_fault(struct pt_regs *regs)
{
        irqentry_state_t state =3D irqentry_enter(regs);

        __do_page_fault(regs);

        local_irq_disable();

        irqentry_exit(regs, state);
}
NOKPROBE_SYMBOL(do_page_fault);

You still could profile __do_page_fault.

>
> And I took a look at other architectures, none of them disables the
> instrumentation on do_page_fault.
That's not true, have a look at power & arm64. All of them have some
limitations at the entry of page_fault.

>
>
> >   {
> >       struct task_struct *tsk;
> >       struct vm_area_struct *vma;



--=20
Best Regards
 Guo Ren
