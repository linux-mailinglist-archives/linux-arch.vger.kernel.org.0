Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5BC3E0890
	for <lists+linux-arch@lfdr.de>; Wed,  4 Aug 2021 21:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240578AbhHDTQ2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Aug 2021 15:16:28 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:58794 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240503AbhHDTQV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Aug 2021 15:16:21 -0400
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3F34540DBA;
        Wed,  4 Aug 2021 19:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1628104567; bh=ETzGMk/ObfVL8wKfDVOEoi0RM2tas4Uky7iyu8ZWips=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c+o0MSTNHiEFFu5uApAXwSL8QsJ2m0J8c8AVi+iXZVELxkY34RA6BH7mhFuF2thX1
         qpPdtcyjIbLSKhUujw5prCfXP3sOhkQSLwO4cYWc8SFnEoIB1OupxNsk8ZD3pDQEer
         B/geApv/HiJj0ivLUNHqy+/NRm1FJsYRbNlA+o9Sb0mJl7V3TVWvgeq4xAPo+E465a
         olrkHURomE+z81JTeR/RuwITqKqctlHIXo/d0Go2o9Z6H6HCsQ0/rRtZXX3LG/OA2e
         PI6oWnrawOnpZAL/83WAWB+Nhz59mwWhaJkJUzzItURzBEz4PxTN04qFTAGbhihwMv
         QDlKTdbNe4hvw==
Received: from vineetg-Latitude-7400.internal.synopsys.com (snps-fugpbdpduq.internal.synopsys.com [10.202.17.37])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id EB36AA0094;
        Wed,  4 Aug 2021 19:16:06 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Vladimir Isaev <Vladimir.Isaev@synopsys.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 11/11] ARC: atomic_cmpxchg/atomic_xchg: implement relaxed variants
Date:   Wed,  4 Aug 2021 12:15:54 -0700
Message-Id: <20210804191554.1252776-12-vgupta@synopsys.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210804191554.1252776-1-vgupta@synopsys.com>
References: <20210804191554.1252776-1-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

And move them out of cmpxchg.h to canonical atomic.h

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/atomic.h  | 27 +++++++++++++++++++++++++++
 arch/arc/include/asm/cmpxchg.h | 23 -----------------------
 2 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/arch/arc/include/asm/atomic.h b/arch/arc/include/asm/atomic.h
index ee88e1dbaab5..52ee51e1ff7c 100644
--- a/arch/arc/include/asm/atomic.h
+++ b/arch/arc/include/asm/atomic.h
@@ -22,6 +22,33 @@
 #include <asm/atomic-spinlock.h>
 #endif
 
+#define arch_atomic_cmpxchg(v, o, n)					\
+({									\
+	arch_cmpxchg(&((v)->counter), (o), (n));			\
+})
+
+#ifdef arch_cmpxchg_relaxed
+#define arch_atomic_cmpxchg_relaxed(v, o, n)				\
+({									\
+	arch_cmpxchg_relaxed(&((v)->counter), (o), (n));		\
+})
+#endif
+
+#define arch_atomic_xchg(v, n)						\
+({									\
+	arch_xchg(&((v)->counter), (n));				\
+})
+
+#ifdef arch_xchg_relaxed
+#define arch_atomic_xchg_relaxed(v, n)					\
+({									\
+	arch_xchg_relaxed(&((v)->counter), (n));			\
+})
+#endif
+
+/*
+ * 64-bit atomics
+ */
 #ifdef CONFIG_GENERIC_ATOMIC64
 #include <asm-generic/atomic64.h>
 #else
diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
index e2ae0eb1ca07..c5b544a5fe81 100644
--- a/arch/arc/include/asm/cmpxchg.h
+++ b/arch/arc/include/asm/cmpxchg.h
@@ -80,14 +80,6 @@
 
 #endif
 
-/*
- * atomic_cmpxchg is same as cmpxchg
- *   LLSC: only different in data-type, semantics are exactly same
- *  !LLSC: cmpxchg() has to use an external lock atomic_ops_lock to guarantee
- *         semantics, and this lock also happens to be used by atomic_*()
- */
-#define arch_atomic_cmpxchg(v, o, n) ((int)arch_cmpxchg(&((v)->counter), (o), (n)))
-
 /*
  * xchg
  */
@@ -148,19 +140,4 @@
 
 #endif
 
-/*
- * "atomic" variant of xchg()
- * REQ: It needs to follow the same serialization rules as other atomic_xxx()
- * Since xchg() doesn't always do that, it would seem that following definition
- * is incorrect. But here's the rationale:
- *   SMP : Even xchg() takes the atomic_ops_lock, so OK.
- *   LLSC: atomic_ops_lock are not relevant at all (even if SMP, since LLSC
- *         is natively "SMP safe", no serialization required).
- *   UP  : other atomics disable IRQ, so no way a difft ctxt atomic_xchg()
- *         could clobber them. atomic_xchg() itself would be 1 insn, so it
- *         can't be clobbered by others. Thus no serialization required when
- *         atomic_xchg is involved.
- */
-#define arch_atomic_xchg(v, new) (arch_xchg(&((v)->counter), new))
-
 #endif
-- 
2.25.1

