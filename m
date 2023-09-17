Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01B27A35FF
	for <lists+linux-arch@lfdr.de>; Sun, 17 Sep 2023 17:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjIQPDP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 17 Sep 2023 11:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbjIQPDH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 17 Sep 2023 11:03:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE16133;
        Sun, 17 Sep 2023 08:03:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09BCC433B6;
        Sun, 17 Sep 2023 15:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694962980;
        bh=WEoHWxaDL2HV4na9gZ7zlh3s8ucDoEGnuRAGx4E8F/0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Zlg0K/RD4fmIzZki4FsNFddG2P0Keb1IT+6lnHewhXBo/Zd17AIbqGNSg3X35bgKE
         T7g4i5IfpHM22VotVUzlDkZxcExAoos33xeQSOJSQJ6X0UGfv/D5GcOtRhHPiNoz8C
         n9I6SYweYbd3TbB7o5bZR7uXUKNjpO48/pk9EjHVRLKh96dyvb5RyllZXetO1MeHsL
         vG4esOelBCJASh4q/l194pPQmoQJYKy4TwrfGkwcgusqW94YDjpoTjLVfgYaX04Gfg
         jHzY8iDT56FJ7xbJS+TMawmJIRz1CH9P256sqbMl7CnN8OUNYdTZ9OD3NOX0YQ+HYX
         oLp22qsZcp1Ig==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-52e5900cf77so4469125a12.2;
        Sun, 17 Sep 2023 08:03:00 -0700 (PDT)
X-Gm-Message-State: AOJu0YyGhSGkxfXOD79ddpm5ajXS+zyLBqX0lnGkDXzZmir0WcdGHJA6
        Ns/tcwKfuuNlJEur6OqafU+WF7zzX34WQTNF750=
X-Google-Smtp-Source: AGHT+IF86mtNik8Am6q6FkjYByJ/srAqDa79Od4bxYxo/a1eiSzpnmj9oJRSMlaFtJOPeg8/iLC+pF3/1OITJQ0OCfM=
X-Received: by 2002:aa7:d954:0:b0:514:9ab4:3524 with SMTP id
 l20-20020aa7d954000000b005149ab43524mr5176110eds.7.1694962979127; Sun, 17 Sep
 2023 08:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230910082911.3378782-1-guoren@kernel.org> <20230910082911.3378782-6-guoren@kernel.org>
 <ZQIbejhIev5tx6vl@redhat.com> <CAJF2gTSdjgUaUqhkfTPmJg6Mph+8Ej4j8MeDmfBOmFY5gkTpBQ@mail.gmail.com>
 <ZQLVqoCGJ1ExMU3e@redhat.com> <CAJF2gTQWUCLOpKMQsybMoJdZrso2FEbBRVYV+2U1veFC=7U8_A@mail.gmail.com>
 <ZQQe9Fa4IPGDF0_f@redhat.com>
In-Reply-To: <ZQQe9Fa4IPGDF0_f@redhat.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 17 Sep 2023 23:02:47 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTad6HCeE3rpd8+Gr0t9+Ay_4kt3pSjSAE0DaRjM4fJsA@mail.gmail.com>
Message-ID: <CAJF2gTTad6HCeE3rpd8+Gr0t9+Ay_4kt3pSjSAE0DaRjM4fJsA@mail.gmail.com>
Subject: Re: [PATCH V11 05/17] riscv: qspinlock: Add basic queued_spinlock support
To:     Leonardo Bras <leobras@redhat.com>
Cc:     paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, paulmck@kernel.org, rostedt@goodmis.org,
        rdunlap@infradead.org, catalin.marinas@arm.com,
        conor.dooley@microchip.com, xiaoguang.xing@sophgo.com,
        bjorn@rivosinc.com, alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 15, 2023 at 5:08=E2=80=AFPM Leonardo Bras <leobras@redhat.com> =
wrote:
>
> On Fri, Sep 15, 2023 at 10:10:25AM +0800, Guo Ren wrote:
> > On Thu, Sep 14, 2023 at 5:43=E2=80=AFPM Leonardo Bras <leobras@redhat.c=
om> wrote:
> > >
> > > On Thu, Sep 14, 2023 at 12:46:56PM +0800, Guo Ren wrote:
> > > > On Thu, Sep 14, 2023 at 4:29=E2=80=AFAM Leonardo Bras <leobras@redh=
at.com> wrote:
> > > > >
> > > > > On Sun, Sep 10, 2023 at 04:28:59AM -0400, guoren@kernel.org wrote=
:
> > > > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > > > >
> > > > > > The requirements of qspinlock have been documented by commit:
> > > > > > a8ad07e5240c ("asm-generic: qspinlock: Indicate the use of mixe=
d-size
> > > > > > atomics").
> > > > > >
> > > > > > Although RISC-V ISA gives out a weaker forward guarantee LR/SC,=
 which
> > > > > > doesn't satisfy the requirements of qspinlock above, it won't p=
revent
> > > > > > some riscv vendors from implementing a strong fwd guarantee LR/=
SC in
> > > > > > microarchitecture to match xchg_tail requirement. T-HEAD C9xx p=
rocessor
> > > > > > is the one.
> > > > > >
> > > > > > We've tested the patch on SOPHGO sg2042 & th1520 and passed the=
 stress
> > > > > > test on Fedora & Ubuntu & OpenEuler ... Here is the performance
> > > > > > comparison between qspinlock and ticket_lock on sg2042 (64 core=
s):
> > > > > >
> > > > > > sysbench test=3Dthreads threads=3D32 yields=3D100 lock=3D8 (+13=
.8%):
> > > > > >   queued_spinlock 0.5109/0.00
> > > > > >   ticket_spinlock 0.5814/0.00
> > > > > >
> > > > > > perf futex/hash (+6.7%):
> > > > > >   queued_spinlock 1444393 operations/sec (+- 0.09%)
> > > > > >   ticket_spinlock 1353215 operations/sec (+- 0.15%)
> > > > > >
> > > > > > perf futex/wake-parallel (+8.6%):
> > > > > >   queued_spinlock (waking 1/64 threads) in 0.0253 ms (+-2.90%)
> > > > > >   ticket_spinlock (waking 1/64 threads) in 0.0275 ms (+-3.12%)
> > > > > >
> > > > > > perf futex/requeue (+4.2%):
> > > > > >   queued_spinlock Requeued 64 of 64 threads in 0.0785 ms (+-0.5=
5%)
> > > > > >   ticket_spinlock Requeued 64 of 64 threads in 0.0818 ms (+-4.1=
2%)
> > > > > >
> > > > > > System Benchmarks (+6.4%)
> > > > > >   queued_spinlock:
> > > > > >     System Benchmarks Index Values               BASELINE      =
 RESULT    INDEX
> > > > > >     Dhrystone 2 using register variables         116700.0  6286=
13745.4  53865.8
> > > > > >     Double-Precision Whetstone                       55.0     1=
82422.8  33167.8
> > > > > >     Execl Throughput                                 43.0      =
13116.6   3050.4
> > > > > >     File Copy 1024 bufsize 2000 maxblocks          3960.0    77=
62306.2  19601.8
> > > > > >     File Copy 256 bufsize 500 maxblocks            1655.0    34=
17556.8  20649.9
> > > > > >     File Copy 4096 bufsize 8000 maxblocks          5800.0    74=
27995.7  12806.9
> > > > > >     Pipe Throughput                               12440.0   230=
58600.5  18535.9
> > > > > >     Pipe-based Context Switching                   4000.0    28=
35617.7   7089.0
> > > > > >     Process Creation                                126.0      =
12537.3    995.0
> > > > > >     Shell Scripts (1 concurrent)                     42.4      =
57057.4  13456.9
> > > > > >     Shell Scripts (8 concurrent)                      6.0      =
 7367.1  12278.5
> > > > > >     System Call Overhead                          15000.0   333=
08301.3  22205.5
> > > > > >                                                                =
        =3D=3D=3D=3D=3D=3D=3D=3D
> > > > > >     System Benchmarks Index Score                              =
         12426.1
> > > > > >
> > > > > >   ticket_spinlock:
> > > > > >     System Benchmarks Index Values               BASELINE      =
 RESULT    INDEX
> > > > > >     Dhrystone 2 using register variables         116700.0  6265=
41701.9  53688.2
> > > > > >     Double-Precision Whetstone                       55.0     1=
81921.0  33076.5
> > > > > >     Execl Throughput                                 43.0      =
12625.1   2936.1
> > > > > >     File Copy 1024 bufsize 2000 maxblocks          3960.0    65=
53792.9  16550.0
> > > > > >     File Copy 256 bufsize 500 maxblocks            1655.0    31=
89231.6  19270.3
> > > > > >     File Copy 4096 bufsize 8000 maxblocks          5800.0    72=
21277.0  12450.5
> > > > > >     Pipe Throughput                               12440.0   205=
94018.7  16554.7
> > > > > >     Pipe-based Context Switching                   4000.0    25=
71117.7   6427.8
> > > > > >     Process Creation                                126.0      =
10798.4    857.0
> > > > > >     Shell Scripts (1 concurrent)                     42.4      =
57227.5  13497.1
> > > > > >     Shell Scripts (8 concurrent)                      6.0      =
 7329.2  12215.3
> > > > > >     System Call Overhead                          15000.0   307=
66778.4  20511.2
> > > > > >                                                                =
        =3D=3D=3D=3D=3D=3D=3D=3D
> > > > > >     System Benchmarks Index Score                              =
         11670.7
> > > > > >
> > > > > > The qspinlock has a significant improvement on SOPHGO SG2042 64
> > > > > > cores platform than the ticket_lock.
> > > > > >
> > > > > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > > > ---
> > > > > >  arch/riscv/Kconfig                | 16 ++++++++++++++++
> > > > > >  arch/riscv/include/asm/Kbuild     |  3 ++-
> > > > > >  arch/riscv/include/asm/spinlock.h | 17 +++++++++++++++++
> > > > > >  3 files changed, 35 insertions(+), 1 deletion(-)
> > > > > >  create mode 100644 arch/riscv/include/asm/spinlock.h
> > > > > >
> > > > > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > > > > index 2c346fe169c1..7f39bfc75744 100644
> > > > > > --- a/arch/riscv/Kconfig
> > > > > > +++ b/arch/riscv/Kconfig
> > > > > > @@ -471,6 +471,22 @@ config NODES_SHIFT
> > > > > >         Specify the maximum number of NUMA Nodes available on t=
he target
> > > > > >         system.  Increases memory reserved to accommodate vario=
us tables.
> > > > > >
> > > > > > +choice
> > > > > > +     prompt "RISC-V spinlock type"
> > > > > > +     default RISCV_TICKET_SPINLOCKS
> > > > > > +
> > > > > > +config RISCV_TICKET_SPINLOCKS
> > > > > > +     bool "Using ticket spinlock"
> > > > > > +
> > > > > > +config RISCV_QUEUED_SPINLOCKS
> > > > > > +     bool "Using queued spinlock"
> > > > > > +     depends on SMP && MMU
> > > > > > +     select ARCH_USE_QUEUED_SPINLOCKS
> > > > > > +     help
> > > > > > +       Make sure your micro arch LL/SC has a strong forward pr=
ogress guarantee.
> > > > > > +       Otherwise, stay at ticket-lock.
> > > > > > +endchoice
> > > > > > +
> > > > > >  config RISCV_ALTERNATIVE
> > > > > >       bool
> > > > > >       depends on !XIP_KERNEL
> > > > > > diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include=
/asm/Kbuild
> > > > > > index 504f8b7e72d4..a0dc85e4a754 100644
> > > > > > --- a/arch/riscv/include/asm/Kbuild
> > > > > > +++ b/arch/riscv/include/asm/Kbuild
> > > > > > @@ -2,10 +2,11 @@
> > > > > >  generic-y +=3D early_ioremap.h
> > > > > >  generic-y +=3D flat.h
> > > > > >  generic-y +=3D kvm_para.h
> > > > > > +generic-y +=3D mcs_spinlock.h
> > > > > >  generic-y +=3D parport.h
> > > > > > -generic-y +=3D spinlock.h
> > > > >
> > > > > IIUC here you take the asm-generic/spinlock.h (which defines arch=
_spin_*())
> > > > > and include the asm-generic headers of mcs_spinlock and qspinlock=
.
> > > > >
> > > > > In this case, the qspinlock.h will provide the arch_spin_*() inte=
rfaces,
> > > > > which seems the oposite of the above description (ticket spinlock=
s being
> > > > > the standard).
> > > > >
> > > > > Shouldn't ticket-spinlock.h also get included here?
> > > > > (Also, I am probably missing something, as I dont' see the use of
> > > > > mcs_spinlock here.)
> > > > No, because asm-generic/spinlock.h:
> > > > ...
> > > > #include <asm-generic/ticket_spinlock.h>
> > > > ...
> > > >
> > >
> > > But aren't you removing asm-generic/spinlock.h below ?
> > > -generic-y +=3D spinlock.h
> > Yes, current is:
> >
> > arch/riscv/include/asm/spinlock.h -> include/asm-generic/spinlock.h ->
> > include/asm-generic/ticket_spinlock.h
>
> I did a little reading on how generic-y works (which I was unaware):
>
> "If an architecture uses a verbatim copy of a header from
> include/asm-generic then this is listed in the file
> arch/$(SRCARCH)/include/asm/Kbuild [...] During the prepare phase of the
> build a wrapper include file is generated in the directory [...]"
>
> Oh, so you are removing the asm-generic/spinlock.h because it's link
> was replaced by a new asm/spinlock.h.
>
> You add qspinlock.h to generic-y because it's new in riscv, and add
> mcs_spinlock.h because it's needed by qspinlock.h.
>
> Ok, it makes sense now.
>
> Sorry about this noise.
> I was unaware of how generic-y worked, and (wrongly)
> assumed it was about including headers automatically in the build.
>
>
> >
> > +#ifdef CONFIG_QUEUED_SPINLOCKS
> > +#include <asm/qspinlock.h>
> > +#include <asm/qrwlock.h>
> > +#else
> > +#include <asm-generic/spinlock.h>
> > +#endif
> >
> > So, you want me:
> > +#ifdef CONFIG_QUEUED_SPINLOCKS
> > +#include <asm/qspinlock.h>
> > +#else
> > +#include <asm-generic/ticket_spinlock.h>
> > +#endif
> >
> > +#include <asm/qrwlock.h>
> >
> > Right?
>
> No, I didn't mean that.
> I was just worried about the arch_spin_*() interfaces, but they should be
> fine.
>
> BTW, according to kernel doc on generic-y, shouldn't be a better idea to
> add 'ticket_spinlock.h' to generic-y, and include above as
> asm/ticket_spinlock.h?
>
> Or is generic-y reserved only for stuff which is indirectly included by
> other headers?
It's okay to add generic-y for ticket_spinlock.h, and I'm okay with
the following:

+#ifdef CONFIG_QUEUED_SPINLOCKS
+#include <asm/qspinlock.h>
+#else
+#include <asm/ticket_spinlock.h>
+#endif

+#include <asm/qrwlock.h>

>
> Thanks!
> Leo
>
> >
> > >
> > > > >
> > > > > >  generic-y +=3D spinlock_types.h
> > > > > >  generic-y +=3D qrwlock.h
> > > > > >  generic-y +=3D qrwlock_types.h
> > > > > > +generic-y +=3D qspinlock.h
> > > > > >  generic-y +=3D user.h
> > > > > >  generic-y +=3D vmlinux.lds.h
> > > > > > diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/inc=
lude/asm/spinlock.h
> > > > > > new file mode 100644
> > > > > > index 000000000000..c644a92d4548
> > > > > > --- /dev/null
> > > > > > +++ b/arch/riscv/include/asm/spinlock.h
> > > > > > @@ -0,0 +1,17 @@
> > > > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > > > +
> > > > > > +#ifndef __ASM_RISCV_SPINLOCK_H
> > > > > > +#define __ASM_RISCV_SPINLOCK_H
> > > > > > +
> > > > > > +#ifdef CONFIG_QUEUED_SPINLOCKS
> > > > > > +#define _Q_PENDING_LOOPS     (1 << 9)
> > > > > > +#endif
> > > > >
> > > > > Any reason the above define couldn't be merged on the ifdef below=
?
> > > > Easy for the next patch to modify. See Waiman's comment:
> > > >
> > > > https://lore.kernel.org/linux-riscv/4cc7113a-0e4e-763a-cba2-7963bcd=
26c7a@redhat.com/
> > > >
> > > > > diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/inclu=
de/asm/spinlock.h
> > > > > index c644a92d4548..9eb3ad31e564 100644
> > > > > --- a/arch/riscv/include/asm/spinlock.h
> > > > > +++ b/arch/riscv/include/asm/spinlock.h
> > > > > @@ -7,11 +7,94 @@
> > > > >   #define _Q_PENDING_LOOPS (1 << 9)
> > > > >   #endif
> > > > >
> > > >
> > > > I see why you separated the _Q_PENDING_LOOPS out.
> > > >
> > >
> > > I see, should be fine then.
> > >
> > > Thanks!
> > > Leo
> > >
> > > >
> > > > >
> > > > > > +
> > > > > > +#ifdef CONFIG_QUEUED_SPINLOCKS
> > > > > > +#include <asm/qspinlock.h>
> > > > > > +#include <asm/qrwlock.h>
> > > > > > +#else
> > > > > > +#include <asm-generic/spinlock.h>
> > > > > > +#endif
> > > > > > +
> > > > > > +#endif /* __ASM_RISCV_SPINLOCK_H */
> > > > > > --
> > > > > > 2.36.1
> > > > > >
> > > > >
> > > > > Thanks!
> > > > > Leo
> > > > >
> > > >
> > > >
> > > > --
> > > > Best Regards
> > > >  Guo Ren
> > > >
> > >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
> >
>


--=20
Best Regards
 Guo Ren
