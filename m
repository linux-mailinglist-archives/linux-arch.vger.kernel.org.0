Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2506339C69
	for <lists+linux-arch@lfdr.de>; Sat, 13 Mar 2021 07:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhCMGmt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 13 Mar 2021 01:42:49 -0500
Received: from mail.loongson.cn ([114.242.206.163]:42676 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231392AbhCMGmi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 13 Mar 2021 01:42:38 -0500
Received: from localhost.localdomain (unknown [222.209.9.50])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxGda4XkxgjLUYAA--.9506S5;
        Sat, 13 Mar 2021 14:42:12 +0800 (CST)
From:   Huang Pei <huangpei@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        ambrosehua@gmail.com
Cc:     Bibo Mao <maobibo@loongson.cn>, linux-mips@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Burton <paulburton@kernel.org>,
        Li Xuefeng <lixuefeng@loongson.cn>,
        Yang Tiezhu <yangtiezhu@loongson.cn>,
        Gao Juxin <gaojuxin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 3/6] MIPS: prepare for new ftrace implementation
Date:   Sat, 13 Mar 2021 14:41:46 +0800
Message-Id: <20210313064149.29276-4-huangpei@loongson.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210313064149.29276-1-huangpei@loongson.cn>
References: <20210313064149.29276-1-huangpei@loongson.cn>
X-CM-TRANSID: AQAAf9AxGda4XkxgjLUYAA--.9506S5
X-Coremail-Antispam: 1UD129KBjvJXoW7ArW5Jr1xZr4ktw1UZw1rCrg_yoW8GF17pa
        n7Aas8Gw4xZFWvy34SkryrGFy3JwsYvrWFgFZrtw4rtFnYqFs8Xrn2yr15trW0gr1xKay8
        Wa48Wr17A3sYv3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxd
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
        IY04v7MxkIecxEwVAFwVW8AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8
        JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1V
        AFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
        8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2Kfnx
        nUUI43ZEXa7VUjPku7UUUUU==
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

No function change

Signed-off-by: Huang Pei <huangpei@loongson.cn>
---
 arch/mips/kernel/Makefile                      | 4 ++--
 arch/mips/kernel/{ftrace.c => ftrace-mcount.c} | 0
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/mips/kernel/{ftrace.c => ftrace-mcount.c} (100%)

diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 5b2b551058ac..3e7b0ee54cfb 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -17,7 +17,7 @@ obj-y		+= cpu-probe.o
 endif
 
 ifdef CONFIG_FUNCTION_TRACER
-CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_ftrace-mcount.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_early_printk.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_perf_event.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_perf_event_mipsxx.o = $(CC_FLAGS_FTRACE)
@@ -39,7 +39,7 @@ obj-$(CONFIG_DEBUG_FS)		+= segment.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_MODULES)		+= module.o
 
-obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
+obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace-mcount.o
 
 sw-y				:= r4k_switch.o
 sw-$(CONFIG_CPU_R3000)		:= r2300_switch.o
diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace-mcount.c
similarity index 100%
rename from arch/mips/kernel/ftrace.c
rename to arch/mips/kernel/ftrace-mcount.c
-- 
2.17.1

