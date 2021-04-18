Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827C43634D9
	for <lists+linux-arch@lfdr.de>; Sun, 18 Apr 2021 13:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhDRL3a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 18 Apr 2021 07:29:30 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:57065 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbhDRL3a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 18 Apr 2021 07:29:30 -0400
X-Originating-IP: 2.7.49.219
Received: from debian.home (lfbn-lyo-1-457-219.w2-7.abo.wanadoo.fr [2.7.49.219])
        (Authenticated sender: alex@ghiti.fr)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 782E0240002;
        Sun, 18 Apr 2021 11:28:57 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH] riscv: Remove 32b kernel mapping from page table dump
Date:   Sun, 18 Apr 2021 07:28:56 -0400
Message-Id: <20210418112856.15078-1-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 32b kernel mapping lies in the linear mapping, there is no point in
printing its address in page table dump, so remove this leftover that
comes from moving the kernel mapping outside the linear mapping for 64b
kernel.

Fixes: e9efb21fe352 ("riscv: Prepare ptdump for vm layout dynamic addresses")
Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/riscv/mm/ptdump.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
index 0aba4421115c..a4ed4bdbbfde 100644
--- a/arch/riscv/mm/ptdump.c
+++ b/arch/riscv/mm/ptdump.c
@@ -76,8 +76,8 @@ enum address_markers_idx {
 	PAGE_OFFSET_NR,
 #ifdef CONFIG_64BIT
 	MODULES_MAPPING_NR,
-#endif
 	KERNEL_MAPPING_NR,
+#endif
 	END_OF_SPACE_NR
 };
 
@@ -99,8 +99,8 @@ static struct addr_marker address_markers[] = {
 	{0, "Linear mapping"},
 #ifdef CONFIG_64BIT
 	{0, "Modules mapping"},
-#endif
 	{0, "Kernel mapping (kernel, BPF)"},
+#endif
 	{-1, NULL},
 };
 
@@ -379,8 +379,8 @@ static int ptdump_init(void)
 	address_markers[PAGE_OFFSET_NR].start_address = PAGE_OFFSET;
 #ifdef CONFIG_64BIT
 	address_markers[MODULES_MAPPING_NR].start_address = MODULES_VADDR;
-#endif
 	address_markers[KERNEL_MAPPING_NR].start_address = kernel_virt_addr;
+#endif
 
 	kernel_ptd_info.base_addr = KERN_VIRT_START;
 
-- 
2.20.1

