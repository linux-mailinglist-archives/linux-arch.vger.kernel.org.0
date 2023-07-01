Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDEA74467F
	for <lists+linux-arch@lfdr.de>; Sat,  1 Jul 2023 06:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjGAEWq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 1 Jul 2023 00:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGAEWp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 1 Jul 2023 00:22:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A3392;
        Fri, 30 Jun 2023 21:22:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D96860BA3;
        Sat,  1 Jul 2023 04:22:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB378C433AB;
        Sat,  1 Jul 2023 04:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688185362;
        bh=OhwUqoyM7mX3bYtml9angbmaZJYkLz9FzOREfaGSs9I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZaMy+vIA11WCprcXudYnjh9+un7sykXtX5ozWVWwS0nIQCcgLoG3PruJnKndj1Rnr
         7lZ8845daNjhrZsxCHHFqHsxnGHvr8DKtIIGsAVe4DdAjNoYn/GiW7BdgCahVrCGob
         7I/0zglT7vgDD2sJ/Qa8r4KDAwbVmIJRdLGbuC4hFfHBQlO+2tJ7cZ5yTGDj12n1PJ
         qQttRztGr/lFvhOHJ14Y5fm/EON5SXffQc/jyjAy5oCjn1NhIS0QOeyIComPNprFNF
         bWO114ftYshYeEX46mQulYcMrl239qs+fB0UXvpN6Bq/5SmpycySFxLiNvyk0ku2Gm
         uCPBfLnO+uR3A==
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3fba5a8af2cso26894625e9.3;
        Fri, 30 Jun 2023 21:22:42 -0700 (PDT)
X-Gm-Message-State: AC+VfDzaJ3TmZvIA+zp/YU3NDYAwT3c0ImuEkkYLTEF4H5wNUAvBzCzb
        t/hvYXzBHEGtRHZWiHLpiC0KyVDx7/gjm4YcZRY=
X-Google-Smtp-Source: ACHHUZ4JP/s3W2hQJU+1B0lGCIyu++ARD9uIeLUETBd7DkYJM9Z3qI3vYHcLC2GazMNMY28myOXE6DLRb/2l2+lXAW8=
X-Received: by 2002:a05:600c:204b:b0:3fb:c217:722e with SMTP id
 p11-20020a05600c204b00b003fbc217722emr2993267wmg.33.1688185360740; Fri, 30
 Jun 2023 21:22:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230222033021.983168-1-guoren@kernel.org> <20230222033021.983168-5-guoren@kernel.org>
 <ZJ2PBosSQtSX28Mf@wychelm> <CAJF2gTRPYDxDpia=o6oqbt_8_5hqAQk-pwY1uPwUjcxCFg1EPw@mail.gmail.com>
 <CAJF2gTTRViivgy3njDc1k7A-jaSFUsyo2VPg2JwEAwx=H3mR4w@mail.gmail.com>
 <20230630145056.GB2872423@aspen.lan> <CAJF2gTTRUi8fZnf3Dngpn2e-nZkRV_DbnnLTC+_RxfSastZusQ@mail.gmail.com>
 <CAJF2gTSCF2VLcJ5LKe88zhqM4eep-f5kpVoYOQy1TD4ZPQRb+g@mail.gmail.com>
In-Reply-To: <CAJF2gTSCF2VLcJ5LKe88zhqM4eep-f5kpVoYOQy1TD4ZPQRb+g@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 1 Jul 2023 12:22:28 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSsPMCKO-Lmc=87wqRZ_05aK8Oj78kk3vjmeNBT2c_jJg@mail.gmail.com>
Message-ID: <CAJF2gTSsPMCKO-Lmc=87wqRZ_05aK8Oj78kk3vjmeNBT2c_jJg@mail.gmail.com>
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jul 1, 2023 at 11:08=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote:
>
> On Sat, Jul 1, 2023 at 10:55=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote=
:
> >
> > On Fri, Jun 30, 2023 at 10:51=E2=80=AFPM Daniel Thompson
> > <daniel.thompson@linaro.org> wrote:
> > >
> > > On Fri, Jun 30, 2023 at 07:22:40AM -0400, Guo Ren wrote:
> > > > On Fri, Jun 30, 2023 at 7:16=E2=80=AFAM Guo Ren <guoren@kernel.org>=
 wrote:
> > > > >
> > > > > On Thu, Jun 29, 2023 at 10:02=E2=80=AFAM Daniel Thompson
> > > > > <daniel.thompson@linaro.org> wrote:
> > > > > >
> > > > > > On Tue, Feb 21, 2023 at 10:30:18PM -0500, guoren@kernel.org wro=
te:
> > > > > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > > > > >
> > > > > > > This patch converts riscv to use the generic entry infrastruc=
ture from
> > > > > > > kernel/entry/*. The generic entry makes maintainers' work eas=
ier and
> > > > > > > codes more elegant. Here are the changes:
> > > > > > >
> > > > > > >  - More clear entry.S with handle_exception and ret_from_exce=
ption
> > > > > > >  - Get rid of complex custom signal implementation
> > > > > > >  - Move syscall procedure from assembly to C, which is much m=
ore
> > > > > > >    readable.
> > > > > > >  - Connect ret_from_fork & ret_from_kernel_thread to generic =
entry.
> > > > > > >  - Wrap with irqentry_enter/exit and syscall_enter/exit_from_=
user_mode
> > > > > > >  - Use the standard preemption code instead of custom
> > > > > > >
> > > > > > > Suggested-by: Huacai Chen <chenhuacai@kernel.org>
> > > > > > > Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> > > > > > > Tested-by: Yipeng Zou <zouyipeng@huawei.com>
> > > > > > > Tested-by: Jisheng Zhang <jszhang@kernel.org>
> > > > > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > > > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > > > > Cc: Ben Hutchings <ben@decadent.org.uk>
> > > > > >
> > > > > > Apologies for the late feedback but I've been swamped lately an=
d only
> > > > > > recently got round to running the full kgdb test suite on the v=
6.4
> > > > > > series.
> > > > > >
> > > > > > The kgdb test suite includes a couple of tests that verify that=
 the
> > > > > > system resumes after breakpointing due to a BUG():
> > > > > > https://github.com/daniel-thompson/kgdbtest/blob/master/tests/t=
est_kdb_fault_injection.py#L24-L45
> > > > > >
> > > > > > These tests have regressed on riscv between v6.3 and v6.4 and a=
 bisect
> > > > > > is pointing at this patch. With these changes in place then, af=
ter kdb
> > > > > > resumes the system, the BUG() message is printed as normal but =
then
> > > > > > immediately fails. From the backtrace it looks like the new ent=
ry/exit
> > > > > > code cannot advance past a compiled breakpoint instruction:
> > > > > > ~~~
> > > > > > PANIC: Fatal exception in interrupt
> > > > > It comes from:
> > > > > void die(struct pt_regs *regs, ...
> > > > > {
> > > > > ...
> > > > > if (in_interrupt())
> > > > >         panic("Fatal exception in interrupt");
> > > > > ...
> > > > >
> > > > > We could add a dump_backtrace to see what happened:
> > > > > if (in_interrupt()) {
> > > > > +      dump_backtrace(regs, NULL, KERN_DEFAULT);
> > > > Sorry, it should be:
> > > > +        dump_backtrace(NULL, NULL, KERN_DEFAULT);
> > > > We need current stack info, not exception context.
> > >
> > > I added this... and I also stopped kgdb from intercepting the panic()
> > > since that interferes with the console output from dump_backtrace().
> > >
> > > ~~~
> > > # /bin/echo BUG > /sys/kernel/debug/provoke-crash/DIRECT
> > > [    3.380565] lkdtm: Performing direct entry BUG
> > >
> > > Entering kdb (current=3D0xff6000000380ab00, pid 98) on processor 0 du=
e to NonMaskable Interrupt @ 0xffffffff8064b844
> > > kdb> go
> > > Catastrophic error detected
> > > kdb_continue_catastrophic=3D0, type go a second time if you really wa=
nt to continue
> > > kdb> go
> > > Catastrophic error detected
> > > kdb_continue_catastrophic=3D0, attempting to continue
> > > [    3.381411] ------------[ cut here ]------------
> > > [    3.381454] kernel BUG at drivers/misc/lkdtm/bugs.c:78!
> > > [    3.381609] Kernel BUG [#1]
> > > [    3.381632] Modules linked in:
> > > [    3.381734] CPU: 0 PID: 98 Comm: echo Not tainted 6.4.0-rc6-00004-=
ge6e9d4598760-dirty #126
> > > [    3.381817] Hardware name: riscv-virtio,qemu (DT)
> > > [    3.381885] epc : lkdtm_BUG+0x6/0x8
> > > [    3.381959]  ra : lkdtm_do_action+0x10/0x1c
> > > [    3.381978] epc : ffffffff8064b844 ra : ffffffff8064afb4 sp : ff20=
0000008c3d30
> > > [    3.381991]  gp : ffffffff810665a0 tp : ff6000000380ab00 t0 : 6500=
000000000000
> > > [    3.382002]  t1 : 0000000000000001 t2 : 6550203a6d74646b s0 : ff20=
0000008c3d40
> > > [    3.382012]  s1 : ff60000003988000 a0 : ffffffff80fc0260 a1 : ff60=
00003ffad788
> > > [    3.382023]  a2 : ff6000003ffb9530 a3 : 0000000000000000 a4 : 0000=
000000000000
> > > [    3.382034]  a5 : ffffffff8064b83e a6 : 0000000000000050 a7 : 0000=
000000040000
> > > [    3.382045]  s2 : 0000000000000004 s3 : ffffffff80fc0260 s4 : ff20=
0000008c3e70
> > > [    3.382056]  s5 : ff600000033223a8 s6 : 00000000000f0cc0 s7 : ff60=
000002211000
> > > [    3.382066]  s8 : 00ffffffafc50c08 s9 : 00ffffffafc4b9b8 s10: 0000=
000000000000
> > > [    3.382077]  s11: 0000000000000001 t3 : 461f715700000000 t4 : 0000=
000000000002
> > > [    3.382087]  t5 : 0000000000000000 t6 : ff200000008c3b58
> > > [    3.382097] status: 0000000200000120 badaddr: 0000000000000000 cau=
se: 0000000000000003
> > > [    3.382139] [<ffffffff8064b844>] lkdtm_BUG+0x6/0x8
> > > [    3.382245] Code: 0513 9245 b097 0039 80e7 7f20 bf39 1141 e422 080=
0 (9002) 1141
> > > [    3.594697] ---[ end trace 0000000000000000 ]---
> > >
> > > At this point we expect a shell prompt since we should have taken the=
 BUG(),
> > > killed the echo process and returned to the shell. However in v6.4 we=
 get the
> > > following instead (including the instrumentation you asked for):
> >
> > After comparing with arm64, I found that arm64 uses spinlock_irq to
> > protect the in_interrupt(). I think this would make in_interrupt() =3D
> > 0.
> >
> > So how about trying:
> >
> > diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> > index 5158961ea977..0ac914a99ee3 100644
> > --- a/arch/riscv/kernel/traps.c
> > +++ b/arch/riscv/kernel/traps.c
> > @@ -82,13 +82,15 @@ void die(struct pt_regs *regs, const char *str)
> >
> >         bust_spinlocks(0);
> >         add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
> > -       spin_unlock_irqrestore(&die_lock, flags);
> >         oops_exit();
> >
> >         if (in_interrupt())
> >                 panic("Fatal exception in interrupt");
> >         if (panic_on_oops)
> >                 panic("Fatal exception");
> > +
> > +       spin_unlock_irqrestore(&die_lock, flags);
> En... It seems it's not correct, how can I reproduce your environment
> on qemu? Sorry, I'm not familiar with kgdb.

I got it:
Normal is:
# mount -t debugfs none /sys/kernel/debug/
# /bin/echo BUG > /sys/kernel/debug/provoke-crash/DIRECT
[    8.948041] lkdtm: Performing direct entry BUG
[    8.949228] ------------[ cut here ]------------
[    8.949640] kernel BUG at drivers/misc/lkdtm/bugs.c:78!
[    8.950534] Kernel BUG [#1]
[    8.950944] Modules linked in:
[    8.951805] CPU: 0 PID: 106 Comm: echo Not tainted
6.3.0-rc2-00295-gb4e5219985e8 #22
[    8.952831] Hardware name: riscv-virtio,qemu (DT)
[    8.953587] epc : lkdtm_BUG+0x6/0x8
[    8.954232]  ra : lkdtm_do_action+0x14/0x1c
[    8.954713] epc : ffffffff805549e2 ra : ffffffff8087245c sp :
ff2000000081bd60
[    8.955378]  gp : ffffffff814ffec0 tp : ff600000023c8000 t0 :
6500000000000000
[    8.956029]  t1 : 000000000000006c t2 : 6550203a6d74646b s0 :
ff2000000081bd70
[    8.956699]  s1 : ffffffff814bee50 a0 : ffffffff814bee50 a1 :
ff6000001fbd8608
[    8.957381]  a2 : ff6000001fbdb868 a3 : 0000000000000000 a4 :
0000000000000000
[    8.958035]  a5 : ffffffff805549dc a6 : 0000000000000032 a7 :
0000000000000038
[    8.958708]  s2 : 0000000000000004 s3 : 00000000556371a0 s4 :
ff2000000081be90
[    8.959397]  s5 : ff60000001c90000 s6 : 00000000556371a0 s7 :
0000000000000030
[    8.960053]  s8 : 000000007fffec78 s9 : 0000000000000007 s10:
0000000055637480
[    8.960717]  s11: 0000000000000001 t3 : ffffffff81512e97 t4 :
ffffffff81512e97
[    8.961379]  t5 : ffffffff81512e98 t6 : ff2000000081bba8
[    8.961888] status: 0000000100000120 badaddr: 0000000000000000
cause: 0000000000000003
[    8.962923] [<ffffffff805549e2>] lkdtm_BUG+0x6/0x8
[    8.964194] Code: 0513 d665 7097 0031 80e7 f000 b705 1141 e422 0800
(9002) 1141
[    8.965847] ---[ end trace 0000000000000000 ]---
[    8.966637] note: echo[106] exited with irqs disabled
Segmentation fault
#

After generic_entry:
# mount -t debugfs none /sys/kernel/debug/
# /bin/echo BUG > /sys/kernel/debug/provoke-crash/DIRECT
[    8.152247] lkdtm: Performing direct entry BUG
[    8.153652] ------------[ cut here ]------------
[    8.153825] kernel BUG at drivers/misc/lkdtm/bugs.c:78!
[    8.154341] Kernel BUG [#1]
[    8.154440] Modules linked in:
[    8.154918] CPU: 0 PID: 106 Comm: echo Not tainted
6.4.0-rc1-00055-g0ca05a4b079f #21
[    8.155301] Hardware name: riscv-virtio,qemu (DT)
[    8.155581] epc : lkdtm_BUG+0x6/0x8
[    8.155880]  ra : lkdtm_do_action+0x14/0x1c
[    8.155977] epc : ffffffff8059d4b4 ra : ffffffff808c1a84 sp :
ff2000000081bd40
[    8.156030]  gp : ffffffff81503c08 tp : ff600000028ebac0 t0 :
6500000000000000
[    8.156079]  t1 : 000000000000006c t2 : 6550203a6d74646b s0 :
ff2000000081bd50
[    8.156144]  s1 : ffffffff814c2e88 a0 : ffffffff814c2e88 a1 :
ff6000001ffd8608
[    8.156193]  a2 : ff6000001ffdb870 a3 : 0000000000000000 a4 :
0000000000000000
[    8.156241]  a5 : ffffffff8059d4ae a6 : 0000000000000032 a7 :
0000000000000038
[    8.156288]  s2 : 0000000000000004 s3 : 00000000556371a0 s4 :
ff2000000081be70
[    8.156335]  s5 : ff60000002090000 s6 : 00000000556371a0 s7 :
0000000000000030
[    8.156382]  s8 : 000000007fffec78 s9 : 0000000000000007 s10:
0000000055637480
[    8.156428]  s11: 0000000000000001 t3 : ffffffff815173d7 t4 :
ffffffff815173d7
[    8.156473]  t5 : ffffffff815173d8 t6 : ff2000000081bb88
[    8.156516] status: 0000000100000120 badaddr: 0000000000000000
cause: 0000000000000003
[    8.156830] [<ffffffff8059d4b4>] lkdtm_BUG+0x6/0x8
[    8.157630] Code: 0513 1745 d097 0031 80e7 70a0 b705 1141 e422 0800
(9002) 1141
[    8.169646] ---[ end trace 0000000000000000 ]---
[    8.170148] Kernel panic - not syncing: Fatal exception in interrupt
[    8.171839] ---[ end Kernel panic - not syncing: Fatal exception in
interrupt ]---

I'm debugging on it, and soon give the patch.

>
> > +
> >         if (ret !=3D NOTIFY_STOP)
> >                 make_task_dead(SIGSEGV);
> >  }
> >
> > >
> > > [    3.594801] [<ffffffff80005e3a>] dump_backtrace+0x1c/0x24
> > > [    3.594826] [<ffffffff800059f0>] die+0x228/0x238
> > > [    3.594835] [<ffffffff80005b38>] handle_break+0x9a/0xe0
> > > [    3.594843] [<ffffffff809f30d6>] do_trap_break+0x48/0x5c
> > > [    3.594854] [<ffffffff80003ee4>] ret_from_exception+0x0/0x64
> > > [    3.594862] [<ffffffff8064b844>] lkdtm_BUG+0x6/0x8
> > > [    3.594959] Kernel panic - not syncing: Fatal exception in interru=
pt
> > > [    3.595005] SMP: stopping secondary CPUs
> > > [    3.596444] ---[ end Kernel panic - not syncing: Fatal exception i=
n interrupt ]---
> > > ~~~
> > >
> > >
> > > Daniel.
> >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
>
>
>
> --
> Best Regards
>  Guo Ren



--=20
Best Regards
 Guo Ren
