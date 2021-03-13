Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B7B339C6B
	for <lists+linux-arch@lfdr.de>; Sat, 13 Mar 2021 07:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbhCMGmu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 13 Mar 2021 01:42:50 -0500
Received: from mail.loongson.cn ([114.242.206.163]:42756 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232627AbhCMGms (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 13 Mar 2021 01:42:48 -0500
Received: from localhost.localdomain (unknown [222.209.9.50])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxGda4XkxgjLUYAA--.9506S6;
        Sat, 13 Mar 2021 14:42:13 +0800 (CST)
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
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: [PATCH 4/6] kprobes/ftrace: Use ftrace_location() when [dis]arming probes
Date:   Sat, 13 Mar 2021 14:41:47 +0800
Message-Id: <20210313064149.29276-5-huangpei@loongson.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210313064149.29276-1-huangpei@loongson.cn>
References: <20210313064149.29276-1-huangpei@loongson.cn>
X-CM-TRANSID: AQAAf9AxGda4XkxgjLUYAA--.9506S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw43WFy7tF4rKryrtw43Wrg_yoW8KrWrpa
        s0kwn8tr48JFWvgF9Fgw4kZr1rtrn8t347ArW2y3yYyrnxJr1YgF42v3yDtrn8GrZYyFWS
        yF42vFyjya1xu3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
        1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j
        6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x
        IIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_
        Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8c
        xan2IY04v7MxkIecxEwVAFwVW8AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
        JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
        kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
        6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
        IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2
        KfnxnUUI43ZEXa7VUjgo2UUUUUU==
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Ftrace location could include more than a single instruction in case
of some architectures (powerpc64, for now). In this case, kprobe is
permitted on any of those instructions, and uses ftrace infrastructure
for functioning.

However, [dis]arm_kprobe_ftrace() uses the kprobe address when setting
up ftrace filter IP. This won't work if the address points to any
instruction apart from the one that has a branch to _mcount(). To
resolve this, have [dis]arm_kprobe_ftrace() use ftrace_function() to
identify the filter IP.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 41fdbb7953c6..66ee28b071c2 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1045,9 +1045,10 @@ static int prepare_kprobe(struct kprobe *p)
 static int __arm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
 			       int *cnt)
 {
+	unsigned long ftrace_ip = ftrace_location((unsigned long)p->addr);
 	int ret = 0;
 
-	ret = ftrace_set_filter_ip(ops, (unsigned long)p->addr, 0, 0);
+	ret = ftrace_set_filter_ip(ops, ftrace_ip, 0, 0);
 	if (ret) {
 		pr_debug("Failed to arm kprobe-ftrace at %pS (%d)\n",
 			 p->addr, ret);
@@ -1070,7 +1071,7 @@ static int __arm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
 	 * At this point, sinec ops is not registered, we should be sefe from
 	 * registering empty filter.
 	 */
-	ftrace_set_filter_ip(ops, (unsigned long)p->addr, 1, 0);
+	ftrace_set_filter_ip(ops, ftrace_ip, 1, 0);
 	return ret;
 }
 
@@ -1087,6 +1088,7 @@ static int arm_kprobe_ftrace(struct kprobe *p)
 static int __disarm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
 				  int *cnt)
 {
+	unsigned long ftrace_ip = ftrace_location((unsigned long)p->addr);
 	int ret = 0;
 
 	if (*cnt == 1) {
@@ -1097,7 +1099,7 @@ static int __disarm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
 
 	(*cnt)--;
 
-	ret = ftrace_set_filter_ip(ops, (unsigned long)p->addr, 1, 0);
+	ret = ftrace_set_filter_ip(ops, ftrace_ip, 1, 0);
 	WARN_ONCE(ret < 0, "Failed to disarm kprobe-ftrace at %pS (%d)\n",
 		  p->addr, ret);
 	return ret;
-- 
2.17.1

