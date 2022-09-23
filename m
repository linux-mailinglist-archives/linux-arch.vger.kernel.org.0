Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975CC5E79ED
	for <lists+linux-arch@lfdr.de>; Fri, 23 Sep 2022 13:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbiIWLrJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Sep 2022 07:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiIWLrI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Sep 2022 07:47:08 -0400
X-Greylist: delayed 166 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 23 Sep 2022 04:47:05 PDT
Received: from condef-02.nifty.com (condef-02.nifty.com [202.248.20.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E226123D8E;
        Fri, 23 Sep 2022 04:47:04 -0700 (PDT)
Received: from conssluserg-03.nifty.com ([10.126.8.82])by condef-02.nifty.com with ESMTP id 28NBg0tM020933;
        Fri, 23 Sep 2022 20:42:00 +0900
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 28NBfeea005588;
        Fri, 23 Sep 2022 20:41:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 28NBfeea005588
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1663933301;
        bh=XEqynJ/qM0YehRgKpe9Zd1GHDe8Z+P7TKeVukg7eYj4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MleFGuUPZDaSfiG9iFRE6OnfD7ssI9PA3x3McJLKlXA42h2BMGgz2wx9KraP4aBr4
         MzVAKBzUT76JakBLlPV/ksbxlflXK1M4kCBWp+RpVGE8e0sezLgnxF17kH0qG7G+nb
         ATTzKFHhhbL/myF55dFk3eH8AaiYBgQg6vE9PrjDZD8UeqLmiWszOehcii8XllpkP0
         mqqX9BPbtlJJdkhoEBxwpIX1Mx21sSlv95+pJrKnLo2CCc2fdwaaa6wlv8u0SXzqhx
         1rmSALTWPDs64CI7UBDp6ZHnchp56aBm2v1DMxrn/jWiduukZrSg4tZv9LEk1IIZH2
         L+ywxN3lIp0+A==
X-Nifty-SrcIP: [209.85.167.179]
Received: by mail-oi1-f179.google.com with SMTP id m130so16055926oif.6;
        Fri, 23 Sep 2022 04:41:40 -0700 (PDT)
X-Gm-Message-State: ACrzQf0EvFG652wLTU8Boy6j/suFTbSlJovMwlNlddz4fbfQWFtxXxIc
        qnWa+klVsA30UF2ylAZO6TWPn99XSGmIhpMS3yY=
X-Google-Smtp-Source: AMsMyM6cd56ugpwKNSvQ1sViQz1Tu3gs2qx9a9M1FE/GqSUhMZzqriqvbdySh21f+vK3TPO1SySV3jMuDeA4BncXoug=
X-Received: by 2002:a05:6808:1b85:b0:34d:8ce1:d5b0 with SMTP id
 cj5-20020a0568081b8500b0034d8ce1d5b0mr8479724oib.194.1663933299470; Fri, 23
 Sep 2022 04:41:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220906061313.1445810-1-masahiroy@kernel.org>
 <20220906061313.1445810-4-masahiroy@kernel.org> <20220921043946.GA1355561@roeck-us.net>
 <CGME20220923113907eucas1p2b33fa5cf73646401089f96a69cf9b745@eucas1p2.samsung.com>
 <8e70837d-d859-dfb2-bf7f-83f8b31467bc@samsung.com> <0997c2b5-b2f6-2ef7-df6a-6f5657ed4d3a@samsung.com>
In-Reply-To: <0997c2b5-b2f6-2ef7-df6a-6f5657ed4d3a@samsung.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 23 Sep 2022 20:41:03 +0900
X-Gmail-Original-Message-ID: <CAK7LNASJFw=NwFfwdOCW9VMTsmCv8z+4Mt9QgaJnYv=P3AKb4A@mail.gmail.com>
Message-ID: <CAK7LNASJFw=NwFfwdOCW9VMTsmCv8z+4Mt9QgaJnYv=P3AKb4A@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] kbuild: move core-y and drivers-y to ./Kbuild
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 23, 2022 at 8:39 PM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi All,
>
> CCed: Christoph and Robin, although this is not strictly DMA-mapping
> related issue...
>
> On 22.09.2022 14:16, Marek Szyprowski wrote:
> > On 21.09.2022 06:39, Guenter Roeck wrote:
> >> On Tue, Sep 06, 2022 at 03:13:08PM +0900, Masahiro Yamada wrote:
> >>> Use the ordinary obj-y to list subdirectories.
> >>>
> >>> Note1:
> >>> GNU Make seems to transform './.modules.order' to '.modules.order'
> >>> before matching it against the target pattern. Split ./.modules.order
> >>> to a dedicated rule to avoid "doesn't match the target pattern"
> >>> warning. [1]
> >>>
> >>> Note2:
> >>> Previously, the link order of lib-y depended on CONFIG_MODULES; lib-y
> >>> was linked before drivers-y when CONFIG_MODULES=y, otherwise after
> >>> drivers-y. This was a bug of commit 7273ad2b08f8 ("kbuild: link lib-y
> >>> objects to vmlinux forcibly when CONFIG_MODULES=y"), but it was not a
> >>> big deal after all. Now, libs-y (all objects that come from lib/ and
> >>> arch/*/lib/) is linked last, irrespective of CONFIG_MODULES.
> >>>
> >>> Note3:
> >>> Now, the single target build in arch/*/lib/ works correctly. There was
> >>> a bug report about this. [2]
> >>>
> >>>    $ make ARCH=arm arch/arm/lib/findbit.o
> >>>      CALL    scripts/checksyscalls.sh
> >>>      AS      arch/arm/lib/findbit.o
> >>>
> >>> [1]: https://lists.gnu.org/archive/html/bug-make/2022-08/msg00059.html
> >>> [2]:
> >>> https://lore.kernel.org/linux-kbuild/YvUQOwL6lD4%2F5%2FU6@shell.armlinux.org.uk/
> >>>
> >>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> >> With this patch in place, all parisc images crash during boot with the
> >> crash dump below. Bisect on next-20220920 points to this patch.
> >> Crash and bisect logs are attached.
> >>
> >> Loking through boot logs, the same problem (same backtrace) is seen
> >> with various boot tests on alpha. There may be more, but -next
> >> crashes all over the place right now so it is difficult to determine
> >> the platforms affected by a specicfic problem.
> >
> > I confirm this. I've observed similar issue recently (from time to
> > time) on the ARM 32bit based Exynos5250-based Arndale board. 'git
> > bisect' lead me also to this change. A short investigation revealed
> > that the issue is caused by the NULL sgp->pool in
> > lib/sg_pool.c:sg_pool_alloc() function. Sometimes it works fine,
> > sometimes not. It looks that there is a race in the sg_pools and scsi
> > initialization somehow after this patch.
> >
> > To confirm that this change is really responsible for the issue I've
> > tried to revert it on top of linux-next. This is however hard due to
> > the dependencies. Instead I've only did:
> >
> > # git revert -m1 6fb5a32d95a9b1a9d4a6e135404468a8d74cfde6
> >
> > on top of the linux next-20220921 and resolved the conflict (trivial
> > to resolve). After that the kernel boots fine and I was not able to
> > reproduce the issue.
> >
> > The issue I've observed was:
> >
> > ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> > ata1.00: HPA detected: current 117229295, native 117231408
> > ata1.00: ATA-8: Corsair CSSD-F60GB2, 1.1, max UDMA/133
> > ata1.00: 117229295 sectors, multi 1: LBA48 NCQ (depth 32)
> > ata1.00: configured for UDMA/133
> > scsi 0:0:0:0: Direct-Access     ATA      Corsair CSSD-F60 1.1  PQ: 0
> > ANSI: 5
> > sd 0:0:0:0: [sda] 117229295 512-byte logical blocks: (60.0 GB/55.9 GiB)
> > sd 0:0:0:0: Attached scsi generic sg0 type 0
> > sd 0:0:0:0: [sda] Write Protect is off
> > sd 0:0:0:0: [sda] Preferred minimum I/O size 512 bytes
> > 8<--- cut here ---
> > Unable to handle kernel NULL pointer dereference at virtual address
> > 00000034
> > usb3503 usb-hub: switched to HUB mode
> > [00000034] *pgd=00000000
> > usb3503 usb-hub: usb3503_probe: probed in hub mode
> > UDC core: g_ether: couldn't find an available UDC
> >
> > Internal error: Oops: 5 [#1] PREEMPT SMP ARM
> > Modules linked in:
> > CPU: 0 PID: 7 Comm: kworker/0:0H Not tainted
> > 6.0.0-rc5-00016-g10d1d4b75525 #12835
> > Hardware name: Samsung Exynos (Flattened Device Tree)
> > Workqueue: kblockd blk_mq_run_work_fn
> > PC is at mempool_alloc+0x48/0x14c
> > LR is at mempool_alloc+0x2c/0x14c
> > pc : [<c0267a2c>]    lr : [<c0267a10>]    psr: 40000013
> > ...
> > Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> > Control: 10c5387d  Table: 4000406a  DAC: 00000051
> > ...
> > Process kworker/0:0H (pid: 7, stack limit = 0x(ptrval))
> > Stack: (0xf0839cc8 to 0xf083a000)
> > ...
> >  mempool_alloc from __sg_alloc_table+0x120/0x160
> >  __sg_alloc_table from sg_alloc_table_chained+0x5c/0xc0
> >  sg_alloc_table_chained from scsi_alloc_sgtables+0x5c/0x294
> >  scsi_alloc_sgtables from sd_init_command+0x118/0x908
> >  sd_init_command from scsi_queue_rq+0x360/0xbe0
> >  scsi_queue_rq from blk_mq_dispatch_rq_list+0x1d8/0x8c8
> >  blk_mq_dispatch_rq_list from blk_mq_do_dispatch_sched+0x2e0/0x338
> >  blk_mq_do_dispatch_sched from
> > __blk_mq_sched_dispatch_requests+0xa8/0x150
> >  __blk_mq_sched_dispatch_requests from
> > blk_mq_sched_dispatch_requests+0x34/0x5c
> >  blk_mq_sched_dispatch_requests from __blk_mq_run_hw_queue+0x88/0x22c
> >  __blk_mq_run_hw_queue from process_one_work+0x288/0x778
> >  process_one_work from worker_thread+0x44/0x504
> >  worker_thread from kthread+0xf0/0x124
> >  kthread from ret_from_fork+0x14/0x2c
> > Exception stack(0xf0839fb0 to 0xf0839ff8)
> > 9fa0:                                     00000000 00000000 00000000
> > 00000000
> > 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > 00000000
> > 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> > Code: e30ea764 e3c44d11 e34ca017 e3844a92 (e5953034)
> > ---[ end trace 0000000000000000 ]---
> >
> I've analyzed this issue a bit more and it looks that the $subject patch
> just revealed a bug in the lib/sg_pool.c. This looks a bit suspicious
> for me:
>
> module_init(sg_pool_init);
>
> After changing the above to:
>
> core_initcall(sg_pool_init);
>
> the issue is gone.
>
>
> Please confirm that this is a proper way of fixing this issue, so I will
> send a final patch.



What a coincidence, I just submitted a patch...




>
> >>
> >> Guenter
> >>
> >> ---
> >> # bad: [ef08d387bbbc20df740ced8caee0ffac835869ac] Add linux-next
> >> specific files for 20220920
> >> # good: [521a547ced6477c54b4b0cc206000406c221b4d6] Linux 6.0-rc6
> >> git bisect start 'HEAD' 'v6.0-rc6'
> >> # bad: [df970c033333b10c728198606fe787535e08ab8a] Merge branch
> >> 'drm-next' of git://git.freedesktop.org/git/drm/drm.git
> >> git bisect bad df970c033333b10c728198606fe787535e08ab8a
> >> # bad: [0120f1228dc162c1e00ac24b788a67cc669ff56f] Merge branch
> >> 'docs-next' of git://git.lwn.net/linux.git
> >> git bisect bad 0120f1228dc162c1e00ac24b788a67cc669ff56f
> >> # bad: [ed1b38e88a53a328673e1fffdd6bb69e02c34af1] Merge branch
> >> 'for-next' of
> >> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
> >> git bisect bad ed1b38e88a53a328673e1fffdd6bb69e02c34af1
> >> # bad: [4dd0700db9ab87d345d989c7589077d858a1f387] Merge branch
> >> 'for-next/core' of
> >> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
> >> git bisect bad 4dd0700db9ab87d345d989c7589077d858a1f387
> >> # good: [61aa10c4f088adac94f88ba967db44ffab627aef] Merge branch
> >> 'fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git
> >> git bisect good 61aa10c4f088adac94f88ba967db44ffab627aef
> >> # bad: [94c23f8f94b27223a557c88075ea063c70afc0ae] Merge branch
> >> 'perf/core' of
> >> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
> >> git bisect bad 94c23f8f94b27223a557c88075ea063c70afc0ae
> >> # good: [6357b3bb80d81a4ad5fe1d15f50ebe5de6c9cab2] perf intel-pt:
> >> Support itrace option flag d+e to log on error
> >> git bisect good 6357b3bb80d81a4ad5fe1d15f50ebe5de6c9cab2
> >> # bad: [d2ed1be371b80f97d2141cfcb0c4ecd02e550180] scripts: remove
> >> unused argument 'type'
> >> git bisect bad d2ed1be371b80f97d2141cfcb0c4ecd02e550180
> >> # good: [a521c97e2a63490c238865763fc86942dce8d6bb] kbuild: rewrite
> >> check-local-export in sh/awk
> >> git bisect good a521c97e2a63490c238865763fc86942dce8d6bb
> >> # bad: [165b718fdd8c5a9165b4485019729c0cd8728120] kbuild: unify two
> >> modpost invocations
> >> git bisect bad 165b718fdd8c5a9165b4485019729c0cd8728120
> >> # bad: [10d1d4b75525f3172c6930fb20445f669762ea95] kbuild: move core-y
> >> and drivers-y to ./Kbuild
> >> git bisect bad 10d1d4b75525f3172c6930fb20445f669762ea95
> >> # good: [fd5f5437264c05b9fc0fff4349f0564f474bdf5e] kbuild: rename
> >> modules.order in sub-directories to .modules.order
> >> git bisect good fd5f5437264c05b9fc0fff4349f0564f474bdf5e
> >> # first bad commit: [10d1d4b75525f3172c6930fb20445f669762ea95]
> >> kbuild: move core-y and drivers-y to ./Kbuild
> >>
> >> ---
> >> [    1.812993] sym53c8xx 0000:00:00.0: enabling SERR and PARITY (0107
> >> -> 0147)
> >> [    1.816056] sym0: <895a> rev 0x0 at pci 0000:00:00.0 irq 19
> >> [    1.823635] sym0: PA-RISC Firmware, ID 7, Fast-40, LVD, parity
> >> checking
> >> [    1.827770] sym0: SCSI BUS has been reset.
> >> [    1.833713] scsi host0: sym-2.2.3
> >> [    1.845265] Backtrace:
> >> [    1.845750]  [<10b83400>] sg_pool_alloc+0xac/0xc0
> >> [    1.846512]  [<10ac8ba8>] __sg_alloc_table+0x16c/0x1c0
> >> [    1.846728]  [<10b83540>] sg_alloc_table_chained+0x6c/0xec
> >> [    1.846911]  [<106ff470>] scsi_alloc_sgtables+0x8c/0x268
> >> [    1.847129]  [<10703d5c>] scsi_queue_rq+0xae4/0xb3c
> >> [    1.847296]  [<1060f62c>] blk_mq_dispatch_rq_list+0x1e4/0xa2c
> >> [    1.847538]  [<10617184>] __blk_mq_sched_dispatch_requests+0xb4/0x188
> >> [    1.847758]  [<10617334>] blk_mq_sched_dispatch_requests+0x58/0x84
> >> [    1.847787]  [<1060b6bc>] __blk_mq_run_hw_queue+0x78/0x108
> >> [    1.847787]  [<1060d968>] __blk_mq_delay_run_hw_queue+0x114/0x1e0
> >> [    1.847787]  [<1060dc64>] blk_mq_run_hw_queue+0xb0/0x12c
> >> [    1.847787]  [<10617600>] blk_mq_sched_insert_request+0x12c/0x158
> >> [    1.847787]  [<1060ad9c>] blk_execute_rq+0x9c/0x194
> >> [    1.847787]  [<10700a1c>] __scsi_execute+0x130/0x1f4
> >> [    1.847787]  [<10704d70>] scsi_probe_and_add_lun+0x214/0xc60
> >> [    1.847787]  [<10706144>] __scsi_scan_target+0x164/0x5b4
> >> [    1.847787]  [<10706804>] scsi_scan_host_selected+0x138/0x23c
> >> [    1.847787]  [<107069d8>] do_scsi_scan_host+0xd0/0xf0
> >> [    1.847787]  [<10706b98>] scsi_scan_host+0x1a0/0x1f0
> >> [    1.847787]  [<10716ba0>] sym2_probe+0x824/0x850
> >> [    1.847787]  [<10656110>] pci_device_probe+0x9c/0x148
> >> [    1.847787]  [<106deee0>] really_probe+0xc4/0x34c
> >> [    1.847787]  [<106df1c4>] __driver_probe_device+0x5c/0xbc
> >> [    1.847787]  [<106df2c0>] driver_probe_device+0x9c/0x188
> >> [    1.847787]  [<106dfb50>] __driver_attach+0xac/0x194
> >> [    1.847787]  [<106dc784>] bus_for_each_dev+0x78/0xb8
> >> [    1.847787]  [<106de698>] driver_attach+0x28/0x38
> >> [    1.847787]  [<106de144>] bus_add_driver+0x198/0x224
> >> [    1.847787]  [<106e05e0>] driver_register+0x98/0x168
> >> [    1.847787]  [<106555d0>] __pci_register_driver+0x80/0x94
> >> [    1.847787]
> >> [    1.847787]
> >> [    1.847787] Kernel Fault: Code=26 (Data memory access rights trap)
> >> at addr 0000002c
> >> [    1.847787] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> >> 6.0.0-rc6-next-20220920-32bit #1
> >> [    1.847787] Hardware name: 9000/778/B160L
> >> [    1.847787]
> >> [    1.847787]      YZrvWESTHLNXBCVMcbcbcbcbOGFRQPDI
> >> [    1.847787] PSW: 00000000000001001011111100001111 Not tainted
> >> [    1.847787] r00-03  0004bf0f 1183d400 10b83400 1183d440
> >> [    1.847787] r04-07  00000000 00092820 00092820 00000080
> >> [    1.847787] r08-11  00000000 00000034 00000002 11830000
> >> [    1.847787] r12-15  000001f4 10db0000 1204f128 00000001
> >> [    1.847787] r16-19  11beb200 1204f038 1183d0c8 00000080
> >> [    1.847787] r20-23  00000820 00000001 10b83354 00000000
> >> [    1.847787] r24-27  00000080 00000820 00000000 10e42e18
> >> [    1.847787] r28-31  00092000 0000000f 1183d4c0 10ac8ba8
> >> [    1.847787] sr00-03  00000000 00000000 00000000 00000000
> >> [    1.847787] sr04-07  00000000 00000000 00000000 00000000
> >> [    1.847787]
> >> [    1.847787] IASQ: 00000000 00000000 IAOQ: 102bce5c 102bce60
> >> [    1.847787]  IIR: 48960058    ISR: 00000000  IOR: 0000002c
> >> [    1.847787]  CPU:        0   CR30: 11830000 CR31: 00000000
> >> [    1.847787]  ORIG_R28: 86b51896
> >> [    1.847787]  IAOQ[0]: mempool_alloc+0x78/0x1a8
> >> [    1.847787]  IAOQ[1]: mempool_alloc+0x7c/0x1a8
> >> [    1.847787]  RP(r2): sg_pool_alloc+0xac/0xc0
> >> [    1.847787] Backtrace:
> >> [    1.847787]  [<10b83400>] sg_pool_alloc+0xac/0xc0
> >> [    1.847787]  [<10ac8ba8>] __sg_alloc_table+0x16c/0x1c0
> >> [    1.847787]  [<10b83540>] sg_alloc_table_chained+0x6c/0xec
> >> [    1.847787]  [<106ff470>] scsi_alloc_sgtables+0x8c/0x268
> >> [    1.847787]  [<10703d5c>] scsi_queue_rq+0xae4/0xb3c
> >> [    1.847787]  [<1060f62c>] blk_mq_dispatch_rq_list+0x1e4/0xa2c
> >> [    1.847787]  [<10617184>] __blk_mq_sched_dispatch_requests+0xb4/0x188
> >> [    1.847787]  [<10617334>] blk_mq_sched_dispatch_requests+0x58/0x84
> >> [    1.847787]  [<1060b6bc>] __blk_mq_run_hw_queue+0x78/0x108
> >> [    1.847787]  [<1060d968>] __blk_mq_delay_run_hw_queue+0x114/0x1e0
> >> [    1.847787]  [<1060dc64>] blk_mq_run_hw_queue+0xb0/0x12c
> >> [    1.847787]  [<10617600>] blk_mq_sched_insert_request+0x12c/0x158
> >> [    1.847787]  [<1060ad9c>] blk_execute_rq+0x9c/0x194
> >> [    1.847787]  [<10700a1c>] __scsi_execute+0x130/0x1f4
> >> [    1.847787]  [<10704d70>] scsi_probe_and_add_lun+0x214/0xc60
> >> [    1.847787]  [<10706144>] __scsi_scan_target+0x164/0x5b4
> >> [    1.847787]  [<10706804>] scsi_scan_host_selected+0x138/0x23c
> >> [    1.847787]  [<107069d8>] do_scsi_scan_host+0xd0/0xf0
> >> [    1.847787]  [<10706b98>] scsi_scan_host+0x1a0/0x1f0
> >> [    1.847787]  [<10716ba0>] sym2_probe+0x824/0x850
> >> [    1.847787]  [<10656110>] pci_device_probe+0x9c/0x148
> >> [    1.847787]  [<106deee0>] really_probe+0xc4/0x34c
> >> [    1.847787]  [<106df1c4>] __driver_probe_device+0x5c/0xbc
> >> [    1.847787]  [<106df2c0>] driver_probe_device+0x9c/0x188
> >> [    1.847787]  [<106dfb50>] __driver_attach+0xac/0x194
> >> [    1.847787]  [<106dc784>] bus_for_each_dev+0x78/0xb8
> >> [    1.847787]  [<106de698>] driver_attach+0x28/0x38
> >> [    1.847787]  [<106de144>] bus_add_driver+0x198/0x224
> >> [    1.847787]  [<106e05e0>] driver_register+0x98/0x168
> >> [    1.847787]  [<106555d0>] __pci_register_driver+0x80/0x94
> >> [    1.847787]
> >> [    1.847787] Kernel panic - not syncing: Kernel Fault
> >>
> >
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>


-- 
Best Regards
Masahiro Yamada
