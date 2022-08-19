Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3558D5996E1
	for <lists+linux-arch@lfdr.de>; Fri, 19 Aug 2022 10:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347123AbiHSIO3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Aug 2022 04:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347540AbiHSIOX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Aug 2022 04:14:23 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9FAD15FAE2;
        Fri, 19 Aug 2022 01:14:17 -0700 (PDT)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxT+BLRv9i9I0EAA--.22658S7;
        Fri, 19 Aug 2022 16:14:10 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, hejinyang@loongson.cn,
        zhangqing@loongson.cn
Subject: [PATCH 5/9] Loongarch/ftrace: Add DYNAMIC_FTRACE_WITH_REGS support
Date:   Fri, 19 Aug 2022 16:13:59 +0800
Message-Id: <20220819081403.7143-6-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220819081403.7143-1-zhangqing@loongson.cn>
References: <20220819081403.7143-1-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxT+BLRv9i9I0EAA--.22658S7
X-Coremail-Antispam: 1UD129KBjvJXoWxCF43Gry5Zr1ktr17ZF48Crg_yoWrWw4xpr
        92yrn8GFWj9Fsag3yfKrykWrs8XrWvg34avay7CFyrJr4qq3W5ArW0kr1DZFyxt3yxG3yx
        XF1fCr4Yya17XwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE
        3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
        x0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8
        JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2
        ka0xkIwI1lc2xSY4AK67AK6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
        6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
        AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE
        2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
        vEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
        vjDU0xZFpf9x0JUxUUUUUUUU=
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch implements DYNAMIC_FTRACE_WITH_REGS on LoongArch, which allows
a traced function's arguments (and some other registers) to be captured
into a struct pt_regs, allowing these to be inspected and modified.

Co-developed-by: Jinyang He <hejinyang@loongson.cn>
Signed-off-by: Jinyang He <hejinyang@loongson.cn>
Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---
 arch/loongarch/Kconfig              |  1 +
 arch/loongarch/include/asm/ftrace.h |  3 +++
 arch/loongarch/kernel/entry_dyn.S   | 36 +++++++++++++++++++++++++++--
 arch/loongarch/kernel/ftrace_dyn.c  | 17 ++++++++++++++
 4 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index f2d4899b1a0e..22eb3d6f8537 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -84,6 +84,7 @@ config LOONGARCH
 	select HAVE_DEBUG_STACKOVERFLOW
 	select HAVE_DMA_CONTIGUOUS
         select HAVE_DYNAMIC_FTRACE
+        select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_EXIT_THREAD
 	select HAVE_FAST_GUP
 	select HAVE_FTRACE_MCOUNT_RECORD
diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/include/asm/ftrace.h
index 76ca58767f4d..a3f974a7a5ce 100644
--- a/arch/loongarch/include/asm/ftrace.h
+++ b/arch/loongarch/include/asm/ftrace.h
@@ -28,6 +28,9 @@ struct dyn_ftrace;
 int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
 #define ftrace_init_nop ftrace_init_nop
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+#define ARCH_SUPPORTS_FTRACE_OPS 1
+#endif
 #endif /* CONFIG_DYNAMIC_FTRACE */
 #endif /* __ASSEMBLY__ */
 #endif /* CONFIG_FUNCTION_TRACER */
diff --git a/arch/loongarch/kernel/entry_dyn.S b/arch/loongarch/kernel/entry_dyn.S
index 4e3fb0c9a48f..38f616c1b4db 100644
--- a/arch/loongarch/kernel/entry_dyn.S
+++ b/arch/loongarch/kernel/entry_dyn.S
@@ -27,7 +27,7 @@
  * follows the LoongArch psABI well.
  */
 
-	.macro  ftrace_regs_entry
+	.macro  ftrace_regs_entry allregs=0
 	PTR_ADDI sp, sp, -PT_SIZE
 	/* Save trace function ra at PT_ERA */
 	PTR_S	ra, sp, PT_ERA
@@ -43,16 +43,48 @@
 	PTR_S	a7, sp, PT_R11
 	PTR_S	fp, sp, PT_R22
 
+	.if \allregs
+	PTR_S	t0, sp, PT_R12
+	PTR_S	t1, sp, PT_R13
+	PTR_S	t2, sp, PT_R14
+	PTR_S	t3, sp, PT_R15
+	PTR_S	t4, sp, PT_R16
+	PTR_S	t5, sp, PT_R17
+	PTR_S	t6, sp, PT_R18
+	PTR_S	t7, sp, PT_R19
+	PTR_S	t8, sp, PT_R20
+	PTR_S	s0, sp, PT_R23
+	PTR_S	s1, sp, PT_R24
+	PTR_S	s2, sp, PT_R25
+	PTR_S	s3, sp, PT_R26
+	PTR_S	s4, sp, PT_R27
+	PTR_S	s5, sp, PT_R28
+	PTR_S	s6, sp, PT_R29
+	PTR_S	s7, sp, PT_R30
+	PTR_S	s8, sp, PT_R31
+	PTR_S	tp, sp, PT_R2
+	/* Clear it for later use as a flag sometimes. */
+	PTR_S	zero, sp, PT_R0
+	PTR_S	$r21, sp, PT_R21
+	.endif
+
 	PTR_ADDI t8, sp, PT_SIZE
 	PTR_S   t8, sp, PT_R3
 
 	.endm
 
 SYM_CODE_START(ftrace_caller)
-	ftrace_regs_entry
+	ftrace_regs_entry allregs=0
 	b	ftrace_common
 SYM_CODE_END(ftrace_caller)
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+SYM_CODE_START(ftrace_regs_caller)
+	ftrace_regs_entry allregs=1
+	b	ftrace_common
+SYM_CODE_END(ftrace_regs_caller)
+#endif
+
 SYM_CODE_START(ftrace_common)
 	PTR_ADDI	a0, ra, -8	/* arg0: ip */
 	move		a1, t0		/* arg1: parent_ip */
diff --git a/arch/loongarch/kernel/ftrace_dyn.c b/arch/loongarch/kernel/ftrace_dyn.c
index 3fe791b6783e..ec3d951be50c 100644
--- a/arch/loongarch/kernel/ftrace_dyn.c
+++ b/arch/loongarch/kernel/ftrace_dyn.c
@@ -99,6 +99,23 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
 	return ftrace_modify_code(pc, old, new, true);
 }
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
+			unsigned long addr)
+{
+	unsigned long pc;
+	long offset;
+	u32 old, new;
+
+	pc = rec->ip + LOONGARCH_INSN_SIZE;
+
+	old = larch_insn_gen_bl(pc, old_addr);
+	new = larch_insn_gen_bl(pc, addr);
+
+	return ftrace_modify_code(pc, old, new, true);
+}
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
+
 void arch_ftrace_update_code(int command)
 {
 	command |= FTRACE_MAY_SLEEP;
-- 
2.36.1

