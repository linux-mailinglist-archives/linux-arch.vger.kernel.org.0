Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4F155712D
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jun 2022 04:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237829AbiFWCvB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jun 2022 22:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiFWCu7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jun 2022 22:50:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EB13F32C
        for <linux-arch@vger.kernel.org>; Wed, 22 Jun 2022 19:50:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80A1961D42
        for <linux-arch@vger.kernel.org>; Thu, 23 Jun 2022 02:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B35C34114;
        Thu, 23 Jun 2022 02:50:55 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Fix sleeping in atomic context in setup_tlb_handler()
Date:   Thu, 23 Jun 2022 10:52:15 +0800
Message-Id: <20220623025215.1824726-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since setup_tlb_handler() is executed in atomic context, we should use
GFP_ATOMIC instead of GFP_KERNEL to alloc pages. Otherwise we will get
a "sleeping in atomic context" error:

[    0.013118] BUG: sleeping function called from invalid context at mm/page_alloc.c:5158
[    0.013126] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/1
[    0.013131] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.19-rc3+ #1008 1a223086d14d07967cc427f15d52139422271360
[    0.013136] Hardware name: Loongson Loongson-3A5000-7A1000-1w-V0.1-CRB/Loongson-LS3A5000-7A1000-1w-EVB-V1.21, BIOS Loongson-UDK2018-V2.0.04082-beta7 04/27
[    0.013140] Stack : 90000000015fc990 9000000100493c18 9000000000df3370 9000000100490000
[    0.013151]         9000000100493b50 0000000000000000 9000000100493b58 9000000001417ef0
[    0.013160]         900000000199e54e 0000000000000040 9000000100493c18 90000000015f7a98
[    0.013168]         ffffffffffffffff 6de72f8b42179d1e 9000000100403b80 90000000015f7890
[    0.013176]         0000000000000001 00000000fffff175 9000000000eb9860 9000000001530b4b
[    0.013184]         9000000000e99e60 0000000000000013 0000000006ecc000 0000000000000001
[    0.013193]         90000000015f7a98 9000000001417ef0 0000000000000004 0000000000000000
[    0.013201]         0000000000000cc0 0000000000000000 0000000000000001 90000000015fc990
[    0.013209]         9000000000217e74 9000000001603b6b 9000000000208640 0000000000000000
[    0.013217]         00000000000000b0 0000000000000004 0000000000000000 0000000000070000
[    0.013225]         ...
[    0.013229] Call Trace:
[    0.013230] [<9000000000208640>] show_stack+0x4c/0x14c
[    0.013240] [<9000000000df3370>] dump_stack_lvl+0x70/0xac
[    0.013246] [<9000000000270c8c>] ___might_sleep+0x104/0x124
[    0.013253] [<9000000000477e84>] __alloc_pages+0x240/0x464
[    0.013260] [<9000000000214214>] setup_tlb_handler+0x104/0x1e8
[    0.013265] [<9000000000214324>] tlb_init+0x2c/0x3c
[    0.013270] [<9000000000208b74>] per_cpu_trap_init+0xec/0x108
[    0.013275] [<9000000000202850>] cpu_probe+0x400/0x8a4
[    0.013279] [<900000000020d160>] start_secondary+0x5c/0x3d4

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/mm/tlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/mm/tlb.c b/arch/loongarch/mm/tlb.c
index e272f8ac57d1..6d050973241c 100644
--- a/arch/loongarch/mm/tlb.c
+++ b/arch/loongarch/mm/tlb.c
@@ -281,7 +281,7 @@ void setup_tlb_handler(int cpu)
 		if (pcpu_handlers[cpu])
 			return;
 
-		page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL, get_order(vec_sz));
+		page = alloc_pages_node(cpu_to_node(cpu), GFP_ATOMIC, get_order(vec_sz));
 		if (!page)
 			return;
 
-- 
2.27.0

