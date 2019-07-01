Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D33FB3A6A8
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2019 17:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbfFIPkW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 Jun 2019 11:40:22 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:44129 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbfFIPkW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Jun 2019 11:40:22 -0400
Received: from grover.flets-west.jp (softbank126125154139.bbtec.net [126.125.154.139]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x59Fdj4k004189;
        Mon, 10 Jun 2019 00:39:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x59Fdj4k004189
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1560094786;
        bh=sepyG/8hIxhxQ9QmsdIoCmB/ivnSjIcnDWqmCNOKakA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nigX/i8pIjUH/361+haohot9jBjBpNqL7RiRRkNnqmOsSwE+fBCYtVsa0T4JJpxAD
         R0DhFJAbW5JAdbjECFFEX5VoJEMv1oX0FjEneR2G5/HLNUDC3jcN34MaGNy2kmsoim
         elvIuXuwuD2TETx0T24QOgLWLFJ+frN57H+wFCNy93GSiwT1NLsXY8iGG9IrrhHfOP
         dm4C3kOGni6Favj6oitCr0i5PtAoeSEkBPrtC98w1MpZvZOlugvqm2v2kqw998xcgw
         SU0iYhusnx9hh8H0z/6I8FeDO2xYfyVQkgpaLQYXje2P6z4699R6vW70UO+cBWR6Qj
         1FSj0v372vkWA==
X-Nifty-SrcIP: [126.125.154.139]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-s390@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 2/2] arch: replace _BITUL() in kernel-space headers with BIT()
Date:   Mon, 10 Jun 2019 00:39:41 +0900
Message-Id: <20190609153941.17249-2-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190609153941.17249-1-yamada.masahiro@socionext.com>
References: <20190609153941.17249-1-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Now that BIT() can be used from assembly code, we can safely replace
_BITUL() with equivalent BIT().

UAPI headers are still required to use _BITUL(), but there is no more
reason to use it in kernel headers. BIT() is shorter.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arc/include/asm/pgtable.h          |  8 +--
 arch/arc/plat-eznps/include/plat/ctop.h | 15 ++---
 arch/arm64/include/asm/sysreg.h         | 82 ++++++++++++-------------
 arch/s390/include/asm/ctl_reg.h         | 42 ++++++-------
 arch/s390/include/asm/nmi.h             | 20 +++---
 arch/s390/include/asm/processor.h       | 20 +++---
 arch/s390/include/asm/ptrace.h          | 10 +--
 arch/s390/include/asm/setup.h           | 40 ++++++------
 arch/s390/include/asm/thread_info.h     | 34 +++++-----
 9 files changed, 136 insertions(+), 135 deletions(-)

diff --git a/arch/arc/include/asm/pgtable.h b/arch/arc/include/asm/pgtable.h
index cf4be70d5892..8e729649d1b1 100644
--- a/arch/arc/include/asm/pgtable.h
+++ b/arch/arc/include/asm/pgtable.h
@@ -35,7 +35,7 @@
 #ifndef _ASM_ARC_PGTABLE_H
 #define _ASM_ARC_PGTABLE_H
 
-#include <linux/const.h>
+#include <linux/bits.h>
 #define __ARCH_USE_5LEVEL_HACK
 #include <asm-generic/pgtable-nopmd.h>
 #include <asm/page.h>
@@ -218,11 +218,11 @@
 #define BITS_FOR_PTE	(PGDIR_SHIFT - PAGE_SHIFT)
 #define BITS_FOR_PGD	(32 - PGDIR_SHIFT)
 
-#define PGDIR_SIZE	_BITUL(PGDIR_SHIFT)	/* vaddr span, not PDG sz */
+#define PGDIR_SIZE	BIT(PGDIR_SHIFT)	/* vaddr span, not PDG sz */
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
-#define	PTRS_PER_PTE	_BITUL(BITS_FOR_PTE)
-#define	PTRS_PER_PGD	_BITUL(BITS_FOR_PGD)
+#define	PTRS_PER_PTE	BIT(BITS_FOR_PTE)
+#define	PTRS_PER_PGD	BIT(BITS_FOR_PGD)
 
 /*
  * Number of entries a user land program use.
diff --git a/arch/arc/plat-eznps/include/plat/ctop.h b/arch/arc/plat-eznps/include/plat/ctop.h
index 309a994f64f0..a4a61531c7fb 100644
--- a/arch/arc/plat-eznps/include/plat/ctop.h
+++ b/arch/arc/plat-eznps/include/plat/ctop.h
@@ -10,6 +10,7 @@
 #error "Incorrect ctop.h include"
 #endif
 
+#include <linux/bits.h>
 #include <linux/types.h>
 #include <soc/nps/common.h>
 
@@ -51,19 +52,19 @@
 #define CTOP_INST_AXOR_DI_R2_R2_R3		0x4A664C06
 
 /* Do not use D$ for address in 2G-3G */
-#define HW_COMPLY_KRN_NOT_D_CACHED		_BITUL(28)
+#define HW_COMPLY_KRN_NOT_D_CACHED		BIT(28)
 
 #define NPS_MSU_EN_CFG				0x80
 #define NPS_CRG_BLKID				0x480
-#define NPS_CRG_SYNC_BIT			_BITUL(0)
+#define NPS_CRG_SYNC_BIT			BIT(0)
 #define NPS_GIM_BLKID				0x5C0
 
 /* GIM registers and fields*/
-#define NPS_GIM_UART_LINE			_BITUL(7)
-#define NPS_GIM_DBG_LAN_EAST_TX_DONE_LINE	_BITUL(10)
-#define NPS_GIM_DBG_LAN_EAST_RX_RDY_LINE	_BITUL(11)
-#define NPS_GIM_DBG_LAN_WEST_TX_DONE_LINE	_BITUL(25)
-#define NPS_GIM_DBG_LAN_WEST_RX_RDY_LINE	_BITUL(26)
+#define NPS_GIM_UART_LINE			BIT(7)
+#define NPS_GIM_DBG_LAN_EAST_TX_DONE_LINE	BIT(10)
+#define NPS_GIM_DBG_LAN_EAST_RX_RDY_LINE	BIT(11)
+#define NPS_GIM_DBG_LAN_WEST_TX_DONE_LINE	BIT(25)
+#define NPS_GIM_DBG_LAN_WEST_RX_RDY_LINE	BIT(26)
 
 #ifndef __ASSEMBLY__
 /* Functional registers definition */
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 902d75b60914..3bcd8294acc0 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -20,7 +20,7 @@
 #ifndef __ASM_SYSREG_H
 #define __ASM_SYSREG_H
 
-#include <linux/const.h>
+#include <linux/bits.h>
 #include <linux/stringify.h>
 
 /*
@@ -458,31 +458,31 @@
 #define SYS_ZCR_EL12			sys_reg(3, 5, 1, 2, 0)
 
 /* Common SCTLR_ELx flags. */
-#define SCTLR_ELx_DSSBS	(_BITUL(44))
-#define SCTLR_ELx_ENIA	(_BITUL(31))
-#define SCTLR_ELx_ENIB	(_BITUL(30))
-#define SCTLR_ELx_ENDA	(_BITUL(27))
-#define SCTLR_ELx_EE    (_BITUL(25))
-#define SCTLR_ELx_IESB	(_BITUL(21))
-#define SCTLR_ELx_WXN	(_BITUL(19))
-#define SCTLR_ELx_ENDB	(_BITUL(13))
-#define SCTLR_ELx_I	(_BITUL(12))
-#define SCTLR_ELx_SA	(_BITUL(3))
-#define SCTLR_ELx_C	(_BITUL(2))
-#define SCTLR_ELx_A	(_BITUL(1))
-#define SCTLR_ELx_M	(_BITUL(0))
+#define SCTLR_ELx_DSSBS	(BIT(44))
+#define SCTLR_ELx_ENIA	(BIT(31))
+#define SCTLR_ELx_ENIB	(BIT(30))
+#define SCTLR_ELx_ENDA	(BIT(27))
+#define SCTLR_ELx_EE    (BIT(25))
+#define SCTLR_ELx_IESB	(BIT(21))
+#define SCTLR_ELx_WXN	(BIT(19))
+#define SCTLR_ELx_ENDB	(BIT(13))
+#define SCTLR_ELx_I	(BIT(12))
+#define SCTLR_ELx_SA	(BIT(3))
+#define SCTLR_ELx_C	(BIT(2))
+#define SCTLR_ELx_A	(BIT(1))
+#define SCTLR_ELx_M	(BIT(0))
 
 #define SCTLR_ELx_FLAGS	(SCTLR_ELx_M  | SCTLR_ELx_A | SCTLR_ELx_C | \
 			 SCTLR_ELx_SA | SCTLR_ELx_I | SCTLR_ELx_IESB)
 
 /* SCTLR_EL2 specific flags. */
-#define SCTLR_EL2_RES1	((_BITUL(4))  | (_BITUL(5))  | (_BITUL(11)) | (_BITUL(16)) | \
-			 (_BITUL(18)) | (_BITUL(22)) | (_BITUL(23)) | (_BITUL(28)) | \
-			 (_BITUL(29)))
-#define SCTLR_EL2_RES0	((_BITUL(6))  | (_BITUL(7))  | (_BITUL(8))  | (_BITUL(9))  | \
-			 (_BITUL(10)) | (_BITUL(13)) | (_BITUL(14)) | (_BITUL(15)) | \
-			 (_BITUL(17)) | (_BITUL(20)) | (_BITUL(24)) | (_BITUL(26)) | \
-			 (_BITUL(27)) | (_BITUL(30)) | (_BITUL(31)) | \
+#define SCTLR_EL2_RES1	((BIT(4))  | (BIT(5))  | (BIT(11)) | (BIT(16)) | \
+			 (BIT(18)) | (BIT(22)) | (BIT(23)) | (BIT(28)) | \
+			 (BIT(29)))
+#define SCTLR_EL2_RES0	((BIT(6))  | (BIT(7))  | (BIT(8))  | (BIT(9))  | \
+			 (BIT(10)) | (BIT(13)) | (BIT(14)) | (BIT(15)) | \
+			 (BIT(17)) | (BIT(20)) | (BIT(24)) | (BIT(26)) | \
+			 (BIT(27)) | (BIT(30)) | (BIT(31)) | \
 			 (0xffffefffUL << 32))
 
 #ifdef CONFIG_CPU_BIG_ENDIAN
@@ -504,23 +504,23 @@
 #endif
 
 /* SCTLR_EL1 specific flags. */
-#define SCTLR_EL1_UCI		(_BITUL(26))
-#define SCTLR_EL1_E0E		(_BITUL(24))
-#define SCTLR_EL1_SPAN		(_BITUL(23))
-#define SCTLR_EL1_NTWE		(_BITUL(18))
-#define SCTLR_EL1_NTWI		(_BITUL(16))
-#define SCTLR_EL1_UCT		(_BITUL(15))
-#define SCTLR_EL1_DZE		(_BITUL(14))
-#define SCTLR_EL1_UMA		(_BITUL(9))
-#define SCTLR_EL1_SED		(_BITUL(8))
-#define SCTLR_EL1_ITD		(_BITUL(7))
-#define SCTLR_EL1_CP15BEN	(_BITUL(5))
-#define SCTLR_EL1_SA0		(_BITUL(4))
-
-#define SCTLR_EL1_RES1	((_BITUL(11)) | (_BITUL(20)) | (_BITUL(22)) | (_BITUL(28)) | \
-			 (_BITUL(29)))
-#define SCTLR_EL1_RES0  ((_BITUL(6))  | (_BITUL(10)) | (_BITUL(13)) | (_BITUL(17)) | \
-			 (_BITUL(27)) | (_BITUL(30)) | (_BITUL(31)) | \
+#define SCTLR_EL1_UCI		(BIT(26))
+#define SCTLR_EL1_E0E		(BIT(24))
+#define SCTLR_EL1_SPAN		(BIT(23))
+#define SCTLR_EL1_NTWE		(BIT(18))
+#define SCTLR_EL1_NTWI		(BIT(16))
+#define SCTLR_EL1_UCT		(BIT(15))
+#define SCTLR_EL1_DZE		(BIT(14))
+#define SCTLR_EL1_UMA		(BIT(9))
+#define SCTLR_EL1_SED		(BIT(8))
+#define SCTLR_EL1_ITD		(BIT(7))
+#define SCTLR_EL1_CP15BEN	(BIT(5))
+#define SCTLR_EL1_SA0		(BIT(4))
+
+#define SCTLR_EL1_RES1	((BIT(11)) | (BIT(20)) | (BIT(22)) | (BIT(28)) | \
+			 (BIT(29)))
+#define SCTLR_EL1_RES0  ((BIT(6))  | (BIT(10)) | (BIT(13)) | (BIT(17)) | \
+			 (BIT(27)) | (BIT(30)) | (BIT(31)) | \
 			 (0xffffefffUL << 32))
 
 #ifdef CONFIG_CPU_BIG_ENDIAN
@@ -735,13 +735,13 @@
 #define ZCR_ELx_LEN_SIZE	9
 #define ZCR_ELx_LEN_MASK	0x1ff
 
-#define CPACR_EL1_ZEN_EL1EN	(_BITUL(16)) /* enable EL1 access */
-#define CPACR_EL1_ZEN_EL0EN	(_BITUL(17)) /* enable EL0 access, if EL1EN set */
+#define CPACR_EL1_ZEN_EL1EN	(BIT(16)) /* enable EL1 access */
+#define CPACR_EL1_ZEN_EL0EN	(BIT(17)) /* enable EL0 access, if EL1EN set */
 #define CPACR_EL1_ZEN		(CPACR_EL1_ZEN_EL1EN | CPACR_EL1_ZEN_EL0EN)
 
 
 /* Safe value for MPIDR_EL1: Bit31:RES1, Bit30:U:0, Bit24:MT:0 */
-#define SYS_MPIDR_SAFE_VAL	(_BITUL(31))
+#define SYS_MPIDR_SAFE_VAL	(BIT(31))
 
 #ifdef __ASSEMBLY__
 
diff --git a/arch/s390/include/asm/ctl_reg.h b/arch/s390/include/asm/ctl_reg.h
index 4600453536c2..a59f33b201f6 100644
--- a/arch/s390/include/asm/ctl_reg.h
+++ b/arch/s390/include/asm/ctl_reg.h
@@ -8,27 +8,27 @@
 #ifndef __ASM_CTL_REG_H
 #define __ASM_CTL_REG_H
 
-#include <linux/const.h>
-
-#define CR0_CLOCK_COMPARATOR_SIGN	_BITUL(63 - 10)
-#define CR0_EMERGENCY_SIGNAL_SUBMASK	_BITUL(63 - 49)
-#define CR0_EXTERNAL_CALL_SUBMASK	_BITUL(63 - 50)
-#define CR0_CLOCK_COMPARATOR_SUBMASK	_BITUL(63 - 52)
-#define CR0_CPU_TIMER_SUBMASK		_BITUL(63 - 53)
-#define CR0_SERVICE_SIGNAL_SUBMASK	_BITUL(63 - 54)
-#define CR0_UNUSED_56			_BITUL(63 - 56)
-#define CR0_INTERRUPT_KEY_SUBMASK	_BITUL(63 - 57)
-#define CR0_MEASUREMENT_ALERT_SUBMASK	_BITUL(63 - 58)
-
-#define CR2_GUARDED_STORAGE		_BITUL(63 - 59)
-
-#define CR14_UNUSED_32			_BITUL(63 - 32)
-#define CR14_UNUSED_33			_BITUL(63 - 33)
-#define CR14_CHANNEL_REPORT_SUBMASK	_BITUL(63 - 35)
-#define CR14_RECOVERY_SUBMASK		_BITUL(63 - 36)
-#define CR14_DEGRADATION_SUBMASK	_BITUL(63 - 37)
-#define CR14_EXTERNAL_DAMAGE_SUBMASK	_BITUL(63 - 38)
-#define CR14_WARNING_SUBMASK		_BITUL(63 - 39)
+#include <linux/bits.h>
+
+#define CR0_CLOCK_COMPARATOR_SIGN	BIT(63 - 10)
+#define CR0_EMERGENCY_SIGNAL_SUBMASK	BIT(63 - 49)
+#define CR0_EXTERNAL_CALL_SUBMASK	BIT(63 - 50)
+#define CR0_CLOCK_COMPARATOR_SUBMASK	BIT(63 - 52)
+#define CR0_CPU_TIMER_SUBMASK		BIT(63 - 53)
+#define CR0_SERVICE_SIGNAL_SUBMASK	BIT(63 - 54)
+#define CR0_UNUSED_56			BIT(63 - 56)
+#define CR0_INTERRUPT_KEY_SUBMASK	BIT(63 - 57)
+#define CR0_MEASUREMENT_ALERT_SUBMASK	BIT(63 - 58)
+
+#define CR2_GUARDED_STORAGE		BIT(63 - 59)
+
+#define CR14_UNUSED_32			BIT(63 - 32)
+#define CR14_UNUSED_33			BIT(63 - 33)
+#define CR14_CHANNEL_REPORT_SUBMASK	BIT(63 - 35)
+#define CR14_RECOVERY_SUBMASK		BIT(63 - 36)
+#define CR14_DEGRADATION_SUBMASK	BIT(63 - 37)
+#define CR14_EXTERNAL_DAMAGE_SUBMASK	BIT(63 - 38)
+#define CR14_WARNING_SUBMASK		BIT(63 - 39)
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/s390/include/asm/nmi.h b/arch/s390/include/asm/nmi.h
index 1e5dc4537bf2..b160da8fa14b 100644
--- a/arch/s390/include/asm/nmi.h
+++ b/arch/s390/include/asm/nmi.h
@@ -12,7 +12,7 @@
 #ifndef _ASM_S390_NMI_H
 #define _ASM_S390_NMI_H
 
-#include <linux/const.h>
+#include <linux/bits.h>
 #include <linux/types.h>
 
 #define MCIC_SUBCLASS_MASK	(1ULL<<63 | 1ULL<<62 | 1ULL<<61 | \
@@ -20,15 +20,15 @@
 				1ULL<<55 | 1ULL<<54 | 1ULL<<53 | \
 				1ULL<<52 | 1ULL<<47 | 1ULL<<46 | \
 				1ULL<<45 | 1ULL<<44)
-#define MCCK_CODE_SYSTEM_DAMAGE		_BITUL(63)
-#define MCCK_CODE_EXT_DAMAGE		_BITUL(63 - 5)
-#define MCCK_CODE_CP			_BITUL(63 - 9)
-#define MCCK_CODE_CPU_TIMER_VALID	_BITUL(63 - 46)
-#define MCCK_CODE_PSW_MWP_VALID		_BITUL(63 - 20)
-#define MCCK_CODE_PSW_IA_VALID		_BITUL(63 - 23)
-#define MCCK_CODE_CR_VALID		_BITUL(63 - 29)
-#define MCCK_CODE_GS_VALID		_BITUL(63 - 36)
-#define MCCK_CODE_FC_VALID		_BITUL(63 - 43)
+#define MCCK_CODE_SYSTEM_DAMAGE		BIT(63)
+#define MCCK_CODE_EXT_DAMAGE		BIT(63 - 5)
+#define MCCK_CODE_CP			BIT(63 - 9)
+#define MCCK_CODE_CPU_TIMER_VALID	BIT(63 - 46)
+#define MCCK_CODE_PSW_MWP_VALID		BIT(63 - 20)
+#define MCCK_CODE_PSW_IA_VALID		BIT(63 - 23)
+#define MCCK_CODE_CR_VALID		BIT(63 - 29)
+#define MCCK_CODE_GS_VALID		BIT(63 - 36)
+#define MCCK_CODE_FC_VALID		BIT(63 - 43)
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index b0fcbc37b637..b69beda08b1c 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -12,7 +12,7 @@
 #ifndef __ASM_S390_PROCESSOR_H
 #define __ASM_S390_PROCESSOR_H
 
-#include <linux/const.h>
+#include <linux/bits.h>
 
 #define CIF_MCCK_PENDING	0	/* machine check handling is pending */
 #define CIF_ASCE_PRIMARY	1	/* primary asce needs fixup / uaccess */
@@ -24,15 +24,15 @@
 #define CIF_MCCK_GUEST		7	/* machine check happening in guest */
 #define CIF_DEDICATED_CPU	8	/* this CPU is dedicated */
 
-#define _CIF_MCCK_PENDING	_BITUL(CIF_MCCK_PENDING)
-#define _CIF_ASCE_PRIMARY	_BITUL(CIF_ASCE_PRIMARY)
-#define _CIF_ASCE_SECONDARY	_BITUL(CIF_ASCE_SECONDARY)
-#define _CIF_NOHZ_DELAY		_BITUL(CIF_NOHZ_DELAY)
-#define _CIF_FPU		_BITUL(CIF_FPU)
-#define _CIF_IGNORE_IRQ		_BITUL(CIF_IGNORE_IRQ)
-#define _CIF_ENABLED_WAIT	_BITUL(CIF_ENABLED_WAIT)
-#define _CIF_MCCK_GUEST		_BITUL(CIF_MCCK_GUEST)
-#define _CIF_DEDICATED_CPU	_BITUL(CIF_DEDICATED_CPU)
+#define _CIF_MCCK_PENDING	BIT(CIF_MCCK_PENDING)
+#define _CIF_ASCE_PRIMARY	BIT(CIF_ASCE_PRIMARY)
+#define _CIF_ASCE_SECONDARY	BIT(CIF_ASCE_SECONDARY)
+#define _CIF_NOHZ_DELAY		BIT(CIF_NOHZ_DELAY)
+#define _CIF_FPU		BIT(CIF_FPU)
+#define _CIF_IGNORE_IRQ		BIT(CIF_IGNORE_IRQ)
+#define _CIF_ENABLED_WAIT	BIT(CIF_ENABLED_WAIT)
+#define _CIF_MCCK_GUEST		BIT(CIF_MCCK_GUEST)
+#define _CIF_DEDICATED_CPU	BIT(CIF_DEDICATED_CPU)
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrace.h
index 6f70d81c40f2..f009a13afe71 100644
--- a/arch/s390/include/asm/ptrace.h
+++ b/arch/s390/include/asm/ptrace.h
@@ -7,7 +7,7 @@
 #ifndef _S390_PTRACE_H
 #define _S390_PTRACE_H
 
-#include <linux/const.h>
+#include <linux/bits.h>
 #include <uapi/asm/ptrace.h>
 
 #define PIF_SYSCALL		0	/* inside a system call */
@@ -15,10 +15,10 @@
 #define PIF_SYSCALL_RESTART	2	/* restart the current system call */
 #define PIF_GUEST_FAULT		3	/* indicates program check in sie64a */
 
-#define _PIF_SYSCALL		_BITUL(PIF_SYSCALL)
-#define _PIF_PER_TRAP		_BITUL(PIF_PER_TRAP)
-#define _PIF_SYSCALL_RESTART	_BITUL(PIF_SYSCALL_RESTART)
-#define _PIF_GUEST_FAULT	_BITUL(PIF_GUEST_FAULT)
+#define _PIF_SYSCALL		BIT(PIF_SYSCALL)
+#define _PIF_PER_TRAP		BIT(PIF_PER_TRAP)
+#define _PIF_SYSCALL_RESTART	BIT(PIF_SYSCALL_RESTART)
+#define _PIF_GUEST_FAULT	BIT(PIF_GUEST_FAULT)
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/s390/include/asm/setup.h b/arch/s390/include/asm/setup.h
index 925889d360c1..82deb8fc8319 100644
--- a/arch/s390/include/asm/setup.h
+++ b/arch/s390/include/asm/setup.h
@@ -6,7 +6,7 @@
 #ifndef _ASM_S390_SETUP_H
 #define _ASM_S390_SETUP_H
 
-#include <linux/const.h>
+#include <linux/bits.h>
 #include <uapi/asm/setup.h>
 
 #define EP_OFFSET		0x10008
@@ -21,25 +21,25 @@
  * Machine features detected in early.c
  */
 
-#define MACHINE_FLAG_VM		_BITUL(0)
-#define MACHINE_FLAG_KVM	_BITUL(1)
-#define MACHINE_FLAG_LPAR	_BITUL(2)
-#define MACHINE_FLAG_DIAG9C	_BITUL(3)
-#define MACHINE_FLAG_ESOP	_BITUL(4)
-#define MACHINE_FLAG_IDTE	_BITUL(5)
-#define MACHINE_FLAG_DIAG44	_BITUL(6)
-#define MACHINE_FLAG_EDAT1	_BITUL(7)
-#define MACHINE_FLAG_EDAT2	_BITUL(8)
-#define MACHINE_FLAG_TOPOLOGY	_BITUL(10)
-#define MACHINE_FLAG_TE		_BITUL(11)
-#define MACHINE_FLAG_TLB_LC	_BITUL(12)
-#define MACHINE_FLAG_VX		_BITUL(13)
-#define MACHINE_FLAG_TLB_GUEST	_BITUL(14)
-#define MACHINE_FLAG_NX		_BITUL(15)
-#define MACHINE_FLAG_GS		_BITUL(16)
-#define MACHINE_FLAG_SCC	_BITUL(17)
-
-#define LPP_MAGIC		_BITUL(31)
+#define MACHINE_FLAG_VM		BIT(0)
+#define MACHINE_FLAG_KVM	BIT(1)
+#define MACHINE_FLAG_LPAR	BIT(2)
+#define MACHINE_FLAG_DIAG9C	BIT(3)
+#define MACHINE_FLAG_ESOP	BIT(4)
+#define MACHINE_FLAG_IDTE	BIT(5)
+#define MACHINE_FLAG_DIAG44	BIT(6)
+#define MACHINE_FLAG_EDAT1	BIT(7)
+#define MACHINE_FLAG_EDAT2	BIT(8)
+#define MACHINE_FLAG_TOPOLOGY	BIT(10)
+#define MACHINE_FLAG_TE		BIT(11)
+#define MACHINE_FLAG_TLB_LC	BIT(12)
+#define MACHINE_FLAG_VX		BIT(13)
+#define MACHINE_FLAG_TLB_GUEST	BIT(14)
+#define MACHINE_FLAG_NX		BIT(15)
+#define MACHINE_FLAG_GS		BIT(16)
+#define MACHINE_FLAG_SCC	BIT(17)
+
+#define LPP_MAGIC		BIT(31)
 #define LPP_PID_MASK		_AC(0xffffffff, UL)
 
 /* Offsets to entry points in kernel/head.S  */
diff --git a/arch/s390/include/asm/thread_info.h b/arch/s390/include/asm/thread_info.h
index ce4e17c9aad6..e582fbe59e20 100644
--- a/arch/s390/include/asm/thread_info.h
+++ b/arch/s390/include/asm/thread_info.h
@@ -8,7 +8,7 @@
 #ifndef _ASM_THREAD_INFO_H
 #define _ASM_THREAD_INFO_H
 
-#include <linux/const.h>
+#include <linux/bits.h>
 
 /*
  * General size of kernel stacks
@@ -82,21 +82,21 @@ void arch_setup_new_exec(void);
 #define TIF_SECCOMP		26	/* secure computing */
 #define TIF_SYSCALL_TRACEPOINT	27	/* syscall tracepoint instrumentation */
 
-#define _TIF_NOTIFY_RESUME	_BITUL(TIF_NOTIFY_RESUME)
-#define _TIF_SIGPENDING		_BITUL(TIF_SIGPENDING)
-#define _TIF_NEED_RESCHED	_BITUL(TIF_NEED_RESCHED)
-#define _TIF_UPROBE		_BITUL(TIF_UPROBE)
-#define _TIF_GUARDED_STORAGE	_BITUL(TIF_GUARDED_STORAGE)
-#define _TIF_PATCH_PENDING	_BITUL(TIF_PATCH_PENDING)
-#define _TIF_ISOLATE_BP		_BITUL(TIF_ISOLATE_BP)
-#define _TIF_ISOLATE_BP_GUEST	_BITUL(TIF_ISOLATE_BP_GUEST)
-
-#define _TIF_31BIT		_BITUL(TIF_31BIT)
-#define _TIF_SINGLE_STEP	_BITUL(TIF_SINGLE_STEP)
-
-#define _TIF_SYSCALL_TRACE	_BITUL(TIF_SYSCALL_TRACE)
-#define _TIF_SYSCALL_AUDIT	_BITUL(TIF_SYSCALL_AUDIT)
-#define _TIF_SECCOMP		_BITUL(TIF_SECCOMP)
-#define _TIF_SYSCALL_TRACEPOINT	_BITUL(TIF_SYSCALL_TRACEPOINT)
+#define _TIF_NOTIFY_RESUME	BIT(TIF_NOTIFY_RESUME)
+#define _TIF_SIGPENDING		BIT(TIF_SIGPENDING)
+#define _TIF_NEED_RESCHED	BIT(TIF_NEED_RESCHED)
+#define _TIF_UPROBE		BIT(TIF_UPROBE)
+#define _TIF_GUARDED_STORAGE	BIT(TIF_GUARDED_STORAGE)
+#define _TIF_PATCH_PENDING	BIT(TIF_PATCH_PENDING)
+#define _TIF_ISOLATE_BP		BIT(TIF_ISOLATE_BP)
+#define _TIF_ISOLATE_BP_GUEST	BIT(TIF_ISOLATE_BP_GUEST)
+
+#define _TIF_31BIT		BIT(TIF_31BIT)
+#define _TIF_SINGLE_STEP	BIT(TIF_SINGLE_STEP)
+
+#define _TIF_SYSCALL_TRACE	BIT(TIF_SYSCALL_TRACE)
+#define _TIF_SYSCALL_AUDIT	BIT(TIF_SYSCALL_AUDIT)
+#define _TIF_SECCOMP		BIT(TIF_SECCOMP)
+#define _TIF_SYSCALL_TRACEPOINT	BIT(TIF_SYSCALL_TRACEPOINT)
 
 #endif /* _ASM_THREAD_INFO_H */
-- 
2.17.1

