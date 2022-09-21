Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E635BF57B
	for <lists+linux-arch@lfdr.de>; Wed, 21 Sep 2022 06:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiIUEkX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Sep 2022 00:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiIUEjw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Sep 2022 00:39:52 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645FF7CAB9;
        Tue, 20 Sep 2022 21:39:50 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso2637273pjq.1;
        Tue, 20 Sep 2022 21:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=ZhKpW4bA8Om6ilBjW0WIoXQgS9i7E7XI9ulutjZpVlU=;
        b=ffiNLTgfUmjsjb0YEnr3pnvoki5tUUldKmDVGTdg1y2d/+0UIMiW4c/XzRX3t/5IML
         6akb0bO8+aCTsPMx37BUfIVdbjAempBLs9Dr08DeJaMstoil9v0+RXSIB1y4LZKQMXT/
         EMV9BKDjlk2Uic7dVko9DFVBYjWTEBgQ8NSHrR/m6w2jKn9uuV1mOviBvuA9QSg23OPk
         tleHbiJkpXWO8ZXbe7igQbufj/O1sKsos2aia00/cwhCXXVPddK2sgB2hAs+Q264t/Vt
         CISD1hjWxq6lAlRNZZp2N6Y7qvkNmEu8RGqHpujWTYv1qoxhJVT65Gpa5Smbp3PkelJp
         Qcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ZhKpW4bA8Om6ilBjW0WIoXQgS9i7E7XI9ulutjZpVlU=;
        b=dcp3owifSv/P/9wqnWvOkgqg2vGasoRadTjyHh14YL0PVgIi8YIhSQt6MreS8r0Ea0
         d9mSqkVYdbDdouXaZ6C2xvJkLGU3/cjSuj7qGiOQgzPK+QGiwCYNcBS4DtDQPNCgAaA2
         B7quBqaDrL8OlQmvoYui8srU8N7ZcdaXG8iiUx7BJUTVMVBrhF0K5DOvaVitkDrg2Pqh
         yeMrxzb58i3cqA0mGQgG/Qhpr1Am3juvhuiDQ1AQPHMemwN6obGap18Pw5p1l2m7LkgV
         m2OfvrBD1uXOYxD584CQRNpRCrnm0ChDH3Ct1dr2Uxta0Md+99hIhueHYEGk1J0r5v2e
         NTtQ==
X-Gm-Message-State: ACrzQf2OVSi/16w4z6eBY5XWPibCnPvaS2S9epTkMNU7fWhpTYdjQK6O
        hy2B9511B5XsyYZ9jsh9Yd0Vg9awuf/3kg==
X-Google-Smtp-Source: AMsMyM6oj6ZTkc+6EreWNzXiuhwaqWX0JkBw0q3+S5Ppm1sCFKKVGsC43mXrkkqIWS5Bt8kKEOyh+A==
X-Received: by 2002:a17:903:54:b0:176:cdf8:b791 with SMTP id l20-20020a170903005400b00176cdf8b791mr2854089pla.24.1663735189814;
        Tue, 20 Sep 2022 21:39:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p2-20020a170902c70200b0016f85feae65sm804453plp.87.2022.09.20.21.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 21:39:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 20 Sep 2022 21:39:46 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 3/8] kbuild: move core-y and drivers-y to ./Kbuild
Message-ID: <20220921043946.GA1355561@roeck-us.net>
References: <20220906061313.1445810-1-masahiroy@kernel.org>
 <20220906061313.1445810-4-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906061313.1445810-4-masahiroy@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On Tue, Sep 06, 2022 at 03:13:08PM +0900, Masahiro Yamada wrote:
> Use the ordinary obj-y to list subdirectories.
> 
> Note1:
> GNU Make seems to transform './.modules.order' to '.modules.order'
> before matching it against the target pattern. Split ./.modules.order
> to a dedicated rule to avoid "doesn't match the target pattern"
> warning. [1]
> 
> Note2:
> Previously, the link order of lib-y depended on CONFIG_MODULES; lib-y
> was linked before drivers-y when CONFIG_MODULES=y, otherwise after
> drivers-y. This was a bug of commit 7273ad2b08f8 ("kbuild: link lib-y
> objects to vmlinux forcibly when CONFIG_MODULES=y"), but it was not a
> big deal after all. Now, libs-y (all objects that come from lib/ and
> arch/*/lib/) is linked last, irrespective of CONFIG_MODULES.
> 
> Note3:
> Now, the single target build in arch/*/lib/ works correctly. There was
> a bug report about this. [2]
> 
>   $ make ARCH=arm arch/arm/lib/findbit.o
>     CALL    scripts/checksyscalls.sh
>     AS      arch/arm/lib/findbit.o
> 
> [1]: https://lists.gnu.org/archive/html/bug-make/2022-08/msg00059.html
> [2]: https://lore.kernel.org/linux-kbuild/YvUQOwL6lD4%2F5%2FU6@shell.armlinux.org.uk/
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

With this patch in place, all parisc images crash during boot with the
crash dump below. Bisect on next-20220920 points to this patch.
Crash and bisect logs are attached.

Loking through boot logs, the same problem (same backtrace) is seen
with various boot tests on alpha. There may be more, but -next
crashes all over the place right now so it is difficult to determine
the platforms affected by a specicfic problem.

Guenter

---
# bad: [ef08d387bbbc20df740ced8caee0ffac835869ac] Add linux-next specific files for 20220920
# good: [521a547ced6477c54b4b0cc206000406c221b4d6] Linux 6.0-rc6
git bisect start 'HEAD' 'v6.0-rc6'
# bad: [df970c033333b10c728198606fe787535e08ab8a] Merge branch 'drm-next' of git://git.freedesktop.org/git/drm/drm.git
git bisect bad df970c033333b10c728198606fe787535e08ab8a
# bad: [0120f1228dc162c1e00ac24b788a67cc669ff56f] Merge branch 'docs-next' of git://git.lwn.net/linux.git
git bisect bad 0120f1228dc162c1e00ac24b788a67cc669ff56f
# bad: [ed1b38e88a53a328673e1fffdd6bb69e02c34af1] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
git bisect bad ed1b38e88a53a328673e1fffdd6bb69e02c34af1
# bad: [4dd0700db9ab87d345d989c7589077d858a1f387] Merge branch 'for-next/core' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
git bisect bad 4dd0700db9ab87d345d989c7589077d858a1f387
# good: [61aa10c4f088adac94f88ba967db44ffab627aef] Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git
git bisect good 61aa10c4f088adac94f88ba967db44ffab627aef
# bad: [94c23f8f94b27223a557c88075ea063c70afc0ae] Merge branch 'perf/core' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
git bisect bad 94c23f8f94b27223a557c88075ea063c70afc0ae
# good: [6357b3bb80d81a4ad5fe1d15f50ebe5de6c9cab2] perf intel-pt: Support itrace option flag d+e to log on error
git bisect good 6357b3bb80d81a4ad5fe1d15f50ebe5de6c9cab2
# bad: [d2ed1be371b80f97d2141cfcb0c4ecd02e550180] scripts: remove unused argument 'type'
git bisect bad d2ed1be371b80f97d2141cfcb0c4ecd02e550180
# good: [a521c97e2a63490c238865763fc86942dce8d6bb] kbuild: rewrite check-local-export in sh/awk
git bisect good a521c97e2a63490c238865763fc86942dce8d6bb
# bad: [165b718fdd8c5a9165b4485019729c0cd8728120] kbuild: unify two modpost invocations
git bisect bad 165b718fdd8c5a9165b4485019729c0cd8728120
# bad: [10d1d4b75525f3172c6930fb20445f669762ea95] kbuild: move core-y and drivers-y to ./Kbuild
git bisect bad 10d1d4b75525f3172c6930fb20445f669762ea95
# good: [fd5f5437264c05b9fc0fff4349f0564f474bdf5e] kbuild: rename modules.order in sub-directories to .modules.order
git bisect good fd5f5437264c05b9fc0fff4349f0564f474bdf5e
# first bad commit: [10d1d4b75525f3172c6930fb20445f669762ea95] kbuild: move core-y and drivers-y to ./Kbuild

---
[    1.812993] sym53c8xx 0000:00:00.0: enabling SERR and PARITY (0107 -> 0147)
[    1.816056] sym0: <895a> rev 0x0 at pci 0000:00:00.0 irq 19
[    1.823635] sym0: PA-RISC Firmware, ID 7, Fast-40, LVD, parity checking
[    1.827770] sym0: SCSI BUS has been reset.
[    1.833713] scsi host0: sym-2.2.3
[    1.845265] Backtrace:
[    1.845750]  [<10b83400>] sg_pool_alloc+0xac/0xc0
[    1.846512]  [<10ac8ba8>] __sg_alloc_table+0x16c/0x1c0
[    1.846728]  [<10b83540>] sg_alloc_table_chained+0x6c/0xec
[    1.846911]  [<106ff470>] scsi_alloc_sgtables+0x8c/0x268
[    1.847129]  [<10703d5c>] scsi_queue_rq+0xae4/0xb3c
[    1.847296]  [<1060f62c>] blk_mq_dispatch_rq_list+0x1e4/0xa2c
[    1.847538]  [<10617184>] __blk_mq_sched_dispatch_requests+0xb4/0x188
[    1.847758]  [<10617334>] blk_mq_sched_dispatch_requests+0x58/0x84
[    1.847787]  [<1060b6bc>] __blk_mq_run_hw_queue+0x78/0x108
[    1.847787]  [<1060d968>] __blk_mq_delay_run_hw_queue+0x114/0x1e0
[    1.847787]  [<1060dc64>] blk_mq_run_hw_queue+0xb0/0x12c
[    1.847787]  [<10617600>] blk_mq_sched_insert_request+0x12c/0x158
[    1.847787]  [<1060ad9c>] blk_execute_rq+0x9c/0x194
[    1.847787]  [<10700a1c>] __scsi_execute+0x130/0x1f4
[    1.847787]  [<10704d70>] scsi_probe_and_add_lun+0x214/0xc60
[    1.847787]  [<10706144>] __scsi_scan_target+0x164/0x5b4
[    1.847787]  [<10706804>] scsi_scan_host_selected+0x138/0x23c
[    1.847787]  [<107069d8>] do_scsi_scan_host+0xd0/0xf0
[    1.847787]  [<10706b98>] scsi_scan_host+0x1a0/0x1f0
[    1.847787]  [<10716ba0>] sym2_probe+0x824/0x850
[    1.847787]  [<10656110>] pci_device_probe+0x9c/0x148
[    1.847787]  [<106deee0>] really_probe+0xc4/0x34c
[    1.847787]  [<106df1c4>] __driver_probe_device+0x5c/0xbc
[    1.847787]  [<106df2c0>] driver_probe_device+0x9c/0x188
[    1.847787]  [<106dfb50>] __driver_attach+0xac/0x194
[    1.847787]  [<106dc784>] bus_for_each_dev+0x78/0xb8
[    1.847787]  [<106de698>] driver_attach+0x28/0x38
[    1.847787]  [<106de144>] bus_add_driver+0x198/0x224
[    1.847787]  [<106e05e0>] driver_register+0x98/0x168
[    1.847787]  [<106555d0>] __pci_register_driver+0x80/0x94
[    1.847787]
[    1.847787]
[    1.847787] Kernel Fault: Code=26 (Data memory access rights trap) at addr 0000002c
[    1.847787] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.0.0-rc6-next-20220920-32bit #1
[    1.847787] Hardware name: 9000/778/B160L
[    1.847787]
[    1.847787]      YZrvWESTHLNXBCVMcbcbcbcbOGFRQPDI
[    1.847787] PSW: 00000000000001001011111100001111 Not tainted
[    1.847787] r00-03  0004bf0f 1183d400 10b83400 1183d440
[    1.847787] r04-07  00000000 00092820 00092820 00000080
[    1.847787] r08-11  00000000 00000034 00000002 11830000
[    1.847787] r12-15  000001f4 10db0000 1204f128 00000001
[    1.847787] r16-19  11beb200 1204f038 1183d0c8 00000080
[    1.847787] r20-23  00000820 00000001 10b83354 00000000
[    1.847787] r24-27  00000080 00000820 00000000 10e42e18
[    1.847787] r28-31  00092000 0000000f 1183d4c0 10ac8ba8
[    1.847787] sr00-03  00000000 00000000 00000000 00000000
[    1.847787] sr04-07  00000000 00000000 00000000 00000000
[    1.847787]
[    1.847787] IASQ: 00000000 00000000 IAOQ: 102bce5c 102bce60
[    1.847787]  IIR: 48960058    ISR: 00000000  IOR: 0000002c
[    1.847787]  CPU:        0   CR30: 11830000 CR31: 00000000
[    1.847787]  ORIG_R28: 86b51896
[    1.847787]  IAOQ[0]: mempool_alloc+0x78/0x1a8
[    1.847787]  IAOQ[1]: mempool_alloc+0x7c/0x1a8
[    1.847787]  RP(r2): sg_pool_alloc+0xac/0xc0
[    1.847787] Backtrace:
[    1.847787]  [<10b83400>] sg_pool_alloc+0xac/0xc0
[    1.847787]  [<10ac8ba8>] __sg_alloc_table+0x16c/0x1c0
[    1.847787]  [<10b83540>] sg_alloc_table_chained+0x6c/0xec
[    1.847787]  [<106ff470>] scsi_alloc_sgtables+0x8c/0x268
[    1.847787]  [<10703d5c>] scsi_queue_rq+0xae4/0xb3c
[    1.847787]  [<1060f62c>] blk_mq_dispatch_rq_list+0x1e4/0xa2c
[    1.847787]  [<10617184>] __blk_mq_sched_dispatch_requests+0xb4/0x188
[    1.847787]  [<10617334>] blk_mq_sched_dispatch_requests+0x58/0x84
[    1.847787]  [<1060b6bc>] __blk_mq_run_hw_queue+0x78/0x108
[    1.847787]  [<1060d968>] __blk_mq_delay_run_hw_queue+0x114/0x1e0
[    1.847787]  [<1060dc64>] blk_mq_run_hw_queue+0xb0/0x12c
[    1.847787]  [<10617600>] blk_mq_sched_insert_request+0x12c/0x158
[    1.847787]  [<1060ad9c>] blk_execute_rq+0x9c/0x194
[    1.847787]  [<10700a1c>] __scsi_execute+0x130/0x1f4
[    1.847787]  [<10704d70>] scsi_probe_and_add_lun+0x214/0xc60
[    1.847787]  [<10706144>] __scsi_scan_target+0x164/0x5b4
[    1.847787]  [<10706804>] scsi_scan_host_selected+0x138/0x23c
[    1.847787]  [<107069d8>] do_scsi_scan_host+0xd0/0xf0
[    1.847787]  [<10706b98>] scsi_scan_host+0x1a0/0x1f0
[    1.847787]  [<10716ba0>] sym2_probe+0x824/0x850
[    1.847787]  [<10656110>] pci_device_probe+0x9c/0x148
[    1.847787]  [<106deee0>] really_probe+0xc4/0x34c
[    1.847787]  [<106df1c4>] __driver_probe_device+0x5c/0xbc
[    1.847787]  [<106df2c0>] driver_probe_device+0x9c/0x188
[    1.847787]  [<106dfb50>] __driver_attach+0xac/0x194
[    1.847787]  [<106dc784>] bus_for_each_dev+0x78/0xb8
[    1.847787]  [<106de698>] driver_attach+0x28/0x38
[    1.847787]  [<106de144>] bus_add_driver+0x198/0x224
[    1.847787]  [<106e05e0>] driver_register+0x98/0x168
[    1.847787]  [<106555d0>] __pci_register_driver+0x80/0x94
[    1.847787]
[    1.847787] Kernel panic - not syncing: Kernel Fault

