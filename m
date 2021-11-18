Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F34455809
	for <lists+linux-arch@lfdr.de>; Thu, 18 Nov 2021 10:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243503AbhKRJdr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Nov 2021 04:33:47 -0500
Received: from mail.loongson.cn ([114.242.206.163]:48730 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245151AbhKRJdk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 18 Nov 2021 04:33:40 -0500
Received: from localhost.localdomain (unknown [111.9.175.10])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxbuQeHZZhYxcAAA--.269S5;
        Thu, 18 Nov 2021 17:30:18 +0800 (CST)
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
        Fuxin Zhang <zhangfx@lemote.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 4/4] MIPS: fix FTLB configuration
Date:   Thu, 18 Nov 2021 17:30:05 +0800
Message-Id: <20211118093005.3121-4-huangpei@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211118093005.3121-1-huangpei@loongson.cn>
References: <20211118093005.3121-1-huangpei@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9AxbuQeHZZhYxcAAA--.269S5
X-Coremail-Antispam: 1UD129KBjvdXoWrtFyrGr4kCrW5Xr13CFW8Crg_yoWkCwc_Jw
        nF9F4kGr17ZFnF9w1Uu3yrXFWfZw1rZayruFn5W3sIya43Jr15ZayFkFyUG3W3XFsayrWF
        9a95urykCa1xGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbP8FF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWwA2048vs2IY02
        0Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
        8EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
        xKxwCY1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_GFWl42xK82IYc2Ij64vIr41l4I8I
        3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
        WUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
        wI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20x
        vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
        JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbOtxDUUUUU==
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Commit "da1bd29742b1" makes 'set_ftlb_enable' called under
c->cputype unset, which leaves FTLB disabled on BOTH 3A2000
and 3A3000

Fixes: da1bd29742b1 ("MIPS: Loongson64: Probe CPU features via CPUCFG")
Signed-off-by: Huang Pei <huangpei@loongson.cn>
---
 arch/mips/kernel/cpu-probe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index ac0e2cfc6d57..24a529c6c4be 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1734,8 +1734,6 @@ static inline void decode_cpucfg(struct cpuinfo_mips *c)
 
 static inline void cpu_probe_loongson(struct cpuinfo_mips *c, unsigned int cpu)
 {
-	decode_configs(c);
-
 	/* All Loongson processors covered here define ExcCode 16 as GSExc. */
 	c->options |= MIPS_CPU_GSEXCEX;
 
@@ -1796,6 +1794,8 @@ static inline void cpu_probe_loongson(struct cpuinfo_mips *c, unsigned int cpu)
 		panic("Unknown Loongson Processor ID!");
 		break;
 	}
+
+	decode_configs(c);
 }
 #else
 static inline void cpu_probe_loongson(struct cpuinfo_mips *c, unsigned int cpu) { }
-- 
2.20.1

