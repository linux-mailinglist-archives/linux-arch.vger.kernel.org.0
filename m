Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A656599707
	for <lists+linux-arch@lfdr.de>; Fri, 19 Aug 2022 10:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347545AbiHSIOY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Aug 2022 04:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347528AbiHSIOX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Aug 2022 04:14:23 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07DE458DDA;
        Fri, 19 Aug 2022 01:14:15 -0700 (PDT)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxT+BLRv9i9I0EAA--.22658S6;
        Fri, 19 Aug 2022 16:14:09 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, hejinyang@loongson.cn,
        zhangqing@loongson.cn
Subject: [PATCH 4/9] Loongarch/ftrace: Add dynamic function graph tracer support
Date:   Fri, 19 Aug 2022 16:13:58 +0800
Message-Id: <20220819081403.7143-5-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220819081403.7143-1-zhangqing@loongson.cn>
References: <20220819081403.7143-1-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxT+BLRv9i9I0EAA--.22658S6
X-Coremail-Antispam: 1UD129KBjvJXoWxGF4DAF1DKw4rGr1DWF45Jrb_yoWrKw4Upr
        y2y3ZxtrWUCFsakr9Igr4kXrW5J393G342qanrtryrCwsFqF13Aw1xA34qqFyaqw4UCryS
        vayrAr4jka1UX3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Once the function_graph tracer is enabled, a filtered function has the
following call sequence:

1) ftracer_caller        ==> on/off by ftrace_make_call/ftrace_make_nop
2) ftrace_graph_caller
3) ftrace_graph_call     ==> on/off by ftrace_en/disable_ftrace_graph_caller
4) prepare_ftrace_return

Considering the following DYNAMIC_FTRACE_WITH_REGS feature, it would be
more extendable to have a ftrace_graph_caller function, instead of
calling prepare_ftrace_return directly in ftrace_caller.

Co-developed-by: Jinyang He <hejinyang@loongson.cn>
Signed-off-by: Jinyang He <hejinyang@loongson.cn>
Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---
 arch/loongarch/kernel/entry_dyn.S  | 33 ++++++++++++++++++++++
 arch/loongarch/kernel/ftrace_dyn.c | 45 ++++++++++++++++++++++++++++++
 arch/loongarch/kernel/inst.c       | 24 ++++++++++++++++
 3 files changed, 102 insertions(+)

diff --git a/arch/loongarch/kernel/entry_dyn.S b/arch/loongarch/kernel/entry_dyn.S
index e4686e67f049..4e3fb0c9a48f 100644
--- a/arch/loongarch/kernel/entry_dyn.S
+++ b/arch/loongarch/kernel/entry_dyn.S
@@ -62,6 +62,11 @@ SYM_CODE_START(ftrace_common)
 	.globl ftrace_call
 ftrace_call:
 	bl		ftrace_stub
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	.globl ftrace_graph_call
+ftrace_graph_call:
+	nop				/* b ftrace_graph_caller */
+#endif
 /*
  * As we didn't use S series regs in this assmembly code and all calls
  * are C function which will save S series regs by themselves, there is
@@ -84,6 +89,34 @@ ftrace_common_return:
 	jirl	zero, t0, 0
 SYM_CODE_END(ftrace_common)
 
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+SYM_CODE_START(ftrace_graph_caller)
+	PTR_L		a0, sp, PT_ERA
+	PTR_ADDI	a0, a0, -8	/* arg0: self_addr */
+	PTR_ADDI	a1, sp, PT_R1	/* arg1: parent */
+	bl		prepare_ftrace_return
+	b		ftrace_common_return
+SYM_CODE_END(ftrace_graph_caller)
+
+SYM_CODE_START(return_to_handler)
+	/* save return value regs */
+	PTR_ADDI 	sp, sp, -2 * SZREG
+	PTR_S		a0, sp, 0
+	PTR_S		a1, sp, SZREG
+
+	move		a0, zero	/* Has no check FP now. */
+	bl		ftrace_return_to_handler
+	move		ra, a0		/* parent ra */
+
+	/* restore return value regs */
+	PTR_L		a0, sp, 0
+	PTR_L		a1, sp, SZREG
+	PTR_ADDI 	sp, sp, 2 * SZREG
+
+	jirl		zero, ra, 0
+SYM_CODE_END(return_to_handler)
+#endif
+
 SYM_FUNC_START(ftrace_stub)
 	jirl	zero, ra, 0
 SYM_FUNC_END(ftrace_stub)
diff --git a/arch/loongarch/kernel/ftrace_dyn.c b/arch/loongarch/kernel/ftrace_dyn.c
index 1f8955be8b64..3fe791b6783e 100644
--- a/arch/loongarch/kernel/ftrace_dyn.c
+++ b/arch/loongarch/kernel/ftrace_dyn.c
@@ -109,3 +109,48 @@ int __init ftrace_dyn_arch_init(void)
 {
 	return 0;
 }
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+extern void ftrace_graph_call(void);
+
+void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent)
+{
+	unsigned long return_hooker = (unsigned long)&return_to_handler;
+	unsigned long old;
+
+	if (unlikely(atomic_read(&current->tracing_graph_pause)))
+		return;
+
+	old = *parent;
+
+	if (!function_graph_enter(old, self_addr, 0, NULL))
+		*parent = return_hooker;
+}
+
+static int ftrace_modify_graph_caller(bool enable)
+{
+	unsigned long pc, func;
+	u32 branch, nop;
+
+	pc = (unsigned long)&ftrace_graph_call;
+	func = (unsigned long)&ftrace_graph_caller;
+
+	branch = larch_insn_gen_b(pc, func);
+	nop = larch_insn_gen_nop();
+
+	if (enable)
+		return ftrace_modify_code(pc, nop, branch, true);
+	else
+		return ftrace_modify_code(pc, branch, nop, true);
+}
+
+int ftrace_enable_ftrace_graph_caller(void)
+{
+	return ftrace_modify_graph_caller(true);
+}
+
+int ftrace_disable_ftrace_graph_caller(void)
+{
+	return ftrace_modify_graph_caller(false);
+}
+#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
index f2759ae9a8bd..4f7a62ddf210 100644
--- a/arch/loongarch/kernel/inst.c
+++ b/arch/loongarch/kernel/inst.c
@@ -55,6 +55,30 @@ u32 larch_insn_gen_nop(void)
 	return INSN_NOP;
 }
 
+u32 larch_insn_gen_b(unsigned long pc, unsigned long dest)
+{
+	unsigned int immediate_l, immediate_h;
+	union loongarch_instruction insn;
+	long offset = dest - pc;
+
+	if ((offset & 3) || offset < -SZ_128M || offset >= SZ_128M) {
+		pr_warn("The generated b instruction is out of range.\n");
+		return INSN_BREAK;
+	}
+
+	offset >>= 2;
+
+	immediate_l = offset & 0xffff;
+	offset >>= 16;
+	immediate_h = offset & 0x3ff;
+
+	insn.reg0i26_format.opcode = b_op;
+	insn.reg0i26_format.immediate_l = immediate_l;
+	insn.reg0i26_format.immediate_h = immediate_h;
+
+	return insn.word;
+}
+
 u32 larch_insn_gen_bl(unsigned long pc, unsigned long dest)
 {
 	unsigned int immediate_l, immediate_h;
-- 
2.36.1

