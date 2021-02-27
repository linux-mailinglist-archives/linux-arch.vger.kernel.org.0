Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E23326BF2
	for <lists+linux-arch@lfdr.de>; Sat, 27 Feb 2021 07:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhB0GVP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Feb 2021 01:21:15 -0500
Received: from mail.loongson.cn ([114.242.206.163]:50100 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229751AbhB0GVN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 27 Feb 2021 01:21:13 -0500
Received: from localhost.localdomain (unknown [182.149.162.140])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxTeyQ5DlgFIwQAA--.4572S3;
        Sat, 27 Feb 2021 14:20:13 +0800 (CST)
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
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH] MIPS: clean up CONFIG_MIPS_PGD_C0_CONTEXT handling
Date:   Sat, 27 Feb 2021 06:19:44 +0000
Message-Id: <20210227061944.266415-2-huangpei@loongson.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210227061944.266415-1-huangpei@loongson.cn>
References: <20210227061944.266415-1-huangpei@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9BxTeyQ5DlgFIwQAA--.4572S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrWrtw15KF4kWr4fArWfAFb_yoW5JFy5pa
        srJ3WDGr4Uur15ury5AFWkWF4rtayDAa98ZFsrK3sI9FWjqF109w1xGrs0yF1DCFZ7AF4x
        Wr4YgFyYyFnFkw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
        IY04v7MxkIecxEwVAFwVW8AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8
        JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1V
        AFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4
        A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU
        0xZFpf9x0JUjD73UUUUU=
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

CP0 Context has enough room for wraping pgd into its 41-bit PTEBase field.

+. For XPHYS, the trick is that pgd is 4kB aligned, and the PABITS <= 48,
only save 48 - 12 + 5(for bit[63:59]) = 41 bits, aka. :

   bit[63:59] | 0000 0000 000 |  bit[47:12] | 0000 0000 0000

+. for CKSEG0, only save 29 - 12 = 17 bits

+. use CAC_BASE for accessing bit[63:59] of pgd

+. let CONFIG_MIPS_PGD_C0_CONTEXT depend on 64bit, and protect
build_fast_mips_refill_handler from 32bit building

Signed-off-by: Huang Pei <huangpei@loongson.cn>
---
 arch/mips/Kconfig    |  1 +
 arch/mips/mm/tlbex.c | 11 ++++++-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2000bb2b0220..517509ad8596 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2142,6 +2142,7 @@ config CPU_SUPPORTS_HUGEPAGES
 	depends on !(32BIT && (ARCH_PHYS_ADDR_T_64BIT || EVA))
 config MIPS_PGD_C0_CONTEXT
 	bool
+	depends on 64BIT
 	default y if 64BIT && (CPU_MIPSR2 || CPU_MIPSR6) && !CPU_XLP
 
 #
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index a7521b8f7658..5bb9724578f7 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -848,8 +848,8 @@ void build_get_pmde64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 		/* Clear lower 23 bits of context. */
 		uasm_i_dins(p, ptr, 0, 0, 23);
 
-		/* 1 0	1 0 1  << 6  xkphys cached */
-		uasm_i_ori(p, ptr, ptr, 0x540);
+		/* insert bit[63:59] of CAC_BASE into bit[11:6] of ptr */
+		uasm_i_ori(p, ptr, ptr, (CAC_BASE >> 53));
 		uasm_i_drotr(p, ptr, ptr, 11);
 #elif defined(CONFIG_SMP)
 		UASM_i_CPUID_MFC0(p, ptr, SMP_CPUID_REG);
@@ -1106,6 +1106,7 @@ struct mips_huge_tlb_info {
 	bool need_reload_pte;
 };
 
+#ifdef CONFIG_64BIT
 static struct mips_huge_tlb_info
 build_fast_tlb_refill_handler (u32 **p, struct uasm_label **l,
 			       struct uasm_reloc **r, unsigned int tmp,
@@ -1164,8 +1165,8 @@ build_fast_tlb_refill_handler (u32 **p, struct uasm_label **l,
 
 	if (pgd_reg == -1) {
 		vmalloc_branch_delay_filled = 1;
-		/* 1 0	1 0 1  << 6  xkphys cached */
-		uasm_i_ori(p, ptr, ptr, 0x540);
+		/* insert bit[63:59] of CAC_BASE into bit[11:6] of ptr */
+		uasm_i_ori(p, ptr, ptr, (CAC_BASE >> 53));
 		uasm_i_drotr(p, ptr, ptr, 11);
 	}
 
@@ -1292,7 +1293,7 @@ build_fast_tlb_refill_handler (u32 **p, struct uasm_label **l,
 
 	return rv;
 }
-
+#endif
 /*
  * For a 64-bit kernel, we are using the 64-bit XTLB refill exception
  * because EXL == 0.  If we wrap, we can also use the 32 instruction
-- 
2.25.1

