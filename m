Return-Path: <linux-arch+bounces-157-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DC87E8EAA
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 07:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B388F1F20F75
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 06:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1402440E;
	Sun, 12 Nov 2023 06:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVixWE5B"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D84440A
	for <linux-arch@vger.kernel.org>; Sun, 12 Nov 2023 06:17:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F47BC433CC;
	Sun, 12 Nov 2023 06:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699769855;
	bh=McvUmbn7ofR9ECIK1HzZvYjfVLwR/ntK8/66isIijtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cVixWE5BU3e4YiwTPApmxFvfwcQjyW4BCr6TG50g4zBwUphGarDaFwV04CbuzkNp8
	 fcJ0yF57pqfwrYk17nBniNgJxa5HEYSLCYceCYpVlwmBs9t+j9Spx8D1/+UCxRCwZH
	 WXJIGTd4x825tMD5ZBzWbl9DBr7XQEX7SIzW63zoNx0sU9rdFqMSxR2HmlOONiJA/E
	 bFNhgrFJTCHEhWW1sLsfWksh5LGNylmxHUEhA94B/fhLu6Z516D55+XjtOpZ1t0rru
	 EEqGkJ+xcrIaxrsLSz4Q6jxSDw6D/R6mP+p/Ftn3C/cHP9pQd8XP9GFq1R/+IeC50b
	 gWTZeAfPCLuhw==
From: guoren@kernel.org
To: arnd@arndb.de,
	guoren@kernel.org,
	palmer@rivosinc.com,
	tglx@linutronix.de,
	conor.dooley@microchip.com,
	heiko@sntech.de,
	apatel@ventanamicro.com,
	atishp@atishpatra.org,
	bjorn@kernel.org,
	paul.walmsley@sifive.com,
	anup@brainfault.org,
	jiawei@iscas.ac.cn,
	liweiwei@iscas.ac.cn,
	wefu@redhat.com,
	U2FsdGVkX1@gmail.com,
	wangjunqiang@iscas.ac.cn,
	kito.cheng@sifive.com,
	andy.chiu@sifive.com,
	vincent.chen@sifive.com,
	greentime.hu@sifive.com,
	wuwei2016@iscas.ac.cn,
	jrtc27@jrtc27.com,
	luto@kernel.org,
	fweimer@redhat.com,
	catalin.marinas@arm.com,
	hjl.tools@gmail.com
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Guo Ren <guoren@linux.alibaba.com>
Subject: [RFC PATCH V2 21/38] riscv: s64ilp32: Add MMU_SV32 mode support
Date: Sun, 12 Nov 2023 01:14:57 -0500
Message-Id: <20231112061514.2306187-22-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20231112061514.2306187-1-guoren@kernel.org>
References: <20231112061514.2306187-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guo Ren <guoren@linux.alibaba.com>

This needs to add Sv32 mode in the SATP CSR of RV64 ISA, a novel
extension of 64-bit processors' MMU. It could save a bit of page
table footprint and improve the page table walk performance:

s64ilp32 with Sv39:
PageTables:          136 kB

s64ilp32 with Sv32:
PageTables:           60 kB

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/Kconfig           | 11 ++++++++++-
 arch/riscv/Kconfig.errata    |  2 +-
 arch/riscv/include/asm/csr.h |  1 +
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 5a3eb5e7d67a..1d3a236d2c45 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -481,7 +481,7 @@ config RISCV_ISA_SVNAPOT
 
 config RISCV_ISA_SVPBMT
 	bool "Svpbmt extension support for supervisor mode page-based memory types"
-	depends on 64BIT && MMU
+	depends on !MMU_SV32 && MMU
 	depends on RISCV_ALTERNATIVE
 	default y
 	help
@@ -638,6 +638,15 @@ config THREAD_SIZE_ORDER
 	  Specify the Pages of thread stack size (from 4KB to 64KB), which also
 	  affects irq stack size, which is equal to thread stack size.
 
+config MMU_SV32
+	bool "MMU Sv32"
+	depends on 32BIT && MMU
+	help
+	  ARCH_RV32I only supports MMU Sv32 mode, but ARCH_RV64ILP32 supports
+	  MMU Sv39 & Sv32 (MMU Sv32 is optional for RV64 hardware).
+
+	  If unsure, say N.
+
 endmenu # "Platform type"
 
 menu "Kernel features"
diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
index 0c8f4652cd82..1aa85a427ff3 100644
--- a/arch/riscv/Kconfig.errata
+++ b/arch/riscv/Kconfig.errata
@@ -44,7 +44,7 @@ config ERRATA_THEAD
 
 config ERRATA_THEAD_PBMT
 	bool "Apply T-Head memory type errata"
-	depends on ERRATA_THEAD && 64BIT && MMU
+	depends on ERRATA_THEAD && !MMU_SV32 && MMU
 	select RISCV_ALTERNATIVE_EARLY
 	default y
 	help
diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 03acdedc100d..aa78c5f20d75 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -65,6 +65,7 @@
 #define SATP_ASID_MASK	_AC(0x1FF, UXL)
 #else
 #define SATP_PPN	_AC(0x00000FFFFFFFFFFF, UXL)
+#define SATP_MODE_32	_AC(0x1000000000000000, UXL)
 #define SATP_MODE_39	_AC(0x8000000000000000, UXL)
 #define SATP_MODE_48	_AC(0x9000000000000000, UXL)
 #define SATP_MODE_57	_AC(0xa000000000000000, UXL)
-- 
2.36.1


