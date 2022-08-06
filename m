Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D45A58B477
	for <lists+linux-arch@lfdr.de>; Sat,  6 Aug 2022 10:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240425AbiHFIKS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 6 Aug 2022 04:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238561AbiHFIKR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 6 Aug 2022 04:10:17 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB21325E3;
        Sat,  6 Aug 2022 01:10:14 -0700 (PDT)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxbyPdIe5ixooIAA--.1165S6;
        Sat, 06 Aug 2022 16:10:08 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Arnd Bergmann <arnd@arndb.de>, hejinyang@loongson.cn,
        tangyouling@loongson.cn, zhangqing@loongson.cn
Subject: [PATCH v4 4/4] LoongArch: Add USER_STACKTRACE support
Date:   Sat,  6 Aug 2022 16:10:05 +0800
Message-Id: <20220806081005.332-5-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220806081005.332-1-zhangqing@loongson.cn>
References: <20220806081005.332-1-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxbyPdIe5ixooIAA--.1165S6
X-Coremail-Antispam: 1UD129KBjvJXoWxCryUZw1rCF1DtrW5KFWxWFg_yoW5ZF4fpF
        nFy3ZxtrWUWw4Skr9xZrykXr98Xw4kG3y2gFZxta45Zr17Xry8WFs7tFyvqFyUJ393Ja4S
        ga43Krn0qF4DZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
        1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j
        6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x
        IIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_
        Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8c
        xan2IY04v7MxkIecxEwVAFwVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
        JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
        kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY
        6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
        IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
        Ja73UjIFyTuYvjfUYyxRDUUUU
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index 8143774f99cb..9842fd023bcc 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -108,6 +108,7 @@ config LOONGARCH
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

