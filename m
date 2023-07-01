Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47EF744630
	for <lists+linux-arch@lfdr.de>; Sat,  1 Jul 2023 05:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjGAD0t (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Jun 2023 23:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGAD0r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Jun 2023 23:26:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B1846B2;
        Fri, 30 Jun 2023 19:55:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A3356181E;
        Sat,  1 Jul 2023 02:55:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0CFC433A9;
        Sat,  1 Jul 2023 02:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688180144;
        bh=MGyC+sqq+v2EogtxB0k4HSiexaPOuJIVLpjdNbhnLCg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h7Z6jlWTDW/UlkMXQerc4HVJBF0UIAZyQxNMv5/tntmMWmh91KHoL76am1eJc4tcV
         FZ1lFf5gtaNimZcm+9EvqtYjSfuqSKdSr9MUn7TC7JG7DgnmJjTeROKknwzd92d4Jr
         BoIGYfsUgkfrmZT8rKAK9dX4cw2Y7Wv3HpXDXxZRtVz7cJft2/j2RfszA/NWxPj/71
         xcP6b8q7EDbpDb7ekifi9Kx2BGSo7BMrFRKNjRKp7N05NHOEAPMXen81/gmsa+5rnn
         rf/IqlFLsXhyrA4jIvZSzp6EIqG4IFgRZD2gehb+NjTXz5ZLCXrOoPKlcJW+CGTO4z
         AYN66A9ZuMgLA==
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3fbc63c307fso16068795e9.1;
        Fri, 30 Jun 2023 19:55:44 -0700 (PDT)
X-Gm-Message-State: AC+VfDxUiPIE+CP0ji9Xx6goa8BeUcKTwEFDMMVhpagOH/qg/vFgTlGT
        Y8vwvohAHI13lI8U1ivY4A9ZLfNwIq+1vKJzLMA=
X-Google-Smtp-Source: ACHHUZ7cBYrCdsbWyzpPDlewHhFU+6pAeRB0CTjG5HhYU3U59jRGZ9WH7gMLnchr2LSNIdSftDszb8t5Xc5/ow77UsU=
X-Received: by 2002:a05:600c:218f:b0:3fa:a6ce:54ad with SMTP id
 e15-20020a05600c218f00b003faa6ce54admr3406973wme.6.1688180142759; Fri, 30 Jun
 2023 19:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230222033021.983168-1-guoren@kernel.org> <20230222033021.983168-5-guoren@kernel.org>
 <ZJ2PBosSQtSX28Mf@wychelm> <CAJF2gTRPYDxDpia=o6oqbt_8_5hqAQk-pwY1uPwUjcxCFg1EPw@mail.gmail.com>
 <CAJF2gTTRViivgy3njDc1k7A-jaSFUsyo2VPg2JwEAwx=H3mR4w@mail.gmail.com> <20230630145056.GB2872423@aspen.lan>
In-Reply-To: <20230630145056.GB2872423@aspen.lan>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 1 Jul 2023 10:55:31 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTRUi8fZnf3Dngpn2e-nZkRV_DbnnLTC+_RxfSastZusQ@mail.gmail.com>
Message-ID: <CAJF2gTTRUi8fZnf3Dngpn2e-nZkRV_DbnnLTC+_RxfSastZusQ@mail.gmail.com>
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

On Fri, Jun 30, 2023 at 10:51=E2=80=AFPM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Fri, Jun 30, 2023 at 07:22:40AM -0400, Guo Ren wrote:
> > On Fri, Jun 30, 2023 at 7:16=E2=80=AFAM Guo Ren <guoren@kernel.org> wro=
te:
> > >
> > > On Thu, Jun 29, 2023 at 10:02=E2=80=AFAM Daniel Thompson
> > > <daniel.thompson@linaro.org> wrote:
> > > >
> > > > On Tue, Feb 21, 2023 at 10:30:18PM -0500, guoren@kernel.org wrote:
> > > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > > >
> > > > > This patch converts riscv to use the generic entry infrastructure=
 from
> > > > > kernel/entry/*. The generic entry makes maintainers' work easier =
and
> > > > > codes more elegant. Here are the changes:
> > > > >
> > > > >  - More clear entry.S with handle_exception and ret_from_exceptio=
n
> > > > >  - Get rid of complex custom signal implementation
> > > > >  - Move syscall procedure from assembly to C, which is much more
> > > > >    readable.
> > > > >  - Connect ret_from_fork & ret_from_kernel_thread to generic entr=
y.
> > > > >  - Wrap with irqentry_enter/exit and syscall_enter/exit_from_user=
_mode
> > > > >  - Use the standard preemption code instead of custom
> > > > >
> > > > > Suggested-by: Huacai Chen <chenhuacai@kernel.org>
> > > > > Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> > > > > Tested-by: Yipeng Zou <zouyipeng@huawei.com>
> > > > > Tested-by: Jisheng Zhang <jszhang@kernel.org>
> > > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > > Cc: Ben Hutchings <ben@decadent.org.uk>
> > > >
> > > > Apologies for the late feedback but I've been swamped lately and on=
ly
> > > > recently got round to running the full kgdb test suite on the v6.4
> > > > series.
> > > >
> > > > The kgdb test suite includes a couple of tests that verify that the
> > > > system resumes after breakpointing due to a BUG():
> > > > https://github.com/daniel-thompson/kgdbtest/blob/master/tests/test_=
kdb_fault_injection.py#L24-L45
> > > >
> > > > These tests have regressed on riscv between v6.3 and v6.4 and a bis=
ect
> > > > is pointing at this patch. With these changes in place then, after =
kdb
> > > > resumes the system, the BUG() message is printed as normal but then
> > > > immediately fails. From the backtrace it looks like the new entry/e=
xit
> > > > code cannot advance past a compiled breakpoint instruction:
> > > > ~~~
> > > > PANIC: Fatal exception in interrupt
> > > It comes from:
> > > void die(struct pt_regs *regs, ...
> > > {
> > > ...
> > > if (in_interrupt())
> > >         panic("Fatal exception in interrupt");
> > > ...
> > >
> > > We could add a dump_backtrace to see what happened:
> > > if (in_interrupt()) {
> > > +      dump_backtrace(regs, NULL, KERN_DEFAULT);
> > Sorry, it should be:
> > +        dump_backtrace(NULL, NULL, KERN_DEFAULT);
> > We need current stack info, not exception context.
>
> I added this... and I also stopped kgdb from intercepting the panic()
> since that interferes with the console output from dump_backtrace().
>
> ~~~
> # /bin/echo BUG > /sys/kernel/debug/provoke-crash/DIRECT
> [    3.380565] lkdtm: Performing direct entry BUG
>
> Entering kdb (current=3D0xff6000000380ab00, pid 98) on processor 0 due to=
 NonMaskable Interrupt @ 0xffffffff8064b844
> kdb> go
> Catastrophic error detected
> kdb_continue_catastrophic=3D0, type go a second time if you really want t=
o continue
> kdb> go
> Catastrophic error detected
> kdb_continue_catastrophic=3D0, attempting to continue
> [    3.381411] ------------[ cut here ]------------
> [    3.381454] kernel BUG at drivers/misc/lkdtm/bugs.c:78!
> [    3.381609] Kernel BUG [#1]
> [    3.381632] Modules linked in:
> [    3.381734] CPU: 0 PID: 98 Comm: echo Not tainted 6.4.0-rc6-00004-ge6e=
9d4598760-dirty #126
> [    3.381817] Hardware name: riscv-virtio,qemu (DT)
> [    3.381885] epc : lkdtm_BUG+0x6/0x8
> [    3.381959]  ra : lkdtm_do_action+0x10/0x1c
> [    3.381978] epc : ffffffff8064b844 ra : ffffffff8064afb4 sp : ff200000=
008c3d30
> [    3.381991]  gp : ffffffff810665a0 tp : ff6000000380ab00 t0 : 65000000=
00000000
> [    3.382002]  t1 : 0000000000000001 t2 : 6550203a6d74646b s0 : ff200000=
008c3d40
> [    3.382012]  s1 : ff60000003988000 a0 : ffffffff80fc0260 a1 : ff600000=
3ffad788
> [    3.382023]  a2 : ff6000003ffb9530 a3 : 0000000000000000 a4 : 00000000=
00000000
> [    3.382034]  a5 : ffffffff8064b83e a6 : 0000000000000050 a7 : 00000000=
00040000
> [    3.382045]  s2 : 0000000000000004 s3 : ffffffff80fc0260 s4 : ff200000=
008c3e70
> [    3.382056]  s5 : ff600000033223a8 s6 : 00000000000f0cc0 s7 : ff600000=
02211000
> [    3.382066]  s8 : 00ffffffafc50c08 s9 : 00ffffffafc4b9b8 s10: 00000000=
00000000
> [    3.382077]  s11: 0000000000000001 t3 : 461f715700000000 t4 : 00000000=
00000002
> [    3.382087]  t5 : 0000000000000000 t6 : ff200000008c3b58
> [    3.382097] status: 0000000200000120 badaddr: 0000000000000000 cause: =
0000000000000003
> [    3.382139] [<ffffffff8064b844>] lkdtm_BUG+0x6/0x8
> [    3.382245] Code: 0513 9245 b097 0039 80e7 7f20 bf39 1141 e422 0800 (9=
002) 1141
> [    3.594697] ---[ end trace 0000000000000000 ]---
>
> At this point we expect a shell prompt since we should have taken the BUG=
(),
> killed the echo process and returned to the shell. However in v6.4 we get=
 the
> following instead (including the instrumentation you asked for):

After comparing with arm64, I found that arm64 uses spinlock_irq to
protect the in_interrupt(). I think this would make in_interrupt() =3D
0.

So how about trying:

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 5158961ea977..0ac914a99ee3 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -82,13 +82,15 @@ void die(struct pt_regs *regs, const char *str)

        bust_spinlocks(0);
        add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
-       spin_unlock_irqrestore(&die_lock, flags);
        oops_exit();

        if (in_interrupt())
                panic("Fatal exception in interrupt");
        if (panic_on_oops)
                panic("Fatal exception");
+
+       spin_unlock_irqrestore(&die_lock, flags);
+
        if (ret !=3D NOTIFY_STOP)
                make_task_dead(SIGSEGV);
 }

>
> [    3.594801] [<ffffffff80005e3a>] dump_backtrace+0x1c/0x24
> [    3.594826] [<ffffffff800059f0>] die+0x228/0x238
> [    3.594835] [<ffffffff80005b38>] handle_break+0x9a/0xe0
> [    3.594843] [<ffffffff809f30d6>] do_trap_break+0x48/0x5c
> [    3.594854] [<ffffffff80003ee4>] ret_from_exception+0x0/0x64
> [    3.594862] [<ffffffff8064b844>] lkdtm_BUG+0x6/0x8
> [    3.594959] Kernel panic - not syncing: Fatal exception in interrupt
> [    3.595005] SMP: stopping secondary CPUs
> [    3.596444] ---[ end Kernel panic - not syncing: Fatal exception in in=
terrupt ]---
> ~~~
>
>
> Daniel.



--=20
Best Regards
 Guo Ren
