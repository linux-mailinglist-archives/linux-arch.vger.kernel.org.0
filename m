Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFAF11BBE7
	for <lists+linux-arch@lfdr.de>; Wed, 11 Dec 2019 19:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbfLKSkq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Dec 2019 13:40:46 -0500
Received: from foss.arm.com ([217.140.110.172]:43060 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbfLKSkq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Dec 2019 13:40:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB3ED11B3;
        Wed, 11 Dec 2019 10:40:45 -0800 (PST)
Received: from arrakis.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 82B0E3F6CF;
        Wed, 11 Dec 2019 10:40:44 -0800 (PST)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 05/22] arm64: mte: system register definitions
Date:   Wed, 11 Dec 2019 18:40:10 +0000
Message-Id: <20191211184027.20130-6-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191211184027.20130-1-catalin.marinas@arm.com>
References: <20191211184027.20130-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

Add Memory Tagging Extension system register definitions together with
the relevant bitfields.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Co-developed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/kvm_arm.h     |  1 +
 arch/arm64/include/asm/sysreg.h      | 50 ++++++++++++++++++++++++++++
 arch/arm64/include/uapi/asm/ptrace.h |  1 +
 arch/arm64/kernel/ptrace.c           |  2 +-
 4 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 6e5d839f42b5..0b25f9a81c57 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -12,6 +12,7 @@
 #include <asm/types.h>
 
 /* Hyp Configuration Register (HCR) bits */
+#define HCR_ATA		(UL(1) << 56)
 #define HCR_FWB		(UL(1) << 46)
 #define HCR_API		(UL(1) << 41)
 #define HCR_APK		(UL(1) << 40)
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index e21470337c5e..609d1b3238dd 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -171,6 +171,8 @@
 #define SYS_SCTLR_EL1			sys_reg(3, 0, 1, 0, 0)
 #define SYS_ACTLR_EL1			sys_reg(3, 0, 1, 0, 1)
 #define SYS_CPACR_EL1			sys_reg(3, 0, 1, 0, 2)
+#define SYS_RGSR_EL1			sys_reg(3, 0, 1, 0, 5)
+#define SYS_GCR_EL1			sys_reg(3, 0, 1, 0, 6)
 
 #define SYS_ZCR_EL1			sys_reg(3, 0, 1, 2, 0)
 
@@ -208,6 +210,8 @@
 #define SYS_ERXADDR_EL1			sys_reg(3, 0, 5, 4, 3)
 #define SYS_ERXMISC0_EL1		sys_reg(3, 0, 5, 5, 0)
 #define SYS_ERXMISC1_EL1		sys_reg(3, 0, 5, 5, 1)
+#define SYS_TFSR_EL1			sys_reg(3, 0, 5, 6, 0)
+#define SYS_TFSRE0_EL1			sys_reg(3, 0, 5, 6, 1)
 
 #define SYS_FAR_EL1			sys_reg(3, 0, 6, 0, 0)
 #define SYS_PAR_EL1			sys_reg(3, 0, 7, 4, 0)
@@ -358,6 +362,7 @@
 
 #define SYS_CCSIDR_EL1			sys_reg(3, 1, 0, 0, 0)
 #define SYS_CLIDR_EL1			sys_reg(3, 1, 0, 0, 1)
+#define SYS_GMID_EL1			sys_reg(3, 1, 0, 0, 4)
 #define SYS_AIDR_EL1			sys_reg(3, 1, 0, 0, 7)
 
 #define SYS_CSSELR_EL1			sys_reg(3, 2, 0, 0, 0)
@@ -411,6 +416,7 @@
 #define SYS_ESR_EL2			sys_reg(3, 4, 5, 2, 0)
 #define SYS_VSESR_EL2			sys_reg(3, 4, 5, 2, 3)
 #define SYS_FPEXC32_EL2			sys_reg(3, 4, 5, 3, 0)
+#define SYS_TFSR_EL2			sys_reg(3, 4, 5, 6, 0)
 #define SYS_FAR_EL2			sys_reg(3, 4, 6, 0, 0)
 
 #define SYS_VDISR_EL2			sys_reg(3, 4, 12, 1,  1)
@@ -467,6 +473,7 @@
 #define SYS_AFSR0_EL12			sys_reg(3, 5, 5, 1, 0)
 #define SYS_AFSR1_EL12			sys_reg(3, 5, 5, 1, 1)
 #define SYS_ESR_EL12			sys_reg(3, 5, 5, 2, 0)
+#define SYS_TFSR_EL12			sys_reg(3, 5, 5, 6, 0)
 #define SYS_FAR_EL12			sys_reg(3, 5, 6, 0, 0)
 #define SYS_MAIR_EL12			sys_reg(3, 5, 10, 2, 0)
 #define SYS_AMAIR_EL12			sys_reg(3, 5, 10, 3, 0)
@@ -482,6 +489,14 @@
 
 /* Common SCTLR_ELx flags. */
 #define SCTLR_ELx_DSSBS	(BIT(44))
+#define SCTLR_ELx_ATA	(BIT(43))
+
+#define SCTLR_ELx_TCF_SHIFT	40
+#define SCTLR_ELx_TCF_SYNC	(UL(0x1) << SCTLR_ELx_TCF_SHIFT)
+#define SCTLR_ELx_TCF_ASYNC	(UL(0x2) << SCTLR_ELx_TCF_SHIFT)
+#define SCTLR_ELx_TCF_MASK	(UL(0x3) << SCTLR_ELx_TCF_SHIFT)
+
+#define SCTLR_ELx_ITFSB	(BIT(37))
 #define SCTLR_ELx_ENIA	(BIT(31))
 #define SCTLR_ELx_ENIB	(BIT(30))
 #define SCTLR_ELx_ENDA	(BIT(27))
@@ -510,6 +525,13 @@
 #endif
 
 /* SCTLR_EL1 specific flags. */
+#define SCTLR_EL1_ATA0		(BIT(42))
+
+#define SCTLR_EL1_TCF0_SHIFT	38
+#define SCTLR_EL1_TCF0_SYNC	(UL(0x1) << SCTLR_EL1_TCF0_SHIFT)
+#define SCTLR_EL1_TCF0_ASYNC	(UL(0x2) << SCTLR_EL1_TCF0_SHIFT)
+#define SCTLR_EL1_TCF0_MASK	(UL(0x3) << SCTLR_EL1_TCF0_SHIFT)
+
 #define SCTLR_EL1_UCI		(BIT(26))
 #define SCTLR_EL1_E0E		(BIT(24))
 #define SCTLR_EL1_SPAN		(BIT(23))
@@ -544,6 +566,7 @@
 #define MAIR_ATTR_DEVICE_GRE		UL(0x0c)
 #define MAIR_ATTR_NORMAL_NC		UL(0x44)
 #define MAIR_ATTR_NORMAL_WT		UL(0xbb)
+#define MAIR_ATTR_NORMAL_TAGGED		UL(0xf0)
 #define MAIR_ATTR_NORMAL		UL(0xff)
 #define MAIR_ATTR_MASK			UL(0xff)
 
@@ -611,11 +634,16 @@
 
 /* id_aa64pfr1 */
 #define ID_AA64PFR1_SSBS_SHIFT		4
+#define ID_AA64PFR1_MTE_SHIFT		8
 
 #define ID_AA64PFR1_SSBS_PSTATE_NI	0
 #define ID_AA64PFR1_SSBS_PSTATE_ONLY	1
 #define ID_AA64PFR1_SSBS_PSTATE_INSNS	2
 
+#define ID_AA64PFR1_MTE_NI		0x0
+#define ID_AA64PFR1_MTE_EL0		0x1
+#define ID_AA64PFR1_MTE			0x2
+
 /* id_aa64zfr0 */
 #define ID_AA64ZFR0_SM4_SHIFT		40
 #define ID_AA64ZFR0_SHA3_SHIFT		32
@@ -746,6 +774,28 @@
 #define CPACR_EL1_ZEN_EL0EN	(BIT(17)) /* enable EL0 access, if EL1EN set */
 #define CPACR_EL1_ZEN		(CPACR_EL1_ZEN_EL1EN | CPACR_EL1_ZEN_EL0EN)
 
+/* TCR EL1 Bit Definitions */
+#define SYS_TCR_EL1_TCMA1	(BIT(58))
+#define SYS_TCR_EL1_TCMA0	(BIT(57))
+
+/* GCR_EL1 Definitions */
+#define SYS_GCR_EL1_RRND	(BIT(16))
+#define SYS_GCR_EL1_EXCL_MASK	0xffffUL
+
+/* RGSR_EL1 Definitions */
+#define SYS_RGSR_EL1_TAG_MASK	0xfUL
+#define SYS_RGSR_EL1_SEED_SHIFT	8
+#define SYS_RGSR_EL1_SEED_MASK	0xffffUL
+
+/* GMID_EL1 field definitions */
+#define SYS_GMID_EL1_BS_SHIFT	0
+#define SYS_GMID_EL1_BS_SIZE	4
+
+/* TFSR{,E0}_EL1 bit definitions */
+#define SYS_TFSR_EL1_TF0_SHIFT	0
+#define SYS_TFSR_EL1_TF1_SHIFT	1
+#define SYS_TFSR_EL1_TF0	(UL(1) << SYS_TFSR_EL1_TF0_SHIFT)
+#define SYS_TFSR_EL1_TF1	(UK(2) << SYS_TFSR_EL1_TF1_SHIFT)
 
 /* Safe value for MPIDR_EL1: Bit31:RES1, Bit30:U:0, Bit24:MT:0 */
 #define SYS_MPIDR_SAFE_VAL	(BIT(31))
diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
index 7ed9294e2004..0ae569ec7960 100644
--- a/arch/arm64/include/uapi/asm/ptrace.h
+++ b/arch/arm64/include/uapi/asm/ptrace.h
@@ -49,6 +49,7 @@
 #define PSR_SSBS_BIT	0x00001000
 #define PSR_PAN_BIT	0x00400000
 #define PSR_UAO_BIT	0x00800000
+#define PSR_TCO_BIT	0x02000000
 #define PSR_V_BIT	0x10000000
 #define PSR_C_BIT	0x20000000
 #define PSR_Z_BIT	0x40000000
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 6771c399d40c..05dcb4853b8d 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1852,7 +1852,7 @@ void syscall_trace_exit(struct pt_regs *regs)
  * We also reserve IL for the kernel; SS is handled dynamically.
  */
 #define SPSR_EL1_AARCH64_RES0_BITS \
-	(GENMASK_ULL(63, 32) | GENMASK_ULL(27, 25) | GENMASK_ULL(23, 22) | \
+	(GENMASK_ULL(63, 32) | GENMASK_ULL(27, 26) | GENMASK_ULL(23, 22) | \
 	 GENMASK_ULL(20, 13) | GENMASK_ULL(11, 10) | GENMASK_ULL(5, 5))
 #define SPSR_EL1_AARCH32_RES0_BITS \
 	(GENMASK_ULL(63, 32) | GENMASK_ULL(22, 22) | GENMASK_ULL(20, 20))
