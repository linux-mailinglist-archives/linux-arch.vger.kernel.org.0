Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6D132E621
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 11:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhCEKUj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 05:20:39 -0500
Received: from mail.loongson.cn ([114.242.206.163]:49224 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229861AbhCEKUL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Mar 2021 05:20:11 -0500
Received: from localhost.localdomain (unknown [182.149.161.105])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxr9fCBUJgPcwUAA--.6604S5;
        Fri, 05 Mar 2021 18:19:55 +0800 (CST)
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
Subject: [PATCH 3/4] MIPS: prepare for new ftrace implementation
Date:   Fri,  5 Mar 2021 18:19:32 +0800
Message-Id: <20210305101933.9799-4-huangpei@loongson.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210305101933.9799-1-huangpei@loongson.cn>
References: <20210305101933.9799-1-huangpei@loongson.cn>
X-CM-TRANSID: AQAAf9Dxr9fCBUJgPcwUAA--.6604S5
X-Coremail-Antispam: 1UD129KBjvJXoW7ArW5Jr1xZr4ktw1UZw1rCrg_yoW8GF17pa
        n7Aas8Gw4xZFWvy34SkryrGFy3JwsYvrWFgFZrtw4rtFnYqFs8Xrn2yr15trW0gr1xKay8
        Wa48Wr17A3sYv3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
        xKxwCY02Avz4vE14v_Gw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l
        x2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14
        v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IY
        x2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
        80aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU
        0xZFpf9x0JUCg4hUUUUU=
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

