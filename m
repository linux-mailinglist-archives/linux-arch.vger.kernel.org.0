Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C3D3D8D07
	for <lists+linux-arch@lfdr.de>; Wed, 28 Jul 2021 13:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbhG1LuD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jul 2021 07:50:03 -0400
Received: from mail.loongson.cn ([114.242.206.163]:57168 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232530AbhG1LuC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Jul 2021 07:50:02 -0400
Received: from localhost.localdomain (unknown [121.228.27.69])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxWuBbRAFhRkQlAA--.49703S2;
        Wed, 28 Jul 2021 19:49:51 +0800 (CST)
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
Subject: [RFC PATCH v1 4/5] locking/atomic: openrisc: Refactor xchg_small to use atomic_fetch_and_or
Date:   Wed, 28 Jul 2021 19:49:46 +0800
Message-Id: <20210728114946.1394-1-wangrui@loongson.cn>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9AxWuBbRAFhRkQlAA--.49703S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKr45CFWDGrykuF4kJF4xWFg_yoWDJwcE93
        4xta1kWrs7Xws0ywnxAa98tr1qg3s7tF9F9anaqwsrZ34Dt3s8Jr9xJ3WUJr1YganrAr1f
        uFZ5Wr93CFn8AjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbVxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
        n2IY04v7MxkIecxEwVAFwVW8KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVW8JVW3JwCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjfUYOJ5UUUUU
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: wangrui <wangrui@loongson.cn>

Signed-by-off: Rui Wang <wangrui@loongson.cn>
Signed-by-off: hev <r@hev.cc>
---
 arch/openrisc/include/asm/cmpxchg.h | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/openrisc/include/asm/cmpxchg.h b/arch/openrisc/include/asm/cmpxchg.h
index 79fd16162ccb..c69b91ed4b48 100644
--- a/arch/openrisc/include/asm/cmpxchg.h
+++ b/arch/openrisc/include/asm/cmpxchg.h
@@ -99,16 +99,10 @@ static inline u32 xchg_small(volatile void *ptr, u32 x, int size)
 	int bitoff = off * BITS_PER_BYTE;
 #endif
 	u32 bitmask = ((0x1 << size * BITS_PER_BYTE) - 1) << bitoff;
-	u32 oldv, newv;
-	u32 ret;
-
-	do {
-		oldv = READ_ONCE(*p);
-		ret = (oldv & bitmask) >> bitoff;
-		newv = (oldv & ~bitmask) | (x << bitoff);
-	} while (cmpxchg_u32(p, oldv, newv) != oldv);
+	u32 oldv;
 
-	return ret;
+	oldv = atomic_fetch_and_or(p, ~bitmask, x << bitoff);
+	return (oldv & bitmask) >> bitoff;
 }
 
 /*
-- 
2.32.0

