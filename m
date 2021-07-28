Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A053D8D06
	for <lists+linux-arch@lfdr.de>; Wed, 28 Jul 2021 13:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbhG1Ltu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jul 2021 07:49:50 -0400
Received: from mail.loongson.cn ([114.242.206.163]:57122 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232530AbhG1Ltt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Jul 2021 07:49:49 -0400
Received: from localhost.localdomain (unknown [121.228.27.69])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxL+NQRAFhPkQlAA--.1302S2;
        Wed, 28 Jul 2021 19:49:40 +0800 (CST)
From:   Rui Wang <wangrui@loongson.cn>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, Guo Ren <guoren@kernel.org>,
        linux-arch@vger.kernel.org, Rui Wang <wangrui@loongson.cn>,
        hev <r@hev.cc>, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [RFC PATCH v1 3/5] locking/atomic: mips: Refactor xchg_small to use atomic_fetch_and_or
Date:   Wed, 28 Jul 2021 19:49:36 +0800
Message-Id: <20210728114936.1344-1-wangrui@loongson.cn>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxL+NQRAFhPkQlAA--.1302S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKr45CFWDGrykuF4kJF4xWFg_yoWkKwc_ta
        s2qF1kuFn3G3sFq343XryYqrZ8t3W2kFWDC3WDZr4ay347ArZ8ZF1xta15Xr1UZan3Ar17
        uFW5ZF9IkanFkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbV8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
        n2IY04v7MxkIecxEwVAFwVW8KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r4j6FyUMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x0JUkHUDUUUUU=
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: wangrui <wangrui@loongson.cn>

Signed-by-off: Rui Wang <wangrui@loongson.cn>
Signed-by-off: hev <r@hev.cc>
---
 arch/mips/kernel/cmpxchg.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/mips/kernel/cmpxchg.c b/arch/mips/kernel/cmpxchg.c
index ac9c8cfb2ba9..34ef35194cbe 100644
--- a/arch/mips/kernel/cmpxchg.c
+++ b/arch/mips/kernel/cmpxchg.c
@@ -9,7 +9,7 @@
 
 unsigned long __xchg_small(volatile void *ptr, unsigned long val, unsigned int size)
 {
-	u32 old32, new32, load32, mask;
+	u32 old32, mask;
 	volatile u32 *ptr32;
 	unsigned int shift;
 
@@ -36,15 +36,9 @@ unsigned long __xchg_small(volatile void *ptr, unsigned long val, unsigned int s
 	 * includes our byte of interest, and load its value.
 	 */
 	ptr32 = (volatile u32 *)((unsigned long)ptr & ~0x3);
-	load32 = *ptr32;
-
-	do {
-		old32 = load32;
-		new32 = (load32 & ~mask) | (val << shift);
-		load32 = arch_cmpxchg(ptr32, old32, new32);
-	} while (load32 != old32);
+	old32 = atomic_fetch_and_or(ptr32, ~mask, val << shift);
 
-	return (load32 & mask) >> shift;
+	return (old32 & mask) >> shift;
 }
 
 unsigned long __cmpxchg_small(volatile void *ptr, unsigned long old,
-- 
2.32.0

