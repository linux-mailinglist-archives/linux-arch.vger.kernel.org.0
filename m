Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FDD6545BF
	for <lists+linux-arch@lfdr.de>; Thu, 22 Dec 2022 18:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiLVRuo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Dec 2022 12:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiLVRun (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Dec 2022 12:50:43 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22287C1
        for <linux-arch@vger.kernel.org>; Thu, 22 Dec 2022 09:50:40 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id e13so3942432edj.7
        for <linux-arch@vger.kernel.org>; Thu, 22 Dec 2022 09:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C4G6seCP5WW62r+QMvjgCT/XU/pY504ZXCTNG71hNFA=;
        b=dHBbtkTqqGNbNH5l5uCnx6ZK8WBghGFl6XMCc3o+yu50mZDukRfuKs4S7VZ5bhCQ0t
         JYNW1FmTpWCj+S6p4EpRHuRxTxYi7qrx7g6fZa7IIgQ6X3cl7EWMhvoO2KqxOp5J3L6l
         C9/MwIbZuQpF9TgWh1sTUpVUAqlxsgYBj8qfX52kTZf06ySaHjTLTWsZ9ZgOnIpiEET3
         9zDOsI4teL0DlvJOAtXjp+5UxKOXV6UfNHUi9ed7YciizAKG14doYSwOkRF9dFvA7rdr
         bqrJqeIIWKUCBs/1fWBb8ilScQGnxJKRR7R5+2hZ/Ht1aqxGbJ05jtpFdS/PBcezU4Ns
         2Ztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C4G6seCP5WW62r+QMvjgCT/XU/pY504ZXCTNG71hNFA=;
        b=uUM5WR9sweYP5RuhxDjeNVe7s+Mb1TCngNNMrhAYG81b58aiyl1np4dgVIP49xRnue
         674EZ8eTJrZQuvpRDZq24LHEnbeB18ijW27Gq8JHyqorCVO65lWmaJYN1m+X5gCzxfjE
         TpivReW1XDNGn1AVmpC04fXPPPCx4wLSzH+YeGiNQqoJMcH0g9KBOtOQGi2jqc9WnNI+
         mXsUtmgy/ohCnAbpm6RWVD3XKcTEvL31E/p2la2vWhBK7JbGrkdor/g1qzG4yXoSw1j7
         ZhYNqUyct1LbdzO02yHSBKmsa2eOxaO5qclnRoOWNdg68O6pR6mu0D7j90Zn9A9iJRGr
         nXZQ==
X-Gm-Message-State: AFqh2kqpv3gIqbUzCttWLmtCeUdEAgJgreox0xXME9OO+UXFYCEKqmEr
        uItT3hlAShd9T0LG9gHUWerxCBd258aEIW2U2dM=
X-Google-Smtp-Source: AMrXdXsuT0u7BYOrqWMsgNXmclLoWcIlGAokYiymXdCeoyzvFzvtQ5PNrY7L6IH27vmINpF8fUbke7SNTSGrHj0lWnc=
X-Received: by 2002:a05:6402:249e:b0:461:f919:caa4 with SMTP id
 q30-20020a056402249e00b00461f919caa4mr796399eda.255.1671731438503; Thu, 22
 Dec 2022 09:50:38 -0800 (PST)
MIME-Version: 1.0
References: <20220829205219.283543-1-geomatsi@gmail.com>
In-Reply-To: <20220829205219.283543-1-geomatsi@gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 22 Dec 2022 17:50:12 +0000
Message-ID: <CA+V-a8uLmp33PSYGmJjf9FupJ0M8Hf7ef7A1G4va8GDL_61Qyw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] riscv: mm: notify remote harts about mmu cache updates
To:     Sergey Matyukevich <geomatsi@gmail.com>
Cc:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Guo Ren <guoren@kernel.org>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Conor Dooley <Conor.Dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Sergey,

On Mon, Aug 29, 2022 at 9:53 PM Sergey Matyukevich <geomatsi@gmail.com> wrote:
>
> From: Sergey Matyukevich <sergey.matyukevich@syntacore.com>
>
> Current implementation of update_mmu_cache function performs local TLB
> flush. It does not take into account ASID information. Besides, it does
> not take into account other harts currently running the same mm context
> or possible migration of the running context to other harts. Meanwhile
> TLB flush is not performed for every context switch if ASID support
> is enabled.
>
> Patch [1] proposed to add ASID support to update_mmu_cache to avoid
> flushing local TLB entirely. This patch takes into account other
> harts currently running the same mm context as well as possible
> migration of this context to other harts.
>
> For this purpose the approach from flush_icache_mm is reused. Remote
> harts currently running the same mm context are informed via SBI calls
> that they need to flush their local TLBs. All the other harts are marked
> as needing a deferred TLB flush when this mm context runs on them.
>
> [1] https://lore.kernel.org/linux-riscv/20220821013926.8968-1-tjytimi@163.com/
>
> Signed-off-by: Sergey Matyukevich <sergey.matyukevich@syntacore.com>
> ---
>  arch/riscv/include/asm/mmu.h      |  2 ++
>  arch/riscv/include/asm/pgtable.h  |  2 +-
>  arch/riscv/include/asm/tlbflush.h | 18 ++++++++++++++++++
>  arch/riscv/mm/context.c           | 10 ++++++++++
>  arch/riscv/mm/tlbflush.c          | 28 +++++++++++-----------------
>  5 files changed, 42 insertions(+), 18 deletions(-)
>
I couldn't find your latest patch in my mailbox so I'm replying to this one.

I merged Palmer's for-next branch and when running tests on eMMC with
bonnie++ on the Renesas RZ/Five SoC I am seeing the below issues:

root@smarc-rzfive:/lava-testing# ./emmc_t_002.sh

Welcome to fdisk (util-linux 2.35.1).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

[   40.809677]  mmcblk0: p1

Command (m for help): Created a new DOS disklabel with disk identifier
0xf4682ae9.

Command (m for help): Partition type
   p   primary (0 primary, 0 extended, 4 free)
   e   extended (container for logical partitions)
Select (default p): Partition number (1-4, default 1): First sector
(2048-124321791, default 2048): Last sector, +/-sectors or
+/-size{K,M,G,T,P} (2048-124321791, default 124321791):
Created a new partition 1 of type 'Linux' and of size 59.3 GiB.
Partition #1 contains a ext4 signature.

Command (m for help):
The partition table has been altered.
Calling ioctl() to re-read partition table.
[   40.945583]  mmcblk0: p1
Syncing disks.

mke2fs 1.45.7 (28-Jan-2021)
/dev/mmcblk0p1 contains a ext4 file system
        last mounted on /tmp/tmp.PDgTkhohqt/mnt on Fri Dec 16 19:48:34 2022
Discarding device blocks: done
Creating filesystem with 15539968 4k blocks and 3891200 inodes
Filesystem UUID: 6effbf47-2d7a-4eb8-b2dc-1333b848e449
Superblock backups stored on blocks:
        32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
        4096000, 7962624, 11239424

Allocating group tables: done
Writing inode tables: done
Creating journal (65536 blocks): done
Writing superblocks and filesystem accounting information: done

e2fsck 1.45.7 (28-Jan-2021)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
/dev/mmcblk0p1: 11/3891200 files (0.0% non-contiguous), 323121/15539968 blocks
[   91.521828] EXT4-fs (mmcblk0p1): mounted filesystem
6effbf47-2d7a-4eb8-b2dc-1333b848e449 with ordered data mode. Quota
mode: disabled.
Using uid:0, gid:0.
Writing with putc()...[  131.775220] do_trap: 3 callbacks suppressed
[  131.775245] sd-resolve[128]: unhandled signal 11 code 0x1 at
0x0000000000000060 in libpthread-2.28.so[3fa6d80000+13000]
[  131.790382] CPU: 0 PID: 128 Comm: sd-resolve Not tainted
6.1.0-11009-gf4e9a8cdc25b #167
[  131.798386] Hardware name: Renesas SMARC EVK based on r9a07g043f01 (DT)
[  131.804999] epc : 0000003fa6d8eeac ra : 0000003fa6f4a76c sp :
0000003fa6b8c330
[  131.812214]  gp : 0000002aacc1cb88 tp : 0000003fa6b92810 t0 :
0000000000000022
[  131.819432]  t1 : 0000003fa6e7f0ec t2 : 0000003fa6b8b290 s0 :
0000003fa6b8c850
[  131.826669]  s1 : 0000002aacc1f430 a0 : 000000000000000a a1 :
0000003fa6b8c3b8
[  131.833891]  a2 : 0000000000004000 a3 : 0000000000000000 a4 :
0000000000000020
[  131.841110]  a5 : 0000000000000002 a6 : 0000003fa6b8c360 a7 :
0000000000000007
[  131.848328]  s2 : ffffffffffffb000 s3 : ffffffffffffd3d0 s4 :
0000003fa6fe0918
[  131.855561]  s5 : 0000003fa6b8ec20 s6 : 0000003fa6b8c440 s7 :
fffffffffffffffd
[  131.862783]  s8 : 0000003fa6b8c420 s9 : 000000000000000a s10:
0000000000000000
[  131.870001]  s11: 0000003fa6fe2090 t3 : 0000003fa6d8eeaa t4 :
00000009a331f45c
[  131.877219]  t5 : 000000000000003f t6 : 0000000000000000
[  131.882548] status: 8000000200006020 badaddr: 0000000000000060
cause: 000000000000000d
[  131.891349] systemd-journal[87]: unhandled signal 11 code 0x1 at
0x00000000000000c8 in systemd-journald[2abd710000+1b000]
[  131.902382] CPU: 0 PID: 87 Comm: systemd-journal Not tainted
6.1.0-11009-gf4e9a8cdc25b #167
[  131.910731] Hardware name: Renesas SMARC EVK based on r9a07g043f01 (DT)
[  131.917359] epc : 0000002abd7167e0 ra : 0000002abd7179e4 sp :
0000003fd65416c0
[  131.924578]  gp : 0000002abd72e120 tp : 0000003fbea1f720 t0 :
3534616138333466
[  131.931796]  t1 : ffffffffffffe000 t2 : 000000000000000d s0 :
0000003fd65416c0
[  131.939014]  s1 : 0000003fd65437a8 a0 : 0000000000000009 a1 :
0000003fd65416c0
[  131.946232]  a2 : 0000000000002000 a3 : 0000003fd65437a8 a4 :
0000003fd65436c8
[  131.953450]  a5 : 0000003fd65436d0 a6 : 0000000000000083 a7 :
0000000000000018
[  131.960668]  s2 : 0000003fbee6c918 s3 : 0000003fd6543708 s4 :
0000003fd6543700
[  131.967885]  s5 : 0000002abd724718 s6 : 0000002abd7247d8 s7 :
0000000000000000
[  131.975102]  s8 : ffffffffffffffff s9 : 0000002ad2397120 s10:
0000000000000000
[  131.982319]  s11: 0000003fe5aad418 t3 : 0000003fbed75364 t4 :
00000009a7934adc
[  131.989564]  t5 : 00000000001ea8b0 t6 : 3463396363613637
[  131.994883] status: 0000000200004020 badaddr: 00000000000000c8
cause: 000000000000000d
[  132.003911] audit: type=1701 audit(1671220069.615:11):
auid=4294967295 uid=0 gid=0 ses=4294967295 pid=87
comm="systemd-journal" exe="/lib/systemd/systemd-journald" sig=11
res=1
[  132.024142] systemd[1]: unhandled signal 11 code 0x1 at
0xffffffac2b2a2928 in ld-2.28.so[3f83a6e000+17000]
[  132.033946] CPU: 0 PID: 1 Comm: systemd Not tainted
6.1.0-11009-gf4e9a8cdc25b #167
[  132.041563] Hardware name: Renesas SMARC EVK based on r9a07g043f01 (DT)
[  132.048198] epc : 0000003f83a7a81c ra : 0000003f83a7a992 sp :
0000003fe5aad570
[  132.055419]  gp : 0000002ad234ad28 tp : 0000003f83628e70 t0 :
0000000000a9919e
[  132.062635]  t1 : 0000003f8391f7dc t2 : 0000000000000000 s0 :
0000003f83a664d0
[  132.069852]  s1 : 0000003f83a85918 a0 : 0000000000000001 a1 :
0000003f83a20940
[  132.077068]  a2 : 0000003f83629680 a3 : 0000000000000073 a4 :
0000000000000001
[  132.084284]  a5 : 0000003f83a87090 a6 : 000000000000002f a7 :
0000000000062164
[  132.091501]  s2 : 0000002ad22cdce0 s3 : 0000003f83a85918 s4 :
0000000000000006
[  132.098722]  s5 : 0000000000000002 s6 : 0000003f83a85918 s7 :
0000000000001000
[  132.105939]  s8 : 0000003fe5aad750 s9 : 0000003fe5aad9e0 s10:
0000002ad22fdd60
[  132.113155]  s11: 2f2e2d2c2b2a2928 t3 : 0000003f83a7a9cc t4 :
0000000000000068
[  132.120371]  t5 : 0000000052d19905 t6 : 0000000000d19905
[  132.125686] status: 0000000200004020 badaddr: ffffffac2b2a2928
cause: 000000000000000d
[  132.145321] audit: type=1701 audit(1671220069.747:12):
auid=4294967295 uid=995 gid=994 ses=4294967295 pid=126
comm="sd-resolve" exe="/lib/systemd/systemd-timesyncd" sig=11 res=1
[  132.161689] systemd[1]: unhandled signal 11 code 0x1 at 0x0000006c6b6a6968
[  132.168714] CPU: 0 PID: 1 Comm: systemd Not tainted
6.1.0-11009-gf4e9a8cdc25b #167
[  132.176293] Hardware name: Renesas SMARC EVK based on r9a07g043f01 (DT)
[  132.182906] epc : 0000006c6b6a6968 ra : 0000003f838630b2 sp :
0000003fe5aace60
[  132.190125]  gp : 0000002ad234ad28 tp : 0000003f83628e70 t0 :
0000000000a9919e
[  132.197357]  t1 : 0000003f838595fc t2 : 0000000000000000 s0 :
0000003fe5aad050
[  132.204574]  s1 : 0000000000000000 a0 : 0000003fe5aace70 a1 :
0000003fe5aad058
[  132.211791]  a2 : 0000000000000080 a3 : 0000000000000010 a4 :
0000000000000001
[  132.219007]  a5 : 0000003f839a1784 a6 : 0000000000000000 a7 :
0000000000000000
[  132.226223]  s2 : 0000000000000011 s3 : 000000000000000b s4 :
0000000000000006
[  132.233439]  s5 : 0000000000000002 s6 : 0000003f83a85918 s7 :
0000000000001000
[  132.240655]  s8 : 0000003fe5aad750 s9 : 0000003fe5aad9e0 s10:
0000002ad22fdd60
[  132.247872]  s11: 2f2e2d2c2b2a2928 t3 : 6f6e6d6c6b6a6968 t4 :
0000000000000068
[  132.255088]  t5 : 0000000052d19905 t6 : 0000000000d19905
[  132.260403] status: 0000000200004020 badaddr: 0000006c6b6a6968
cause: 000000000000000c
[  132.269759] systemd[1]: unhandled signal 11 code 0x1 at 0x0000006c6b6a6968
[  132.276708] CPU: 0 PID: 1 Comm: systemd Not tainted
6.1.0-11009-gf4e9a8cdc25b #167
[  132.284283] Hardware name: Renesas SMARC EVK based on r9a07g043f01 (DT)
[  132.290895] epc : 0000006c6b6a6968 ra : 0000003f838630b2 sp :
0000003fe5aac750
[  132.298113]  gp : 0000002ad234ad28 tp : 0000003f83628e70 t0 :
0000000000a9919e
[  132.305363]  t1 : 0000003f838595fc t2 : 0000000000000000 s0 :
0000003fe5aac940
[  132.312580]  s1 : 0000000000000000 a0 : 0000003fe5aac760 a1 :
0000003fe5aac948
[  132.319796]  a2 : 0000000000000080 a3 : 0000000000000010 a4 :
0000000000000001
[  132.327013]  a5 : 0000003f839a1784 a6 : 0000000000000000 a7 :
0000000000000000
[  132.334229]  s2 : 0000000000000011 s3 : 000000000000000b s4 :
0000000000000006
[  132.341444]  s5 : 0000000000000002 s6 : 0000003f83a85918 s7 :
0000000000001000
[  132.348660]  s8 : 0000003fe5aad750 s9 : 0000003fe5aad9e0 s10:
0000002ad22fdd60
[  132.355877]  s11: 2f2e2d2c2b2a2928 t3 : 6f6e6d6c6b6a6968 t4 :
0000000000000068
[  132.363093]  t5 : 0000000052d19905 t6 : 0000000000d19905
[  132.368408] status: 0000000200004020 badaddr: 0000006c6b6a6968
cause: 000000000000000c
[  132.377123] systemd[1]: unhandled signal 11 code 0x1 at 0x0000006c6b6a6968
[  132.384078] CPU: 0 PID: 1 Comm: systemd Not tainted
6.1.0-11009-gf4e9a8cdc25b #167
[  132.391652] Hardware name: Renesas SMARC EVK based on r9a07g043f01 (DT)
[  132.398262] epc : 0000006c6b6a6968 ra : 0000003f838630b2 sp :
0000003fe5aac040
[  132.405479]  gp : 0000002ad234ad28 tp : 0000003f83628e70 t0 :
0000000000a9919e
[  132.412745]  t1 : 0000003f838595fc t2 : 0000000000000000 s0 :
0000003fe5aac230
[  132.419967]  s1 : 0000000000000000 a0 : 0000003fe5aac050 a1 :
0000003fe5aac238
[  132.427184]  a2 : 0000000000000080 a3 : 0000000000000010 a4 :
0000000000000001
[  132.434401]  a5 : 0000003f839a1784 a6 : 0000000000000000 a7 :
0000000000000000
[  132.441618]  s2 : 0000000000000011 s3 : 000000000000000b s4 :
0000000000000006
[  132.448833]  s5 : 0000000000000002 s6 : 0000003f83a85918 s7 :
0000000000001000
[  132.456049]  s8 : 0000003fe5aad750 s9 : 0000003fe5aad9e0 s10:
0000002ad22fdd60
[  132.463265]  s11: 2f2e2d2c2b2a2928 t3 : 6f6e6d6c6b6a6968 t4 :
0000000000000068
[  132.470480]  t5 : 0000000052d19905 t6 : 0000000000d19905
[  132.475804] status: 0000000200004020 badaddr: 0000006c6b6a6968
cause: 000000000000000c
[  132.496855] systemd[1]: unhandled signal 11 code 0x1 at 0x0000006c6b6a6968
[  132.503842] CPU: 0 PID: 1 Comm: systemd Not tainted
6.1.0-11009-gf4e9a8cdc25b #167
[  132.511415] Hardware name: Renesas SMARC EVK based on r9a07g043f01 (DT)
[  132.518027] epc : 0000006c6b6a6968 ra : 0000003f838630b2 sp :
0000003fe5aab930
[  132.525244]  gp : 0000002ad234ad28 tp : 0000003f83628e70 t0 :
0000000000a9919e
[  132.532462]  t1 : 0000003f838595fc t2 : 0000000000000000 s0 :
0000003fe5aabb20
[  132.539678]  s1 : 0000000000000000 a0 : 0000003fe5aab940 a1 :
0000003fe5aabb28
[  132.546939]  a2 : 0000000000000080 a3 : 0000000000000010 a4 :
0000000000000001
[  132.554161]  a5 : 0000003f839a1784 a6 : 0000000000000000 a7 :
0000000000000000
[  132.561378]  s2 : 0000000000000011 s3 : 000000000000000b s4 :
0000000000000006
[  132.568595]  s5 : 0000000000000002 s6 : 0000003f83a85918 s7 :
0000000000001000
[  132.575812]  s8 : 0000003fe5aad750 s9 : 0000003fe5aad9e0 s10:
0000002ad22fdd60
[  132.583029]  s11: 2f2e2d2c2b2a2928 t3 : 6f6e6d6c6b6a6968 t4 :
0000000000000068
[  132.590246]  t5 : 0000000052d19905 t6 : 0000000000d19905
[  132.595561] status: 0000000200004020 badaddr: 0000006c6b6a6968
cause: 000000000000000c
[  132.604448] systemd[1]: unhandled signal 11 code 0x1 at 0x0000006c6b6a6968
[  132.611424] CPU: 0 PID: 1 Comm: systemd Not tainted
6.1.0-11009-gf4e9a8cdc25b #167
[  132.618987] Hardware name: Renesas SMARC EVK based on r9a07g043f01 (DT)
[  132.625606] epc : 0000006c6b6a6968 ra : 0000003f838630b2 sp :
0000003fe5aab220
[  132.632818]  gp : 0000002ad234ad28 tp : 0000003f83628e70 t0 :
0000000000a9919e
[  132.640035]  t1 : 0000003f838595fc t2 : 0000000000000000 s0 :
0000003fe5aab410
[  132.647252]  s1 : 0000000000000000 a0 : 0000003fe5aab230 a1 :
0000003fe5aab418
[  132.654467]  a2 : 0000000000000080 a3 : 0000000000000010 a4 :
0000000000000001
[  132.661682]  a5 : 0000003f839a1784 a6 : 0000000000000000 a7 :
0000000000000000
[  132.668898]  s2 : 0000000000000011 s3 : 000000000000000b s4 :
0000000000000006
[  132.676113]  s5 : 0000000000000002 s6 : 0000003f83a85918 s7 :
0000000000001000
[  132.683329]  s8 : 0000003fe5aad750 s9 : 0000003fe5aad9e0 s10:
0000002ad22fdd60
[  132.690556]  s11: 2f2e2d2c2b2a2928 t3 : 6f6e6d6c6b6a6968 t4 :
0000000000000068
[  132.697773]  t5 : 0000000052d19905 t6 : 0000000000d19905
[  132.703086] status: 0000000200004020 badaddr: 0000006c6b6a6968
cause: 000000000000000c
[  132.993558] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b
[  133.001210] CPU: 0 PID: 1 Comm: systemd Not tainted
6.1.0-11009-gf4e9a8cdc25b #167
[  133.008752] Hardware name: Renesas SMARC EVK based on r9a07g043f01 (DT)
[  133.015338] Call Trace:
[  133.017778] [<ffffffff800055cc>] dump_backtrace+0x1c/0x24
[  133.023174] [<ffffffff80776836>] show_stack+0x2c/0x38
[  133.028214] [<ffffffff80780244>] dump_stack_lvl+0x3c/0x54
[  133.033597] [<ffffffff80780270>] dump_stack+0x14/0x1c
[  133.038633] [<ffffffff80776c00>] panic+0x102/0x29a
[  133.043409] [<ffffffff800137ba>] do_exit+0x704/0x70a
[  133.048362] [<ffffffff8001390e>] do_group_exit+0x24/0x70
[  133.053659] [<ffffffff8001de54>] get_signal+0x68a/0x6dc
[  133.058874] [<ffffffff8000494e>] do_work_pending+0xd6/0x44e
[  133.064427] [<ffffffff800036c2>] resume_userspace_slow+0x8/0xa
[  133.070249] ---[ end Kernel panic - not syncing: Attempted to kill
init! exitcode=0x0000000b ]---

If I revert this patch [0] bonnie++ works as expected.

Any pointers on what could be the issue here?

[0] https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/commit/?h=for-next&id=4bd1d80efb5af640f99157f39b50fb11326ce641

Cheers,
Prabhakar

> diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
> index cedcf8ea3c76..86670a1b4ffd 100644
> --- a/arch/riscv/include/asm/mmu.h
> +++ b/arch/riscv/include/asm/mmu.h
> @@ -20,6 +20,8 @@ typedef struct {
>  #ifdef CONFIG_SMP
>         /* A local icache flush is needed before user execution can resume. */
>         cpumask_t icache_stale_mask;
> +       /* A local tlb flush is needed before user execution can resume. */
> +       cpumask_t tlb_stale_mask;
>  #endif
>  } mm_context_t;
>
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 7ec936910a96..330f75fe1278 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -415,7 +415,7 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
>          * Relying on flush_tlb_fix_spurious_fault would suffice, but
>          * the extra traps reduce performance.  So, eagerly SFENCE.VMA.
>          */
> -       local_flush_tlb_page(address);
> +       flush_tlb_page(vma, address);
>  }
>
>  static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
> diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
> index 801019381dea..907b9efd39a8 100644
> --- a/arch/riscv/include/asm/tlbflush.h
> +++ b/arch/riscv/include/asm/tlbflush.h
> @@ -22,6 +22,24 @@ static inline void local_flush_tlb_page(unsigned long addr)
>  {
>         ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
>  }
> +
> +static inline void local_flush_tlb_all_asid(unsigned long asid)
> +{
> +       __asm__ __volatile__ ("sfence.vma x0, %0"
> +                       :
> +                       : "r" (asid)
> +                       : "memory");
> +}
> +
> +static inline void local_flush_tlb_page_asid(unsigned long addr,
> +               unsigned long asid)
> +{
> +       __asm__ __volatile__ ("sfence.vma %0, %1"
> +                       :
> +                       : "r" (addr), "r" (asid)
> +                       : "memory");
> +}
> +
>  #else /* CONFIG_MMU */
>  #define local_flush_tlb_all()                  do { } while (0)
>  #define local_flush_tlb_page(addr)             do { } while (0)
> diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> index 7acbfbd14557..80ce9caba8d2 100644
> --- a/arch/riscv/mm/context.c
> +++ b/arch/riscv/mm/context.c
> @@ -196,6 +196,16 @@ static void set_mm_asid(struct mm_struct *mm, unsigned int cpu)
>
>         if (need_flush_tlb)
>                 local_flush_tlb_all();
> +#ifdef CONFIG_SMP
> +       else {
> +               cpumask_t *mask = &mm->context.tlb_stale_mask;
> +
> +               if (cpumask_test_cpu(cpu, mask)) {
> +                       cpumask_clear_cpu(cpu, mask);
> +                       local_flush_tlb_all_asid(cntx & asid_mask);
> +               }
> +       }
> +#endif
>  }
>
>  static void set_mm_noasid(struct mm_struct *mm)
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index 37ed760d007c..ce7dfc81bb3f 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -5,23 +5,7 @@
>  #include <linux/sched.h>
>  #include <asm/sbi.h>
>  #include <asm/mmu_context.h>
> -
> -static inline void local_flush_tlb_all_asid(unsigned long asid)
> -{
> -       __asm__ __volatile__ ("sfence.vma x0, %0"
> -                       :
> -                       : "r" (asid)
> -                       : "memory");
> -}
> -
> -static inline void local_flush_tlb_page_asid(unsigned long addr,
> -               unsigned long asid)
> -{
> -       __asm__ __volatile__ ("sfence.vma %0, %1"
> -                       :
> -                       : "r" (addr), "r" (asid)
> -                       : "memory");
> -}
> +#include <asm/tlbflush.h>
>
>  void flush_tlb_all(void)
>  {
> @@ -31,6 +15,7 @@ void flush_tlb_all(void)
>  static void __sbi_tlb_flush_range(struct mm_struct *mm, unsigned long start,
>                                   unsigned long size, unsigned long stride)
>  {
> +       struct cpumask *pmask = &mm->context.tlb_stale_mask;
>         struct cpumask *cmask = mm_cpumask(mm);
>         unsigned int cpuid;
>         bool broadcast;
> @@ -44,6 +29,15 @@ static void __sbi_tlb_flush_range(struct mm_struct *mm, unsigned long start,
>         if (static_branch_unlikely(&use_asid_allocator)) {
>                 unsigned long asid = atomic_long_read(&mm->context.id);
>
> +               /*
> +                * TLB will be immediately flushed on harts concurrently
> +                * executing this MM context. TLB flush on other harts
> +                * is deferred until this MM context migrates there.
> +                */
> +               cpumask_setall(pmask);
> +               cpumask_clear_cpu(cpuid, pmask);
> +               cpumask_andnot(pmask, pmask, cmask);
> +
>                 if (broadcast) {
>                         sbi_remote_sfence_vma_asid(cmask, start, size, asid);
>                 } else if (size <= stride) {
> --
> 2.37.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
