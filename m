Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F995E7A6C
	for <lists+linux-arch@lfdr.de>; Fri, 23 Sep 2022 14:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbiIWMVL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Sep 2022 08:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiIWMUT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Sep 2022 08:20:19 -0400
X-Greylist: delayed 1737 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 23 Sep 2022 05:10:57 PDT
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004BEE6DDF;
        Fri, 23 Sep 2022 05:10:56 -0700 (PDT)
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 28NCALaE023394;
        Fri, 23 Sep 2022 21:10:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 28NCALaE023394
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1663935022;
        bh=WhugoWZRyKqqBZUcmDpfw3eSjXuzOdApVcqA0ITzK6g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oXKRT1SwAbTLcEUi4l381YYauJLR221cZf4BMGgII3LDs6Gf+92VrDeqKyZ+VtGDY
         wxG2+jCAEjndHwn0cFTfC2BUKtU5hLQGYTsyd1ReAQkepMg4dfX9Hq4FB92Ojw30lp
         CgHv1dzQyEo64p318UZaHGKEC40vHw5NOYcyDvR3/DtDUgqf9uPokdG8PLIKx+7As4
         WMsPR742ye5XkI0H+fPGlgP8tGrMVFCmUSK8eZhkaBTMkosZeIAT1xYm6vKIMe+WVz
         BAxS1UVMSGRLyFKbw/KglbLZFKWSTAc6WLPmth1cXm8tihxbcMoTuyqDSy6qyNaSp7
         pyJjnSkV4YgCw==
X-Nifty-SrcIP: [209.85.161.45]
Received: by mail-oo1-f45.google.com with SMTP id u3-20020a4ab5c3000000b0044b125e5d9eso12774ooo.12;
        Fri, 23 Sep 2022 05:10:21 -0700 (PDT)
X-Gm-Message-State: ACrzQf3yvzrPKDe2JQtFC1cBhXcFom3msT2ut9lz9XH3duGC/L5J8ra+
        ks9O/NWDR/uC8igrZ4RcQCyEQHd/t5cZXDTjqs0=
X-Google-Smtp-Source: AMsMyM4rumpmOGqZuiZErevZi9hJaLAHvqKCe++epcBOijqsb9wZifSsD9IDENRln7KT42zgJAddmQc5grDvI7uBwhM=
X-Received: by 2002:a05:6820:1992:b0:475:c2c0:3f92 with SMTP id
 bp18-20020a056820199200b00475c2c03f92mr3287421oob.96.1663935020240; Fri, 23
 Sep 2022 05:10:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220906061313.1445810-1-masahiroy@kernel.org>
 <20220906061313.1445810-4-masahiroy@kernel.org> <20220921043946.GA1355561@roeck-us.net>
 <CGME20220923113907eucas1p2b33fa5cf73646401089f96a69cf9b745@eucas1p2.samsung.com>
 <8e70837d-d859-dfb2-bf7f-83f8b31467bc@samsung.com> <0997c2b5-b2f6-2ef7-df6a-6f5657ed4d3a@samsung.com>
In-Reply-To: <0997c2b5-b2f6-2ef7-df6a-6f5657ed4d3a@samsung.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 23 Sep 2022 21:09:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQYN2gL1iQoCKBxt8vT6oMWBuPrBFnUEO6nVH4Zoz+t1Q@mail.gmail.com>
Message-ID: <CAK7LNAQYN2gL1iQoCKBxt8vT6oMWBuPrBFnUEO6nVH4Zoz+t1Q@mail.gmail.com>
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


I am not sure about the choice for *_initcall.
Please feel free to override me.

Anyway, I will make my Kbuild refactoring not depend on sg_pool fix-up.



-- 
Best Regards
Masahiro Yamada
