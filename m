Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6405F332028
	for <lists+linux-arch@lfdr.de>; Tue,  9 Mar 2021 09:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhCIICh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Mar 2021 03:02:37 -0500
Received: from mail.loongson.cn ([114.242.206.163]:60974 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229555AbhCIIC2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 9 Mar 2021 03:02:28 -0500
Received: from localhost.localdomain (unknown [222.209.9.50])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxTeyEK0dgyU0XAA--.7938S3;
        Tue, 09 Mar 2021 16:02:19 +0800 (CST)
From:   Huang Pei <huangpei@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        ambrosehua@gmail.com
Cc:     Bibo Mao <maobibo@loongson.cn>, linux-mips@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Burton <paulburton@kernel.org>,
        Li Xuefeng <lixuefeng@loongson.cn>,
        Yang Tiezhu <yangtiezhu@loongson.cn>,
        Gao Juxin <gaojuxin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>
Subject: [PATCH 1/2] MIPS: clean up CONFIG_MIPS_PGD_C0_CONTEXT handling
Date:   Tue,  9 Mar 2021 16:02:09 +0800
Message-Id: <20210309080210.25561-2-huangpei@loongson.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210309080210.25561-1-huangpei@loongson.cn>
References: <20210309080210.25561-1-huangpei@loongson.cn>
X-CM-TRANSID: AQAAf9BxTeyEK0dgyU0XAA--.7938S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJrW5Gw4xGF1rurW3Aw48Crg_yoW8KF13p3
        92v3WkGr4xur98ur98ZFWkWrs5tayDAa90vF1DKas09FWqqFnYvw4fJwsIyF1DGFZ7Ja1x
        WrZ0qry5JrnF9w7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPG14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
        xKxwCY02Avz4vE14v_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l
        x2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14
        v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IY
        x2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87
        Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIF
        yTuYvjfUjVbyDUUUU
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

+. LOONGSON64 use 0x98xx_xxxx_xxxx_xxxx as xphys cached

+. let CONFIG_MIPS_PGD_C0_CONTEXT depend on 64bit

+. cast CAC_BASE into u64 to silence warning on MIPS32

CP0 Context has enough room for wraping pgd into its 41-bit PTEBase field.

+. For XPHYS, the trick is that pgd is 4kB aligned, and the PABITS <= 48,
only save 48 - 12 + 5(for bit[63:59]) = 41 bits, aka. :

   bit[63:59] | 0000 0000 000 |  bit[47:12] | 0000 0000 0000

+. for CKSEG0, only save 29 - 12 = 17 bits

Signed-off-by: Huang Pei <huangpei@loongson.cn>
---
 arch/mips/Kconfig    |  3 ++-
 arch/mips/mm/tlbex.c | 10 +++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2000bb2b0220..5741dae35b74 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2142,7 +2142,8 @@ config CPU_SUPPORTS_HUGEPAGES
 	depends on !(32BIT && (ARCH_PHYS_ADDR_T_64BIT || EVA))
 config MIPS_PGD_C0_CONTEXT
 	bool
-	default y if 64BIT && (CPU_MIPSR2 || CPU_MIPSR6) && !CPU_XLP
+	depends on 64BIT
+	default y if (CPU_MIPSR2 || CPU_MIPSR6) && !CPU_XLP
 
 #
 # Set to y for ptrace access to watch registers.
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index a7521b8f7658..591cfa0fca02 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -848,8 +848,8 @@ void build_get_pmde64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 		/* Clear lower 23 bits of context. */
 		uasm_i_dins(p, ptr, 0, 0, 23);
 
-		/* 1 0	1 0 1  << 6  xkphys cached */
-		uasm_i_ori(p, ptr, ptr, 0x540);
+		/* insert bit[63:59] of CAC_BASE into bit[11:6] of ptr */
+		uasm_i_ori(p, ptr, ptr, ((u64)(CAC_BASE) >> 53));
 		uasm_i_drotr(p, ptr, ptr, 11);
 #elif defined(CONFIG_SMP)
 		UASM_i_CPUID_MFC0(p, ptr, SMP_CPUID_REG);
@@ -1164,8 +1164,9 @@ build_fast_tlb_refill_handler (u32 **p, struct uasm_label **l,
 
 	if (pgd_reg == -1) {
 		vmalloc_branch_delay_filled = 1;
-		/* 1 0	1 0 1  << 6  xkphys cached */
-		uasm_i_ori(p, ptr, ptr, 0x540);
+		/* insert bit[63:59] of CAC_BASE into bit[11:6] of ptr */
+		uasm_i_ori(p, ptr, ptr, ((u64)(CAC_BASE) >> 53));
+
 		uasm_i_drotr(p, ptr, ptr, 11);
 	}
 
@@ -1292,7 +1293,6 @@ build_fast_tlb_refill_handler (u32 **p, struct uasm_label **l,
 
 	return rv;
 }
-
 /*
  * For a 64-bit kernel, we are using the 64-bit XTLB refill exception
  * because EXL == 0.  If we wrap, we can also use the 32 instruction
-- 
2.17.1

