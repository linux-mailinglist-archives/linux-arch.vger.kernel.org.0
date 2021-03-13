Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F36339C6D
	for <lists+linux-arch@lfdr.de>; Sat, 13 Mar 2021 07:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhCMGmu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 13 Mar 2021 01:42:50 -0500
Received: from mail.loongson.cn ([114.242.206.163]:42738 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232462AbhCMGmk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 13 Mar 2021 01:42:40 -0500
Received: from localhost.localdomain (unknown [222.209.9.50])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxGda4XkxgjLUYAA--.9506S7;
        Sat, 13 Mar 2021 14:42:16 +0800 (CST)
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
Subject: [PATCH 5/6] ftrace: introduce FTRACE_IP_EXTENSION
Date:   Sat, 13 Mar 2021 14:41:48 +0800
Message-Id: <20210313064149.29276-6-huangpei@loongson.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210313064149.29276-1-huangpei@loongson.cn>
References: <20210313064149.29276-1-huangpei@loongson.cn>
X-CM-TRANSID: AQAAf9AxGda4XkxgjLUYAA--.9506S7
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw43Xw4rWFyrtFyfur45Jrb_yoW8AF15pF
        9rC3WkGFWxJFWqkryv93s5Gr9rCw4kZrW7Ga9rGw4Yqr9xtF1vgrnFvrs2vr1xJrZ7GFWa
        vFyj9ryUCw4UZFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4U
        JVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7V
        C0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j
        6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x0262
        8vn2kIc2xKxwCY02Avz4vE14v_GF1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
        IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnI
        WIevJa73UjIFyTuYvjfUn5l8UUUUU
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

On some architectures, the DYNAMIC_FTRACE_WITH_REGS is implemented by
gcc's -fpatchable-function-entry option. Take arm64 for example, arm64
makes use of GCC -fpatchable-function-entry=2 option to insert two
nops. When the function is traced, the first nop will be modified to
the LR saver, then the second nop to "bl <ftrace-entry>". we need to
update ftrace_location() to recognise these two instructions  as being
part of ftrace. To do this, we introduce FTRACE_IP_EXTENSION to let
ftrace_location search IP, IP + FTRACE_IP_EXTENSION range.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ftrace.h | 4 ++++
 kernel/trace/ftrace.c  | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 1bd3a0356ae4..c1e1fbde8a04 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -20,6 +20,10 @@
 
 #include <asm/ftrace.h>
 
+#ifndef FTRACE_IP_EXTENSION
+#define  FTRACE_IP_EXTENSION 0
+#endif
+
 /*
  * If the arch supports passing the variable contents of
  * function_trace_op as the third parameter back from the
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 9c1bba8cc51b..a6f0e3db2479 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1583,7 +1583,7 @@ unsigned long ftrace_location_range(unsigned long start, unsigned long end)
  */
 unsigned long ftrace_location(unsigned long ip)
 {
-	return ftrace_location_range(ip, ip);
+	return ftrace_location_range(ip, ip + FTRACE_IP_EXTENSION);
 }
 
 /**
-- 
2.17.1

