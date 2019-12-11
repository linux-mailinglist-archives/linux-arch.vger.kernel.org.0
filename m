Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 646EC11BBE6
	for <lists+linux-arch@lfdr.de>; Wed, 11 Dec 2019 19:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbfLKSkp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Dec 2019 13:40:45 -0500
Received: from foss.arm.com ([217.140.110.172]:43052 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729522AbfLKSko (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Dec 2019 13:40:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E5C5113E;
        Wed, 11 Dec 2019 10:40:44 -0800 (PST)
Received: from arrakis.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D9A5D3F6CF;
        Wed, 11 Dec 2019 10:40:42 -0800 (PST)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 04/22] arm64: Use macros instead of hard-coded constants for MAIR_EL1
Date:   Wed, 11 Dec 2019 18:40:09 +0000
Message-Id: <20191211184027.20130-5-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191211184027.20130-1-catalin.marinas@arm.com>
References: <20191211184027.20130-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Currently, the arm64 __cpu_setup has hard-coded constants for the memory
attributes that go into the MAIR_EL1 register. Define proper macros in
asm/sysreg.h and make use of them in proc.S.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/sysreg.h | 12 ++++++++++++
 arch/arm64/mm/proc.S            | 27 ++++++++++-----------------
 2 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 6e919fafb43d..e21470337c5e 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -538,6 +538,18 @@
 			 SCTLR_EL1_NTWE | SCTLR_ELx_IESB | SCTLR_EL1_SPAN |\
 			 ENDIAN_SET_EL1 | SCTLR_EL1_UCI  | SCTLR_EL1_RES1)
 
+/* MAIR_ELx memory attributes (used by Linux) */
+#define MAIR_ATTR_DEVICE_nGnRnE		UL(0x00)
+#define MAIR_ATTR_DEVICE_nGnRE		UL(0x04)
+#define MAIR_ATTR_DEVICE_GRE		UL(0x0c)
+#define MAIR_ATTR_NORMAL_NC		UL(0x44)
+#define MAIR_ATTR_NORMAL_WT		UL(0xbb)
+#define MAIR_ATTR_NORMAL		UL(0xff)
+#define MAIR_ATTR_MASK			UL(0xff)
+
+/* Position the attr at the correct index */
+#define MAIR_ATTRIDX(attr, idx)		((attr) << ((idx) * 8))
+
 /* id_aa64isar0 */
 #define ID_AA64ISAR0_TS_SHIFT		52
 #define ID_AA64ISAR0_FHM_SHIFT		48
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index a1e0592d1fbc..55f715957b36 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -42,7 +42,14 @@
 #define TCR_KASAN_FLAGS 0
 #endif
 
-#define MAIR(attr, mt)	((attr) << ((mt) * 8))
+/* Default MAIR_EL1 */
+#define MAIR_EL1_SET							\
+	(MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRnE, MT_DEVICE_nGnRnE) |	\
+	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRE, MT_DEVICE_nGnRE) |	\
+	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_GRE, MT_DEVICE_GRE) |		\
+	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_NC, MT_NORMAL_NC) |		\
+	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL) |			\
+	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_WT, MT_NORMAL_WT))
 
 #ifdef CONFIG_CPU_PM
 /**
@@ -416,23 +423,9 @@ ENTRY(__cpu_setup)
 	enable_dbg				// since this is per-cpu
 	reset_pmuserenr_el0 x0			// Disable PMU access from EL0
 	/*
-	 * Memory region attributes for LPAE:
-	 *
-	 *   n = AttrIndx[2:0]
-	 *			n	MAIR
-	 *   DEVICE_nGnRnE	000	00000000
-	 *   DEVICE_nGnRE	001	00000100
-	 *   DEVICE_GRE		010	00001100
-	 *   NORMAL_NC		011	01000100
-	 *   NORMAL		100	11111111
-	 *   NORMAL_WT		101	10111011
+	 * Memory region attributes
 	 */
-	ldr	x5, =MAIR(0x00, MT_DEVICE_nGnRnE) | \
-		     MAIR(0x04, MT_DEVICE_nGnRE) | \
-		     MAIR(0x0c, MT_DEVICE_GRE) | \
-		     MAIR(0x44, MT_NORMAL_NC) | \
-		     MAIR(0xff, MT_NORMAL) | \
-		     MAIR(0xbb, MT_NORMAL_WT)
+	mov_q	x5, MAIR_EL1_SET
 	msr	mair_el1, x5
 	/*
 	 * Prepare SCTLR
