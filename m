Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE803D47A6
	for <lists+linux-arch@lfdr.de>; Sat, 24 Jul 2021 14:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbhGXLz3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 24 Jul 2021 07:55:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:37574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231511AbhGXLz3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 24 Jul 2021 07:55:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 843E360E98;
        Sat, 24 Jul 2021 12:35:58 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, Guo Ren <guoren@kernel.org>,
        linux-arch@vger.kernel.org, Rui Wang <wangrui@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH RFC 2/2] qspinlock: Use ARCH_HAS_HW_XCHG_SMALL to select _Q_PENDING_BITS definition
Date:   Sat, 24 Jul 2021 20:36:17 +0800
Message-Id: <20210724123617.3525377-2-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210724123617.3525377-1-chenhuacai@loongson.cn>
References: <20210724123617.3525377-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

There are two types of bitfield definition in qspinlock data structues:

     * When NR_CPUS < 16K
     *  0- 7: locked byte
     *     8: pending
     *  9-15: not used
     * 16-17: tail index
     * 18-31: tail cpu (+1)
     *
     * When NR_CPUS >= 16K
     *  0- 7: locked byte
     *     8: pending
     *  9-10: tail index
     * 11-31: tail cpu (+1)

_Q_PENDING_BITS is 8 or 1 for the two types respectively. The second
type is a universal definition while the first type is an optimization
for NR_CPUS < 16K, but it relies on hardware 16bit xchg/cmpxchg support.

Unfortunately, some architectures don't have hardware sub-word xchg/
cmpxchg support. Though these archs can use software emulation (e.g.,
MIPS), but the cost is too expensive, and they have no benefits from
_Q_PENDING_BITS=8. So we only allow archs with ARCH_HAS_HW_XCHG_SMALL
to select _Q_PENDING_BITS=8.

This patch can let CSKY, RISC-V and other similar archs use qspinlock to
replace existing ticket spinlock.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 include/asm-generic/qspinlock_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/qspinlock_types.h b/include/asm-generic/qspinlock_types.h
index 2fd1fb89ec36..458e5d941c92 100644
--- a/include/asm-generic/qspinlock_types.h
+++ b/include/asm-generic/qspinlock_types.h
@@ -71,7 +71,7 @@ typedef struct qspinlock {
 #define _Q_LOCKED_MASK		_Q_SET_MASK(LOCKED)
 
 #define _Q_PENDING_OFFSET	(_Q_LOCKED_OFFSET + _Q_LOCKED_BITS)
-#if CONFIG_NR_CPUS < (1U << 14)
+#if (CONFIG_NR_CPUS < (1U << 14)) && defined(CONFIG_ARCH_HAS_HW_XCHG_SMALL)
 #define _Q_PENDING_BITS		8
 #else
 #define _Q_PENDING_BITS		1
-- 
2.27.0

