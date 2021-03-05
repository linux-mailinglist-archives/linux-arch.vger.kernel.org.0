Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B7732E5A5
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 11:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbhCEKDy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 05:03:54 -0500
Received: from mail.loongson.cn ([114.242.206.163]:44674 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229940AbhCEKDo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Mar 2021 05:03:44 -0500
Received: from localhost.localdomain (unknown [182.149.161.105])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxTeztAUJgzcoUAA--.6567S4;
        Fri, 05 Mar 2021 18:03:34 +0800 (CST)
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
        Huacai Chen <chenhuacai@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>
Subject: [PATCH 2/3] MIPS: clean up CONFIG_MIPS_PGD_C0_CONTEXT handling
Date:   Fri,  5 Mar 2021 18:03:09 +0800
Message-Id: <20210305100310.26627-3-huangpei@loongson.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210305100310.26627-1-huangpei@loongson.cn>
References: <20210305100310.26627-1-huangpei@loongson.cn>
X-CM-TRANSID: AQAAf9BxTeztAUJgzcoUAA--.6567S4
X-Coremail-Antispam: 1UD129KBjvJXoWxCF4ktw4DJFW3KFW8KFyxAFb_yoW5Gw1Up3
        s7Z3WkGr4xur15uryYvFWkWr4rtasFya98ZF47Kr9I9FWjqrnY9w1xJrsIyF1DCF97Wa1x
        Wr4jgrW5Jrn29w7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPG14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
        xKxwCY02Avz4vE14v_Gw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l
        x2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14
        v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IY
        x2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87
        Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIF
        yTuYvjfUOdgAUUUUU
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

+. LOONGSON64 use 0x98xx_xxxx_xxxx_xxxx as xphys cached

+. let CONFIG_MIPS_PGD_C0_CONTEXT depend on 64bit

CP0 Context has enough room for wraping pgd into its 41-bit PTEBase field.

+. For XPHYS, the trick is that pgd is 4kB aligned, and the PABITS <= 48,
only save 48 - 12 + 5(for bit[63:59]) = 41 bits, aka. :

   bit[63:59] | 0000 0000 000 |  bit[47:12] | 0000 0000 0000

+. for CKSEG0, only save 29 - 12 = 17 bits

Signed-off-by: Huang Pei <huangpei@loongson.cn>
---
 arch/mips/Kconfig    |  3 ++-
 arch/mips/mm/tlbex.c | 18 +++++++++++++++---
 2 files changed, 17 insertions(+), 4 deletions(-)

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
index a7521b8f7658..7d89e016076e 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -848,8 +848,14 @@ void build_get_pmde64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 		/* Clear lower 23 bits of context. */
 		uasm_i_dins(p, ptr, 0, 0, 23);
 
-		/* 1 0	1 0 1  << 6  xkphys cached */
+		/* insert bit[63:59] of CAC_BASE into bit[11:6] of ptr */
+#ifdef CONFIG_CPU_LOONGSON64
+		/* 0x98xx xxxx xxxx xxxx, bit[63:59]: 1 0 0 1 1 << 6, xphys cached */
+		uasm_i_ori(p, ptr, ptr, 0x4c0);
+#else
+		/* 0xa8xx xxxx xxxx xxxx, bit[63:59]: 1 0 1 0 1 << 6, xphys cached */
 		uasm_i_ori(p, ptr, ptr, 0x540);
+#endif
 		uasm_i_drotr(p, ptr, ptr, 11);
 #elif defined(CONFIG_SMP)
 		UASM_i_CPUID_MFC0(p, ptr, SMP_CPUID_REG);
@@ -1164,8 +1170,15 @@ build_fast_tlb_refill_handler (u32 **p, struct uasm_label **l,
 
 	if (pgd_reg == -1) {
 		vmalloc_branch_delay_filled = 1;
-		/* 1 0	1 0 1  << 6  xkphys cached */
+		/* insert bit[63:59] of CAC_BASE into bit[11:6] of ptr */
+#ifdef CONFIG_CPU_LOONGSON64
+		/* 0x98xx xxxx xxxx xxxx, bit[63:59]: 1 0 0 1 1 << 6, xphys cached */
+		uasm_i_ori(p, ptr, ptr, 0x4c0);
+#else
+		/* 0xa8xx xxxx xxxx xxxx, bit[63:59]: 1 0 1 0 1 << 6, xphys cached */
 		uasm_i_ori(p, ptr, ptr, 0x540);
+#endif
+
 		uasm_i_drotr(p, ptr, ptr, 11);
 	}
 
@@ -1292,7 +1305,6 @@ build_fast_tlb_refill_handler (u32 **p, struct uasm_label **l,
 
 	return rv;
 }
-
 /*
  * For a 64-bit kernel, we are using the 64-bit XTLB refill exception
  * because EXL == 0.  If we wrap, we can also use the 32 instruction
-- 
2.17.1

