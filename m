Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B9B599703
	for <lists+linux-arch@lfdr.de>; Fri, 19 Aug 2022 10:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346678AbiHSIRc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Aug 2022 04:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347579AbiHSIRH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Aug 2022 04:17:07 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FA97C6CE8;
        Fri, 19 Aug 2022 01:17:04 -0700 (PDT)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx32v5Rv9isI4EAA--.18159S3;
        Fri, 19 Aug 2022 16:16:58 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, hejinyang@loongson.cn,
        zhangqing@loongson.cn
Subject: [PATCH 7/9] Loongarch/ftrace: Add HAVE_FUNCTION_GRAPH_RET_ADDR_PTR support
Date:   Fri, 19 Aug 2022 16:16:55 +0800
Message-Id: <20220819081657.7254-2-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220819081657.7254-1-zhangqing@loongson.cn>
References: <20220819081657.7254-1-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bx32v5Rv9isI4EAA--.18159S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAr43CF45Zr4xCr1fZr4ktFb_yoWrtF1xpF
        9xAas5GrWxWF9agrnFqr1Uur4kGrnrCw1agFWqyryFkFsFqF13WrnFvryDXFWkt3ykWrWI
        qas5GrWYkF4UXwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPK14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
        8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
        jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
        kIwI1lc2xSY4AK67AK6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4U
        MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67
        AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4
        A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU
        0xZFpf9x0JUoVb9UUUUU=
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Ftrace_graph_ret_addr can be called by stack unwinding code to convert
a found stack return address ('ret') to its original value, in case the
function graph tracer has modified it to be 'return_to_handler',If the
hasn't been modified, the unchanged value of 'ret' is returned.

Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---
 arch/loongarch/include/asm/ftrace.h     |  3 +++
 arch/loongarch/include/asm/unwind.h     |  1 +
 arch/loongarch/kernel/ftrace_dyn.c      |  2 +-
 arch/loongarch/kernel/unwind_guess.c    |  4 +++-
 arch/loongarch/kernel/unwind_prologue.c | 10 +++++++++-
 5 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/include/asm/ftrace.h
index 0ed3d649c1ba..f96adef0e4a5 100644
--- a/arch/loongarch/include/asm/ftrace.h
+++ b/arch/loongarch/include/asm/ftrace.h
@@ -10,6 +10,8 @@
 #define FTRACE_REGS_PLT_IDX	1
 #define NR_FTRACE_PLTS		2
 
+#define GRAPH_FAKE_OFFSET (sizeof(struct pt_regs) - offsetof(struct pt_regs, regs[1]))
+
 #ifdef CONFIG_FUNCTION_TRACER
 #define MCOUNT_INSN_SIZE 4		/* sizeof mcount call */
 
@@ -20,6 +22,7 @@ extern void _mcount(void);
 #endif
 
 #ifdef CONFIG_DYNAMIC_FTRACE
+#define HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
 {
 	return addr;
diff --git a/arch/loongarch/include/asm/unwind.h b/arch/loongarch/include/asm/unwind.h
index 6af4718bdf01..f66b07c3e6a1 100644
--- a/arch/loongarch/include/asm/unwind.h
+++ b/arch/loongarch/include/asm/unwind.h
@@ -21,6 +21,7 @@ struct unwind_state {
 	struct stack_info stack_info;
 	struct task_struct *task;
 	bool first, error;
+	int graph_idx;
 	unsigned long sp, pc, ra;
 };
 
diff --git a/arch/loongarch/kernel/ftrace_dyn.c b/arch/loongarch/kernel/ftrace_dyn.c
index a7c36b92e558..53961e5890fd 100644
--- a/arch/loongarch/kernel/ftrace_dyn.c
+++ b/arch/loongarch/kernel/ftrace_dyn.c
@@ -219,7 +219,7 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent)
 
 	old = *parent;
 
-	if (!function_graph_enter(old, self_addr, 0, NULL))
+	if (!function_graph_enter(old, self_addr, 0, parent))
 		*parent = return_hooker;
 }
 
diff --git a/arch/loongarch/kernel/unwind_guess.c b/arch/loongarch/kernel/unwind_guess.c
index 5afa6064d73e..229ba014cea0 100644
--- a/arch/loongarch/kernel/unwind_guess.c
+++ b/arch/loongarch/kernel/unwind_guess.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2022 Loongson Technology Corporation Limited
  */
+#include <linux/ftrace.h>
 #include <linux/kernel.h>
 
 #include <asm/unwind.h>
@@ -53,7 +54,8 @@ bool unwind_next_frame(struct unwind_state *state)
 		     state->sp < info->end;
 		     state->sp += sizeof(unsigned long)) {
 			addr = *(unsigned long *)(state->sp);
-
+			state->pc = ftrace_graph_ret_addr(state->task, &state->graph_idx,
+				addr, (unsigned long *)(state->sp - GRAPH_FAKE_OFFSET));
 			if (__kernel_text_address(addr))
 				return true;
 		}
diff --git a/arch/loongarch/kernel/unwind_prologue.c b/arch/loongarch/kernel/unwind_prologue.c
index b206d9159205..03f8b31a90cc 100644
--- a/arch/loongarch/kernel/unwind_prologue.c
+++ b/arch/loongarch/kernel/unwind_prologue.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2022 Loongson Technology Corporation Limited
  */
+#include <linux/ftrace.h>
 #include <linux/kallsyms.h>
 
 #include <asm/inst.h>
@@ -32,6 +33,8 @@ static bool unwind_by_guess(struct unwind_state *state)
 	     state->sp < info->end;
 	     state->sp += sizeof(unsigned long)) {
 		addr = *(unsigned long *)(state->sp);
+		state->pc = ftrace_graph_ret_addr(state->task, &state->graph_idx,
+			addr, (unsigned long *)(state->sp - GRAPH_FAKE_OFFSET));
 		if (__kernel_text_address(addr))
 			return true;
 	}
@@ -146,8 +149,11 @@ bool unwind_next_frame(struct unwind_state *state)
 			break;
 
 		case UNWINDER_PROLOGUE:
-			if (unwind_by_prologue(state))
+			if (unwind_by_prologue(state)) {
+				state->pc = ftrace_graph_ret_addr(state->task, &state->graph_idx,
+					state->pc, (unsigned long *)(state->sp - GRAPH_FAKE_OFFSET));
 				return true;
+			}
 
 			if (info->type == STACK_TYPE_IRQ &&
 				info->end == state->sp) {
@@ -159,6 +165,8 @@ bool unwind_next_frame(struct unwind_state *state)
 
 				state->pc = pc;
 				state->sp = regs->regs[3];
+				state->pc = ftrace_graph_ret_addr(state->task, &state->graph_idx,
+					pc, (unsigned long *)(state->sp - GRAPH_FAKE_OFFSET));
 				state->ra = regs->regs[1];
 				state->first = true;
 				get_stack_info(state->sp, state->task, info);
-- 
2.36.1

