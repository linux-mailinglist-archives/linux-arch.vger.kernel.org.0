Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4F032E625
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 11:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhCEKUj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 05:20:39 -0500
Received: from mail.loongson.cn ([114.242.206.163]:49222 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229813AbhCEKUL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Mar 2021 05:20:11 -0500
Received: from localhost.localdomain (unknown [182.149.161.105])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxr9fCBUJgPcwUAA--.6604S4;
        Fri, 05 Mar 2021 18:19:54 +0800 (CST)
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
        Jinyang He <hejinyang@loongson.cn>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 2/4] MIPS: move FTRACE_SYSCALLS from ftrace.c into syscall.c
Date:   Fri,  5 Mar 2021 18:19:31 +0800
Message-Id: <20210305101933.9799-3-huangpei@loongson.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210305101933.9799-1-huangpei@loongson.cn>
References: <20210305101933.9799-1-huangpei@loongson.cn>
X-CM-TRANSID: AQAAf9Dxr9fCBUJgPcwUAA--.6604S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAF4ktr1xZr15Xry3WF4UJwb_yoWrGFykpF
        s8Z3ZrG395WF10y347ZryFkrZ3Jw4kZryay3ZrK34rZ3Wxt3W5XrZ29a4ktryktFWq9FW8
        uFWxGr15Cr4ru3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPC14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
        xKxwCY02Avz4vE14v_Gw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l
        x2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14
        v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IY
        x2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87
        Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI
        43ZEXa7VU1c18PUUUUU==
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Signed-off-by: Huang Pei <huangpei@loongson.cn>
---
 arch/mips/kernel/Makefile  |  1 -
 arch/mips/kernel/ftrace.c  | 33 ---------------------------------
 arch/mips/kernel/syscall.c | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 32 insertions(+), 34 deletions(-)

diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 33e31ea10234..5b2b551058ac 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -39,7 +39,6 @@ obj-$(CONFIG_DEBUG_FS)		+= segment.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_MODULES)		+= module.o
 
-obj-$(CONFIG_FTRACE_SYSCALLS)	+= ftrace.o
 obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
 
 sw-y				:= r4k_switch.o
diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index f57e68f40a34..5156b2e54bfe 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -12,14 +12,11 @@
 #include <linux/uaccess.h>
 #include <linux/init.h>
 #include <linux/ftrace.h>
-#include <linux/syscalls.h>
 
 #include <asm/asm.h>
 #include <asm/asm-offsets.h>
 #include <asm/cacheflush.h>
-#include <asm/syscall.h>
 #include <asm/uasm.h>
-#include <asm/unistd.h>
 
 #include <asm-generic/sections.h>
 
@@ -382,33 +379,3 @@ void prepare_ftrace_return(unsigned long *parent_ra_addr, unsigned long self_ra,
 	WARN_ON(1);
 }
 #endif	/* CONFIG_FUNCTION_GRAPH_TRACER */
-
-#ifdef CONFIG_FTRACE_SYSCALLS
-
-#ifdef CONFIG_32BIT
-unsigned long __init arch_syscall_addr(int nr)
-{
-	return (unsigned long)sys_call_table[nr - __NR_O32_Linux];
-}
-#endif
-
-#ifdef CONFIG_64BIT
-
-unsigned long __init arch_syscall_addr(int nr)
-{
-#ifdef CONFIG_MIPS32_N32
-	if (nr >= __NR_N32_Linux && nr < __NR_N32_Linux + __NR_N32_Linux_syscalls)
-		return (unsigned long)sysn32_call_table[nr - __NR_N32_Linux];
-#endif
-	if (nr >= __NR_64_Linux  && nr < __NR_64_Linux + __NR_64_Linux_syscalls)
-		return (unsigned long)sys_call_table[nr - __NR_64_Linux];
-#ifdef CONFIG_MIPS32_O32
-	if (nr >= __NR_O32_Linux && nr < __NR_O32_Linux + __NR_O32_Linux_syscalls)
-		return (unsigned long)sys32_call_table[nr - __NR_O32_Linux];
-#endif
-
-	return (unsigned long) &sys_ni_syscall;
-}
-#endif
-
-#endif /* CONFIG_FTRACE_SYSCALLS */
diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
index 2afa3eef486a..797d9ce478da 100644
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -39,7 +39,9 @@
 #include <asm/shmparam.h>
 #include <asm/sync.h>
 #include <asm/sysmips.h>
+#include <asm/syscall.h>
 #include <asm/switch_to.h>
+#include <asm/unistd.h>
 
 /*
  * For historic reasons the pipe(2) syscall on MIPS has an unusual calling
@@ -233,6 +235,36 @@ SYSCALL_DEFINE3(sysmips, long, cmd, long, arg1, long, arg2)
 	return -EINVAL;
 }
 
+#ifdef CONFIG_FTRACE_SYSCALLS
+
+#ifdef CONFIG_32BIT
+unsigned long __init arch_syscall_addr(int nr)
+{
+	return (unsigned long)sys_call_table[nr - __NR_O32_Linux];
+}
+#endif
+
+#ifdef CONFIG_64BIT
+
+unsigned long __init arch_syscall_addr(int nr)
+{
+#ifdef CONFIG_MIPS32_N32
+	if (nr >= __NR_N32_Linux && nr < __NR_N32_Linux + __NR_N32_Linux_syscalls)
+		return (unsigned long)sysn32_call_table[nr - __NR_N32_Linux];
+#endif
+	if (nr >= __NR_64_Linux  && nr < __NR_64_Linux + __NR_64_Linux_syscalls)
+		return (unsigned long)sys_call_table[nr - __NR_64_Linux];
+#ifdef CONFIG_MIPS32_O32
+	if (nr >= __NR_O32_Linux && nr < __NR_O32_Linux + __NR_O32_Linux_syscalls)
+		return (unsigned long)sys32_call_table[nr - __NR_O32_Linux];
+#endif
+
+	return (unsigned long) &sys_ni_syscall;
+}
+#endif
+
+#endif /* CONFIG_FTRACE_SYSCALLS */
+
 /*
  * No implemented yet ...
  */
-- 
2.17.1

