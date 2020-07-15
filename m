Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA9B221347
	for <lists+linux-arch@lfdr.de>; Wed, 15 Jul 2020 19:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgGORJS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jul 2020 13:09:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbgGORJS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Jul 2020 13:09:18 -0400
Received: from localhost.localdomain (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6711206F4;
        Wed, 15 Jul 2020 17:09:15 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 12/29] arm64: mte: Handle the MAIR_EL1 changes for late CPU bring-up
Date:   Wed, 15 Jul 2020 18:08:27 +0100
Message-Id: <20200715170844.30064-13-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200715170844.30064-1-catalin.marinas@arm.com>
References: <20200715170844.30064-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

CnP must be enabled only after the MAIR_EL1 register has been set up by
the cpu_enable_mte() function. Inconsistent MAIR_EL1 between CPUs
sharing the same TLB may lead to the wrong memory type being used for a
brief window during CPU power-up.

Move the ARM64_HAS_CNP capability to a higher number and add a
corresponding BUILD_BUG_ON() to check for any inadvertent future
change in the relative positions of MTE and CnP. The cpufeature.c code
ensures that the cpu_enable() function is called in the ascending order
of the capability number.

In addition, move the TLB invalidation to cpu_enable_mte() since late
CPUs brought up won't be covered by the flush_tlb_all() in
system_enable_mte().

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---

Notes:
    New in v7.

 arch/arm64/include/asm/cpucaps.h |  4 ++--
 arch/arm64/kernel/cpufeature.c   | 14 ++++++++++----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index 6bc3e21e5929..bc39fdbf0706 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -22,7 +22,7 @@
 #define ARM64_WORKAROUND_CAVIUM_27456		12
 #define ARM64_HAS_32BIT_EL0			13
 #define ARM64_HARDEN_EL2_VECTORS		14
-#define ARM64_HAS_CNP				15
+#define ARM64_MTE				15
 #define ARM64_HAS_NO_FPSIMD			16
 #define ARM64_WORKAROUND_REPEAT_TLBI		17
 #define ARM64_WORKAROUND_QCOM_FALKOR_E1003	18
@@ -62,7 +62,7 @@
 #define ARM64_HAS_GENERIC_AUTH			52
 #define ARM64_HAS_32BIT_EL1			53
 #define ARM64_BTI				54
-#define ARM64_MTE				55
+#define ARM64_HAS_CNP				55
 
 #define ARM64_NCAPS				56
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index c1df72bfede4..4d3abb51f7d4 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1670,6 +1670,14 @@ static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
 	write_sysreg_s(0, SYS_TFSR_EL1);
 	write_sysreg_s(0, SYS_TFSRE0_EL1);
 
+	/*
+	 * CnP must be enabled only after the MAIR_EL1 register has been set
+	 * up. Inconsistent MAIR_EL1 between CPUs sharing the same TLB may
+	 * lead to the wrong memory type being used for a brief window during
+	 * CPU power-up.
+	 */
+	BUILD_BUG_ON(ARM64_HAS_CNP < ARM64_MTE);
+
 	/*
 	 * Update the MT_NORMAL_TAGGED index in MAIR_EL1. Tag checking is
 	 * disabled for the kernel, so there won't be any observable effect
@@ -1679,8 +1687,9 @@ static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
 	mair &= ~MAIR_ATTRIDX(MAIR_ATTR_MASK, MT_NORMAL_TAGGED);
 	mair |= MAIR_ATTRIDX(MAIR_ATTR_NORMAL_TAGGED, MT_NORMAL_TAGGED);
 	write_sysreg_s(mair, SYS_MAIR_EL1);
-
 	isb();
+
+	local_flush_tlb_all();
 }
 
 static int __init system_enable_mte(void)
@@ -1688,9 +1697,6 @@ static int __init system_enable_mte(void)
 	if (!system_supports_mte())
 		return 0;
 
-	/* Ensure the TLB does not have stale MAIR attributes */
-	flush_tlb_all();
-
 	/*
 	 * Clear the tags in the zero page. This needs to be done via the
 	 * linear map which has the Tagged attribute.
