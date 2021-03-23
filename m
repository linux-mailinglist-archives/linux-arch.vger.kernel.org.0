Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD3234557F
	for <lists+linux-arch@lfdr.de>; Tue, 23 Mar 2021 03:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhCWCeW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Mar 2021 22:34:22 -0400
Received: from mail.loongson.cn ([114.242.206.163]:49600 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229467AbhCWCeV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Mar 2021 22:34:21 -0400
Received: from localhost.localdomain (unknown [182.149.161.110])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxqa6aU1lgrXQFAA--.1011S2;
        Tue, 23 Mar 2021 10:34:10 +0800 (CST)
From:   Huang Pei <huangpei@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        ambrosehua@gmail.com
Cc:     Bibo Mao <maobibo@loongson.cn>, linux-mips@vger.kernel.org,
        linux-arch@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Burton <paulburton@kernel.org>,
        Li Xuefeng <lixuefeng@loongson.cn>,
        Yang Tiezhu <yangtiezhu@loongson.cn>,
        Gao Juxin <gaojuxin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>
Subject: [PATCH] MIPS: fix local_irq_{disable,enable} in asmmacro.h
Date:   Tue, 23 Mar 2021 10:34:02 +0800
Message-Id: <20210323023402.9657-1-huangpei@loongson.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: AQAAf9Dxqa6aU1lgrXQFAA--.1011S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZr1kur4DtFWkXFyUCFy8Krg_yoWDXwc_Aw
        1IqwsrWr4fXFZ3W347tw4fuayqga18X393uF4FkrnIyr13Ka1UJa1kZ3sxXw15CFZ0yr4r
        uay5trWUCwnFkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb3xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
        1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
        8cxan2IY04v7MxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1l
        IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
        C2KfnxnUUI43ZEXa7VU1sYFtUUUUU==
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

commit ba9196d2e005 ("MIPS: Make DIEI support as a config option")
use CPU_HAS_DIEI to indicate whether di/ei is implemented correctly,
without this patch, "local_irq_disable" from entry.S in 3A1000
(with buggy di/ei) lose protection of commit e97c5b609880 ("MIPS:
Make irqflags.h functions preempt-safe")

Fixes: ba9196d2e005 ("MIPS: Make DIEI support as a config option")
Signed-off-by: Huang Pei <huangpei@loongson.cn>
---
 arch/mips/include/asm/asmmacro.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
index 86f2323ebe6b..ca83ada7015f 100644
--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -44,8 +44,7 @@
 	.endm
 #endif
 
-#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR5) || \
-    defined(CONFIG_CPU_MIPSR6)
+#ifdef CONFIG_CPU_HAS_DIEI
 	.macro	local_irq_enable reg=t0
 	ei
 	irq_enable_hazard
-- 
2.17.1

