Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C4C2B0AB7
	for <lists+linux-arch@lfdr.de>; Thu, 12 Nov 2020 17:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgKLQtt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Nov 2020 11:49:49 -0500
Received: from foss.arm.com ([217.140.110.172]:54180 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728086AbgKLQtt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 12 Nov 2020 11:49:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FE07142F;
        Thu, 12 Nov 2020 08:49:47 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 991623F73C;
        Thu, 12 Nov 2020 08:49:45 -0800 (PST)
Date:   Thu, 12 Nov 2020 16:49:43 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "kernel-team@android.com" <kernel-team@android.com>
Subject: Re: [PATCH 2/6] arm64: Allow mismatched 32-bit EL0 support
Message-ID: <20201112164943.7kdskvxcnuodphow@e107158-lin.cambridge.arm.com>
References: <20201030161353.GC32582@willie-the-truck>
 <20201102114444.GC21082@gaia>
 <20201105213846.GA8600@willie-the-truck>
 <20201106125425.u6qoswsjfskyxtoo@e107158-lin.cambridge.arm.com>
 <20201106130007.GA10605@willie-the-truck>
 <20201106144835.q363ezyse4vc5kdg@e107158-lin.cambridge.arm.com>
 <20201109135259.GA14526@willie-the-truck>
 <20201111162700.p4sem2fup5qjjbqz@e107158-lin.cambridge.arm.com>
 <20201112102424.GB19506@willie-the-truck>
 <20201112115555.65sfsod6uf6xm5gy@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="f427e6ds5xakvtyh"
Content-Disposition: inline
In-Reply-To: <20201112115555.65sfsod6uf6xm5gy@e107158-lin.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--f427e6ds5xakvtyh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On 11/12/20 11:55, Qais Yousef wrote:
> On 11/12/20 10:24, Will Deacon wrote:
> > On Wed, Nov 11, 2020 at 04:27:00PM +0000, Qais Yousef wrote:
> > > On 11/09/20 13:52, Will Deacon wrote:
> > > > On Fri, Nov 06, 2020 at 02:48:35PM +0000, Qais Yousef wrote:
> > > > > On 11/06/20 13:00, Will Deacon wrote:
> > > > > > On Fri, Nov 06, 2020 at 12:54:25PM +0000, Qais Yousef wrote:
> > > > > > > FWIW I have my v3 over here in case it's of any help. It solves the problem of
> > > > > > > HWCAP discovery when late AArch32 CPU is booted by populating boot_cpu_date
> > > > > > > with 32bit features then.
> > > > > > > 
> > > > > > > 	git clone https://git.gitlab.arm.com/linux-arm/linux-qy.git -b asym-aarch32-upstream-v3 origin/asym-aarch32-upstream-v3
> > > > > > 
> > > > > > Cheers, I've done something similar. I was hoping to post it today, but I've
> > > > > > been side-tracked with bug fixing this morning. The main headache I ended up
> > > > > > with was allowing late-onlining of 64-bit-only CPUs if all the boot CPUs
> > > > > > are 32-bit capable. What do you do in that case?
> > > > > 
> > > > > Do you mean if CPUs 0-3 were 32bit capable and we boot with maxcpus=4 then
> > > > > attempt to bring the remaining 64bit-only cpus online later?
> > > > 
> > > > Right. I think we will refuse to online them. I'll post my attempt at
> > > > handling that shortly.
> > > 
> > > Sorry for the delayed response.
> > > 
> > > You're right, I tried that and they refuse to come online. We missed that tbh.
> > > 
> > > Haven't thought what we should do yet. I tried your v2 and it failed similarly.
> > 
> > Hmm, it shouldn't do. Please could you provide the log? My hunch is that you
> > are blatting 32-bit EL1 support as well, and we can't handle a mismatch for
> > that with a late CPU. Do you know if the CPUs being integrated into these
> > broken designs have a mismatch at EL1 as well?
> 
> Hmm my test could have been invalid then. We shouldn't have mismatch at EL1,
> for ease of testing I used a hacked up patch to fake asymmetry on Juno. Testing
> on FVP now, it takes time to boot up though..
> 
> Let me re-run this and get you the log from proper environment. Assuming it
> still fails.

Still fails the same on FVP. dmesg attached. There's a splat shortly after
attempting to online CPU 4.

	# cat /sys/devices/system/cpu/online
	0-3
	# cat /sys/devices/system/cpu/aarch32_el0
	0-3

Now while writing this I just realized I tell the FVP to disable aarch32
support at EL0. So this might still make the kernel thinks there's AArch32
support at EL1 - which seems is what makes your series get confused?

Anyway. No real hardware to test on and not sure if I can tell the FVP to
disable AArch32 support at EL1.

/me goes and dig

Thanks

--
Qais Yousef

--f427e6ds5xakvtyh
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="dmesg.txt"

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd0f0]
[    0.000000] Linux version 5.10.0-rc2-00006-g0e6c7349e720-dirty (qyousef@e107158-lin) (aarch64-linux-gnu-gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #239 SMP PREEMPT Thu Nov 12 11:39:59 GMT 2020
[    0.000000] Machine model: FVP Base RevC
[    0.000000] earlycon: pl11 at MMIO 0x000000001c090000 (options '')
[    0.000000] printk: bootconsole [pl11] enabled
[    0.000000] efi: UEFI not found.
[    0.000000] [Firmware Bug]: Kernel image misaligned at boot, please fix your bootloader!
[    0.000000] Reserved memory: created DMA memory pool at 0x0000000018000000, size 8 MiB
[    0.000000] OF: reserved mem: initialized node vram@18000000, compatible id shared-dma-pool
[    0.000000] cma: Reserved 32 MiB at 0x00000000fe000000
[    0.000000] NUMA: No NUMA configuration found
[    0.000000] NUMA: Faking a node at [mem 0x0000000080000000-0x00000008ffffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x8ff7f7000-0x8ff7f8fff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000080000000-0x00000000bfffffff]
[    0.000000]   DMA32    [mem 0x00000000c0000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000008ffffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080000000-0x00000000ffffffff]
[    0.000000]   node   0: [mem 0x0000000880000000-0x00000008ffffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x00000008ffffffff]
[    0.000000] On node 0 totalpages: 1048576
[    0.000000]   DMA zone: 4096 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 262144 pages, LIFO batch:63
[    0.000000]   DMA32 zone: 4096 pages used for memmap
[    0.000000]   DMA32 zone: 262144 pages, LIFO batch:63
[    0.000000]   Normal zone: 8192 pages used for memmap
[    0.000000]   Normal zone: 524288 pages, LIFO batch:63
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: Using PSCI v0.1 Function IDs from DT
[    0.000000] percpu: Embedded 51 pages/cpu s168080 r8192 d32624 u208896
[    0.000000] pcpu-alloc: s168080 r8192 d32624 u208896 alloc=51*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 [0] 6 [0] 7 
[    0.000000] Detected PIPT I-cache on CPU0
[    0.000000] CPU features: detected: GIC system register CPU interface
[    0.000000] CPU features: kernel page table isolation forced ON by KASLR
[    0.000000] CPU features: detected: Kernel page table isolation (KPTI)
[    0.000000] CPU features: detected: Spectre-v2
[    0.000000] CPU features: detected: Spectre-v4
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 1032192
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: console=ttyAMA0 earlycon=pl011,0x1c090000 root=/dev/vda rootwait allow_mismatched_32bit_el0 maxcpus=4
[    0.000000] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] software IO TLB: mapped [mem 0x00000000bbfff000-0x00000000bffff000] (64MB)
[    0.000000] Memory: 3901352K/4194304K available (26752K kernel code, 4802K rwdata, 15452K rodata, 54144K init, 11359K bss, 260184K reserved, 32768K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] ftrace: allocating 82932 entries in 324 pages
[    0.000000] ftrace: allocated 324 pages with 3 groups
[    0.000000] Running RCU self tests
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu: 	RCU event tracing is enabled.
[    0.000000] rcu: 	RCU lockdep checking is enabled.
[    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=8.
[    0.000000] 	Trampoline variant of Tasks RCU enabled.
[    0.000000] 	Rude variant of Tasks RCU enabled.
[    0.000000] 	Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: 224 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] GICv3: Distributor has no Range Selector support
[    0.000000] GICv3: 16 PPIs implemented
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x000000002f100000
[    0.000000] ITS [mem 0x2f020000-0x2f03ffff]
[    0.000000] ITS@0x000000002f020000: allocated 8192 Devices @880250000 (indirect, esz 8, psz 64K, shr 1)
[    0.000000] ITS@0x000000002f020000: allocated 8192 Virtual CPUs @880260000 (indirect, esz 8, psz 64K, shr 1)
[    0.000000] ITS@0x000000002f020000: allocated 8192 Interrupt Collections @880270000 (flat, esz 8, psz 64K, shr 1)
[    0.000000] GICv3: using LPI property table @0x0000000880280000
[    0.000000] GICv3: CPU0: using allocated LPI pending table @0x0000000880290000
[    0.000000] random: get_random_bytes called from start_kernel+0x3a8/0x574 with crng_init=0
[    0.000000] clocksource: arm,sp804: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275 ns
[    0.000000] sched_clock: 32 bits at 1000kHz, resolution 1000ns, wraps every 2147483647500ns
[    0.001387] Failed to initialize '/bus@8000000/motherboard-bus/iofpga-bus@300000000/timer@120000': -22
[    0.005714] arch_timer: cp15 timer(s) running at 25.16MHz (phys).
[    0.005919] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x5cdd39714, max_idle_ns: 440795202620 ns
[    0.006286] sched_clock: 56 bits at 25MHz, resolution 39ns, wraps every 4398046511084ns
[    0.020121] Console: colour dummy device 80x25
[    0.022074] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.023050] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.024027] ... MAX_LOCK_DEPTH:          48
[    0.025024] ... MAX_LOCKDEP_KEYS:        8192
[    0.026631] ... CLASSHASH_SIZE:          4096
[    0.027608] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.028422] ... MAX_LOCKDEP_CHAINS:      65536
[    0.029398] ... CHAINHASH_SIZE:          32768
[    0.030958]  memory used by lock dependency info: 6365 kB
[    0.032002]  memory used for stack traces: 4224 kB
[    0.032979]  per task-struct memory footprint: 1920 bytes
[    0.038769] Calibrating delay loop (skipped), value calculated using timer frequency.. 50.33 BogoMIPS (lpj=100663)
[    0.040954] pid_max: default: 32768 minimum: 301
[    0.052020] LSM: Security Framework initializing
[    0.058532] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.059834] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.359022] rcu: Hierarchical SRCU implementation.
[    0.473083] Platform MSI: msi-controller@2f020000 domain created
[    0.482364] PCI/MSI: /interrupt-controller@2f000000/msi-controller@2f020000 domain created
[    0.515889] EFI services will not be available.
[    0.604752] smp: Bringing up secondary CPUs ...
[    0.745022] Detected PIPT I-cache on CPU1
[    0.745419] GICv3: CPU1: found redistributor 100 region 0:0x000000002f120000
[    0.746033] GICv3: CPU1: using allocated LPI pending table @0x00000008802a0000
[    0.747406] CPU1: Booted secondary processor 0x0000000100 [0x410fd0f0]
[    0.933372] Detected PIPT I-cache on CPU2
[    0.934167] GICv3: CPU2: found redistributor 200 region 0:0x000000002f140000
[    0.934565] GICv3: CPU2: using allocated LPI pending table @0x00000008802b0000
[    0.936314] CPU2: Booted secondary processor 0x0000000200 [0x410fd0f0]
[    1.111392] Detected PIPT I-cache on CPU3
[    1.112243] GICv3: CPU3: found redistributor 300 region 0:0x000000002f160000
[    1.112584] GICv3: CPU3: using allocated LPI pending table @0x00000008802c0000
[    1.113802] CPU3: Booted secondary processor 0x0000000300 [0x410fd0f0]
[    1.157328] smp: Brought up 1 node, 4 CPUs
[    1.173380] SMP: Total of 4 processors activated.
[    1.174580] CPU features: detected: 32-bit EL0 Support
[    1.175882] CPU features: detected: 32-bit EL1 Support
[    4.568064] CPU: All CPU(s) started at EL2
[    4.574484] alternatives: patching kernel code
[    4.738533] devtmpfs: initialized
[    5.517367] KASLR disabled due to lack of seed
[    5.659444] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    5.661397] futex hash table entries: 2048 (order: 6, 262144 bytes, linear)
[    5.779398] pinctrl core: initialized pinctrl subsystem
[    6.002946] DMI not present or invalid.
[    6.083214] NET: Registered protocol family 16
[    6.471294] DMA: preallocated 512 KiB GFP_KERNEL pool for atomic allocations
[    6.480340] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    6.489522] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    6.504023] audit: initializing netlink subsys (disabled)
[    6.525878] audit: type=2000 audit(4.728:1): state=initialized audit_enabled=0 res=1
[    6.707783] thermal_sys: Registered thermal governor 'step_wise'
[    6.708269] thermal_sys: Registered thermal governor 'power_allocator'
[    6.724162] cpuidle: using governor menu
[    6.744893] NET: Registered protocol family 42
[    6.784281] hw-breakpoint: found 16 breakpoint and 16 watchpoint registers.
[    6.802673] ASID allocator initialised with 32768 entries
[    6.990010] Serial: AMBA PL011 UART driver
[   10.396603] 1c090000.serial: ttyAMA0 at MMIO 0x1c090000 (irq = 21, base_baud = 0) is a PL011 rev2
[   10.404561] printk: console [ttyAMA0] enabled
[   10.406677] printk: bootconsole [pl11] disabled
[   10.552510] 1c0a0000.serial: ttyAMA1 at MMIO 0x1c0a0000 (irq = 22, base_baud = 0) is a PL011 rev2
[   10.671813] 1c0b0000.serial: ttyAMA2 at MMIO 0x1c0b0000 (irq = 23, base_baud = 0) is a PL011 rev2
[   10.801915] 1c0c0000.serial: ttyAMA3 at MMIO 0x1c0c0000 (irq = 24, base_baud = 0) is a PL011 rev2
[   16.484622] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[   16.487403] HugeTLB registered 32.0 MiB page size, pre-allocated 0 pages
[   16.489203] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[   16.490824] HugeTLB registered 64.0 KiB page size, pre-allocated 0 pages
[   17.066760] cryptd: max_cpu_qlen set to 1000
[   17.808695] raid6: neonx8   gen()    51 MB/s
[   17.892087] raid6: neonx8   xor()    35 MB/s
[   17.976501] raid6: neonx4   gen()    48 MB/s
[   18.061787] raid6: neonx4   xor()    34 MB/s
[   18.145446] raid6: neonx2   gen()    43 MB/s
[   18.228780] raid6: neonx2   xor()    28 MB/s
[   18.313689] raid6: neonx1   gen()    35 MB/s
[   18.398725] raid6: neonx1   xor()    22 MB/s
[   18.483499] raid6: int64x8  gen()    17 MB/s
[   18.567648] raid6: int64x8  xor()     9 MB/s
[   18.652244] raid6: int64x4  gen()    18 MB/s
[   18.739269] raid6: int64x4  xor()     9 MB/s
[   18.824808] raid6: int64x2  gen()    16 MB/s
[   18.911490] raid6: int64x2  xor()     9 MB/s
[   18.995965] raid6: int64x1  gen()    14 MB/s
[   19.079808] raid6: int64x1  xor()     7 MB/s
[   19.081397] raid6: using algorithm neonx8 gen() 51 MB/s
[   19.082987] raid6: .... xor() 35 MB/s, rmw enabled
[   19.084179] raid6: using neon recovery algorithm
[   19.158910] ACPI: Interpreter disabled.
[   19.375264] iommu: Default domain type: Translated 
[   19.416376] vgaarb: loaded
[   19.497660] SCSI subsystem initialized
[   19.531351] libata version 3.00 loaded.
[   19.582132] usbcore: registered new interface driver usbfs
[   19.592805] usbcore: registered new interface driver hub
[   19.613071] usbcore: registered new device driver usb
[   19.707643] mc: Linux media interface: v0.10
[   19.715597] videodev: Linux video capture interface: v2.00
[   19.737446] pps_core: LinuxPPS API ver. 1 registered
[   19.739035] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[   19.743804] PTP clock support registered
[   19.809184] EDAC MC: Ver: 3.0.0
[   19.987732] FPGA manager framework
[   20.023151] Advanced Linux Sound Architecture Driver Initialized.
[   20.154281] Bluetooth: Core ver 2.22
[   20.160691] NET: Registered protocol family 31
[   20.163023] Bluetooth: HCI device and connection manager initialized
[   20.166997] Bluetooth: HCI socket layer initialized
[   20.169209] Bluetooth: L2CAP socket layer initialized
[   20.174944] Bluetooth: SCO socket layer initialized
[   20.263954] clocksource: Switched to clocksource arch_sys_counter
[  132.044209] VFS: Disk quotas dquot_6.6.0
[  132.056835] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[  132.135911] pnp: PnP ACPI: disabled
[  134.446227] NET: Registered protocol family 2
[  134.529633] tcp_listen_portaddr_hash hash table entries: 2048 (order: 5, 163840 bytes, linear)
[  134.562217] TCP established hash table entries: 32768 (order: 6, 262144 bytes, linear)
[  134.673187] TCP bind hash table entries: 32768 (order: 9, 2359296 bytes, linear)
[  134.931578] TCP: Hash tables configured (established 32768 bind 32768)
[  134.965433] UDP hash table entries: 2048 (order: 6, 327680 bytes, linear)
[  135.009252] UDP-Lite hash table entries: 2048 (order: 6, 327680 bytes, linear)
[  135.081481] NET: Registered protocol family 1
[  135.212503] RPC: Registered named UNIX socket transport module.
[  135.216994] RPC: Registered udp transport module.
[  135.220478] RPC: Registered tcp transport module.
[  135.224059] RPC: Registered tcp NFSv4.1 backchannel transport module.
[  135.348204] PCI: CLS 0 bytes, default 64
[ 1598.688719] hw perfevents: enabled with armv8_pmuv3 PMU driver, 9 counters available
[ 1598.705155] kvm [1]: IPA Size Limit: 40 bits
[ 1599.985716] kvm [1]: vgic-v2@2c02f000
[ 1599.992608] kvm [1]: GIC system register CPU interface enabled
[ 1600.019626] kvm [1]: vgic interrupt IRQ9
[ 1600.049294] kvm [1]: Hyp mode initialized successfully
[ 1601.384836] Initialise system trusted keyrings
[ 1601.425225] workingset: timestamp_bits=44 max_order=20 bucket_order=0
[ 1605.817544] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[ 1606.057839] NFS: Registering the id_resolver key type
[ 1606.065389] Key type id_resolver registered
[ 1606.069977] Key type id_legacy registered
[ 1606.120700] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[ 1606.168705] fuse: init (API version 7.32)
[ 1606.373793] 9p: Installing v9fs 9p2000 file system support
[ 1606.744515] jitterentropy: Initialization failed with host not compliant with requirements: 2
[ 1606.747979] NET: Registered protocol family 38
[ 1606.752861] xor: measuring software checksum speed
[ 1607.123467]    8regs           :    27 MB/sec
[ 1607.400137]    32regs          :    36 MB/sec
[ 1607.589288]    arm64_neon      :    53 MB/sec
[ 1607.592544] xor: using function: arm64_neon (53 MB/sec)
[ 1607.595798] Key type asymmetric registered
[ 1607.600518] Asymmetric key parser 'x509' registered
[ 1607.609180] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
[ 1607.613419] io scheduler mq-deadline registered
[ 1607.616700] io scheduler kyber registered
[ 1609.357679] pci-host-generic 40000000.pci: host bridge /pci@40000000 ranges:
[ 1609.365329] pci-host-generic 40000000.pci:      MEM 0x0050000000..0x005fffffff -> 0x0050000000
[ 1609.377976] pci-host-generic 40000000.pci: ECAM at [mem 0x40000000-0x4fffffff] for [bus 00-01]
[ 1609.424707] pci-host-generic 40000000.pci: PCI host bridge to bus 0000:00
[ 1609.428284] pci_bus 0000:00: root bus resource [bus 00-01]
[ 1609.432257] pci_bus 0000:00: root bus resource [mem 0x50000000-0x5fffffff]
[ 1609.444756] pci 0000:00:00.0: [1af4:1001] type 00 class 0x018000
[ 1609.450138] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x00000fff]
[ 1609.456894] pci 0000:00:00.0: reg 0x18: [mem 0x00000000-0x00000fff]
[ 1609.461684] pci 0000:00:00.0: reg 0x20: [mem 0x00000000-0x00000fff]
[ 1609.484709] pci 0000:00:00.0: PME# supported from D3hot
[ 1609.565374] pci 0000:00:02.0: [1af4:1001] type 00 class 0x018000
[ 1609.572528] pci 0000:00:02.0: reg 0x10: [mem 0x00000000-0x00000fff]
[ 1609.577569] pci 0000:00:02.0: reg 0x18: [mem 0x00000000-0x00000fff]
[ 1609.584567] pci 0000:00:02.0: reg 0x20: [mem 0x00000000-0x00000fff]
[ 1609.604750] pci 0000:00:02.0: PME# supported from D3hot
[ 1609.680759] pci 0000:00:03.0: [0abc:aced] type 00 class 0x010601
[ 1609.685804] pci 0000:00:03.0: reg 0x10: [mem 0x00000000-0x00001fff]
[ 1609.692004] pci 0000:00:03.0: reg 0x14: [mem 0x00000000-0x00001fff]
[ 1609.696384] pci 0000:00:03.0: reg 0x18: [mem 0x00000000-0x00000fff]
[ 1609.700479] pci 0000:00:03.0: reg 0x1c: [mem 0x00000000-0x00001fff]
[ 1609.705010] pci 0000:00:03.0: reg 0x20: [mem 0x00000000-0x00000fff]
[ 1609.709220] pci 0000:00:03.0: reg 0x24: [mem 0x00000000-0x00001fff]
[ 1609.724718] pci 0000:00:03.0: PME# supported from D3hot
[ 1609.848077] pci 0000:00:03.0: BAR 0: assigned [mem 0x50000000-0x50001fff]
[ 1609.851983] pci 0000:00:03.0: BAR 1: assigned [mem 0x50002000-0x50003fff]
[ 1609.856245] pci 0000:00:03.0: BAR 3: assigned [mem 0x50004000-0x50005fff]
[ 1609.860219] pci 0000:00:03.0: BAR 5: assigned [mem 0x50006000-0x50007fff]
[ 1609.864192] pci 0000:00:00.0: BAR 0: assigned [mem 0x50008000-0x50008fff]
[ 1609.868259] pci 0000:00:00.0: BAR 2: assigned [mem 0x50009000-0x50009fff]
[ 1609.872140] pci 0000:00:00.0: BAR 4: assigned [mem 0x5000a000-0x5000afff]
[ 1609.876234] pci 0000:00:02.0: BAR 0: assigned [mem 0x5000b000-0x5000bfff]
[ 1609.880087] pci 0000:00:02.0: BAR 2: assigned [mem 0x5000c000-0x5000cfff]
[ 1609.884060] pci 0000:00:02.0: BAR 4: assigned [mem 0x5000d000-0x5000dfff]
[ 1609.888034] pci 0000:00:03.0: BAR 2: assigned [mem 0x5000e000-0x5000efff]
[ 1609.892008] pci 0000:00:03.0: BAR 4: assigned [mem 0x5000f000-0x5000ffff]
[ 1610.171807] IPMI message handler: version 39.2
[ 1610.191989] ipmi device interface
[ 1610.204359] ipmi_si: IPMI System Interface driver
[ 1610.264633] ipmi_si: Unable to find any System Interface(s)
[ 1610.360103] EINJ: ACPI disabled.
[ 1613.177667] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[ 1613.888301] SuperH (H)SCI(F) driver initialized
[ 1613.948012] msm_serial: driver initialized
[ 1614.364740] arm-smmu-v3 2b400000.iommu: ias 48-bit, oas 48-bit (features 0x00001fef)
[ 1614.392184] arm-smmu-v3 2b400000.iommu: allocated 65536 entries for cmdq
[ 1614.505975] arm-smmu-v3 2b400000.iommu: allocated 32768 entries for evtq
[ 1616.056898] panel-simple panel: supply power not found, using dummy regulator
[ 1616.143343] ------------[ cut here ]------------
[ 1616.144952] WARNING: CPU: 1 PID: 1 at drivers/gpu/drm/panel/panel-simple.c:467 panel_simple_parse_panel_timing_node+0x1e4/0x1f8
[ 1616.146416] Modules linked in:
[ 1616.148207] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.10.0-rc2-00006-g0e6c7349e720-dirty #239
[ 1616.149701] Hardware name: FVP Base RevC (DT)
[ 1616.151135] pstate: 20000005 (nzCv daif -PAN -UAO -TCO BTYPE=--)
[ 1616.152601] pc : panel_simple_parse_panel_timing_node+0x1e4/0x1f8
[ 1616.154102] lr : panel_simple_probe+0x2b4/0x3e0
[ 1616.155375] sp : ffff80001005ba60
[ 1616.156670] x29: ffff80001005ba60 x28: 0000000000000000 
[ 1616.159188] x27: ffff8000129d04e0 x26: ffff800012ad10d8 
[ 1616.161622] x25: ffff8000161d0a38 x24: 0000000000000000 
[ 1616.164006] x23: ffff8000120d4848 x22: ffff000800388000 
[ 1616.166390] x21: ffff000800ab0010 x20: ffff000800388000 
[ 1616.168937] x19: ffff000800d3b680 x18: 0000000000001460 
[ 1616.171319] x17: 0000000000000004 x16: 0000000000000000 
[ 1616.173597] x15: ffffffffffffffff x14: ffffffff00000000 
[ 1616.176324] x13: ffffffffffffffff x12: 0000000000000020 
[ 1616.178709] x11: 0000000000000004 x10: 0101010101010101 
[ 1616.181093] x9 : ffff800010dcf4ec x8 : 00000000ffffffff 
[ 1616.183526] x7 : 00000000000000e3 x6 : 0000000000000001 
[ 1616.185968] x5 : ffff00087f805b10 x4 : 0000000000000000 
[ 1616.188245] x3 : ffff8000120d4848 x2 : ffff80001005bb18 
[ 1616.190850] x1 : 0000000000000001 x0 : ffff000800ab0010 
[ 1616.193293] Call trace:
[ 1616.194756]  panel_simple_parse_panel_timing_node+0x1e4/0x1f8
[ 1616.196221]  panel_simple_probe+0x2b4/0x3e0
[ 1616.197523]  panel_simple_platform_probe+0x3c/0x58
[ 1616.199030]  platform_drv_probe+0x5c/0xb0
[ 1616.200453]  really_probe+0xec/0x3b8
[ 1616.201918]  driver_probe_device+0x60/0xc0
[ 1616.203345]  device_driver_attach+0x7c/0x88
[ 1616.204538]  __driver_attach+0x60/0xf0
[ 1616.206149]  bus_for_each_dev+0x78/0xd0
[ 1616.207507]  driver_attach+0x2c/0x38
[ 1616.208917]  bus_add_driver+0x158/0x200
[ 1616.210381]  driver_register+0x6c/0x128
[ 1616.211746]  __platform_driver_register+0x50/0x60
[ 1616.213279]  panel_simple_init+0x2c/0x54
[ 1616.214613]  do_one_initcall+0x94/0x4b0
[ 1616.216079]  kernel_init_freeable+0x2c0/0x32c
[ 1616.217253]  kernel_init+0x1c/0x128
[ 1616.218844]  ret_from_fork+0x10/0x30
[ 1616.220223] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.10.0-rc2-00006-g0e6c7349e720-dirty #239
[ 1616.221624] Hardware name: FVP Base RevC (DT)
[ 1616.222915] Call trace:
[ 1616.224406]  dump_backtrace+0x0/0x1b0
[ 1616.225734]  show_stack+0x20/0x70
[ 1616.227187]  dump_stack+0xf8/0x168
[ 1616.228610]  __warn+0xfc/0x180
[ 1616.229968]  report_bug+0xfc/0x170
[ 1616.231377]  bug_handler+0x28/0x70
[ 1616.232750]  call_break_hook+0x70/0x88
[ 1616.234144]  brk_handler+0x24/0x68
[ 1616.235532]  do_debug_exception+0xb8/0x130
[ 1616.236911]  el1_sync_handler+0xd8/0x120
[ 1616.238377]  el1_sync+0x80/0x100
[ 1616.239721]  panel_simple_parse_panel_timing_node+0x1e4/0x1f8
[ 1616.241143]  panel_simple_probe+0x2b4/0x3e0
[ 1616.242608]  panel_simple_platform_probe+0x3c/0x58
[ 1616.244073]  platform_drv_probe+0x5c/0xb0
[ 1616.245465]  really_probe+0xec/0x3b8
[ 1616.246927]  driver_probe_device+0x60/0xc0
[ 1616.248305]  device_driver_attach+0x7c/0x88
[ 1616.249441]  __driver_attach+0x60/0xf0
[ 1616.251164]  bus_for_each_dev+0x78/0xd0
[ 1616.252536]  driver_attach+0x2c/0x38
[ 1616.253838]  bus_add_driver+0x158/0x200
[ 1616.255399]  driver_register+0x6c/0x128
[ 1616.256768]  __platform_driver_register+0x50/0x60
[ 1616.258233]  panel_simple_init+0x2c/0x54
[ 1616.259699]  do_one_initcall+0x94/0x4b0
[ 1616.261000]  kernel_init_freeable+0x2c0/0x32c
[ 1616.262464]  kernel_init+0x1c/0x128
[ 1616.263880]  ret_from_fork+0x10/0x30
[ 1616.265154] irq event stamp: 2125172
[ 1616.266533] hardirqs last  enabled at (2125171): [<ffff800011a970a0>] _raw_spin_unlock_irqrestore+0xa0/0xa8
[ 1616.268115] hardirqs last disabled at (2125172): [<ffff8000100ba094>] debug_exception_enter+0xb4/0xf0
[ 1616.269789] softirqs last  enabled at (2124972): [<ffff800010090a8c>] __do_softirq+0x604/0x684
[ 1616.271295] softirqs last disabled at (2124967): [<ffff800010130c70>] irq_exit+0x180/0x1a0
[ 1616.272884] ---[ end trace 8ab98a1b1a71c11c ]---
[ 1616.276857] panel-simple panel: Reject override mode: panel has a fixed mode
[ 1616.280434] panel-simple panel: Specify missing connector_type
[ 1616.441990] drm-clcd-pl111 1c1f0000.clcd: assigned reserved memory node vram@18000000
[ 1616.445570] drm-clcd-pl111 1c1f0000.clcd: using device-specific reserved memory
[ 1616.449151] drm-clcd-pl111 1c1f0000.clcd: no max memory bandwidth specified, assume unlimited
[ 1616.473553] drm-clcd-pl111 1c1f0000.clcd: DVI muxed to motherboard CLCD
[ 1616.483982] drm-clcd-pl111 1c1f0000.clcd: can't find the sysreg device, deferring
[ 1616.485772] drm-clcd-pl111 1c1f0000.clcd: Versatile Express init failed - -517
[ 1616.632907] cacheinfo: Unable to detect cache hierarchy for CPU 0
[ 1621.848727] loop: module loaded
[ 1632.609010] virtio_blk virtio0: [vda] 0 512-byte logical blocks (0 B/0 B)
[ 1633.432663] basic-mmio-gpio: Failed to locate of_node [id: -2]
[ 1633.572138] basic-mmio-gpio: Failed to locate of_node [id: -2]
[ 1633.705986] basic-mmio-gpio: Failed to locate of_node [id: -2]
[ 1636.908623] mpt3sas version 35.100.00.00 loaded
[ 1637.410414] ahci 0000:00:03.0: Adding to iommu group 0
[ 1637.497303] ahci 0000:00:03.0: version 3.0
[ 1637.500908] ahci 0000:00:03.0: enabling device (0000 -> 0002)
[ 1637.560154] ahci 0000:00:03.0: AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
[ 1637.562106] ahci 0000:00:03.0: flags: 64bit ncq only 
[ 1637.809828] scsi host0: ahci
[ 1637.969769] ata1: SATA max UDMA/133 abar m8192@0x50006000 port 0x50006100 irq 41
[ 1638.312297] ata1: SATA link down (SStatus 0 SControl 300)
[ 1639.064548] libphy: Fixed MDIO Bus: probed
[ 1639.517510] tun: Universal TUN/TAP device driver, 1.6
[ 1639.727960] virtio_net: probe of virtio2 failed with error -2
[ 1639.956988] thunder_xcv, ver 1.0
[ 1639.972589] thunder_bgx, ver 1.0
[ 1639.992750] nicpf, ver 1.0
[ 1640.089310] hclge is initializing
[ 1640.108005] hns3: Hisilicon Ethernet Network Driver for Hip08 Family - version
[ 1640.109632] hns3: Copyright (c) 2017 Huawei Corporation.
[ 1640.124932] e1000e: Intel(R) PRO/1000 Network Driver
[ 1640.127854] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[ 1640.141762] igb: Intel(R) Gigabit Ethernet Network Driver
[ 1640.145278] igb: Copyright (c) 2007-2014 Intel Corporation.
[ 1640.156670] igbvf: Intel(R) Gigabit Virtual Function Network Driver
[ 1640.160438] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[ 1640.233493] sky2: driver version 1.30
[ 1640.410088] smc91x 1a000000.ethernet (unnamed net_device) (uninitialized): smc91x: IOADDR (____ptrval____) doesn't match configuration (300).
[ 1640.413832] smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@fluxnic.net>
[ 1643.585381] smc91x 1a000000.ethernet eth0: SMC91C11xFD (rev 1) at (____ptrval____) IRQ 15
[ 1643.588897] 
[ 1643.589693] smc91x 1a000000.ethernet eth0: Ethernet addr: 00:02:f7:ef:36:98
[ 1643.969175] pegasus: v0.9.3 (2013/04/25), Pegasus/Pegasus II USB Ethernet driver
[ 1643.980699] usbcore: registered new interface driver pegasus
[ 1643.992619] usbcore: registered new interface driver rtl8150
[ 1644.005733] usbcore: registered new interface driver r8152
[ 1644.016859] usbcore: registered new interface driver lan78xx
[ 1644.029972] usbcore: registered new interface driver asix
[ 1644.041273] usbcore: registered new interface driver ax88179_178a
[ 1644.052829] usbcore: registered new interface driver cdc_ether
[ 1644.062159] usbcore: registered new interface driver dm9601
[ 1644.076838] usbcore: registered new interface driver CoreChips
[ 1644.089938] usbcore: registered new interface driver smsc75xx
[ 1644.105074] usbcore: registered new interface driver smsc95xx
[ 1644.116995] usbcore: registered new interface driver net1080
[ 1644.128121] usbcore: registered new interface driver plusb
[ 1644.137464] usbcore: registered new interface driver cdc_subset
[ 1644.148387] usbcore: registered new interface driver zaurus
[ 1644.159910] usbcore: registered new interface driver MOSCHIP usb-ethernet driver
[ 1644.173901] usbcore: registered new interface driver cdc_ncm
[ 1644.221449] VFIO - User Level meta-driver version: 0.3
[ 1644.648370] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[ 1644.649997] ehci-pci: EHCI PCI platform driver
[ 1644.661879] ehci-platform: EHCI generic platform driver
[ 1644.685641] ehci-orion: EHCI orion driver
[ 1644.709067] ehci-exynos: EHCI Exynos driver
[ 1644.732514] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[ 1644.737400] ohci-pci: OHCI PCI platform driver
[ 1644.749201] ohci-platform: OHCI generic platform driver
[ 1644.772881] ohci-exynos: OHCI Exynos driver
[ 1644.868410] usbcore: registered new interface driver usb-storage
[ 1645.674265] rtc-pl031 1c170000.rtc: registered as rtc0
[ 1645.681247] rtc-pl031 1c170000.rtc: setting system clock to 2020-11-12T15:38:43 UTC (1605195523)
[ 1645.836391] i2c /dev entries driver
[ 1646.276670] usbcore: registered new interface driver uvcvideo
[ 1646.279848] USB Video Class driver (1.1.1)
[ 1646.281439] gspca_main: v2.14.0 registered
[ 1647.137302] sp805-wdt 1c0f0000.wdt: registration successful
[ 1647.452471] device-mapper: ioctl: 4.43.0-ioctl (2020-10-01) initialised: dm-devel@redhat.com
[ 1647.457637] Bluetooth: HCI UART driver ver 2.3
[ 1647.460898] Bluetooth: HCI UART protocol H4 registered
[ 1647.468365] Bluetooth: HCI UART protocol LL registered
[ 1647.492264] Bluetooth: HCI UART protocol Broadcom registered
[ 1647.499757] Bluetooth: HCI UART protocol QCA registered
[ 1647.513117] usbcore: registered new interface driver btusb
[ 1647.732613] mmci-pl18x 1c050000.mmci: Got CD GPIO
[ 1647.740818] mmci-pl18x 1c050000.mmci: Got WP GPIO
[ 1647.864027] mmci-pl18x 1c050000.mmci: mmc0: PL180 manf 41 rev0 at 0x1c050000 irq 17,18 (pio)
[ 1648.063617] sdhci: Secure Digital Host Controller Interface driver
[ 1648.065361] sdhci: Copyright(c) Pierre Ossman
[ 1648.131963] Synopsys Designware Multimedia Card Interface Driver
[ 1648.305759] sdhci-pltfm: SDHCI platform and OF driver helper
[ 1648.313956] input: PS/2 Generic Mouse as /devices/platform/bus@8000000/bus@8000000:motherboard-bus/bus@8000000:motherboard-bus:iofpga-bus@300000000/1c070000.kmi/serio1/input/input1
[ 1648.588933] ledtrig-cpu: registered to indicate activity on CPUs
[ 1648.909605] input: AT Raw Set 2 keyboard as /devices/platform/bus@8000000/bus@8000000:motherboard-bus/bus@8000000:motherboard-bus:iofpga-bus@300000000/1c060000.kmi/serio0/input/input2
[ 1649.000999] usbcore: registered new interface driver usbhid
[ 1649.004178] usbhid: USB HID core driver
[ 1650.760131] drop_monitor: Initializing network drop monitor service
[ 1651.172295] NET: Registered protocol family 10
[ 1651.436842] Segment Routing with IPv6
[ 1651.503998] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[ 1651.668506] NET: Registered protocol family 17
[ 1651.682016] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[ 1651.685592] Bluetooth: HIDP socket layer initialized
[ 1651.697362] 8021q: 802.1Q VLAN Support v1.8
[ 1651.769463] 9pnet: Installing 9P2000 support
[ 1651.876328] Key type dns_resolver registered
[ 1651.997166] registered taskstats version 1
[ 1652.001659] Loading compiled-in X.509 certificates
[ 1652.388279] Btrfs loaded, crc32c=crc32c-generic
[ 1653.089124] virtio-pci 0000:00:00.0: Adding to iommu group 1
[ 1653.170017] virtio-pci 0000:00:00.0: enabling device (0000 -> 0002)
[ 1653.177298] virtio-pci 0000:00:00.0: virtio_pci: leaving for legacy driver
[ 1653.470155] virtio_blk virtio3: [vdb] 0 512-byte logical blocks (0 B/0 B)
[ 1654.545215] virtio-pci 0000:00:02.0: Adding to iommu group 2
[ 1654.616794] virtio-pci 0000:00:02.0: enabling device (0000 -> 0002)
[ 1654.624281] virtio-pci 0000:00:02.0: virtio_pci: leaving for legacy driver
[ 1654.852188] virtio_blk virtio4: [vdc] 0 512-byte logical blocks (0 B/0 B)
[ 1655.924899] drm-clcd-pl111 1c1f0000.clcd: assigned reserved memory node vram@18000000
[ 1655.929046] drm-clcd-pl111 1c1f0000.clcd: using device-specific reserved memory
[ 1655.933417] drm-clcd-pl111 1c1f0000.clcd: no max memory bandwidth specified, assume unlimited
[ 1655.965604] drm-clcd-pl111 1c1f0000.clcd: DVI muxed to motherboard CLCD
[ 1656.032523] drm-clcd-pl111 1c1f0000.clcd: initializing Versatile Express PL111
[ 1656.105078] drm-clcd-pl111 1c1f0000.clcd: found panel on endpoint 0
[ 1656.381644] [drm] Initialized pl111 1.0.0 20170317 for 1c1f0000.clcd on minor 0
[ 1657.562213] Console: switching to colour frame buffer device 128x48
[ 1658.301312] drm-clcd-pl111 1c1f0000.clcd: [drm] fb0: pl111drmfb frame buffer device
[ 1658.471780] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[ 1659.821384] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[ 1659.860171] ALSA device list:
[ 1659.871695]   No soundcards found.
[ 1659.918064] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[ 1659.924544] platform regulatory.0: Falling back to sysfs fallback for: regulatory.db
[ 1659.944412] uart-pl011 1c090000.serial: no DMA platform data
[ 1665.641822] Freeing unused kernel memory: 54144K
[ 1665.656524] Run /init as init process
[ 1665.657716]   with arguments:
[ 1665.660100]     /init
[ 1665.660895]   with environment:
[ 1665.661553]     HOME=/
[ 1665.663676]     TERM=linux
[ 1720.461405] cfg80211: failed to load regulatory.db
[ 2264.157156] random: dd: uninitialized urandom read (512 bytes read)
[ 2391.928388] random: crng init done
[ 2400.436615] smc91x 1a000000.ethernet eth0: link up, 10Mbps, half-duplex, lpa 0x0000
[ 8569.024731] CPU features: CPU4: Detected conflict for capability 53 (32-bit EL1 Support), System: 1, CPU: 0
[ 8569.025525] CPU4: will not boot
[ 8574.269542] CPU4: failed to come online
[ 8574.282258] CPU4: died during early boot
[ 8599.142560] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[ 8599.149806] rcu: 	4-O...: (0 ticks this GP) idle=002/1/0x4000000000000000 softirq=0/0 fqs=2435 
[ 8599.150508] 	(detected by 0, t=6502 jiffies, g=44965, q=100)
[ 8599.150620] Task dump for CPU 4:
[ 8599.151302] task:swapper/4       state:R  running task     stack:    0 pid:    0 ppid:     1 flags:0x00000028
[ 8599.152248] Call trace:
[ 8599.152736]  ret_from_fork+0x0/0x30
[ 8599.153876] 
[ 8599.153945] =============================
[ 8599.154084] [ BUG: Invalid wait context ]
[ 8599.154084] 5.10.0-rc2-00006-g0e6c7349e720-dirty #239 Tainted: G        W        
[ 8599.154084] -----------------------------
[ 8599.154084] swapper/0/0 is trying to lock:
[ 8599.154482] ffff000800ab3898 (&port_lock_key){-.-.}-{3:3}, at: pl011_console_write+0x138/0x218
[ 8599.154879] other info that might help us debug this:
[ 8599.155050] context-{2:2}
[ 8599.155177] 2 locks held by swapper/0/0:
[ 8599.155340]  #0: ffff800015efb2b0 (console_lock){+.+.}-{0:0}, at: vprintk_emit+0x154/0x338
[ 8599.155861]  #1: ffff800015efb3d8 (console_owner){-.-.}-{0:0}, at: console_unlock+0x190/0x6d8
[ 8599.156945] stack backtrace:
[ 8599.156945] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.10.0-rc2-00006-g0e6c7349e720-dirty #239
[ 8599.157263] Hardware name: FVP Base RevC (DT)
[ 8599.157660] Call trace:
[ 8599.157782]  dump_backtrace+0x0/0x1b0
[ 8599.157944]  show_stack+0x20/0x70
[ 8599.158455]  dump_stack+0xf8/0x168
[ 8599.158455]  __lock_acquire+0x8c8/0x1a08
[ 8599.158455]  lock_acquire+0x26c/0x500
[ 8599.158455]  _raw_spin_lock+0x64/0x88
[ 8599.158852]  pl011_console_write+0x138/0x218
[ 8599.159251]  console_unlock+0x2c4/0x6d8
[ 8599.159251]  vprintk_emit+0x15c/0x338
[ 8599.159409]  vprintk_default+0x40/0x50
[ 8599.159409]  vprintk_func+0xfc/0x2b0
[ 8599.159572]  printk+0x68/0x90
[ 8599.159647]  rcu_sched_clock_irq+0x454/0xbb8
[ 8599.159735]  update_process_times+0x68/0xa8
[ 8599.159897]  tick_sched_handle.isra.0+0x3c/0x60
[ 8599.159897]  tick_sched_timer+0x54/0xb0
[ 8599.160060]  __hrtimer_run_queues+0x368/0x6a0
[ 8599.160060]  hrtimer_interrupt+0xf0/0x250
[ 8599.160223]  arch_timer_handler_phys+0x3c/0x50
[ 8599.160223]  handle_percpu_devid_irq+0xd8/0x460
[ 8599.160442]  generic_handle_irq+0x38/0x50
[ 8599.160442]  __handle_domain_irq+0x6c/0xc8
[ 8599.160442]  gic_handle_irq+0x60/0x12c
[ 8599.160442]  el1_irq+0xc0/0x180
[ 8599.160442]  arch_cpu_idle+0x28/0x38
[ 8599.160874]  default_idle_call+0x80/0x390
[ 8599.160874]  do_idle+0x25c/0x2a8
[ 8599.161078]  cpu_startup_entry+0x2c/0x78
[ 8599.161078]  rest_init+0x1b4/0x288
[ 8599.161237]  arch_call_rest_init+0x18/0x24
[ 8599.161237]  start_kernel+0x538/0x574
[ 8677.161944] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[ 8677.162656] rcu: 	4-O...: (0 ticks this GP) idle=002/1/0x4000000000000000 softirq=0/0 fqs=11256 
[ 8677.163479] 	(detected by 0, t=26007 jiffies, g=44965, q=226)
[ 8677.163641] Task dump for CPU 4:
[ 8677.164292] task:swapper/4       state:R  running task     stack:    0 pid:    0 ppid:     1 flags:0x00000028
[ 8677.165106] Call trace:
[ 8677.165594]  ret_from_fork+0x0/0x30
[ 8755.182354] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[ 8755.183009] rcu: 	4-O...: (0 ticks this GP) idle=002/1/0x4000000000000000 softirq=0/0 fqs=19219 
[ 8755.183660] 	(detected by 0, t=45512 jiffies, g=44965, q=609)
[ 8755.183822] Task dump for CPU 4:
[ 8755.184473] task:swapper/4       state:R  running task     stack:    0 pid:    0 ppid:     1 flags:0x00000028
[ 8755.185450] Call trace:
[ 8755.185776]  ret_from_fork+0x0/0x30

--f427e6ds5xakvtyh--
