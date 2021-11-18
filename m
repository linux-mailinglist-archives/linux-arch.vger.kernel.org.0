Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3555E455817
	for <lists+linux-arch@lfdr.de>; Thu, 18 Nov 2021 10:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245189AbhKRJgu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Nov 2021 04:36:50 -0500
Received: from mail.loongson.cn ([114.242.206.163]:49540 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245185AbhKRJg2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 18 Nov 2021 04:36:28 -0500
Received: from localhost.localdomain (unknown [111.9.175.10])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Ax3uTZHZZhoBcAAA--.294S2;
        Thu, 18 Nov 2021 17:33:18 +0800 (CST)
From:   Huang Pei <huangpei@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        ambrosehua@gmail.com
Cc:     Bibo Mao <maobibo@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Burton <paulburton@kernel.org>,
        Li Xuefeng <lixuefeng@loongson.cn>,
        Yang Tiezhu <yangtiezhu@loongson.cn>,
        Gao Juxin <gaojuxin@loongson.cn>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] MIPS: simplify copy_user_high_page for MIPS64 w/o cache alias
Date:   Thu, 18 Nov 2021 17:33:10 +0800
Message-Id: <20211118093310.3195-1-huangpei@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Ax3uTZHZZhoBcAAA--.294S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF17tF47Xw1rWw4DAr1UJrb_yoW8ZF1rpF
        W7Gw43KrWFgrW7u3Z3Xwsrury3Jas2yay8XF47ta4Y9wnxWF1aqF1FqFWIqF1YqrWkGa15
        W3yqgay5WFn8u3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
        xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
        8cxan2IY04v7MxkIecxEwVAFwVW8uwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1l
        IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
        C2KfnxnUUI43ZEXa7VUbnNVDUUUUU==
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Borrow from ARM64

MIPS64 CPU has enough direct mapped memory space to access all
physical memory. In case of no cache alias, bypass both kmap_atomic
and kmap_coherent for better real-time performance.

Signed-off-by: Huang Pei <huangpei@loongson.cn>
---
 arch/mips/mm/init.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 325e1552cbea..54f8464fbb95 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -171,21 +171,34 @@ void copy_user_highpage(struct page *to, struct page *from,
 {
 	void *vfrom, *vto;
 
-	vto = kmap_atomic(to);
-	if (cpu_has_dc_aliases &&
-	    page_mapcount(from) && !Page_dcache_dirty(from)) {
-		vfrom = kmap_coherent(from, vaddr);
+	if (IS_ENABLED(CONFIG_64BIT) && !cpu_has_dc_aliases) {
+		vfrom = page_address(from);
+		vto   = page_address(to);
 		copy_page(vto, vfrom);
-		kunmap_coherent();
+		/*
+		 * even without cache alias, still need to maintain
+		 * coherence between icache and dcache
+		 */
+		if (!cpu_has_ic_fills_f_dc)
+			flush_data_cache_page((unsigned long)vto);
+
 	} else {
-		vfrom = kmap_atomic(from);
-		copy_page(vto, vfrom);
-		kunmap_atomic(vfrom);
+		vto = kmap_atomic(to);
+		if (cpu_has_dc_aliases &&
+		    page_mapcount(from) && !Page_dcache_dirty(from)) {
+			vfrom = kmap_coherent(from, vaddr);
+			copy_page(vto, vfrom);
+			kunmap_coherent();
+		} else {
+			vfrom = kmap_atomic(from);
+			copy_page(vto, vfrom);
+			kunmap_atomic(vfrom);
+		}
+		if ((!cpu_has_ic_fills_f_dc) ||
+		      pages_do_alias((unsigned long)vto, vaddr & PAGE_MASK))
+			flush_data_cache_page((unsigned long)vto);
+		kunmap_atomic(vto);
 	}
-	if ((!cpu_has_ic_fills_f_dc) ||
-	    pages_do_alias((unsigned long)vto, vaddr & PAGE_MASK))
-		flush_data_cache_page((unsigned long)vto);
-	kunmap_atomic(vto);
 	/* Make sure this page is cleared on other CPU's too before using it */
 	smp_wmb();
 }
-- 
2.20.1

