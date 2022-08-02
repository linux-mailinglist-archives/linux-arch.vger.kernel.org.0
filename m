Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FA95876CC
	for <lists+linux-arch@lfdr.de>; Tue,  2 Aug 2022 07:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235790AbiHBFib (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 Aug 2022 01:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235707AbiHBFi3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Aug 2022 01:38:29 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E5BF4330B;
        Mon,  1 Aug 2022 22:38:28 -0700 (PDT)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxoM5KuOhiZCABAA--.2520S6;
        Tue, 02 Aug 2022 13:38:22 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Arnd Bergmann <arnd@arndb.de>, hejinyang@loongson.cn,
        tangyouling@loongson.cn, zhangqing@loongson.cn
Subject: [PATCH v3 4/4] LoongArch: Add USER_STACKTRACE support
Date:   Tue,  2 Aug 2022 13:38:18 +0800
Message-Id: <20220802053818.18051-5-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220802053818.18051-1-zhangqing@loongson.cn>
References: <20220802053818.18051-1-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxoM5KuOhiZCABAA--.2520S6
X-Coremail-Antispam: 1UD129KBjvJXoWxCryUZw1rCF1DtrW5KFWxWFg_yoW5ZF4fpF
        nFy3ZxtrWUWw4Skr9xZrykXr98Xw4kG3y2gFZxta45Zr17Xry8Wr4IyFyvqFyUJ397Ja4S
        ga43Krn0qF4DZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
        1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE
        3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
        x0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8
        JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2
        ka0xkIwI1lc2xSY4AK67AK6r4rMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
        6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
        AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
        2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
        C2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
        nUUI43ZEXa7VUjQ6ptUUUUU==
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

To get the best output you can compile your userspace programs with
frame pointers (at least glibc + the app you are tracing export "CC
=gcc -fno-omit-frame-pointer".

...
     echo 'p:malloc /usr/lib64/libc.so.6:0x0a4704 size=%r4:u64'
                                                > uprobe_events
     echo 'p:free /usr/lib64/libc.so.6:0x0a4d50 ptr=%r4:x64'
                                               >> uprobe_events
     echo 'comm == "demo"' > ./events/uprobes/malloc/filter
     echo 'comm == "demo"' > ./events/uprobes/free/filter
     echo 1 > ./options/userstacktrace
     echo 1 > ./options/sym-userobj
 ...

Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---
 arch/loongarch/Kconfig                  |  1 +
 arch/loongarch/include/asm/stacktrace.h |  5 +++
 arch/loongarch/kernel/stacktrace.c      | 41 +++++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 85d0fa3147cd..05906384d564 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -107,6 +107,7 @@ config LOONGARCH
 	select SWIOTLB
 	select TRACE_IRQFLAGS_SUPPORT
 	select USE_PERCPU_NUMA_NODE_ID
+	select USER_STACKTRACE_SUPPORT
 	select ZONE_DMA32
 	select MMU_GATHER_MERGE_VMAS if MMU
 
diff --git a/arch/loongarch/include/asm/stacktrace.h b/arch/loongarch/include/asm/stacktrace.h
index 49cb89213aeb..77fdb8ad662d 100644
--- a/arch/loongarch/include/asm/stacktrace.h
+++ b/arch/loongarch/include/asm/stacktrace.h
@@ -21,6 +21,11 @@ struct stack_info {
 	unsigned long begin, end, next_sp;
 };
 
+struct stack_frame {
+	unsigned long	fp;
+	unsigned long	ra;
+};
+
 bool in_task_stack(unsigned long stack, struct task_struct *task,
 			struct stack_info *info);
 bool in_irq_stack(unsigned long stack, struct stack_info *info);
diff --git a/arch/loongarch/kernel/stacktrace.c b/arch/loongarch/kernel/stacktrace.c
index f4f4b8ad3917..cba1b6ab8a1a 100644
--- a/arch/loongarch/kernel/stacktrace.c
+++ b/arch/loongarch/kernel/stacktrace.c
@@ -6,6 +6,7 @@
  */
 #include <linux/sched.h>
 #include <linux/stacktrace.h>
+#include <linux/uaccess.h>
 
 #include <asm/stacktrace.h>
 #include <asm/unwind.h>
@@ -35,3 +36,43 @@ void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
 			break;
 	}
 }
+
+static int
+copy_stack_frame(unsigned long fp, struct stack_frame *frame)
+{
+	int ret = 1;
+	unsigned long err;
+	unsigned long __user *user_frame_tail;
+
+	user_frame_tail = (unsigned long *)(fp - sizeof(struct stack_frame));
+	if (!access_ok(user_frame_tail, sizeof(*frame)))
+		return 0;
+
+	pagefault_disable();
+	err = (__copy_from_user_inatomic(frame, user_frame_tail, sizeof(*frame)));
+	if (err || (unsigned long)user_frame_tail >= frame->fp)
+		ret = 0;
+	pagefault_enable();
+
+	return ret;
+}
+
+void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
+			  const struct pt_regs *regs)
+{
+	unsigned long fp = regs->regs[22];
+
+	while (fp && !((unsigned long)fp & 0xf)) {
+		struct stack_frame frame;
+
+		frame.fp = 0;
+		frame.ra = 0;
+		if (!copy_stack_frame(fp, &frame))
+			break;
+		if (!frame.ra)
+			break;
+		if (!consume_entry(cookie, frame.ra))
+			break;
+		fp = frame.fp;
+	}
+}
-- 
2.20.1

