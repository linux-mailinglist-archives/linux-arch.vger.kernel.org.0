Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44AD5E6220
	for <lists+linux-arch@lfdr.de>; Thu, 22 Sep 2022 14:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiIVMRH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Sep 2022 08:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiIVMRF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Sep 2022 08:17:05 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82470E4DA4
        for <linux-arch@vger.kernel.org>; Thu, 22 Sep 2022 05:17:01 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220922121656euoutp02ab39078b98a3161fd431a546a242c603~XLd1rwarH2318923189euoutp02o
        for <linux-arch@vger.kernel.org>; Thu, 22 Sep 2022 12:16:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220922121656euoutp02ab39078b98a3161fd431a546a242c603~XLd1rwarH2318923189euoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663849016;
        bh=JP1CCC83ecikgKhB1aKVTL+wH4Cqu3wMuMPaOL07y84=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=bFPMqKrl+5sXV786zC/fMvKVwd3Hpqvz+zH6TJyqlvGk/WbGYNTZRi9B3+2JGmnVf
         9wRWAVm5RXWBEgaF2Cu6C7khVAjjk0qwbx3Y4ySqFFosQ2gnsAppGki1rev9fcfFXT
         dIerIysekAKJeteY/J9siDwLweWYxdax6Bd05Cco=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220922121656eucas1p1ddd26a1feb35304a35d7d401fd0a73e3~XLd1bwg9D1887618876eucas1p1e;
        Thu, 22 Sep 2022 12:16:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 90.8E.07817.7325C236; Thu, 22
        Sep 2022 13:16:55 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220922121655eucas1p11822db5dbd1455bcbdba901f543b8e6b~XLd1GHWOc0058200582eucas1p15;
        Thu, 22 Sep 2022 12:16:55 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220922121655eusmtrp2349ac1d1a632d8b1739a89777d731071~XLd1FeCim1231712317eusmtrp2I;
        Thu, 22 Sep 2022 12:16:55 +0000 (GMT)
X-AuditID: cbfec7f4-893ff70000011e89-4e-632c5237d5d7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id FE.62.10862.7325C236; Thu, 22
        Sep 2022 13:16:55 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220922121655eusmtip25a77a22399ad270aefada98b441cce24~XLd0psA-D1374613746eusmtip26;
        Thu, 22 Sep 2022 12:16:55 +0000 (GMT)
Message-ID: <8e70837d-d859-dfb2-bf7f-83f8b31467bc@samsung.com>
Date:   Thu, 22 Sep 2022 14:16:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v2 3/8] kbuild: move core-y and drivers-y to ./Kbuild
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-scsi <linux-scsi@vger.kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20220921043946.GA1355561@roeck-us.net>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42LZduznOV3zIJ1kg+t3rC06dn1lsfizaweT
        xeVdc9gsuq/vYLN4svAMk8XDBzdYHdg8Nq3qZPPY+b2B3ePzJrkA5igum5TUnMyy1CJ9uwSu
        jN6fV5gKWrIq9s5uZGxgnBbZxcjJISFgIjHvzH2WLkYuDiGBFYwSWw9eYoNwvjBKrJr5nQmk
        SkjgM6PEge1lMB1P1p1hhihaziix7PINKOcjo8S/P8vYQap4Bewk7s5qZAGxWQRUJTZca4aK
        C0qcnPkELC4qkCwx69gxRhBbWMBT4uySTjYQm1lAXOLWk/lAmzk4RAQCJK4tiACZzyzQyigx
        8cwKsF42AUOJrrddYPWcQBft3LeNHaJXXqJ562ywgyQEDnBIvPm4kR3ibBeJ/rswtrDEq+Nb
        oGwZif87QZaBNLQzSiz4fR/KmcAo0fD8FiNElbXEnXO/2EBOYhbQlFi/Sx8i7Cjx4vdDVpCw
        hACfxI23ghBH8ElM2jadGSLMK9HRJgRRrSYx6/g6uLUHL1xinsCoNAspWGYheX8WkndmIexd
        wMiyilE8tbQ4Nz212CgvtVyvODG3uDQvXS85P3cTIzDNnP53/MsOxuWvPuodYmTiYDzEKMHB
        rCTCO/uOZrIQb0piZVVqUX58UWlOavEhRmkOFiVxXrYZWslCAumJJanZqakFqUUwWSYOTqkG
        poX3/X6/P8jstslyVUs1856+3Bd/f2TapP/J4n9nfOO6wpZ36YlrG62XnHm4NfdmcbdKZ3PF
        fTNlBbfcksOK27gPJVY+Yrj7Y1u5X/DU50cc2yfklCT5+6wVzA4DeuPxpBnt/Ev1HqXZ+BzV
        2aMhERUWNqnJ/Y6Cxet1D1eGH3Aq2Km3IGGzyevigin747x+afdfkay/ovSlmtH711LD62zp
        QQEMGxpubpJRTTB6e2bX6TJV5roDZed/nnVy/PLqX93kbR+O62qucZokeaLriQtnZuMzrvUR
        ibbp0Xse8+Qv+FA2abkoM2ub0WeeM9fjrD5EM2Ss7gt6eehgRdzss898ls26sX3/4QOWn95e
        U2Ipzkg01GIuKk4EAD7CNkCiAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsVy+t/xe7rmQTrJBm+6NSw6dn1lsfizaweT
        xeVdc9gsuq/vYLN4svAMk8XDBzdYHdg8Nq3qZPPY+b2B3ePzJrkA5ig9m6L80pJUhYz84hJb
        pWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jN6fV5gKWrIq9s5uZGxgnBbZ
        xcjJISFgIvFk3RnmLkYuDiGBpYwST09tY4JIyEicnNbACmELS/y51sUGUfSeUaKzaxVYEa+A
        ncTdWY0sIDaLgKrEhmvN7BBxQYmTM5+AxUUFkiWWNNwHGyQs4ClxdkknG4jNLCAucevJfLA5
        IgJ+EgeWdbNCxFsZJU7vcIRYNp1Rou3oYWaQBJuAoUTX2y6wZk6gs3fu28YO0WAm0bW1ixHC
        lpdo3jqbeQKj0Cwkd8xCsm8WkpZZSFoWMLKsYhRJLS3OTc8tNtIrTswtLs1L10vOz93ECIys
        bcd+btnBuPLVR71DjEwcjIcYJTiYlUR4Z9/RTBbiTUmsrEotyo8vKs1JLT7EaAoMjInMUqLJ
        +cDYziuJNzQzMDU0MbM0MLU0M1YS5/Us6EgUEkhPLEnNTk0tSC2C6WPi4JRqYFr6oWbiezkp
        h0anpQGCQd+/6RedDH7w6sC7tW8c3qxfGvYwTeeXFu/l8J2vbAyuCK9xC1j/y3jJTX7Oncuk
        tpv/89jQtsFK2e5noX3EOYlJntJWydv363UahMpy9G9WmM9msZm3/bXOha3Z8Z0XyyVCi9SZ
        LnAu+38zkf223Bre9xPzjx08eHrLjHe6825712X56aULtr3uU/FtUxE00z5na1i1+cRPX+s/
        O6xrRU6XXp4n7t26PUVn6bcIOzZzt8UBbtyXTnyQep0rXiYuovzEn6E5NY3xCd/GuIcO6g9c
        0mY02xdX7XrIWsOTPXfir5kVPj3zTEqsCyK1s3vn1M7fLhoVv4fr+kGL9/XGSizFGYmGWsxF
        xYkApP+U4TUDAAA=
X-CMS-MailID: 20220922121655eucas1p11822db5dbd1455bcbdba901f543b8e6b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220922121655eucas1p11822db5dbd1455bcbdba901f543b8e6b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220922121655eucas1p11822db5dbd1455bcbdba901f543b8e6b
References: <20220906061313.1445810-1-masahiroy@kernel.org>
        <20220906061313.1445810-4-masahiroy@kernel.org>
        <20220921043946.GA1355561@roeck-us.net>
        <CGME20220922121655eucas1p11822db5dbd1455bcbdba901f543b8e6b@eucas1p1.samsung.com>
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,SUSPICIOUS_RECIPS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi All,

On 21.09.2022 06:39, Guenter Roeck wrote:
> On Tue, Sep 06, 2022 at 03:13:08PM +0900, Masahiro Yamada wrote:
>> Use the ordinary obj-y to list subdirectories.
>>
>> Note1:
>> GNU Make seems to transform './.modules.order' to '.modules.order'
>> before matching it against the target pattern. Split ./.modules.order
>> to a dedicated rule to avoid "doesn't match the target pattern"
>> warning. [1]
>>
>> Note2:
>> Previously, the link order of lib-y depended on CONFIG_MODULES; lib-y
>> was linked before drivers-y when CONFIG_MODULES=y, otherwise after
>> drivers-y. This was a bug of commit 7273ad2b08f8 ("kbuild: link lib-y
>> objects to vmlinux forcibly when CONFIG_MODULES=y"), but it was not a
>> big deal after all. Now, libs-y (all objects that come from lib/ and
>> arch/*/lib/) is linked last, irrespective of CONFIG_MODULES.
>>
>> Note3:
>> Now, the single target build in arch/*/lib/ works correctly. There was
>> a bug report about this. [2]
>>
>>    $ make ARCH=arm arch/arm/lib/findbit.o
>>      CALL    scripts/checksyscalls.sh
>>      AS      arch/arm/lib/findbit.o
>>
>> [1]: https://lists.gnu.org/archive/html/bug-make/2022-08/msg00059.html
>> [2]: https://lore.kernel.org/linux-kbuild/YvUQOwL6lD4%2F5%2FU6@shell.armlinux.org.uk/
>>
>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> With this patch in place, all parisc images crash during boot with the
> crash dump below. Bisect on next-20220920 points to this patch.
> Crash and bisect logs are attached.
>
> Loking through boot logs, the same problem (same backtrace) is seen
> with various boot tests on alpha. There may be more, but -next
> crashes all over the place right now so it is difficult to determine
> the platforms affected by a specicfic problem.

I confirm this. I've observed similar issue recently (from time to time) 
on the ARM 32bit based Exynos5250-based Arndale board. 'git bisect' lead 
me also to this change. A short investigation revealed that the issue is 
caused by the NULL sgp->pool in lib/sg_pool.c:sg_pool_alloc() function. 
Sometimes it works fine, sometimes not. It looks that there is a race in 
the sg_pools and scsi initialization somehow after this patch.

To confirm that this change is really responsible for the issue I've 
tried to revert it on top of linux-next. This is however hard due to the 
dependencies. Instead I've only did:

# git revert -m1 6fb5a32d95a9b1a9d4a6e135404468a8d74cfde6

on top of the linux next-20220921 and resolved the conflict (trivial to 
resolve). After that the kernel boots fine and I was not able to 
reproduce the issue.

The issue I've observed was:

ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: HPA detected: current 117229295, native 117231408
ata1.00: ATA-8: Corsair CSSD-F60GB2, 1.1, max UDMA/133
ata1.00: 117229295 sectors, multi 1: LBA48 NCQ (depth 32)
ata1.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      Corsair CSSD-F60 1.1  PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 117229295 512-byte logical blocks: (60.0 GB/55.9 GiB)
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Preferred minimum I/O size 512 bytes
8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 00000034
usb3503 usb-hub: switched to HUB mode
[00000034] *pgd=00000000
usb3503 usb-hub: usb3503_probe: probed in hub mode
UDC core: g_ether: couldn't find an available UDC

Internal error: Oops: 5 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 0 PID: 7 Comm: kworker/0:0H Not tainted 
6.0.0-rc5-00016-g10d1d4b75525 #12835
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: kblockd blk_mq_run_work_fn
PC is at mempool_alloc+0x48/0x14c
LR is at mempool_alloc+0x2c/0x14c
pc : [<c0267a2c>]    lr : [<c0267a10>]    psr: 40000013
...
Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 4000406a  DAC: 00000051
...
Process kworker/0:0H (pid: 7, stack limit = 0x(ptrval))
Stack: (0xf0839cc8 to 0xf083a000)
...
  mempool_alloc from __sg_alloc_table+0x120/0x160
  __sg_alloc_table from sg_alloc_table_chained+0x5c/0xc0
  sg_alloc_table_chained from scsi_alloc_sgtables+0x5c/0x294
  scsi_alloc_sgtables from sd_init_command+0x118/0x908
  sd_init_command from scsi_queue_rq+0x360/0xbe0
  scsi_queue_rq from blk_mq_dispatch_rq_list+0x1d8/0x8c8
  blk_mq_dispatch_rq_list from blk_mq_do_dispatch_sched+0x2e0/0x338
  blk_mq_do_dispatch_sched from __blk_mq_sched_dispatch_requests+0xa8/0x150
  __blk_mq_sched_dispatch_requests from 
blk_mq_sched_dispatch_requests+0x34/0x5c
  blk_mq_sched_dispatch_requests from __blk_mq_run_hw_queue+0x88/0x22c
  __blk_mq_run_hw_queue from process_one_work+0x288/0x778
  process_one_work from worker_thread+0x44/0x504
  worker_thread from kthread+0xf0/0x124
  kthread from ret_from_fork+0x14/0x2c
Exception stack(0xf0839fb0 to 0xf0839ff8)
9fa0:                                     00000000 00000000 00000000 
00000000
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
00000000
9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
Code: e30ea764 e3c44d11 e34ca017 e3844a92 (e5953034)
---[ end trace 0000000000000000 ]---


>
> Guenter
>
> ---
> # bad: [ef08d387bbbc20df740ced8caee0ffac835869ac] Add linux-next specific files for 20220920
> # good: [521a547ced6477c54b4b0cc206000406c221b4d6] Linux 6.0-rc6
> git bisect start 'HEAD' 'v6.0-rc6'
> # bad: [df970c033333b10c728198606fe787535e08ab8a] Merge branch 'drm-next' of git://git.freedesktop.org/git/drm/drm.git
> git bisect bad df970c033333b10c728198606fe787535e08ab8a
> # bad: [0120f1228dc162c1e00ac24b788a67cc669ff56f] Merge branch 'docs-next' of git://git.lwn.net/linux.git
> git bisect bad 0120f1228dc162c1e00ac24b788a67cc669ff56f
> # bad: [ed1b38e88a53a328673e1fffdd6bb69e02c34af1] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
> git bisect bad ed1b38e88a53a328673e1fffdd6bb69e02c34af1
> # bad: [4dd0700db9ab87d345d989c7589077d858a1f387] Merge branch 'for-next/core' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
> git bisect bad 4dd0700db9ab87d345d989c7589077d858a1f387
> # good: [61aa10c4f088adac94f88ba967db44ffab627aef] Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git
> git bisect good 61aa10c4f088adac94f88ba967db44ffab627aef
> # bad: [94c23f8f94b27223a557c88075ea063c70afc0ae] Merge branch 'perf/core' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
> git bisect bad 94c23f8f94b27223a557c88075ea063c70afc0ae
> # good: [6357b3bb80d81a4ad5fe1d15f50ebe5de6c9cab2] perf intel-pt: Support itrace option flag d+e to log on error
> git bisect good 6357b3bb80d81a4ad5fe1d15f50ebe5de6c9cab2
> # bad: [d2ed1be371b80f97d2141cfcb0c4ecd02e550180] scripts: remove unused argument 'type'
> git bisect bad d2ed1be371b80f97d2141cfcb0c4ecd02e550180
> # good: [a521c97e2a63490c238865763fc86942dce8d6bb] kbuild: rewrite check-local-export in sh/awk
> git bisect good a521c97e2a63490c238865763fc86942dce8d6bb
> # bad: [165b718fdd8c5a9165b4485019729c0cd8728120] kbuild: unify two modpost invocations
> git bisect bad 165b718fdd8c5a9165b4485019729c0cd8728120
> # bad: [10d1d4b75525f3172c6930fb20445f669762ea95] kbuild: move core-y and drivers-y to ./Kbuild
> git bisect bad 10d1d4b75525f3172c6930fb20445f669762ea95
> # good: [fd5f5437264c05b9fc0fff4349f0564f474bdf5e] kbuild: rename modules.order in sub-directories to .modules.order
> git bisect good fd5f5437264c05b9fc0fff4349f0564f474bdf5e
> # first bad commit: [10d1d4b75525f3172c6930fb20445f669762ea95] kbuild: move core-y and drivers-y to ./Kbuild
>
> ---
> [    1.812993] sym53c8xx 0000:00:00.0: enabling SERR and PARITY (0107 -> 0147)
> [    1.816056] sym0: <895a> rev 0x0 at pci 0000:00:00.0 irq 19
> [    1.823635] sym0: PA-RISC Firmware, ID 7, Fast-40, LVD, parity checking
> [    1.827770] sym0: SCSI BUS has been reset.
> [    1.833713] scsi host0: sym-2.2.3
> [    1.845265] Backtrace:
> [    1.845750]  [<10b83400>] sg_pool_alloc+0xac/0xc0
> [    1.846512]  [<10ac8ba8>] __sg_alloc_table+0x16c/0x1c0
> [    1.846728]  [<10b83540>] sg_alloc_table_chained+0x6c/0xec
> [    1.846911]  [<106ff470>] scsi_alloc_sgtables+0x8c/0x268
> [    1.847129]  [<10703d5c>] scsi_queue_rq+0xae4/0xb3c
> [    1.847296]  [<1060f62c>] blk_mq_dispatch_rq_list+0x1e4/0xa2c
> [    1.847538]  [<10617184>] __blk_mq_sched_dispatch_requests+0xb4/0x188
> [    1.847758]  [<10617334>] blk_mq_sched_dispatch_requests+0x58/0x84
> [    1.847787]  [<1060b6bc>] __blk_mq_run_hw_queue+0x78/0x108
> [    1.847787]  [<1060d968>] __blk_mq_delay_run_hw_queue+0x114/0x1e0
> [    1.847787]  [<1060dc64>] blk_mq_run_hw_queue+0xb0/0x12c
> [    1.847787]  [<10617600>] blk_mq_sched_insert_request+0x12c/0x158
> [    1.847787]  [<1060ad9c>] blk_execute_rq+0x9c/0x194
> [    1.847787]  [<10700a1c>] __scsi_execute+0x130/0x1f4
> [    1.847787]  [<10704d70>] scsi_probe_and_add_lun+0x214/0xc60
> [    1.847787]  [<10706144>] __scsi_scan_target+0x164/0x5b4
> [    1.847787]  [<10706804>] scsi_scan_host_selected+0x138/0x23c
> [    1.847787]  [<107069d8>] do_scsi_scan_host+0xd0/0xf0
> [    1.847787]  [<10706b98>] scsi_scan_host+0x1a0/0x1f0
> [    1.847787]  [<10716ba0>] sym2_probe+0x824/0x850
> [    1.847787]  [<10656110>] pci_device_probe+0x9c/0x148
> [    1.847787]  [<106deee0>] really_probe+0xc4/0x34c
> [    1.847787]  [<106df1c4>] __driver_probe_device+0x5c/0xbc
> [    1.847787]  [<106df2c0>] driver_probe_device+0x9c/0x188
> [    1.847787]  [<106dfb50>] __driver_attach+0xac/0x194
> [    1.847787]  [<106dc784>] bus_for_each_dev+0x78/0xb8
> [    1.847787]  [<106de698>] driver_attach+0x28/0x38
> [    1.847787]  [<106de144>] bus_add_driver+0x198/0x224
> [    1.847787]  [<106e05e0>] driver_register+0x98/0x168
> [    1.847787]  [<106555d0>] __pci_register_driver+0x80/0x94
> [    1.847787]
> [    1.847787]
> [    1.847787] Kernel Fault: Code=26 (Data memory access rights trap) at addr 0000002c
> [    1.847787] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.0.0-rc6-next-20220920-32bit #1
> [    1.847787] Hardware name: 9000/778/B160L
> [    1.847787]
> [    1.847787]      YZrvWESTHLNXBCVMcbcbcbcbOGFRQPDI
> [    1.847787] PSW: 00000000000001001011111100001111 Not tainted
> [    1.847787] r00-03  0004bf0f 1183d400 10b83400 1183d440
> [    1.847787] r04-07  00000000 00092820 00092820 00000080
> [    1.847787] r08-11  00000000 00000034 00000002 11830000
> [    1.847787] r12-15  000001f4 10db0000 1204f128 00000001
> [    1.847787] r16-19  11beb200 1204f038 1183d0c8 00000080
> [    1.847787] r20-23  00000820 00000001 10b83354 00000000
> [    1.847787] r24-27  00000080 00000820 00000000 10e42e18
> [    1.847787] r28-31  00092000 0000000f 1183d4c0 10ac8ba8
> [    1.847787] sr00-03  00000000 00000000 00000000 00000000
> [    1.847787] sr04-07  00000000 00000000 00000000 00000000
> [    1.847787]
> [    1.847787] IASQ: 00000000 00000000 IAOQ: 102bce5c 102bce60
> [    1.847787]  IIR: 48960058    ISR: 00000000  IOR: 0000002c
> [    1.847787]  CPU:        0   CR30: 11830000 CR31: 00000000
> [    1.847787]  ORIG_R28: 86b51896
> [    1.847787]  IAOQ[0]: mempool_alloc+0x78/0x1a8
> [    1.847787]  IAOQ[1]: mempool_alloc+0x7c/0x1a8
> [    1.847787]  RP(r2): sg_pool_alloc+0xac/0xc0
> [    1.847787] Backtrace:
> [    1.847787]  [<10b83400>] sg_pool_alloc+0xac/0xc0
> [    1.847787]  [<10ac8ba8>] __sg_alloc_table+0x16c/0x1c0
> [    1.847787]  [<10b83540>] sg_alloc_table_chained+0x6c/0xec
> [    1.847787]  [<106ff470>] scsi_alloc_sgtables+0x8c/0x268
> [    1.847787]  [<10703d5c>] scsi_queue_rq+0xae4/0xb3c
> [    1.847787]  [<1060f62c>] blk_mq_dispatch_rq_list+0x1e4/0xa2c
> [    1.847787]  [<10617184>] __blk_mq_sched_dispatch_requests+0xb4/0x188
> [    1.847787]  [<10617334>] blk_mq_sched_dispatch_requests+0x58/0x84
> [    1.847787]  [<1060b6bc>] __blk_mq_run_hw_queue+0x78/0x108
> [    1.847787]  [<1060d968>] __blk_mq_delay_run_hw_queue+0x114/0x1e0
> [    1.847787]  [<1060dc64>] blk_mq_run_hw_queue+0xb0/0x12c
> [    1.847787]  [<10617600>] blk_mq_sched_insert_request+0x12c/0x158
> [    1.847787]  [<1060ad9c>] blk_execute_rq+0x9c/0x194
> [    1.847787]  [<10700a1c>] __scsi_execute+0x130/0x1f4
> [    1.847787]  [<10704d70>] scsi_probe_and_add_lun+0x214/0xc60
> [    1.847787]  [<10706144>] __scsi_scan_target+0x164/0x5b4
> [    1.847787]  [<10706804>] scsi_scan_host_selected+0x138/0x23c
> [    1.847787]  [<107069d8>] do_scsi_scan_host+0xd0/0xf0
> [    1.847787]  [<10706b98>] scsi_scan_host+0x1a0/0x1f0
> [    1.847787]  [<10716ba0>] sym2_probe+0x824/0x850
> [    1.847787]  [<10656110>] pci_device_probe+0x9c/0x148
> [    1.847787]  [<106deee0>] really_probe+0xc4/0x34c
> [    1.847787]  [<106df1c4>] __driver_probe_device+0x5c/0xbc
> [    1.847787]  [<106df2c0>] driver_probe_device+0x9c/0x188
> [    1.847787]  [<106dfb50>] __driver_attach+0xac/0x194
> [    1.847787]  [<106dc784>] bus_for_each_dev+0x78/0xb8
> [    1.847787]  [<106de698>] driver_attach+0x28/0x38
> [    1.847787]  [<106de144>] bus_add_driver+0x198/0x224
> [    1.847787]  [<106e05e0>] driver_register+0x98/0x168
> [    1.847787]  [<106555d0>] __pci_register_driver+0x80/0x94
> [    1.847787]
> [    1.847787] Kernel panic - not syncing: Kernel Fault
>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

