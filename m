Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380F03E088A
	for <lists+linux-arch@lfdr.de>; Wed,  4 Aug 2021 21:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240526AbhHDTQW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Aug 2021 15:16:22 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:40408 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239232AbhHDTQS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Aug 2021 15:16:18 -0400
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 02AD5C0CD8;
        Wed,  4 Aug 2021 19:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1628104565; bh=GUlPhWysasMU3M5hFTCrzEu/YnDzJLWYAJ20nKaE6Hk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LJkuQpBqQaK6Z2FOtxn5p7RNDnLHu+AoaG+8/42sP9RlgxLTfKrfhEECnEwYS6xZr
         86Y8BtH5cv41D53KkLTpRjqpHSrhy7u17YZBVy+yvNEDtdrJmgU4m/nIQUbC1ned1G
         /V2CXPSP5I1lUoqdseUat9jvkKJGDK9jDl4zNj3gMYYTd+Tdif74Z5abFOkIjj2qRk
         mN4CH2ZwQO4sg+B2QrdW93e6v2FSe5aAR6MdSn4R+cAtZQD7eoeFh0vcgLKFb1ek7x
         thp22sXtRl/VU45m3E38cpnZevzPxV5ELlJVe6zl8i+/tf74sxIGodKCxQ1b+nAKgm
         OTrC9SmStEhPQ==
Received: from vineetg-Latitude-7400.internal.synopsys.com (snps-fugpbdpduq.internal.synopsys.com [10.202.17.37])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 97E73A009B;
        Wed,  4 Aug 2021 19:16:04 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Vladimir Isaev <Vladimir.Isaev@synopsys.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 02/11] ARC: atomic: !LLSC: remove hack in atomic_set() for for UP
Date:   Wed,  4 Aug 2021 12:15:45 -0700
Message-Id: <20210804191554.1252776-3-vgupta@synopsys.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210804191554.1252776-1-vgupta@synopsys.com>
References: <20210804191554.1252776-1-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

!LLSC atomics use spinlock (SMP) or irq-disable (UP) to implement
criticla regions. UP atomic_set() however was "cheating" by not doing
any of that so and still being functional.

Remove this anomaly (primarily as cleanup for future code improvements)
given that this config is not worth hassle of special case code.

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/atomic-spinlock.h | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/arch/arc/include/asm/atomic-spinlock.h b/arch/arc/include/asm/atomic-spinlock.h
index bdf87610b2d7..8c6fd0e651e5 100644
--- a/arch/arc/include/asm/atomic-spinlock.h
+++ b/arch/arc/include/asm/atomic-spinlock.h
@@ -3,12 +3,10 @@
 #ifndef _ASM_ARC_ATOMIC_SPLOCK_H
 #define _ASM_ARC_ATOMIC_SPLOCK_H
 
-#ifndef CONFIG_SMP
-
- /* violating atomic_xxx API locking protocol in UP for optimization sake */
-#define arch_atomic_set(v, i) WRITE_ONCE(((v)->counter), (i))
-
-#else
+/*
+ * Non hardware assisted Atomic-R-M-W
+ * Locking would change to irq-disabling only (UP) and spinlocks (SMP)
+ */
 
 static inline void arch_atomic_set(atomic_t *v, int i)
 {
@@ -30,13 +28,6 @@ static inline void arch_atomic_set(atomic_t *v, int i)
 
 #define arch_atomic_set_release(v, i)	arch_atomic_set((v), (i))
 
-#endif
-
-/*
- * Non hardware assisted Atomic-R-M-W
- * Locking would change to irq-disabling only (UP) and spinlocks (SMP)
- */
-
 #define ATOMIC_OP(op, c_op, asm_op)					\
 static inline void arch_atomic_##op(int i, atomic_t *v)			\
 {									\
-- 
2.25.1

