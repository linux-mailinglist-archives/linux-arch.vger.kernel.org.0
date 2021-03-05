Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34B432E62A
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 11:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhCEKUk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 05:20:40 -0500
Received: from mail.loongson.cn ([114.242.206.163]:49266 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229899AbhCEKUZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Mar 2021 05:20:25 -0500
Received: from localhost.localdomain (unknown [182.149.161.105])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxr9fCBUJgPcwUAA--.6604S3;
        Fri, 05 Mar 2021 18:19:52 +0800 (CST)
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
Subject: [PATCH 1/4] MIPS: replace -pg with CC_FLAGS_FTRACE
Date:   Fri,  5 Mar 2021 18:19:30 +0800
Message-Id: <20210305101933.9799-2-huangpei@loongson.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210305101933.9799-1-huangpei@loongson.cn>
References: <20210305101933.9799-1-huangpei@loongson.cn>
X-CM-TRANSID: AQAAf9Dxr9fCBUJgPcwUAA--.6604S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CrWxCw43AF48try7Zr13urg_yoW5Jryxpa
        nak3Z7Xw4xurW8Kr92yFyUZrsrArWvqrW0qF9rKryUJFySvFnYgr4xtFy5tr95WryxJa48
        W348WF47JrySv3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPC14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
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
        43ZEXa7VUjWv37UUUUU==
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Signed-off-by: Huang Pei <huangpei@loongson.cn>
---
 arch/mips/boot/compressed/Makefile | 2 +-
 arch/mips/kernel/Makefile          | 8 ++++----
 arch/mips/vdso/Makefile            | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index d66511825fe1..8fc9ceeec709 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -18,7 +18,7 @@ include $(srctree)/arch/mips/Kbuild.platforms
 BOOT_HEAP_SIZE := 0x400000
 
 # Disable Function Tracer
-KBUILD_CFLAGS := $(filter-out -pg, $(KBUILD_CFLAGS))
+KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE), $(KBUILD_CFLAGS))
 
 KBUILD_CFLAGS := $(filter-out -fstack-protector, $(KBUILD_CFLAGS))
 
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 2a05b923f579..33e31ea10234 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -17,10 +17,10 @@ obj-y		+= cpu-probe.o
 endif
 
 ifdef CONFIG_FUNCTION_TRACER
-CFLAGS_REMOVE_ftrace.o = -pg
-CFLAGS_REMOVE_early_printk.o = -pg
-CFLAGS_REMOVE_perf_event.o = -pg
-CFLAGS_REMOVE_perf_event_mipsxx.o = -pg
+CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_early_printk.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_perf_event.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_perf_event_mipsxx.o = $(CC_FLAGS_FTRACE)
 endif
 
 obj-$(CONFIG_CEVT_BCM1480)	+= cevt-bcm1480.o
diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index 5810cc12bc1d..f21cf88f7ae3 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -49,7 +49,7 @@ CFLAGS_vgettimeofday-o32.o = -include $(srctree)/$(src)/config-n32-o32-env.c -in
 CFLAGS_vgettimeofday-n32.o = -include $(srctree)/$(src)/config-n32-o32-env.c -include $(c-gettimeofday-y)
 endif
 
-CFLAGS_REMOVE_vgettimeofday.o = -pg
+CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE)
 
 ifdef CONFIG_MIPS_DISABLE_VDSO
   ifndef CONFIG_MIPS_LD_CAN_LINK_VDSO
@@ -63,7 +63,7 @@ ldflags-y := -Bsymbolic --no-undefined -soname=linux-vdso.so.1 \
 	$(filter -E%,$(KBUILD_CFLAGS)) -nostdlib -shared \
 	-G 0 --eh-frame-hdr --hash-style=sysv --build-id=sha1 -T
 
-CFLAGS_REMOVE_vdso.o = -pg
+CFLAGS_REMOVE_vdso.o = $(CC_FLAGS_FTRACE)
 
 GCOV_PROFILE := n
 UBSAN_SANITIZE := n
-- 
2.17.1

