Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8945A57139F
	for <lists+linux-arch@lfdr.de>; Tue, 12 Jul 2022 09:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbiGLH4T (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Jul 2022 03:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbiGLH4O (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Jul 2022 03:56:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686289D502;
        Tue, 12 Jul 2022 00:56:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17CD5B81614;
        Tue, 12 Jul 2022 07:56:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D570C341C0;
        Tue, 12 Jul 2022 07:56:05 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
        Huacai Chen <chenhuacai@loongson.cn>, stable@vger.kernel.org
Subject: [PATCH 6/6] UM: cpuinfo: Fix a warning for CONFIG_CPUMASK_OFFSTACK
Date:   Tue, 12 Jul 2022 15:52:55 +0800
Message-Id: <20220712075255.1345991-6-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220712075255.1345991-1-chenhuacai@loongson.cn>
References: <20220712075255.1345991-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When CONFIG_CPUMASK_OFFSTACK and CONFIG_DEBUG_PER_CPU_MAPS is selected,
cpu_max_bits_warn() generates a runtime warning similar as below while
we show /proc/cpuinfo. Fix this by using nr_cpu_ids (the runtime limit)
instead of NR_CPUS to iterate CPUs.

[    3.052463] ------------[ cut here ]------------
[    3.059679] WARNING: CPU: 3 PID: 1 at include/linux/cpumask.h:108 show_cpuinfo+0x5e8/0x5f0
[    3.070072] Modules linked in: efivarfs autofs4
[    3.076257] CPU: 0 PID: 1 Comm: systemd Not tainted 5.19-rc5+ #1052
[    3.099465] Stack : 9000000100157b08 9000000000f18530 9000000000cf846c 9000000100154000
[    3.109127]         9000000100157a50 0000000000000000 9000000100157a58 9000000000ef7430
[    3.118774]         90000001001578e8 0000000000000040 0000000000000020 ffffffffffffffff
[    3.128412]         0000000000aaaaaa 1ab25f00eec96a37 900000010021de80 900000000101c890
[    3.138056]         0000000000000000 0000000000000000 0000000000000000 0000000000aaaaaa
[    3.147711]         ffff8000339dc220 0000000000000001 0000000006ab4000 0000000000000000
[    3.157364]         900000000101c998 0000000000000004 9000000000ef7430 0000000000000000
[    3.167012]         0000000000000009 000000000000006c 0000000000000000 0000000000000000
[    3.176641]         9000000000d3de08 9000000001639390 90000000002086d8 00007ffff0080286
[    3.186260]         00000000000000b0 0000000000000004 0000000000000000 0000000000071c1c
[    3.195868]         ...
[    3.199917] Call Trace:
[    3.203941] [<90000000002086d8>] show_stack+0x38/0x14c
[    3.210666] [<9000000000cf846c>] dump_stack_lvl+0x60/0x88
[    3.217625] [<900000000023d268>] __warn+0xd0/0x100
[    3.223958] [<9000000000cf3c90>] warn_slowpath_fmt+0x7c/0xcc
[    3.231150] [<9000000000210220>] show_cpuinfo+0x5e8/0x5f0
[    3.238080] [<90000000004f578c>] seq_read_iter+0x354/0x4b4
[    3.245098] [<90000000004c2e90>] new_sync_read+0x17c/0x1c4
[    3.252114] [<90000000004c5174>] vfs_read+0x138/0x1d0
[    3.258694] [<90000000004c55f8>] ksys_read+0x70/0x100
[    3.265265] [<9000000000cfde9c>] do_syscall+0x7c/0x94
[    3.271820] [<9000000000202fe4>] handle_syscall+0xc4/0x160
[    3.281824] ---[ end trace 8b484262b4b8c24c ]---

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/um/kernel/um_arch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index a149a5e9a16a..03177c9907d5 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -93,7 +93,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 
 static void *c_start(struct seq_file *m, loff_t *pos)
 {
-	return *pos < NR_CPUS ? cpu_data + *pos : NULL;
+	return *pos < nr_cpu_ids ? cpu_data + *pos : NULL;
 }
 
 static void *c_next(struct seq_file *m, void *v, loff_t *pos)
-- 
2.31.1

