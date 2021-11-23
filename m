Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0BA7459D15
	for <lists+linux-arch@lfdr.de>; Tue, 23 Nov 2021 08:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbhKWHxc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Nov 2021 02:53:32 -0500
Received: from mail.loongson.cn ([114.242.206.163]:52120 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234407AbhKWHxa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 23 Nov 2021 02:53:30 -0500
Received: from localhost.localdomain (unknown [111.9.175.10])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxF+genZxh3IgAAA--.1089S6;
        Tue, 23 Nov 2021 15:50:14 +0800 (CST)
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
Subject: [PATCH 4/6] MIPS: tx39: fix tx39_flush_cache_page
Date:   Tue, 23 Nov 2021 15:49:25 +0800
Message-Id: <20211123074927.12461-5-huangpei@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211123074927.12461-1-huangpei@loongson.cn>
References: <20211123074927.12461-1-huangpei@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9AxF+genZxh3IgAAA--.1089S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4kuFWUZr15CF4xWFy8Xwb_yoW8Gw1xp3
        y2kan8J3y0g3WruFyfAw4qyr1Sg3srKFWIva17K34Y934YqF1UKrn3Krn0gF15ArZYyay7
        uFWjyF15Zw4qv3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl
        6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x
        IIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_
        Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8c
        xan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
        rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
        CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
        67AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1I6r4UMIIF0xvEx4A2jsIE14v26r
        1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQ
        SdkUUUUU=
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Indexed cache operation need KSEG0 address for safety and assume
that no dcache alias nor high memory, since indexed cache instrcution
CAN NOT handle cache alias

Signed-off-by: Huang Pei <huangpei@loongson.cn>
---
 arch/mips/mm/c-tx39.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/mips/mm/c-tx39.c b/arch/mips/mm/c-tx39.c
index 03dfbb40ec73..c7c3dbfe7756 100644
--- a/arch/mips/mm/c-tx39.c
+++ b/arch/mips/mm/c-tx39.c
@@ -170,6 +170,7 @@ static void tx39_flush_cache_page(struct vm_area_struct *vma, unsigned long page
 	struct mm_struct *mm = vma->vm_mm;
 	pmd_t *pmdp;
 	pte_t *ptep;
+	unsigned long vaddr = phys_to_virt(pfn_to_phys(pfn));
 
 	/*
 	 * If ownes no valid ASID yet, cannot possibly have gotten
@@ -207,11 +208,14 @@ static void tx39_flush_cache_page(struct vm_area_struct *vma, unsigned long page
 	/*
 	 * Do indexed flush, too much work to get the (possible) TLB refills
 	 * to work correctly.
+	 *
+	 * Assuming that tx39 family do not support high memory, nor has
+	 * dcache alias, vaddr can index dcache directly and correctly
 	 */
-	if (cpu_has_dc_aliases || exec)
-		tx39_blast_dcache_page_indexed(page);
-	if (exec)
-		tx39_blast_icache_page_indexed(page);
+	if (exec) {
+		tx39_blast_dcache_page_indexed(vaddr);
+		tx39_blast_icache_page_indexed(vaddr);
+	}
 }
 
 static void local_tx39_flush_data_cache_page(void * addr)
-- 
2.20.1

