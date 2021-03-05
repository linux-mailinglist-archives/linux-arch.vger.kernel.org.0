Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCB632E5A3
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 11:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhCEKDy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 05:03:54 -0500
Received: from mail.loongson.cn ([114.242.206.163]:44666 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229711AbhCEKDo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Mar 2021 05:03:44 -0500
Received: from localhost.localdomain (unknown [182.149.161.105])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxTeztAUJgzcoUAA--.6567S3;
        Fri, 05 Mar 2021 18:03:32 +0800 (CST)
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
Subject: [PATCH 1/3] MIPS: sync arrangement of pt_regs with user_pt_regs and regoffset_table
Date:   Fri,  5 Mar 2021 18:03:08 +0800
Message-Id: <20210305100310.26627-2-huangpei@loongson.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210305100310.26627-1-huangpei@loongson.cn>
References: <20210305100310.26627-1-huangpei@loongson.cn>
X-CM-TRANSID: AQAAf9BxTeztAUJgzcoUAA--.6567S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAF45ur4kKFWkGF43WFy5XFb_yoW5Ww47pF
        n8Ca1qga1Uuryjg345ZFyDWr98trnrJ3y2kanIyrWaqa4jv3Wagw4Iyr98Jr4jqrykt3WI
        gFySgrn8Ar4ayw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
        v7MxkIecxEwVAFwVW8twCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC2
        0s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI
        0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv2
        0xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2js
        IE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZF
        pf9x0JU4OJ5UUUUU=
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Signed-off-by: Huang Pei <huangpei@loongson.cn>
---
 arch/mips/include/asm/ptrace.h | 10 +++++-----
 arch/mips/kernel/asm-offsets.c |  6 +++---
 arch/mips/kernel/ptrace.c      | 10 +++++-----
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
index 1e76774b36dd..e51691f2b7af 100644
--- a/arch/mips/include/asm/ptrace.h
+++ b/arch/mips/include/asm/ptrace.h
@@ -34,16 +34,16 @@ struct pt_regs {
 	/* Saved main processor registers. */
 	unsigned long regs[32];
 
+	unsigned long lo;
+	unsigned long hi;
 	/* Saved special registers. */
+	unsigned long cp0_epc;
+	unsigned long cp0_badvaddr;
 	unsigned long cp0_status;
-	unsigned long hi;
-	unsigned long lo;
+	unsigned long cp0_cause;
 #ifdef CONFIG_CPU_HAS_SMARTMIPS
 	unsigned long acx;
 #endif
-	unsigned long cp0_badvaddr;
-	unsigned long cp0_cause;
-	unsigned long cp0_epc;
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
 	unsigned long long mpl[6];        /* MTM{0-5} */
 	unsigned long long mtp[6];        /* MTP{0-5} */
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index aebfda81120a..8a9ab78bcc63 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -60,13 +60,13 @@ void output_ptreg_defines(void)
 	OFFSET(PT_R31, pt_regs, regs[31]);
 	OFFSET(PT_LO, pt_regs, lo);
 	OFFSET(PT_HI, pt_regs, hi);
-#ifdef CONFIG_CPU_HAS_SMARTMIPS
-	OFFSET(PT_ACX, pt_regs, acx);
-#endif
 	OFFSET(PT_EPC, pt_regs, cp0_epc);
 	OFFSET(PT_BVADDR, pt_regs, cp0_badvaddr);
 	OFFSET(PT_STATUS, pt_regs, cp0_status);
 	OFFSET(PT_CAUSE, pt_regs, cp0_cause);
+#ifdef CONFIG_CPU_HAS_SMARTMIPS
+	OFFSET(PT_ACX, pt_regs, acx);
+#endif
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
 	OFFSET(PT_MPL, pt_regs, mpl);
 	OFFSET(PT_MTP, pt_regs, mtp);
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index db7c5be1d4a3..06ee1184fad3 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -886,15 +886,15 @@ static const struct pt_regs_offset regoffset_table[] = {
 	REG_OFFSET_NAME(r29, regs[29]),
 	REG_OFFSET_NAME(r30, regs[30]),
 	REG_OFFSET_NAME(r31, regs[31]),
-	REG_OFFSET_NAME(c0_status, cp0_status),
-	REG_OFFSET_NAME(hi, hi),
 	REG_OFFSET_NAME(lo, lo),
+	REG_OFFSET_NAME(hi, hi),
+	REG_OFFSET_NAME(c0_epc, cp0_epc),
+	REG_OFFSET_NAME(c0_badvaddr, cp0_badvaddr),
+	REG_OFFSET_NAME(c0_status, cp0_status),
+	REG_OFFSET_NAME(c0_cause, cp0_cause),
 #ifdef CONFIG_CPU_HAS_SMARTMIPS
 	REG_OFFSET_NAME(acx, acx),
 #endif
-	REG_OFFSET_NAME(c0_badvaddr, cp0_badvaddr),
-	REG_OFFSET_NAME(c0_cause, cp0_cause),
-	REG_OFFSET_NAME(c0_epc, cp0_epc),
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
 	REG_OFFSET_NAME(mpl0, mpl[0]),
 	REG_OFFSET_NAME(mpl1, mpl[1]),
-- 
2.17.1

