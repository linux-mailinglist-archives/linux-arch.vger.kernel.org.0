Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172395E79C5
	for <lists+linux-arch@lfdr.de>; Fri, 23 Sep 2022 13:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiIWLjV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Sep 2022 07:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiIWLjU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Sep 2022 07:39:20 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF2B137916
        for <linux-arch@vger.kernel.org>; Fri, 23 Sep 2022 04:39:13 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220923113908euoutp013d4f56c9b3ab12ed4b14194bab09505f~XemH3D7jD2347023470euoutp01F
        for <linux-arch@vger.kernel.org>; Fri, 23 Sep 2022 11:39:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220923113908euoutp013d4f56c9b3ab12ed4b14194bab09505f~XemH3D7jD2347023470euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663933148;
        bh=EXjy6ciPk0YuzQ/Una5YpB5CqjKhUgebD9+YrRptb/k=;
        h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
        b=n4Azsv1BqfEv85ayLRQQUzso+76QATuJR+KpwkIMPjec6cok7NTK6Ba/b8jNUZy4h
         y2r4v0gRG1DMMxNUftMIxKfnVBB6GmGUsJMYj0z66Bx5I5qnRLVBJlEtoaM8ks3CwD
         7cHuANtRMFa8W0I9jFYoHpZFXQgxgLONM6v5KgOc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220923113908eucas1p21fe1919aeb4c65cd50033a6e082a439d~XemHllrCK2898228982eucas1p2T;
        Fri, 23 Sep 2022 11:39:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 8D.DE.19378.CDA9D236; Fri, 23
        Sep 2022 12:39:08 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220923113907eucas1p2b33fa5cf73646401089f96a69cf9b745~XemHP05km2916729167eucas1p2W;
        Fri, 23 Sep 2022 11:39:07 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220923113907eusmtrp1f1f6a3e974565801c6c44e707b85333a~XemHPC21i1375113751eusmtrp1U;
        Fri, 23 Sep 2022 11:39:07 +0000 (GMT)
X-AuditID: cbfec7f5-a4dff70000014bb2-14-632d9adc81ad
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B6.B0.07473.BDA9D236; Fri, 23
        Sep 2022 12:39:07 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220923113907eusmtip15d9fa16d74da3927617e17053026440b~XemGufAu-2585025850eusmtip12;
        Fri, 23 Sep 2022 11:39:07 +0000 (GMT)
Message-ID: <0997c2b5-b2f6-2ef7-df6a-6f5657ed4d3a@samsung.com>
Date:   Fri, 23 Sep 2022 13:39:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v2 3/8] kbuild: move core-y and drivers-y to ./Kbuild
Content-Language: en-US
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>
In-Reply-To: <8e70837d-d859-dfb2-bf7f-83f8b31467bc@samsung.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsWy7djPc7p3ZukmG8w/xWmxcvVRJouOXV9Z
        LP7s2sFkcXnXHDaL7us72CyeLDzDZPHwwQ1Wi4MfnrA6cHismbeG0WPTqk42j903G9g8dn5v
        YPf4vEkugDWKyyYlNSezLLVI3y6BK+PSgTfMBXtKKu4uPMnawPgypYuRk0NCwETi/ql3zF2M
        XBxCAisYJZ79mA7lfGGU2H3zGCNIlZDAZ0aJm3tdYDou7tnECFG0nFFizbbdUB0fGSX27jvF
        BlLFK2An8XDjTjCbRUBVYtKZeYwQcUGJkzOfsIDYogLJErOOQWwQFvCUOLukE6yeWUBc4taT
        +UwgNpuAoUTX2y6gOAeHiECAxLUFESC7mAXOMEpcmL6DFaSGU8Be4v2vT1C98hLNW2eDHSQh
        8IRDomlJOyPE2S4Shy/vgrKFJV4d38IOYctInJ7cwwLR0M4oseD3fSYIZwKjRMPzW1Ad1hJ3
        zv0CO4NZQFNi/S59iLCjxJF7a1lAwhICfBI33gpCHMEnMWkbKBxBwrwSHW1CENVqErOOr4Nb
        e/DCJeYJjEqzkIJlFpL3ZyF5ZxbC3gWMLKsYxVNLi3PTU4uN81LL9YoTc4tL89L1kvNzNzEC
        09Hpf8e/7mBc8eqj3iFGJg7GQ4wSHMxKIryz72gmC/GmJFZWpRblxxeV5qQWH2KU5mBREudl
        m6GVLCSQnliSmp2aWpBaBJNl4uCUamBSqP59KL9w8b9TKp/9Ytu/vT2wdYfb6+M/Nx8vbKzU
        u+dee3/h8RcGiyI6YuosD+RNXbXQfO/9qYpHCq0jjkqE8OysmOkr85LX741AvG7vbqULgesy
        jET2vL2bt/bv6Z+/jq3hqlUrW7DzvODeqo797qGpP9ZweIp/Ph5zoyK57VCPN79HLMMUv4zP
        5Y3M3ef0WXfdr5zjMfuaQ5RZ4czwo/eKvlnJTNV5Envi893q7D2GnVkHGtn/x7xV+MHMvK5q
        evD5dpPlCba/Ah5eEbw1a8Yp4Uv+djHRzHceOf8S0fn3cFXTjt1Hdu4RyBVeuiA49InGsyO8
        p2YJ3dztIvz+adOr+IcSL+av9nq0Wk3klhJLcUaioRZzUXEiACg1QCK2AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsVy+t/xu7q3Z+kmGzxfp2excvVRJouOXV9Z
        LP7s2sFkcXnXHDaL7us72CyeLDzDZPHwwQ1Wi4MfnrA6cHismbeG0WPTqk42j903G9g8dn5v
        YPf4vEkugDVKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI
        3y5BL+PSgTfMBXtKKu4uPMnawPgypYuRk0NCwETi4p5NjF2MXBxCAksZJZZNeMwEkZCRODmt
        gRXCFpb4c62LDaLoPaPE4dmXWEASvAJ2Eg837mQDsVkEVCUmnZnHCBEXlDg58wlYjahAssSS
        hvtgg4QFPCXOLukEq2cWEJe49WQ+2DI2AUOJrrddYHERAT+JA8u6WUGWMQucYZToa/vECrEZ
        yGntnQA2iVPAXuL9r09Qk8wkurZ2MULY8hLNW2czT2AUmoXkkFlIFs5C0jILScsCRpZVjCKp
        pcW56bnFhnrFibnFpXnpesn5uZsYgTG47djPzTsY5736qHeIkYmD8RCjBAezkgjv7DuayUK8
        KYmVValF+fFFpTmpxYcYTYGhMZFZSjQ5H5gE8kriDc0MTA1NzCwNTC3NjJXEeT0LOhKFBNIT
        S1KzU1MLUotg+pg4OKUamNhesdgbpqyU/3k++tC9Q01TeCW0vxcrdNaVr/JtFZH+enbigj5H
        yVX2tUKOE8MihSZnq2x6EzRrV/PqabH7w1Sr/07b/+1LsPxf7vMHDycf3feD67ZojsYemWn3
        T/2t5hP8KqBjF/ijbe0E8dMP9/h9bL68b8md03eu2ax6qO3ksPfyTD7/DxeCVV7MUzZPP9V+
        obHb6/7Npbz28QqNJ8rX32/JWT59R0L5p3A5d9u4nb+j2O31gu2Cz3oePV7HW3vj4B957gIX
        5rdTrXffSNhz079hMf/nnkTntkeX9saHbH5dJzU3IPz5Zf4wj1Odsy9zLTg/dw93cqL4RRen
        HoVrGvszEn9xePYtPHd4W7ISS3FGoqEWc1FxIgD+2zyCSgMAAA==
X-CMS-MailID: 20220923113907eucas1p2b33fa5cf73646401089f96a69cf9b745
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220923113907eucas1p2b33fa5cf73646401089f96a69cf9b745
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220923113907eucas1p2b33fa5cf73646401089f96a69cf9b745
References: <20220906061313.1445810-1-masahiroy@kernel.org>
        <20220906061313.1445810-4-masahiroy@kernel.org>
        <20220921043946.GA1355561@roeck-us.net>
        <8e70837d-d859-dfb2-bf7f-83f8b31467bc@samsung.com>
        <CGME20220923113907eucas1p2b33fa5cf73646401089f96a69cf9b745@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi All,

CCed: Christoph and Robin, although this is not strictly DMA-mapping 
related issue...

On 22.09.2022 14:16, Marek Szyprowski wrote:
> On 21.09.2022 06:39, Guenter Roeck wrote:
>> On Tue, Sep 06, 2022 at 03:13:08PM +0900, Masahiro Yamada wrote:
>>> Use the ordinary obj-y to list subdirectories.
>>>
>>> Note1:
>>> GNU Make seems to transform './.modules.order' to '.modules.order'
>>> before matching it against the target pattern. Split ./.modules.order
>>> to a dedicated rule to avoid "doesn't match the target pattern"
>>> warning. [1]
>>>
>>> Note2:
>>> Previously, the link order of lib-y depended on CONFIG_MODULES; lib-y
>>> was linked before drivers-y when CONFIG_MODULES=y, otherwise after
>>> drivers-y. This was a bug of commit 7273ad2b08f8 ("kbuild: link lib-y
>>> objects to vmlinux forcibly when CONFIG_MODULES=y"), but it was not a
>>> big deal after all. Now, libs-y (all objects that come from lib/ and
>>> arch/*/lib/) is linked last, irrespective of CONFIG_MODULES.
>>>
>>> Note3:
>>> Now, the single target build in arch/*/lib/ works correctly. There was
>>> a bug report about this. [2]
>>>
>>>    $ make ARCH=arm arch/arm/lib/findbit.o
>>>      CALL    scripts/checksyscalls.sh
>>>      AS      arch/arm/lib/findbit.o
>>>
>>> [1]: https://lists.gnu.org/archive/html/bug-make/2022-08/msg00059.html
>>> [2]: 
>>> https://lore.kernel.org/linux-kbuild/YvUQOwL6lD4%2F5%2FU6@shell.armlinux.org.uk/
>>>
>>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>> With this patch in place, all parisc images crash during boot with the
>> crash dump below. Bisect on next-20220920 points to this patch.
>> Crash and bisect logs are attached.
>>
>> Loking through boot logs, the same problem (same backtrace) is seen
>> with various boot tests on alpha. There may be more, but -next
>> crashes all over the place right now so it is difficult to determine
>> the platforms affected by a specicfic problem.
>
> I confirm this. I've observed similar issue recently (from time to 
> time) on the ARM 32bit based Exynos5250-based Arndale board. 'git 
> bisect' lead me also to this change. A short investigation revealed 
> that the issue is caused by the NULL sgp->pool in 
> lib/sg_pool.c:sg_pool_alloc() function. Sometimes it works fine, 
> sometimes not. It looks that there is a race in the sg_pools and scsi 
> initialization somehow after this patch.
>
> To confirm that this change is really responsible for the issue I've 
> tried to revert it on top of linux-next. This is however hard due to 
> the dependencies. Instead I've only did:
>
> # git revert -m1 6fb5a32d95a9b1a9d4a6e135404468a8d74cfde6
>
> on top of the linux next-20220921 and resolved the conflict (trivial 
> to resolve). After that the kernel boots fine and I was not able to 
> reproduce the issue.
>
> The issue I've observed was:
>
> ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata1.00: HPA detected: current 117229295, native 117231408
> ata1.00: ATA-8: Corsair CSSD-F60GB2, 1.1, max UDMA/133
> ata1.00: 117229295 sectors, multi 1: LBA48 NCQ (depth 32)
> ata1.00: configured for UDMA/133
> scsi 0:0:0:0: Direct-Access     ATA      Corsair CSSD-F60 1.1  PQ: 0 
> ANSI: 5
> sd 0:0:0:0: [sda] 117229295 512-byte logical blocks: (60.0 GB/55.9 GiB)
> sd 0:0:0:0: Attached scsi generic sg0 type 0
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Preferred minimum I/O size 512 bytes
> 8<--- cut here ---
> Unable to handle kernel NULL pointer dereference at virtual address 
> 00000034
> usb3503 usb-hub: switched to HUB mode
> [00000034] *pgd=00000000
> usb3503 usb-hub: usb3503_probe: probed in hub mode
> UDC core: g_ether: couldn't find an available UDC
>
> Internal error: Oops: 5 [#1] PREEMPT SMP ARM
> Modules linked in:
> CPU: 0 PID: 7 Comm: kworker/0:0H Not tainted 
> 6.0.0-rc5-00016-g10d1d4b75525 #12835
> Hardware name: Samsung Exynos (Flattened Device Tree)
> Workqueue: kblockd blk_mq_run_work_fn
> PC is at mempool_alloc+0x48/0x14c
> LR is at mempool_alloc+0x2c/0x14c
> pc : [<c0267a2c>]    lr : [<c0267a10>]    psr: 40000013
> ...
> Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 10c5387d  Table: 4000406a  DAC: 00000051
> ...
> Process kworker/0:0H (pid: 7, stack limit = 0x(ptrval))
> Stack: (0xf0839cc8 to 0xf083a000)
> ...
>  mempool_alloc from __sg_alloc_table+0x120/0x160
>  __sg_alloc_table from sg_alloc_table_chained+0x5c/0xc0
>  sg_alloc_table_chained from scsi_alloc_sgtables+0x5c/0x294
>  scsi_alloc_sgtables from sd_init_command+0x118/0x908
>  sd_init_command from scsi_queue_rq+0x360/0xbe0
>  scsi_queue_rq from blk_mq_dispatch_rq_list+0x1d8/0x8c8
>  blk_mq_dispatch_rq_list from blk_mq_do_dispatch_sched+0x2e0/0x338
>  blk_mq_do_dispatch_sched from 
> __blk_mq_sched_dispatch_requests+0xa8/0x150
>  __blk_mq_sched_dispatch_requests from 
> blk_mq_sched_dispatch_requests+0x34/0x5c
>  blk_mq_sched_dispatch_requests from __blk_mq_run_hw_queue+0x88/0x22c
>  __blk_mq_run_hw_queue from process_one_work+0x288/0x778
>  process_one_work from worker_thread+0x44/0x504
>  worker_thread from kthread+0xf0/0x124
>  kthread from ret_from_fork+0x14/0x2c
> Exception stack(0xf0839fb0 to 0xf0839ff8)
> 9fa0:                                     00000000 00000000 00000000 
> 00000000
> 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
> 00000000
> 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> Code: e30ea764 e3c44d11 e34ca017 e3844a92 (e5953034)
> ---[ end trace 0000000000000000 ]---
>
I've analyzed this issue a bit more and it looks that the $subject patch 
just revealed a bug in the lib/sg_pool.c. This looks a bit suspicious 
for me:

module_init(sg_pool_init);

After changing the above to:

core_initcall(sg_pool_init);

the issue is gone.


Please confirm that this is a proper way of fixing this issue, so I will 
send a final patch.


>>
>> Guenter
>>
>> ---
>> # bad: [ef08d387bbbc20df740ced8caee0ffac835869ac] Add linux-next 
>> specific files for 20220920
>> # good: [521a547ced6477c54b4b0cc206000406c221b4d6] Linux 6.0-rc6
>> git bisect start 'HEAD' 'v6.0-rc6'
>> # bad: [df970c033333b10c728198606fe787535e08ab8a] Merge branch 
>> 'drm-next' of git://git.freedesktop.org/git/drm/drm.git
>> git bisect bad df970c033333b10c728198606fe787535e08ab8a
>> # bad: [0120f1228dc162c1e00ac24b788a67cc669ff56f] Merge branch 
>> 'docs-next' of git://git.lwn.net/linux.git
>> git bisect bad 0120f1228dc162c1e00ac24b788a67cc669ff56f
>> # bad: [ed1b38e88a53a328673e1fffdd6bb69e02c34af1] Merge branch 
>> 'for-next' of 
>> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
>> git bisect bad ed1b38e88a53a328673e1fffdd6bb69e02c34af1
>> # bad: [4dd0700db9ab87d345d989c7589077d858a1f387] Merge branch 
>> 'for-next/core' of 
>> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
>> git bisect bad 4dd0700db9ab87d345d989c7589077d858a1f387
>> # good: [61aa10c4f088adac94f88ba967db44ffab627aef] Merge branch 
>> 'fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git
>> git bisect good 61aa10c4f088adac94f88ba967db44ffab627aef
>> # bad: [94c23f8f94b27223a557c88075ea063c70afc0ae] Merge branch 
>> 'perf/core' of 
>> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
>> git bisect bad 94c23f8f94b27223a557c88075ea063c70afc0ae
>> # good: [6357b3bb80d81a4ad5fe1d15f50ebe5de6c9cab2] perf intel-pt: 
>> Support itrace option flag d+e to log on error
>> git bisect good 6357b3bb80d81a4ad5fe1d15f50ebe5de6c9cab2
>> # bad: [d2ed1be371b80f97d2141cfcb0c4ecd02e550180] scripts: remove 
>> unused argument 'type'
>> git bisect bad d2ed1be371b80f97d2141cfcb0c4ecd02e550180
>> # good: [a521c97e2a63490c238865763fc86942dce8d6bb] kbuild: rewrite 
>> check-local-export in sh/awk
>> git bisect good a521c97e2a63490c238865763fc86942dce8d6bb
>> # bad: [165b718fdd8c5a9165b4485019729c0cd8728120] kbuild: unify two 
>> modpost invocations
>> git bisect bad 165b718fdd8c5a9165b4485019729c0cd8728120
>> # bad: [10d1d4b75525f3172c6930fb20445f669762ea95] kbuild: move core-y 
>> and drivers-y to ./Kbuild
>> git bisect bad 10d1d4b75525f3172c6930fb20445f669762ea95
>> # good: [fd5f5437264c05b9fc0fff4349f0564f474bdf5e] kbuild: rename 
>> modules.order in sub-directories to .modules.order
>> git bisect good fd5f5437264c05b9fc0fff4349f0564f474bdf5e
>> # first bad commit: [10d1d4b75525f3172c6930fb20445f669762ea95] 
>> kbuild: move core-y and drivers-y to ./Kbuild
>>
>> ---
>> [    1.812993] sym53c8xx 0000:00:00.0: enabling SERR and PARITY (0107 
>> -> 0147)
>> [    1.816056] sym0: <895a> rev 0x0 at pci 0000:00:00.0 irq 19
>> [    1.823635] sym0: PA-RISC Firmware, ID 7, Fast-40, LVD, parity 
>> checking
>> [    1.827770] sym0: SCSI BUS has been reset.
>> [    1.833713] scsi host0: sym-2.2.3
>> [    1.845265] Backtrace:
>> [    1.845750]  [<10b83400>] sg_pool_alloc+0xac/0xc0
>> [    1.846512]  [<10ac8ba8>] __sg_alloc_table+0x16c/0x1c0
>> [    1.846728]  [<10b83540>] sg_alloc_table_chained+0x6c/0xec
>> [    1.846911]  [<106ff470>] scsi_alloc_sgtables+0x8c/0x268
>> [    1.847129]  [<10703d5c>] scsi_queue_rq+0xae4/0xb3c
>> [    1.847296]  [<1060f62c>] blk_mq_dispatch_rq_list+0x1e4/0xa2c
>> [    1.847538]  [<10617184>] __blk_mq_sched_dispatch_requests+0xb4/0x188
>> [    1.847758]  [<10617334>] blk_mq_sched_dispatch_requests+0x58/0x84
>> [    1.847787]  [<1060b6bc>] __blk_mq_run_hw_queue+0x78/0x108
>> [    1.847787]  [<1060d968>] __blk_mq_delay_run_hw_queue+0x114/0x1e0
>> [    1.847787]  [<1060dc64>] blk_mq_run_hw_queue+0xb0/0x12c
>> [    1.847787]  [<10617600>] blk_mq_sched_insert_request+0x12c/0x158
>> [    1.847787]  [<1060ad9c>] blk_execute_rq+0x9c/0x194
>> [    1.847787]  [<10700a1c>] __scsi_execute+0x130/0x1f4
>> [    1.847787]  [<10704d70>] scsi_probe_and_add_lun+0x214/0xc60
>> [    1.847787]  [<10706144>] __scsi_scan_target+0x164/0x5b4
>> [    1.847787]  [<10706804>] scsi_scan_host_selected+0x138/0x23c
>> [    1.847787]  [<107069d8>] do_scsi_scan_host+0xd0/0xf0
>> [    1.847787]  [<10706b98>] scsi_scan_host+0x1a0/0x1f0
>> [    1.847787]  [<10716ba0>] sym2_probe+0x824/0x850
>> [    1.847787]  [<10656110>] pci_device_probe+0x9c/0x148
>> [    1.847787]  [<106deee0>] really_probe+0xc4/0x34c
>> [    1.847787]  [<106df1c4>] __driver_probe_device+0x5c/0xbc
>> [    1.847787]  [<106df2c0>] driver_probe_device+0x9c/0x188
>> [    1.847787]  [<106dfb50>] __driver_attach+0xac/0x194
>> [    1.847787]  [<106dc784>] bus_for_each_dev+0x78/0xb8
>> [    1.847787]  [<106de698>] driver_attach+0x28/0x38
>> [    1.847787]  [<106de144>] bus_add_driver+0x198/0x224
>> [    1.847787]  [<106e05e0>] driver_register+0x98/0x168
>> [    1.847787]  [<106555d0>] __pci_register_driver+0x80/0x94
>> [    1.847787]
>> [    1.847787]
>> [    1.847787] Kernel Fault: Code=26 (Data memory access rights trap) 
>> at addr 0000002c
>> [    1.847787] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 
>> 6.0.0-rc6-next-20220920-32bit #1
>> [    1.847787] Hardware name: 9000/778/B160L
>> [    1.847787]
>> [    1.847787]      YZrvWESTHLNXBCVMcbcbcbcbOGFRQPDI
>> [    1.847787] PSW: 00000000000001001011111100001111 Not tainted
>> [    1.847787] r00-03  0004bf0f 1183d400 10b83400 1183d440
>> [    1.847787] r04-07  00000000 00092820 00092820 00000080
>> [    1.847787] r08-11  00000000 00000034 00000002 11830000
>> [    1.847787] r12-15  000001f4 10db0000 1204f128 00000001
>> [    1.847787] r16-19  11beb200 1204f038 1183d0c8 00000080
>> [    1.847787] r20-23  00000820 00000001 10b83354 00000000
>> [    1.847787] r24-27  00000080 00000820 00000000 10e42e18
>> [    1.847787] r28-31  00092000 0000000f 1183d4c0 10ac8ba8
>> [    1.847787] sr00-03  00000000 00000000 00000000 00000000
>> [    1.847787] sr04-07  00000000 00000000 00000000 00000000
>> [    1.847787]
>> [    1.847787] IASQ: 00000000 00000000 IAOQ: 102bce5c 102bce60
>> [    1.847787]  IIR: 48960058    ISR: 00000000  IOR: 0000002c
>> [    1.847787]  CPU:        0   CR30: 11830000 CR31: 00000000
>> [    1.847787]  ORIG_R28: 86b51896
>> [    1.847787]  IAOQ[0]: mempool_alloc+0x78/0x1a8
>> [    1.847787]  IAOQ[1]: mempool_alloc+0x7c/0x1a8
>> [    1.847787]  RP(r2): sg_pool_alloc+0xac/0xc0
>> [    1.847787] Backtrace:
>> [    1.847787]  [<10b83400>] sg_pool_alloc+0xac/0xc0
>> [    1.847787]  [<10ac8ba8>] __sg_alloc_table+0x16c/0x1c0
>> [    1.847787]  [<10b83540>] sg_alloc_table_chained+0x6c/0xec
>> [    1.847787]  [<106ff470>] scsi_alloc_sgtables+0x8c/0x268
>> [    1.847787]  [<10703d5c>] scsi_queue_rq+0xae4/0xb3c
>> [    1.847787]  [<1060f62c>] blk_mq_dispatch_rq_list+0x1e4/0xa2c
>> [    1.847787]  [<10617184>] __blk_mq_sched_dispatch_requests+0xb4/0x188
>> [    1.847787]  [<10617334>] blk_mq_sched_dispatch_requests+0x58/0x84
>> [    1.847787]  [<1060b6bc>] __blk_mq_run_hw_queue+0x78/0x108
>> [    1.847787]  [<1060d968>] __blk_mq_delay_run_hw_queue+0x114/0x1e0
>> [    1.847787]  [<1060dc64>] blk_mq_run_hw_queue+0xb0/0x12c
>> [    1.847787]  [<10617600>] blk_mq_sched_insert_request+0x12c/0x158
>> [    1.847787]  [<1060ad9c>] blk_execute_rq+0x9c/0x194
>> [    1.847787]  [<10700a1c>] __scsi_execute+0x130/0x1f4
>> [    1.847787]  [<10704d70>] scsi_probe_and_add_lun+0x214/0xc60
>> [    1.847787]  [<10706144>] __scsi_scan_target+0x164/0x5b4
>> [    1.847787]  [<10706804>] scsi_scan_host_selected+0x138/0x23c
>> [    1.847787]  [<107069d8>] do_scsi_scan_host+0xd0/0xf0
>> [    1.847787]  [<10706b98>] scsi_scan_host+0x1a0/0x1f0
>> [    1.847787]  [<10716ba0>] sym2_probe+0x824/0x850
>> [    1.847787]  [<10656110>] pci_device_probe+0x9c/0x148
>> [    1.847787]  [<106deee0>] really_probe+0xc4/0x34c
>> [    1.847787]  [<106df1c4>] __driver_probe_device+0x5c/0xbc
>> [    1.847787]  [<106df2c0>] driver_probe_device+0x9c/0x188
>> [    1.847787]  [<106dfb50>] __driver_attach+0xac/0x194
>> [    1.847787]  [<106dc784>] bus_for_each_dev+0x78/0xb8
>> [    1.847787]  [<106de698>] driver_attach+0x28/0x38
>> [    1.847787]  [<106de144>] bus_add_driver+0x198/0x224
>> [    1.847787]  [<106e05e0>] driver_register+0x98/0x168
>> [    1.847787]  [<106555d0>] __pci_register_driver+0x80/0x94
>> [    1.847787]
>> [    1.847787] Kernel panic - not syncing: Kernel Fault
>>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

