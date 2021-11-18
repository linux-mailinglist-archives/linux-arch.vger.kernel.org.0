Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F490455807
	for <lists+linux-arch@lfdr.de>; Thu, 18 Nov 2021 10:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243402AbhKRJdq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Nov 2021 04:33:46 -0500
Received: from mail.loongson.cn ([114.242.206.163]:48744 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243503AbhKRJdk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 18 Nov 2021 04:33:40 -0500
Received: from localhost.localdomain (unknown [111.9.175.10])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxbuQeHZZhYxcAAA--.269S3;
        Thu, 18 Nov 2021 17:30:16 +0800 (CST)
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
Subject: [PATCH 2/4] MIPS: fix tx39_flush_cache_page
Date:   Thu, 18 Nov 2021 17:30:03 +0800
Message-Id: <20211118093005.3121-2-huangpei@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211118093005.3121-1-huangpei@loongson.cn>
References: <20211118093005.3121-1-huangpei@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9AxbuQeHZZhYxcAAA--.269S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4kXF4kXr13WFyrGFW3KFg_yoW8Gr4xpa
        12ka1DJ3y0ga4FkFy7A34qyr1Sq3sxKFW0yay7K34Y934YqF1UKrn3Krn0gF15ArWSyay7
        urW2yry5Zw4qq3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
        8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
        jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
        kIwI1lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r4fMxAIw28IcxkI7VAKI48JMxC2
        0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
        0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
        14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20x
        vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
        JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUUPxhtUUUUU==
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Indexed cache operation need KSEG0 address for safety and assume
that no dcache alias nor high memory

Signed-off-by: Huang Pei <huangpei@loongson.cn>
---
 arch/mips/mm/c-tx39.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/c-tx39.c b/arch/mips/mm/c-tx39.c
index 03dfbb40ec73..49e4a16186ce 100644
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
 	if (cpu_has_dc_aliases || exec)
-		tx39_blast_dcache_page_indexed(page);
+		tx39_blast_dcache_page_indexed(vaddr);
 	if (exec)
-		tx39_blast_icache_page_indexed(page);
+		tx39_blast_icache_page_indexed(vaddr);
 }
 
 static void local_tx39_flush_data_cache_page(void * addr)
-- 
2.20.1

