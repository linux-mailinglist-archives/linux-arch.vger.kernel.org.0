Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0EB6D2847
	for <lists+linux-arch@lfdr.de>; Fri, 31 Mar 2023 20:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbjCaSz7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Mar 2023 14:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbjCaSz6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Mar 2023 14:55:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C6222210;
        Fri, 31 Mar 2023 11:55:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2C4762A7A;
        Fri, 31 Mar 2023 18:55:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596B1C433EF;
        Fri, 31 Mar 2023 18:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680288950;
        bh=icBe3Gx0jtUsQSv9WWUxHbZhgNKe2iB8pB4cXHI+AeA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NSnQk2q9qyT+N5MdEkUx+SGMTkMhUkQpT3kkekaJdAU5nzae8yrodSkAgZucMISGg
         tuXI+fMqrmLINpoERd1A8QfdS3LDCg/KlyuBa+0Gn85jCzqP91rbQgJCLIgcbSYGMV
         q+jMj7R6ZBsxa6GXHS0fugRw1Wo569i3/mlgNNBEXvuR8EV8IbBb0zkzUmpTjoS9Wl
         vUvzNz3tZfxXqQWHok43WrxX+Z5xvdmvxqIZPI5Yz6xDC071OfkxxrDH+cFXb2eLpy
         n0Z3qklzShfA32y23ikg97gdu6kNO3WyHKtt0sJ8kXKjyhPzAl9Thyp3Vc0bjrhXWh
         VUpq1sqnzw39w==
Date:   Fri, 31 Mar 2023 19:55:42 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc:     guoren@kernel.org, arnd@arndb.de, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org,
        mark.rutland@arm.com, ben@decadent.org.uk, bjorn@kernel.org,
        palmer@dabbelt.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Yipeng Zou <zouyipeng@huawei.com>
Subject: Re: [PATCH -next V17 4/7] riscv: entry: Convert to generic entry
Message-ID: <24493b95-d994-4a42-a825-38ce2bf47c92@spud>
References: <20230222033021.983168-1-guoren@kernel.org>
 <60ee7c26-1a70-427d-beaf-92e2989fc479@spud>
 <ee83cd00-1f97-49a0-b1f6-b8b4f3ce7258@spud>
 <23668656.ouqheUzb2q@diego>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kqEhgLg8x7cpsgov"
Content-Disposition: inline
In-Reply-To: <23668656.ouqheUzb2q@diego>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--kqEhgLg8x7cpsgov
Content-Type: multipart/mixed; boundary="0j05xWKIImxbmXes"
Content-Disposition: inline


--0j05xWKIImxbmXes
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 31, 2023 at 08:46:44PM +0200, Heiko St=FCbner wrote:
> Hi,
>=20
> Am Freitag, 31. M=E4rz 2023, 20:41:35 CEST schrieb Conor Dooley:
> > On Fri, Mar 31, 2023 at 07:34:38PM +0100, Conor Dooley wrote:
> > > On Tue, Feb 21, 2023 at 10:30:18PM -0500, guoren@kernel.org wrote:
> > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > >=20
> > > > This patch converts riscv to use the generic entry infrastructure f=
rom
> > > > kernel/entry/*. The generic entry makes maintainers' work easier and
> > > > codes more elegant. Here are the changes:
> > > >=20
> > > >  - More clear entry.S with handle_exception and ret_from_exception
> > > >  - Get rid of complex custom signal implementation
> > > >  - Move syscall procedure from assembly to C, which is much more
> > > >    readable.
> > > >  - Connect ret_from_fork & ret_from_kernel_thread to generic entry.
> > > >  - Wrap with irqentry_enter/exit and syscall_enter/exit_from_user_m=
ode
> > > >  - Use the standard preemption code instead of custom
> > >=20
> > > This has unfortunately broken booting my usual NFS rootfs on both my =
D1
> > > and Icicle. It's one of the Fedora images from David, I think this on=
e:
> > > http://fedora.riscv.rocks/kojifiles/work/tasks/3933/1313933/
> > >=20
> > > It gets pretty far into things, it's once systemd is operational that
> > > things go pear shaped:
> >=20
> > Shoulda said, can share the full logs if required of course, but they're
> > quite verbose cos systemd etc.
>=20
> I was just investigating the same thing just now. So that saves me some
> tracking down the culprit :-) .
>=20
> My main qemu is living as a "board" in my boardfarm (also doing nfsroot)
> as well as my d1 nezha with nfsroot was affected.
>=20
> Though my board is stuck in some failure loop with both the journal- as
> well as the timesyncd service failing again and again. And I haven't
> figured out how to get logs without a working login console yet.

I'll attach the full output from a run I guess. journald fails ad
infinitum for me too after I cut this log off.

Cheers,
Conor.

--0j05xWKIImxbmXes
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="nfsroot.fail"
Content-Transfer-Encoding: quoted-printable

[    0.000000] Linux version 6.3.0-rc2-gd5e0396cf8bf-dirty (conor@spud) (Cl=
angBuiltLinux clang version 15.0.7 (/stuff/brsdk/llvm/clang 8dfdcc7b7bf6683=
4a761bd8de445840ef68e4d1a), ClangBuiltLinux LLD 15.0.7) #1 SMP PREEMPT @7=0D
[    0.000000] OF: fdt: Ignoring memory range 0x80000000 - 0x80200000=0D
[    0.000000] Machine model: Microchip PolarFire-SoC Icicle Kit=0D
[    0.000000] earlycon: ns16550a0 at MMIO32 0x0000000020000000 (options '1=
15200n8')=0D
[    0.000000] printk: bootconsole [ns16550a0] enabled=0D
[    0.000000] efi: UEFI not found.=0D
[    0.000000] OF: fdt: Reserved memory: failed to reserve memory for node =
'region@BFC00000': base 0x00000000bfc00000, size 4 MiB=0D
[    0.000000] OF: reserved mem: 0x00000000bfc00000..0x00000000bfffffff (40=
96 KiB) nomap non-reusable region@BFC00000=0D
[    0.000000] Zone ranges:=0D
[    0.000000]   DMA32    [mem 0x0000000080200000-0x00000000bfffffff]=0D
[    0.000000]   Normal   empty=0D
[    0.000000] Movable zone start for each node=0D
[    0.000000] Early memory node ranges=0D
[    0.000000]   node   0: [mem 0x0000000080200000-0x00000000bfffffff]=0D
[    0.000000] Initmem setup node 0 [mem 0x0000000080200000-0x00000000bffff=
fff]=0D
[    0.000000] On node 0, zone DMA32: 512 pages in unavailable ranges=0D
[    0.000000] SBI specification v0.3 detected=0D
[    0.000000] SBI implementation ID=3D0x1 Version=3D0x10000=0D
[    0.000000] SBI TIME extension detected=0D
[    0.000000] SBI IPI extension detected=0D
[    0.000000] SBI RFENCE extension detected=0D
[    0.000000] SBI SRST extension detected=0D
[    0.000000] SBI HSM extension detected=0D
[    0.000000] CPU with hartid=3D0 is not available=0D
[    0.000000] CPU with hartid=3D0 is not available=0D
[    0.000000] CPU with hartid=3D0 is not available=0D
[    0.000000] riscv: base ISA extensions acdfim=0D
[    0.000000] riscv: ELF capabilities acdfim=0D
[    0.000000] percpu: Embedded 29 pages/cpu s79648 r8192 d30944 u118784=0D
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 25805=
5=0D
[    0.000000] Kernel command line: root=3D/dev/nfs rw ip=3Ddhcp nfsroot=3D=
99.99.99.5:/stuff/nfs_share,tcp,v3 rdinit=3D/usr/sbin/init rootwait=3D10 ea=
rlycon=0D
[    0.000000] Unknown kernel command line parameters "rootwait=3D10", will=
 be passed to user space.=0D
[    0.000000] Dentry cache hash table entries: 131072 (order: 8, 1048576 b=
ytes, linear)=0D
[    0.000000] Inode-cache hash table entries: 65536 (order: 7, 524288 byte=
s, linear)=0D
[    0.000000] mem auto-init: stack:all(zero), heap alloc:off, heap free:of=
f=0D
[    0.000000] stackdepot: allocating hash table via alloc_large_system_has=
h=0D
[    0.000000] stackdepot hash table entries: 1048576 (order: 11, 8388608 b=
ytes, linear)=0D
[    0.000000] Virtual kernel memory layout:=0D
[    0.000000]       fixmap : 0xffffffc6fee00000 - 0xffffffc6ff000000   (20=
48 kB)=0D
[    0.000000]       pci io : 0xffffffc6ff000000 - 0xffffffc700000000   (  =
16 MB)=0D
[    0.000000]      vmemmap : 0xffffffc700000000 - 0xffffffc800000000   (40=
96 MB)=0D
[    0.000000]      vmalloc : 0xffffffc800000000 - 0xffffffd800000000   (  =
64 GB)=0D
[    0.000000]      modules : 0xffffffff0305f000 - 0xffffffff80000000   (19=
99 MB)=0D
[    0.000000]       lowmem : 0xffffffd800000000 - 0xffffffd83fe00000   (10=
22 MB)=0D
[    0.000000]        kasan : 0xfffffff700000000 - 0xffffffff00000000   (  =
32 GB)=0D
[    0.000000]       kernel : 0xffffffff80000000 - 0xffffffffffffffff   (20=
47 MB)=0D
[    0.000000] Memory: 545616K/1046528K available (16518K kernel code, 8042=
K rwdata, 8192K rodata, 2303K init, 12559K bss, 500912K reserved, 0K cma-re=
served)=0D
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4, N=
odes=3D1=0D
[    0.000000] trace event string verifier disabled=0D
[    0.000000] Running RCU self tests=0D
[    0.000000] Running RCU synchronous self tests=0D
[    0.000000] rcu: Preemptible hierarchical RCU implementation.=0D
[    0.000000] rcu: 	RCU lockdep checking is enabled.=0D
[    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=3D64 to nr_cpu_ids=
=3D4.=0D
[    0.000000] rcu: 	RCU debug extended QS entry/exit.=0D
[    0.000000] 	Trampoline variant of Tasks RCU enabled.=0D
[    0.000000] 	Tracing variant of Tasks RCU enabled.=0D
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 2=
5 jiffies.=0D
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D4=0D
[    0.000000] Running RCU synchronous self tests=0D
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0=0D
[    0.000000] CPU with hartid=3D0 is not available=0D
[    0.000000] riscv-intc: unable to find hart id for /cpus/cpu@0/interrupt=
-controller=0D
[    0.000000] riscv-intc: 64 local interrupts mapped=0D
[    0.000000] plic: interrupt-controller@c000000: mapped 186 interrupts wi=
th 4 handlers for 9 contexts.=0D
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.=0D
[    0.000000] riscv-timer: riscv_timer_init_dt: Registering clocksource cp=
uid [0] hartid [1]=0D
[    0.000000] clocksource: riscv_clocksource: mask: 0xffffffffffffffff max=
_cycles: 0x1d854df40, max_idle_ns: 3526361616960 ns=0D
[    0.000006] sched_clock: 64 bits at 1000kHz, resolution 1000ns, wraps ev=
ery 2199023255500ns=0D
[    0.015372] Console: colour dummy device 80x25=0D
[    0.020991] printk: console [tty0] enabled=0D
[    0.026672] printk: bootconsole [ns16550a0] disabled=0D
[    0.000000] Linux version 6.3.0-rc2-gd5e0396cf8bf-dirty (conor@spud) (Cl=
angBuiltLinux clang version 15.0.7 (/stuff/brsdk/llvm/clang 8dfdcc7b7bf6683=
4a761bd8de445840ef68e4d1a), ClangBuiltLinux LLD 15.0.7) #1 SMP PREEMPT @7=0D
[    0.000000] OF: fdt: Ignoring memory range 0x80000000 - 0x80200000=0D
[    0.000000] Machine model: Microchip PolarFire-SoC Icicle Kit=0D
[    0.000000] earlycon: ns16550a0 at MMIO32 0x0000000020000000 (options '1=
15200n8')=0D
[    0.000000] printk: bootconsole [ns16550a0] enabled=0D
[    0.000000] efi: UEFI not found.=0D
[    0.000000] OF: fdt: Reserved memory: failed to reserve memory for node =
'region@BFC00000': base 0x00000000bfc00000, size 4 MiB=0D
[    0.000000] OF: reserved mem: 0x00000000bfc00000..0x00000000bfffffff (40=
96 KiB) nomap non-reusable region@BFC00000=0D
[    0.000000] Zone ranges:=0D
[    0.000000]   DMA32    [mem 0x0000000080200000-0x00000000bfffffff]=0D
[    0.000000]   Normal   empty=0D
[    0.000000] Movable zone start for each node=0D
[    0.000000] Early memory node ranges=0D
[    0.000000]   node   0: [mem 0x0000000080200000-0x00000000bfffffff]=0D
[    0.000000] Initmem setup node 0 [mem 0x0000000080200000-0x00000000bffff=
fff]=0D
[    0.000000] On node 0, zone DMA32: 512 pages in unavailable ranges=0D
[    0.000000] SBI specification v0.3 detected=0D
[    0.000000] SBI implementation ID=3D0x1 Version=3D0x10000=0D
[    0.000000] SBI TIME extension detected=0D
[    0.000000] SBI IPI extension detected=0D
[    0.000000] SBI RFENCE extension detected=0D
[    0.000000] SBI SRST extension detected=0D
[    0.000000] SBI HSM extension detected=0D
[    0.000000] CPU with hartid=3D0 is not available=0D
[    0.000000] CPU with hartid=3D0 is not available=0D
[    0.000000] CPU with hartid=3D0 is not available=0D
[    0.000000] riscv: base ISA extensions acdfim=0D
[    0.000000] riscv: ELF capabilities acdfim=0D
[    0.000000] percpu: Embedded 29 pages/cpu s79648 r8192 d30944 u118784=0D
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 25805=
5=0D
[    0.000000] Kernel command line: root=3D/dev/nfs rw ip=3Ddhcp nfsroot=3D=
99.99.99.5:/stuff/nfs_share,tcp,v3 rdinit=3D/usr/sbin/init rootwait=3D10 ea=
rlycon=0D
[    0.000000] Unknown kernel command line parameters "rootwait=3D10", will=
 be passed to user space.=0D
[    0.000000] Dentry cache hash table entries: 131072 (order: 8, 1048576 b=
ytes, linear)=0D
[    0.000000] Inode-cache hash table entries: 65536 (order: 7, 524288 byte=
s, linear)=0D
[    0.000000] mem auto-init: stack:all(zero), heap alloc:off, heap free:of=
f=0D
[    0.000000] stackdepot: allocating hash table via alloc_large_system_has=
h=0D
[    0.000000] stackdepot hash table entries: 1048576 (order: 11, 8388608 b=
ytes, linear)=0D
[    0.000000] Virtual kernel memory layout:=0D
[    0.000000]       fixmap : 0xffffffc6fee00000 - 0xffffffc6ff000000   (20=
48 kB)=0D
[    0.000000]       pci io : 0xffffffc6ff000000 - 0xffffffc700000000   (  =
16 MB)=0D
[    0.000000]      vmemmap : 0xffffffc700000000 - 0xffffffc800000000   (40=
96 MB)=0D
[    0.000000]      vmalloc : 0xffffffc800000000 - 0xffffffd800000000   (  =
64 GB)=0D
[    0.000000]      modules : 0xffffffff0305f000 - 0xffffffff80000000   (19=
99 MB)=0D
[    0.000000]       lowmem : 0xffffffd800000000 - 0xffffffd83fe00000   (10=
22 MB)=0D
[    0.000000]        kasan : 0xfffffff700000000 - 0xffffffff00000000   (  =
32 GB)=0D
[    0.000000]       kernel : 0xffffffff80000000 - 0xffffffffffffffff   (20=
47 MB)=0D
[    0.000000] Memory: 545616K/1046528K available (16518K kernel code, 8042=
K rwdata, 8192K rodata, 2303K init, 12559K bss, 500912K reserved, 0K cma-re=
served)=0D
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4, N=
odes=3D1=0D
[    0.000000] trace event string verifier disabled=0D
[    0.000000] Running RCU self tests=0D
[    0.000000] Running RCU synchronous self tests=0D
[    0.000000] rcu: Preemptible hierarchical RCU implementation.=0D
[    0.000000] rcu: 	RCU lockdep checking is enabled.=0D
[    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=3D64 to nr_cpu_ids=
=3D4.=0D
[    0.000000] rcu: 	RCU debug extended QS entry/exit.=0D
[    0.000000] 	Trampoline variant of Tasks RCU enabled.=0D
[    0.000000] 	Tracing variant of Tasks RCU enabled.=0D
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 2=
5 jiffies.=0D
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D4=0D
[    0.000000] Running RCU synchronous self tests=0D
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0=0D
[    0.000000] CPU with hartid=3D0 is not available=0D
[    0.000000] riscv-intc: unable to find hart id for /cpus/cpu@0/interrupt=
-controller=0D
[    0.000000] riscv-intc: 64 local interrupts mapped=0D
[    0.000000] plic: interrupt-controller@c000000: mapped 186 interrupts wi=
th 4 handlers for 9 contexts.=0D
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.=0D
[    0.000000] riscv-timer: riscv_timer_init_dt: Registering clocksource cp=
uid [0] hartid [1]=0D
[    0.000000] clocksource: riscv_clocksource: mask: 0xffffffffffffffff max=
_cycles: 0x1d854df40, max_idle_ns: 3526361616960 ns=0D
[    0.000006] sched_clock: 64 bits at 1000kHz, resolution 1000ns, wraps ev=
ery 2199023255500ns=0D
[    0.015372] Console: colour dummy device 80x25=0D
[    0.020991] printk: console [tty0] enabled=0D
[    0.026672] printk: bootconsole [ns16550a0] disabled=0D
[    0.033749] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc.,=
 Ingo Molnar=0D
[    0.035065] ... MAX_LOCKDEP_SUBCLASSES:  8=0D
[    0.035844] ... MAX_LOCK_DEPTH:          48=0D
[    0.036633] ... MAX_LOCKDEP_KEYS:        8192=0D
[    0.037658] ... CLASSHASH_SIZE:          4096=0D
[    0.038478] ... MAX_LOCKDEP_ENTRIES:     32768=0D
[    0.039307] ... MAX_LOCKDEP_CHAINS:      65536=0D
[    0.040135] ... CHAINHASH_SIZE:          32768=0D
[    0.040963]  memory used by lock dependency info: 6365 kB=0D
[    0.042130]  memory used for stack traces: 4224 kB=0D
[    0.043012]  per task-struct memory footprint: 1920 bytes=0D
[    0.044452] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 2.00 BogoMIPS (lpj=3D4000)=0D
[    0.046447] pid_max: default: 32768 minimum: 301=0D
[    0.052917] Mount-cache hash table entries: 2048 (order: 2, 16384 bytes,=
 linear)=0D
[    0.054369] Mountpoint-cache hash table entries: 2048 (order: 2, 16384 b=
ytes, linear)=0D
[    0.084506] Running RCU synchronous self tests=0D
[    0.085686] Running RCU synchronous self tests=0D
[    0.095405] CPU node for /cpus/cpu@0 exist but the possible cpu range is=
 :0-3=0D
[    0.130236] cblist_init_generic: Setting adjustable number of callback q=
ueues.=0D
[    0.133050] cblist_init_generic: Setting shift to 2 and lim to 1.=0D
[    0.137669] cblist_init_generic: Setting shift to 2 and lim to 1.=0D
[    0.142192] Running RCU-tasks wait API self tests=0D
[    0.263638] riscv: ELF compat mode unsupported=0D
[    0.263807] ASID allocator disabled (0 bits)=0D
[    0.270226] Callback from call_rcu_tasks_trace() invoked.=0D
[    0.272903] rcu: Hierarchical SRCU implementation.=0D
[    0.274289] rcu: 	Max phase no-delay instances is 1000.=0D
[    0.302638] EFI services will not be available.=0D
[    0.315637] smp: Bringing up secondary CPUs ...=0D
[    0.396166] smp: Brought up 1 node, 4 CPUs=0D
[    0.422047] devtmpfs: initialized=0D
[    0.490692] Callback from call_rcu_tasks() invoked.=0D
[    0.681118] Running RCU synchronous self tests=0D
[    0.682861] Running RCU synchronous self tests=0D
[    0.691211] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 7645041785100000 ns=0D
[    0.693981] futex hash table entries: 1024 (order: 5, 131072 bytes, line=
ar)=0D
[    0.702882] pinctrl core: initialized pinctrl subsystem=0D
[    0.744067] NET: Registered PF_NETLINK/PF_ROUTE protocol family=0D
[    0.758314] DMA: preallocated 128 KiB GFP_KERNEL pool for atomic allocat=
ions=0D
[    0.761255] DMA: preallocated 128 KiB GFP_KERNEL|GFP_DMA32 pool for atom=
ic allocations=0D
[    0.795383] cpuidle: using governor menu=0D
[    1.272427] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 page=
s=0D
[    1.274292] HugeTLB: 0 KiB vmemmap can be freed for a 2.00 MiB page=0D
[    1.411012] SCSI subsystem initialized=0D
[    1.431885] usbcore: registered new interface driver usbfs=0D
[    1.435740] usbcore: registered new interface driver hub=0D
[    1.439351] usbcore: registered new device driver usb=0D
[    1.462261] FPGA manager framework=0D
[    1.512290] vgaarb: loaded=0D
[    1.519890] clocksource: Switched to clocksource riscv_clocksource=0D
[    2.009122] NET: Registered PF_INET protocol family=0D
[    2.016053] IP idents hash table entries: 16384 (order: 5, 131072 bytes,=
 linear)=0D
[    2.052865] tcp_listen_portaddr_hash hash table entries: 512 (order: 3, =
36864 bytes, linear)=0D
[    2.056616] Table-perturb hash table entries: 65536 (order: 6, 262144 by=
tes, linear)=0D
[    2.059500] TCP established hash table entries: 8192 (order: 4, 65536 by=
tes, linear)=0D
[    2.072933] TCP bind hash table entries: 8192 (order: 8, 1179648 bytes, =
linear)=0D
[    2.113517] TCP: Hash tables configured (established 8192 bind 8192)=0D
[    2.120319] UDP hash table entries: 512 (order: 4, 81920 bytes, linear)=
=0D
[    2.125390] UDP-Lite hash table entries: 512 (order: 4, 81920 bytes, lin=
ear)=0D
[    2.136344] NET: Registered PF_UNIX/PF_LOCAL protocol family=0D
[    2.161084] RPC: Registered named UNIX socket transport module.=0D
[    2.162843] RPC: Registered udp transport module.=0D
[    2.164402] RPC: Registered tcp transport module.=0D
[    2.165631] RPC: Registered tcp NFSv4.1 backchannel transport module.=0D
[    2.167599] PCI: CLS 0 bytes, default 64=0D
[    2.190148] Unpacking initramfs...=0D
[    2.251957] workingset: timestamp_bits=3D62 max_order=3D18 bucket_order=
=3D0=0D
[    2.296023] NFS: Registering the id_resolver key type=0D
[    2.299423] Key type id_resolver registered=0D
[    2.300826] Key type id_legacy registered=0D
[    2.303490] nfs4filelayout_init: NFSv4 File Layout Driver Registering...=
=0D
[    2.305408] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Regist=
ering...=0D
[    2.314304] 9p: Installing v9fs 9p2000 file system support=0D
[    2.330388] NET: Registered PF_ALG protocol family=0D
[    2.335558] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 246)=0D
[    2.337681] io scheduler mq-deadline registered=0D
[    2.338886] io scheduler kyber registered=0D
[    2.341159] io scheduler bfq registered=0D
[   13.013052] String selftests succeeded=0D
[   13.014173] test_string_helpers: Running tests...=0D
[   13.386804] CCACHE: DataError @ 0x00000000.0807FFF8=0D
[   13.391444] CCACHE: DataFail @ 0x00000000.0807FFF0=0D
[   13.397053] CCACHE: 4 banks, 16 ways, sets/bank=3D512, bytes/block=3D64=
=0D
[   13.398602] CCACHE: Index of the largest way enabled: 11=0D
[   16.037879] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled=0D
[   16.149343] 20000000.serial: ttyS0 at MMIO 0x20000000 (irq =3D 15, base_=
baud =3D 9375000) is a 16550A=0D
[   16.156089] printk: console [ttyS0] enabled=0D
[   17.265279] 20100000.serial: ttyS1 at MMIO 0x20100000 (irq =3D 16, base_=
baud =3D 9375000) is a 16550A=0D
[   17.327497] 20102000.serial: ttyS2 at MMIO 0x20102000 (irq =3D 17, base_=
baud =3D 9375000) is a 16550A=0D
[   17.389076] 20104000.serial: ttyS3 at MMIO 0x20104000 (irq =3D 18, base_=
baud =3D 9375000) is a 16550A=0D
[   17.426517] of_serial: probe of 20106000.serial failed with error -28=0D
[   17.916595] loop: module loaded=0D
[   17.964831] zram: Added device: zram0=0D
[   18.086264] microchip-corespi 20108000.spi: Registered SPI controller 0=
=0D
[   18.121095] microchip-corespi 20109000.spi: Registered SPI controller 1=
=0D
[   18.203919] spi-nor spi3.0: w25q128 (16384 Kbytes)=0D
[   21.169496] Freeing initrd memory: 15668K=0D
[   21.395452] macb 20110000.ethernet eth0: Cadence GEM rev 0x0107010c at 0=
x20110000 irq 23 (00:04:a3:41:d0:fd)=0D
[   21.412679] e1000e: Intel(R) PRO/1000 Network Driver=0D
[   21.419777] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.=0D
[   21.460117] usbcore: registered new interface driver uas=0D
[   21.469638] usbcore: registered new interface driver usb-storage=0D
[   21.524504] musb-hdrc musb-hdrc.1.auto: MUSB HDRC host driver=0D
[   21.540183] musb-hdrc musb-hdrc.1.auto: new USB bus registered, assigned=
 bus number 1=0D
[   21.610837] hub 1-0:1.0: USB hub found=0D
[   21.621142] hub 1-0:1.0: 1 port detected=0D
[   21.680372] mpfs-musb 20201000.usb: Registered MPFS MUSB driver=0D
[   21.702517] mousedev: PS/2 mouse device common for all mice=0D
[   21.724021] i2c_dev: i2c /dev entries driver=0D
[   21.763554] microchip-corei2c 2010a000.i2c: registered CoreI2C bus drive=
r=0D
[   21.797752] microchip-corei2c 2010b000.i2c: registered CoreI2C bus drive=
r=0D
[   21.852615] sdhci: Secure Digital Host Controller Interface driver=0D
[   21.860773] sdhci: Copyright(c) Pierre Ossman=0D
[   21.868727] sdhci-pltfm: SDHCI platform and OF driver helper=0D
[   21.895884] usbcore: registered new interface driver usbhid=0D
[   21.902221] usbhid: USB HID core driver=0D
[   21.936265] mpfs-mailbox 37020000.mailbox: Registered MPFS mailbox contr=
oller driver=0D
[   21.966319] riscv-pmu-sbi: SBI PMU extension is available=0D
[   21.973922] riscv-pmu-sbi: 15 firmware and 4 hardware counters=0D
[   21.981727] riscv-pmu-sbi: Perf sampling/filtering is not supported as s=
scof extension is not available=0D
[   21.996006] mmc0: SDHCI controller on 20008000.mmc [20008000.mmc] using =
ADMA 64-bit=0D
[   22.032435] NET: Registered PF_INET6 protocol family=0D
[   22.080829] Segment Routing with IPv6=0D
[   22.087604] In-situ OAM (IOAM) with IPv6=0D
[   22.094555] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver=0D
[   22.132241] NET: Registered PF_PACKET protocol family=0D
[   22.143837] 9pnet: Installing 9P2000 support=0D
[   22.145445] mmc0: new HS200 MMC card at address 0001=0D
[   22.160350] Key type dns_resolver registered=0D
[   22.198172] mmcblk0: mmc0:0001 TB2916 14.6 GiB =0D
[   22.359675] mmcblk0boot0: mmc0:0001 TB2916 4.00 MiB =0D
[   22.472842] mmcblk0boot1: mmc0:0001 TB2916 4.00 MiB =0D
[   22.574290] mmcblk0rpmb: mmc0:0001 TB2916 4.00 MiB, chardev (242:0)=0D
[   23.619821] debug_vm_pgtable: [debug_vm_pgtable         ]: Validating ar=
chitecture page table helpers=0D
[   23.910330] mpfs-sys-controller syscontroller: Registered MPFS system co=
ntroller=0D
[   23.955403] random: crng init done=0D
[   23.961736] mpfs-rng mpfs-rng: Registered MPFS hwrng=0D
[   24.040123] macb 20110000.ethernet eth0: PHY [20110000.ethernet-ffffffff=
:00] driver [RTL8211F Gigabit Ethernet] (irq=3DPOLL)=0D
[   24.055924] macb 20110000.ethernet eth0: configuring for phy/sgmii link =
mode=0D
[   28.254478] macb 20110000.ethernet eth0: Link is Up - 1Gbps/Full - flow =
control off=0D
[   28.266341] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready=0D
[   28.275892] Sending DHCP requests ., OK=0D
[   28.306175] IP-Config: Got DHCP answer from 99.99.99.1, my address is 99=
=2E99.99.97=0D
[   28.316744] IP-Config: Complete:=0D
[   28.321357]      device=3Deth0, hwaddr=3D00:04:a3:41:d0:fd, ipaddr=3D99.=
99.99.97, mask=3D255.255.255.0, gw=3D99.99.99.1=0D
[   28.334209]      host=3D99.99.99.97, domain=3D, nis-domain=3D(none)=0D
[   28.341874]      bootserver=3D99.99.99.1, rootserver=3D99.99.99.5, rootp=
ath=3D=0D
[   28.342051]      nameserver0=3D99.99.99.1=0D
[   28.684402] VFS: Mounted root (nfs filesystem) on device 0:16.=0D
[   28.708272] devtmpfs: mounted=0D
[   28.747831] Freeing unused kernel image (initmem) memory: 2300K=0D
[   28.757755] Run /sbin/init as init process=0D
[   39.469486] systemd[1]: System time before build time, advancing clock.=
=0D
[   41.382394] systemd[1]: systemd v246.15-1.0.riscv64.fc33 running in syst=
em mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCR=
YPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMO=
D +IDN2 -IDN +PCRE2 default-hierarchy=3Dunified)=0D
[   41.432906] systemd[1]: Detected architecture riscv64.=0D
=0D
Welcome to =1B[0;34mFedora 33 (Rawhide)=1B[0m!=0D
=0D
[   41.587681] systemd[1]: Set hostname to <fedora-riscv>.=0D
[   50.761418] systemd-sysv-generator[95]: SysV service '/etc/rc.d/init.d/l=
ivesys' lacks a native systemd unit file. Automatically generating a unit f=
ile for compatibility. Please update package to include a native systemd un=
it file, in order to make it more safe and robust.=0D
[   51.527913] zram_generator::generator[97]: Creating dev-zram0.swap for /=
dev/zram0 (275MB)=0D
[   57.964444] systemd[1]: /usr/lib/dracut/modules.d/98dracut-systemd/dracu=
t-pre-udev.service:27: Standard output type syslog is obsolete, automatical=
ly updating to journal. Please update your unit file, and consider removing=
 the setting altogether.=0D
[   57.993549] systemd[1]: /usr/lib/dracut/modules.d/98dracut-systemd/dracu=
t-pre-udev.service:28: Standard output type syslog+console is obsolete, aut=
omatically updating to journal+console. Please update your unit file, and c=
onsider removing the setting altogether.=0D
[   58.053419] systemd[1]: /usr/lib/dracut/modules.d/98dracut-systemd/dracu=
t-pre-trigger.service:23: Standard output type syslog is obsolete, automati=
cally updating to journal. Please update your unit file, and consider remov=
ing the setting altogether.=0D
[   58.081477] systemd[1]: /usr/lib/dracut/modules.d/98dracut-systemd/dracu=
t-pre-trigger.service:24: Standard output type syslog+console is obsolete, =
automatically updating to journal+console. Please update your unit file, an=
d consider removing the setting altogether.=0D
[   58.145535] systemd[1]: /usr/lib/dracut/modules.d/98dracut-systemd/dracu=
t-pre-pivot.service:30: Standard output type syslog is obsolete, automatica=
lly updating to journal. Please update your unit file, and consider removin=
g the setting altogether.=0D
[   58.174372] systemd[1]: /usr/lib/dracut/modules.d/98dracut-systemd/dracu=
t-pre-pivot.service:31: Standard output type syslog+console is obsolete, au=
tomatically updating to journal+console. Please update your unit file, and =
consider removing the setting altogether.=0D
[   58.447602] systemd[1]: /usr/lib/systemd/system/gssproxy.service:13: PID=
File=3D references a path below legacy directory /var/run/, updating /var/r=
un/gssproxy.pid =E2=86=92 /run/gssproxy.pid; please update the unit file ac=
cordingly.=0D
[   59.596376] systemd[1]: /usr/lib/dracut/modules.d/98dracut-systemd/dracu=
t-pre-mount.service:22: Standard output type syslog is obsolete, automatica=
lly updating to journal. Please update your unit file, and consider removin=
g the setting altogether.=0D
[   59.624034] systemd[1]: /usr/lib/dracut/modules.d/98dracut-systemd/dracu=
t-pre-mount.service:23: Standard output type syslog+console is obsolete, au=
tomatically updating to journal+console. Please update your unit file, and =
consider removing the setting altogether.=0D
[   59.682316] systemd[1]: /usr/lib/dracut/modules.d/98dracut-systemd/dracu=
t-mount.service:22: Standard output type syslog is obsolete, automatically =
updating to journal. Please update your unit file, and consider removing th=
e setting altogether.=0D
[   59.709969] systemd[1]: /usr/lib/dracut/modules.d/98dracut-systemd/dracu=
t-mount.service:23: Standard output type syslog+console is obsolete, automa=
tically updating to journal+console. Please update your unit file, and cons=
ider removing the setting altogether.=0D
[   59.766799] systemd[1]: /usr/lib/dracut/modules.d/98dracut-systemd/dracu=
t-initqueue.service:24: Standard output type syslog is obsolete, automatica=
lly updating to journal. Please update your unit file, and consider removin=
g the setting altogether.=0D
[   59.795713] systemd[1]: /usr/lib/dracut/modules.d/98dracut-systemd/dracu=
t-initqueue.service:25: Standard output type syslog+console is obsolete, au=
tomatically updating to journal+console. Please update your unit file, and =
consider removing the setting altogether.=0D
[   59.854333] systemd[1]: /usr/lib/dracut/modules.d/98dracut-systemd/dracu=
t-cmdline.service:26: Standard output type syslog is obsolete, automaticall=
y updating to journal. Please update your unit file, and consider removing =
the setting altogether.=0D
[   59.882177] systemd[1]: /usr/lib/dracut/modules.d/98dracut-systemd/dracu=
t-cmdline.service:27: Standard output type syslog+console is obsolete, auto=
matically updating to journal+console. Please update your unit file, and co=
nsider removing the setting altogether.=0D
[   63.677176] systemd[1]: /usr/lib/systemd/system/ip6tables.service:14: St=
andard output type syslog is obsolete, automatically updating to journal. P=
lease update your unit file, and consider removing the setting altogether.=
=0D
[   63.702465] systemd[1]: /usr/lib/systemd/system/ip6tables.service:15: St=
andard output type syslog is obsolete, automatically updating to journal. P=
lease update your unit file, and consider removing the setting altogether.=
=0D
[   63.755847] systemd[1]: /usr/lib/systemd/system/iptables.service:14: Sta=
ndard output type syslog is obsolete, automatically updating to journal. Pl=
ease update your unit file, and consider removing the setting altogether.=0D
[   63.780923] systemd[1]: /usr/lib/systemd/system/iptables.service:15: Sta=
ndard output type syslog is obsolete, automatically updating to journal. Pl=
ease update your unit file, and consider removing the setting altogether.=0D
[   64.176567] systemd[1]: Queued start job for default target Graphical In=
terface.=0D
[   64.280125] systemd[1]: Created slice Slice /system/getty.=0D
[=1B[0;32m  OK  =1B[0m] Created slice =1B[0;1;39mSlice /system/getty=1B[0m.=
=0D
[   64.354451] systemd[1]: Created slice Slice /system/modprobe.=0D
[=1B[0;32m  OK  =1B[0m] Created slice =1B[0;1;39mSlice /system/modprobe=1B[=
0m.=0D
[   64.419976] systemd[1]: Created slice Slice /system/serial-getty.=0D
[=1B[0;32m  OK  =1B[0m] Created slice =1B[0;1;39mSlice /system/serial-getty=
=1B[0m.=0D
[   64.488102] systemd[1]: Created slice Slice /system/sshd-keygen.=0D
[=1B[0;32m  OK  =1B[0m] Created slice =1B[0;1;39mSlice /system/sshd-keygen=
=1B[0m.=0D
[   64.554661] systemd[1]: Created slice Slice /system/swap-create.=0D
[=1B[0;32m  OK  =1B[0m] Created slice =1B[0;1;39mSlice /system/swap-create=
=1B[0m.=0D
[   64.621316] systemd[1]: Created slice User and Session Slice.=0D
[=1B[0;32m  OK  =1B[0m] Created slice =1B[0;1;39mUser and Session Slice=1B[=
0m.=0D
[   64.678839] systemd[1]: Started Forward Password Requests to Wall Direct=
ory Watch.=0D
[=1B[0;32m  OK  =1B[0m] Started =1B[0;1;39mForward Password R=E2=80=A6uests=
 to Wall Directory Watch=1B[0m.=0D
[   64.732402] systemd[1]: Condition check resulted in Arbitrary Executable=
 File Formats File System Automount Point being skipped.=0D
[   64.749679] systemd[1]: Reached target Slices.=0D
[=1B[0;32m  OK  =1B[0m] Reached target =1B[0;1;39mSlices=1B[0m.=0D
[   64.804090] systemd[1]: Listening on Device-mapper event daemon FIFOs.=0D
[=1B[0;32m  OK  =1B[0m] Listening on =1B[0;1;39mDevice-mapper event daemon =
FIFOs=1B[0m.=0D
[   64.868427] systemd[1]: Listening on LVM2 poll daemon socket.=0D
[=1B[0;32m  OK  =1B[0m] Listening on =1B[0;1;39mLVM2 poll daemon socket=1B[=
0m.=0D
[   64.998827] systemd[1]: Listening on Process Core Dump Socket.=0D
[=1B[0;32m  OK  =1B[0m] Listening on =1B[0;1;39mProcess Core Dump Socket=1B=
[0m.=0D
[   65.061733] systemd[1]: Listening on initctl Compatibility Named Pipe.=0D
[=1B[0;32m  OK  =1B[0m] Listening on =1B[0;1;39minitctl Compatibility Named=
 Pipe=1B[0m.=0D
[   65.762318] systemd[1]: Condition check resulted in Journal Audit Socket=
 being skipped.=0D
[   65.803879] systemd[1]: Listening on Journal Socket (/dev/log).=0D
[=1B[0;32m  OK  =1B[0m] Listening on =1B[0;1;39mJournal Socket (/dev/log)=
=1B[0m.=0D
[   65.870028] systemd[1]: Listening on Journal Socket.=0D
[=1B[0;32m  OK  =1B[0m] Listening on =1B[0;1;39mJournal Socket=1B[0m.=0D
[   65.966580] systemd[1]: Listening on udev Control Socket.=0D
[=1B[0;32m  OK  =1B[0m] Listening on =1B[0;1;39mudev Control Socket=1B[0m.=
=0D
[   66.016638] systemd[1]: Listening on udev Kernel Socket.=0D
[=1B[0;32m  OK  =1B[0m] Listening on =1B[0;1;39mudev Kernel Socket=1B[0m.=0D
[   66.072113] systemd[1]: Listening on User Database Manager Socket.=0D
[=1B[0;32m  OK  =1B[0m] Listening on =1B[0;1;39mUser Database Manager Socke=
t=1B[0m.=0D
[   66.265196] systemd[1]: Mounting Huge Pages File System...=0D
         Mounting =1B[0;1;39mHuge Pages File System=1B[0m...=0D
[   66.477098] systemd[1]: Mounting POSIX Message Queue File System...=0D
         Mounting =1B[0;1;39mPOSIX Message Queue File System=1B[0m...=0D
[   66.717215] systemd[1]: Mounting Kernel Debug File System...=0D
         Mounting =1B[0;1;39mKernel Debug File System=1B[0m...=0D
[   67.000634] systemd[1]: Mounting Kernel Trace File System...=0D
         Mounting =1B[0;1;39mKernel Trace File System=1B[0m...=0D
[   67.061135] systemd[1]: Condition check resulted in Kernel Module suppor=
ting RPCSEC_GSS being skipped.=0D
[   67.078706] systemd[1]: Condition check resulted in Create list of stati=
c device nodes for the current kernel being skipped.=0D
[   67.246059] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots e=
tc. using dmeventd or progress polling...=0D
         Starting =1B[0;1;39mMonitoring of LVM=E2=80=A6meventd or progress =
polling=1B[0m...=0D
[   67.451615] systemd[1]: Starting Load Kernel Module configfs...=0D
         Starting =1B[0;1;39mLoad Kernel Module configfs=1B[0m...=0D
[   67.643795] systemd[1]: Starting Load Kernel Module drm...=0D
         Starting =1B[0;1;39mLoad Kernel Module drm=1B[0m...=0D
[   67.889066] systemd[1]: Starting Load Kernel Module fuse...=0D
         Starting =1B[0;1;39mLoad Kernel Module fuse=1B[0m...=0D
[   68.223484] systemd[1]: Starting Preprocess NFS configuration convertion=
=2E..=0D
         Starting =1B[0;1;39mPreprocess NFS configuration convertion=1B[0m.=
=2E.=0D
[   68.405239] systemd[1]: Condition check resulted in Set Up Additional Bi=
nary Formats being skipped.=0D
[   68.685006] systemd[1]: Starting Load Kernel Modules...=0D
         Starting =1B[0;1;39mLoad Kernel Modules=1B[0m...=0D
[   68.936926] systemd[1]: Starting Remount Root and Kernel File Systems...=
=0D
         Starting =1B[0;1;39mRemount Root and Kernel File Systems=1B[0m...=
=0D
[   69.026562] systemd[1]: Condition check resulted in Repartition Root Dis=
k being skipped.=0D
[   69.217824] systemd[1]: Starting Coldplug All udev Devices...=0D
         Starting =1B[0;1;39mColdplug All udev Devices=1B[0m...=0D
[   69.476888] systemd[1]: Starting Setup Virtual Console...=0D
         Starting =1B[0;1;39mSetup Virtual Console=1B[0m...=0D
[   69.908789] systemd[1]: Mounted Huge Pages File System.=0D
[=1B[0;32m  OK  =1B[0m] Mounted =1B[0;1;39mHuge Pages File System=1B[0m.=0D
[   69.985603] systemd[1]: Mounted POSIX Message Queue File System.=0D
[=1B[0;32m  OK  =1B[0m] Mounted =1B[0;1;39mPOSIX Message Queue File System=
=1B[0m.=0D
[   70.097151] systemd[1]: Mounted Kernel Debug File System.=0D
[=1B[0;32m  OK  =1B[0m] Mounted =1B[0;1;39mKernel Debug File System=1B[0m.=
=0D
[   70.243463] systemd[1]: Mounted Kernel Trace File System.=0D
[=1B[0;32m  OK  =1B[0m] Mounted =1B[0;1;39mKernel Trace File System=1B[0m.=
=0D
[   70.407632] systemd[1]: modprobe@configfs.service: Succeeded.=0D
[   70.493564] systemd[1]: Finished Load Kernel Module configfs.=0D
[=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mLoad Kernel Module configfs=1B[=
0m.=0D
[   71.599759] systemd[1]: modprobe@drm.service: Succeeded.=0D
[   71.667485] systemd[1]: Finished Load Kernel Module drm.=0D
[=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mLoad Kernel Module drm=1B[0m.=0D
[   71.800153] systemd[1]: modprobe@fuse.service: Succeeded.=0D
[   71.890649] systemd[1]: Finished Load Kernel Module fuse.=0D
[=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mLoad Kernel Module fuse=1B[0m.=
=0D
[   72.030929] systemd[1]: nfs-convert.service: Succeeded.=0D
[   72.143720] systemd[1]: Finished Preprocess NFS configuration convertion=
=2E=0D
[=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mPreprocess NFS configuration co=
nvertion=1B[0m.=0D
[   72.226306] systemd[1]: systemd-modules-load.service: Main process exite=
d, code=3Dexited, status=3D1/FAILURE=0D
[   72.288874] systemd[1]: systemd-modules-load.service: Failed with result=
 'exit-code'.=0D
[   72.405669] systemd[1]: Failed to start Load Kernel Modules.=0D
[=1B[0;1;31mFAILED=1B[0m] Failed to start =1B[0;1;39mLoad Kernel Modules=1B=
[0m.=0D
See 'systemctl status systemd-modules-load.service' for details.=0D
[   72.490312] systemd[1]: systemd-modules-load.service: Consumed 1.437s CP=
U time.=0D
[   72.572603] systemd[1]: Condition check resulted in FUSE Control File Sy=
stem being skipped.=0D
[   72.596232] systemd[1]: Condition check resulted in Kernel Configuration=
 File System being skipped.=0D
[   72.813113] systemd[1]: Starting Apply Kernel Variables...=0D
         Starting =1B[0;1;39mApply Kernel Variables=1B[0m...=0D
[   73.694614] systemd[1]: systemd-remount-fs.service: Main process exited,=
 code=3Dexited, status=3D1/FAILURE=0D
[   73.736508] systemd[1]: systemd-remount-fs.service: Failed with result '=
exit-code'.=0D
[   73.781556] systemd[1]: Failed to start Remount Root and Kernel File Sys=
tems.=0D
[=1B[0;1;31mFAILED=1B[0m] Failed to start =1B[0;1;39mRemount Root and Kerne=
l File Systems=1B[0m.=0D
See 'systemctl status systemd-remount-fs.service' for details.=0D
[   73.866320] systemd[1]: systemd-remount-fs.service: Consumed 2.933s CPU =
time.=0D
[   73.899554] systemd[1]: Condition check resulted in First Boot Wizard be=
ing skipped.=0D
[   73.988234] systemd[1]: Condition check resulted in Rebuild Hardware Dat=
abase being skipped.=0D
[   74.177164] systemd[1]: Starting Load/Save Random Seed...=0D
         Starting =1B[0;1;39mLoad/Save Random Seed=1B[0m...=0D
[   74.298545] systemd[1]: Condition check resulted in Create System Users =
being skipped.=0D
[   74.658647] systemd[1]: Starting Create Static Device Nodes in /dev...=0D
         Starting =1B[0;1;39mCreate Static Device Nodes in /dev=1B[0m...=0D
[   75.179823] systemd[1]: Finished Apply Kernel Variables.=0D
[=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mApply Kernel Variables=1B[0m.=0D

--0j05xWKIImxbmXes--

--kqEhgLg8x7cpsgov
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCcsrgAKCRB4tDGHoIJi
0ifDAQCEdjZmMk5v90XAPDaC50bzs22JtCBGv4EM0O8+1NNTagEAuhIRFaoNDmw/
0v0raH6O28j7s+LP2Z5MS8RS79IuiAk=
=SusM
-----END PGP SIGNATURE-----

--kqEhgLg8x7cpsgov--
