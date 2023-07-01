Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18085744642
	for <lists+linux-arch@lfdr.de>; Sat,  1 Jul 2023 05:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjGAD3e (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Jun 2023 23:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjGAD2m (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Jun 2023 23:28:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9834C1E;
        Fri, 30 Jun 2023 20:09:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4DB361773;
        Sat,  1 Jul 2023 03:09:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52583C433A9;
        Sat,  1 Jul 2023 03:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688180942;
        bh=B9uVkh2FBAejbkYUU+d5ex3inwdGhCFabRxGMeuCGuY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EJ0NOyXI0wNMtn2/f92GNb4U3PuP/MEzJmjuDI0hkMTVxnIZCfgeE/pnA2sAZ/I7Z
         OlWB2rt/Kpekb7UBduToerCpQ9gjE6c/YHEarkwaZUVEHddhfUjt4p6Z8D66kbnjgM
         HgX+w5YVXD9UF6GXScD0hoT4vf6eebegXMUYn8j2RoVb5LqK7xryIg0y0eKcOIb1dA
         +i4Wc1opBWemqy42bF8U5ASuzRi21fMu5jGhquEvYmm0b1itH651ORzeAuAM54IZEe
         sHQgYUbyL5IR7fU0JFkuYDfREy1bzfedl/hX9JZV50V2+m4eFzfNixiuhnggRk4O4f
         vIcJbYj8VoGYA==
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3fbc5d5746cso18536185e9.2;
        Fri, 30 Jun 2023 20:09:02 -0700 (PDT)
X-Gm-Message-State: AC+VfDxMxMLnhIHy0oGxgozmQwZfkAoApZ1ukKs5KdupDepBvvguQDqI
        5qg+LEGT/O7Y6zyeEj1AE46fRlW5pgv3Mr7lVdY=
X-Google-Smtp-Source: ACHHUZ76wZgajpynilm5T+AB+f+oOx1KyK+DGWIvzvw2g/n2gPNI+xs8KCvbavx1y7qhQb46AwKb4Vsndfj2lM4aFbw=
X-Received: by 2002:a1c:f318:0:b0:3fb:b008:2003 with SMTP id
 q24-20020a1cf318000000b003fbb0082003mr3385081wmq.38.1688180940472; Fri, 30
 Jun 2023 20:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230222033021.983168-1-guoren@kernel.org> <20230222033021.983168-5-guoren@kernel.org>
 <ZJ2PBosSQtSX28Mf@wychelm> <CAJF2gTRPYDxDpia=o6oqbt_8_5hqAQk-pwY1uPwUjcxCFg1EPw@mail.gmail.com>
 <CAJF2gTTRViivgy3njDc1k7A-jaSFUsyo2VPg2JwEAwx=H3mR4w@mail.gmail.com>
 <20230630145056.GB2872423@aspen.lan> <CAJF2gTTRUi8fZnf3Dngpn2e-nZkRV_DbnnLTC+_RxfSastZusQ@mail.gmail.com>
In-Reply-To: <CAJF2gTTRUi8fZnf3Dngpn2e-nZkRV_DbnnLTC+_RxfSastZusQ@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 1 Jul 2023 11:08:48 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSCF2VLcJ5LKe88zhqM4eep-f5kpVoYOQy1TD4ZPQRb+g@mail.gmail.com>
Message-ID: <CAJF2gTSCF2VLcJ5LKe88zhqM4eep-f5kpVoYOQy1TD4ZPQRb+g@mail.gmail.com>
Subject: Re: [PATCH -next V17 4/7] riscv: entry: Convert to generic entry
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
        falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, mark.rutland@arm.com, ben@decadent.org.uk,
        bjorn@kernel.org, palmer@dabbelt.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Yipeng Zou <zouyipeng@huawei.com>,
        Vincent Chen <vincent.chen@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jul 1, 2023 at 10:55=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote:
>
> On Fri, Jun 30, 2023 at 10:51=E2=80=AFPM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > On Fri, Jun 30, 2023 at 07:22:40AM -0400, Guo Ren wrote:
> > > On Fri, Jun 30, 2023 at 7:16=E2=80=AFAM Guo Ren <guoren@kernel.org> w=
rote:
> > > >
> > > > On Thu, Jun 29, 2023 at 10:02=E2=80=AFAM Daniel Thompson
> > > > <daniel.thompson@linaro.org> wrote:
> > > > >
> > > > > On Tue, Feb 21, 2023 at 10:30:18PM -0500, guoren@kernel.org wrote=
:
> > > > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > > > >
> > > > > > This patch converts riscv to use the generic entry infrastructu=
re from
> > > > > > kernel/entry/*. The generic entry makes maintainers' work easie=
r and
> > > > > > codes more elegant. Here are the changes:
> > > > > >
> > > > > >  - More clear entry.S with handle_exception and ret_from_except=
ion
> > > > > >  - Get rid of complex custom signal implementation
> > > > > >  - Move syscall procedure from assembly to C, which is much mor=
e
> > > > > >    readable.
> > > > > >  - Connect ret_from_fork & ret_from_kernel_thread to generic en=
try.
> > > > > >  - Wrap with irqentry_enter/exit and syscall_enter/exit_from_us=
er_mode
> > > > > >  - Use the standard preemption code instead of custom
> > > > > >
> > > > > > Suggested-by: Huacai Chen <chenhuacai@kernel.org>
> > > > > > Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> > > > > > Tested-by: Yipeng Zou <zouyipeng@huawei.com>
> > > > > > Tested-by: Jisheng Zhang <jszhang@kernel.org>
> > > > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > > > Cc: Ben Hutchings <ben@decadent.org.uk>
> > > > >
> > > > > Apologies for the late feedback but I've been swamped lately and =
only
> > > > > recently got round to running the full kgdb test suite on the v6.=
4
> > > > > series.
> > > > >
> > > > > The kgdb test suite includes a couple of tests that verify that t=
he
> > > > > system resumes after breakpointing due to a BUG():
> > > > > https://github.com/daniel-thompson/kgdbtest/blob/master/tests/tes=
t_kdb_fault_injection.py#L24-L45
> > > > >
> > > > > These tests have regressed on riscv between v6.3 and v6.4 and a b=
isect
> > > > > is pointing at this patch. With these changes in place then, afte=
r kdb
> > > > > resumes the system, the BUG() message is printed as normal but th=
en
> > > > > immediately fails. From the backtrace it looks like the new entry=
/exit
> > > > > code cannot advance past a compiled breakpoint instruction:
> > > > > ~~~
> > > > > PANIC: Fatal exception in interrupt
> > > > It comes from:
> > > > void die(struct pt_regs *regs, ...
> > > > {
> > > > ...
> > > > if (in_interrupt())
> > > >         panic("Fatal exception in interrupt");
> > > > ...
> > > >
> > > > We could add a dump_backtrace to see what happened:
> > > > if (in_interrupt()) {
> > > > +      dump_backtrace(regs, NULL, KERN_DEFAULT);
> > > Sorry, it should be:
> > > +        dump_backtrace(NULL, NULL, KERN_DEFAULT);
> > > We need current stack info, not exception context.
> >
> > I added this... and I also stopped kgdb from intercepting the panic()
> > since that interferes with the console output from dump_backtrace().
> >
> > ~~~
> > # /bin/echo BUG > /sys/kernel/debug/provoke-crash/DIRECT
> > [    3.380565] lkdtm: Performing direct entry BUG
> >
> > Entering kdb (current=3D0xff6000000380ab00, pid 98) on processor 0 due =
to NonMaskable Interrupt @ 0xffffffff8064b844
> > kdb> go
> > Catastrophic error detected
> > kdb_continue_catastrophic=3D0, type go a second time if you really want=
 to continue
> > kdb> go
> > Catastrophic error detected
> > kdb_continue_catastrophic=3D0, attempting to continue
> > [    3.381411] ------------[ cut here ]------------
> > [    3.381454] kernel BUG at drivers/misc/lkdtm/bugs.c:78!
> > [    3.381609] Kernel BUG [#1]
> > [    3.381632] Modules linked in:
> > [    3.381734] CPU: 0 PID: 98 Comm: echo Not tainted 6.4.0-rc6-00004-ge=
6e9d4598760-dirty #126
> > [    3.381817] Hardware name: riscv-virtio,qemu (DT)
> > [    3.381885] epc : lkdtm_BUG+0x6/0x8
> > [    3.381959]  ra : lkdtm_do_action+0x10/0x1c
> > [    3.381978] epc : ffffffff8064b844 ra : ffffffff8064afb4 sp : ff2000=
00008c3d30
> > [    3.381991]  gp : ffffffff810665a0 tp : ff6000000380ab00 t0 : 650000=
0000000000
> > [    3.382002]  t1 : 0000000000000001 t2 : 6550203a6d74646b s0 : ff2000=
00008c3d40
> > [    3.382012]  s1 : ff60000003988000 a0 : ffffffff80fc0260 a1 : ff6000=
003ffad788
> > [    3.382023]  a2 : ff6000003ffb9530 a3 : 0000000000000000 a4 : 000000=
0000000000
> > [    3.382034]  a5 : ffffffff8064b83e a6 : 0000000000000050 a7 : 000000=
0000040000
> > [    3.382045]  s2 : 0000000000000004 s3 : ffffffff80fc0260 s4 : ff2000=
00008c3e70
> > [    3.382056]  s5 : ff600000033223a8 s6 : 00000000000f0cc0 s7 : ff6000=
0002211000
> > [    3.382066]  s8 : 00ffffffafc50c08 s9 : 00ffffffafc4b9b8 s10: 000000=
0000000000
> > [    3.382077]  s11: 0000000000000001 t3 : 461f715700000000 t4 : 000000=
0000000002
> > [    3.382087]  t5 : 0000000000000000 t6 : ff200000008c3b58
> > [    3.382097] status: 0000000200000120 badaddr: 0000000000000000 cause=
: 0000000000000003
> > [    3.382139] [<ffffffff8064b844>] lkdtm_BUG+0x6/0x8
> > [    3.382245] Code: 0513 9245 b097 0039 80e7 7f20 bf39 1141 e422 0800 =
(9002) 1141
> > [    3.594697] ---[ end trace 0000000000000000 ]---
> >
> > At this point we expect a shell prompt since we should have taken the B=
UG(),
> > killed the echo process and returned to the shell. However in v6.4 we g=
et the
> > following instead (including the instrumentation you asked for):
>
> After comparing with arm64, I found that arm64 uses spinlock_irq to
> protect the in_interrupt(). I think this would make in_interrupt() =3D
> 0.
>
> So how about trying:
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 5158961ea977..0ac914a99ee3 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -82,13 +82,15 @@ void die(struct pt_regs *regs, const char *str)
>
>         bust_spinlocks(0);
>         add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
> -       spin_unlock_irqrestore(&die_lock, flags);
>         oops_exit();
>
>         if (in_interrupt())
>                 panic("Fatal exception in interrupt");
>         if (panic_on_oops)
>                 panic("Fatal exception");
> +
> +       spin_unlock_irqrestore(&die_lock, flags);
En... It seems it's not correct, how can I reproduce your environment
on qemu? Sorry, I'm not familiar with kgdb.

> +
>         if (ret !=3D NOTIFY_STOP)
>                 make_task_dead(SIGSEGV);
>  }
>
> >
> > [    3.594801] [<ffffffff80005e3a>] dump_backtrace+0x1c/0x24
> > [    3.594826] [<ffffffff800059f0>] die+0x228/0x238
> > [    3.594835] [<ffffffff80005b38>] handle_break+0x9a/0xe0
> > [    3.594843] [<ffffffff809f30d6>] do_trap_break+0x48/0x5c
> > [    3.594854] [<ffffffff80003ee4>] ret_from_exception+0x0/0x64
> > [    3.594862] [<ffffffff8064b844>] lkdtm_BUG+0x6/0x8
> > [    3.594959] Kernel panic - not syncing: Fatal exception in interrupt
> > [    3.595005] SMP: stopping secondary CPUs
> > [    3.596444] ---[ end Kernel panic - not syncing: Fatal exception in =
interrupt ]---
> > ~~~
> >
> >
> > Daniel.
>
>
>
> --
> Best Regards
>  Guo Ren



--=20
Best Regards
 Guo Ren
