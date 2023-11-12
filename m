Return-Path: <linux-arch+bounces-148-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A35247E8E99
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 07:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F7E8280CF0
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 06:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2845440E;
	Sun, 12 Nov 2023 06:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZw4FPl2"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1049440A
	for <linux-arch@vger.kernel.org>; Sun, 12 Nov 2023 06:16:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32147C433D9;
	Sun, 12 Nov 2023 06:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699769800;
	bh=bKheZRHS9yncX/iADam3fCVUrHEXBhjqFo5pnoPNSGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uZw4FPl2DJ3Wy1j2ZEwoepxbHE6DvDx5D2CMzMcLDv7WUAb1mopfDPG2mTccFGbDZ
	 nPjC2Fr4vIJQHXstErsxJ19YJcQy9J7eqHC7RmE26UZEn5b4VpUvB+m0sPE83Gsot/
	 6rRsUnqbsvfyGrFwrGTER0NPbJMxhuDefiiQ7rdfA03S14dKLQ7qK1ILPU/ZiBdoBy
	 zNuIHRcvaXsIu7tV9NsTyPOxEl7LBd6tFmICqxa+M5dGBTqiErlIRs7OHBijIT7fH8
	 IILxwqB74RlTBAQMJDDnmDZmQa/KRgHjjFZZiBwaCWzl3dmvapPV6WWEfJSituLY9v
	 bU4bVdgMuMuyg==
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
Subject: [RFC PATCH V2 12/38] riscv: s64ilp32: Unify ULL & UL into UXL in csr
Date: Sun, 12 Nov 2023 01:14:48 -0500
Message-Id: <20231112061514.2306187-13-guoren@kernel.org>
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

The 64ilp32's long size has been different from the csr xlen, so
introduce a new macro of UXL to distinguish UL & ULL.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/csr.h | 166 +++++++++++++++++++----------------
 1 file changed, 89 insertions(+), 77 deletions(-)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 638b7a836acc..051c017e1e5e 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -9,64 +9,76 @@
 #include <asm/asm.h>
 #include <linux/bits.h>
 
+#if __riscv_xlen == 32
+#define UXL		UL
+#define GENMASK_UXL	GENMASK
+#else
+#define UXL		ULL
+#define GENMASK_UXL	GENMASK_ULL
+#endif
+
 /* Status register flags */
-#define SR_SIE		_AC(0x00000002, UL) /* Supervisor Interrupt Enable */
-#define SR_MIE		_AC(0x00000008, UL) /* Machine Interrupt Enable */
-#define SR_SPIE		_AC(0x00000020, UL) /* Previous Supervisor IE */
-#define SR_MPIE		_AC(0x00000080, UL) /* Previous Machine IE */
-#define SR_SPP		_AC(0x00000100, UL) /* Previously Supervisor */
-#define SR_MPP		_AC(0x00001800, UL) /* Previously Machine */
-#define SR_SUM		_AC(0x00040000, UL) /* Supervisor User Memory Access */
-
-#define SR_FS		_AC(0x00006000, UL) /* Floating-point Status */
-#define SR_FS_OFF	_AC(0x00000000, UL)
-#define SR_FS_INITIAL	_AC(0x00002000, UL)
-#define SR_FS_CLEAN	_AC(0x00004000, UL)
-#define SR_FS_DIRTY	_AC(0x00006000, UL)
-
-#define SR_VS		_AC(0x00000600, UL) /* Vector Status */
-#define SR_VS_OFF	_AC(0x00000000, UL)
-#define SR_VS_INITIAL	_AC(0x00000200, UL)
-#define SR_VS_CLEAN	_AC(0x00000400, UL)
-#define SR_VS_DIRTY	_AC(0x00000600, UL)
-
-#define SR_XS		_AC(0x00018000, UL) /* Extension Status */
-#define SR_XS_OFF	_AC(0x00000000, UL)
-#define SR_XS_INITIAL	_AC(0x00008000, UL)
-#define SR_XS_CLEAN	_AC(0x00010000, UL)
-#define SR_XS_DIRTY	_AC(0x00018000, UL)
+#define SR_SIE		_AC(0x00000002, UXL) /* Supervisor Interrupt Enable */
+#define SR_MIE		_AC(0x00000008, UXL) /* Machine Interrupt Enable */
+#define SR_SPIE		_AC(0x00000020, UXL) /* Previous Supervisor IE */
+#define SR_MPIE		_AC(0x00000080, UXL) /* Previous Machine IE */
+#define SR_SPP		_AC(0x00000100, UXL) /* Previously Supervisor */
+#define SR_MPP		_AC(0x00001800, UXL) /* Previously Machine */
+#define SR_SUM		_AC(0x00040000, UXL) /* Supervisor User Memory Access */
+
+#define SR_FS		_AC(0x00006000, UXL) /* Floating-point Status */
+#define SR_FS_OFF	_AC(0x00000000, UXL)
+#define SR_FS_INITIAL	_AC(0x00002000, UXL)
+#define SR_FS_CLEAN	_AC(0x00004000, UXL)
+#define SR_FS_DIRTY	_AC(0x00006000, UXL)
+
+#define SR_VS		_AC(0x00000600, UXL) /* Vector Status */
+#define SR_VS_OFF	_AC(0x00000000, UXL)
+#define SR_VS_INITIAL	_AC(0x00000200, UXL)
+#define SR_VS_CLEAN	_AC(0x00000400, UXL)
+#define SR_VS_DIRTY	_AC(0x00000600, UXL)
+
+#define SR_XS		_AC(0x00018000, UXL) /* Extension Status */
+#define SR_XS_OFF	_AC(0x00000000, UXL)
+#define SR_XS_INITIAL	_AC(0x00008000, UXL)
+#define SR_XS_CLEAN	_AC(0x00010000, UXL)
+#define SR_XS_DIRTY	_AC(0x00018000, UXL)
 
 #define SR_FS_VS	(SR_FS | SR_VS) /* Vector and Floating-Point Unit */
 
-#ifndef CONFIG_64BIT
-#define SR_SD		_AC(0x80000000, UL) /* FS/VS/XS dirty */
+#if __riscv_xlen == 32
+#define SR_SD		_AC(0x80000000, UXL) /* FS/VS/XS dirty */
 #else
-#define SR_SD		_AC(0x8000000000000000, UL) /* FS/VS/XS dirty */
+#define SR_SD		_AC(0x8000000000000000, UXL) /* FS/VS/XS dirty */
 #endif
 
-#define SR_UXL		_AC(0x300000000, UL) /* XLEN mask for U-mode */
-#define SR_UXL_32	_AC(0x100000000, UL) /* XLEN = 32 for U-mode */
-#define SR_UXL_64	_AC(0x200000000, UL) /* XLEN = 64 for U-mode */
+#define SR_UXL		_AC(0x300000000, UXL) /* XLEN mask for U-mode */
+#define SR_UXL_32	_AC(0x100000000, UXL) /* XLEN = 32 for U-mode */
+#define SR_UXL_64	_AC(0x200000000, UXL) /* XLEN = 64 for U-mode */
 
 /* SATP flags */
-#ifndef CONFIG_64BIT
-#define SATP_PPN	_AC(0x003FFFFF, UL)
-#define SATP_MODE_32	_AC(0x80000000, UL)
+#if __riscv_xlen == 32
+#define SATP_PPN	_AC(0x003FFFFF, UXL)
+#define SATP_MODE_32	_AC(0x80000000, UXL)
 #define SATP_ASID_BITS	9
 #define SATP_ASID_SHIFT	22
-#define SATP_ASID_MASK	_AC(0x1FF, UL)
+#define SATP_ASID_MASK	_AC(0x1FF, UXL)
 #else
-#define SATP_PPN	_AC(0x00000FFFFFFFFFFF, UL)
-#define SATP_MODE_39	_AC(0x8000000000000000, UL)
-#define SATP_MODE_48	_AC(0x9000000000000000, UL)
-#define SATP_MODE_57	_AC(0xa000000000000000, UL)
+#define SATP_PPN	_AC(0x00000FFFFFFFFFFF, UXL)
+#define SATP_MODE_39	_AC(0x8000000000000000, UXL)
+#define SATP_MODE_48	_AC(0x9000000000000000, UXL)
+#define SATP_MODE_57	_AC(0xa000000000000000, UXL)
 #define SATP_ASID_BITS	16
 #define SATP_ASID_SHIFT	44
-#define SATP_ASID_MASK	_AC(0xFFFF, UL)
+#define SATP_ASID_MASK	_AC(0xFFFF, UXL)
 #endif
 
 /* Exception cause high bit - is an interrupt if set */
-#define CAUSE_IRQ_FLAG		(_AC(1, UL) << (__riscv_xlen - 1))
+#if __riscv_xlen == 32
+#define CAUSE_IRQ_FLAG		(_AC(1, UXL) << (__riscv_xlen - 1))
+#else
+#define CAUSE_IRQ_FLAG		(_AC(1, UXL) << (__riscv_xlen - 1))
+#endif
 
 /* Interrupt causes (minus the high bit) */
 #define IRQ_S_SOFT		1
@@ -81,7 +93,7 @@
 #define IRQ_S_GEXT		12
 #define IRQ_PMU_OVF		13
 #define IRQ_LOCAL_MAX		(IRQ_PMU_OVF + 1)
-#define IRQ_LOCAL_MASK		GENMASK((IRQ_LOCAL_MAX - 1), 0)
+#define IRQ_LOCAL_MASK		GENMASK_UXL((IRQ_LOCAL_MAX - 1), 0)
 
 /* Exception causes */
 #define EXC_INST_MISALIGNED	0
@@ -114,41 +126,41 @@
 #define PMP_L			0x80
 
 /* HSTATUS flags */
-#ifdef CONFIG_64BIT
-#define HSTATUS_VSXL		_AC(0x300000000, UL)
+#if __riscv_xlen == 64
+#define HSTATUS_VSXL		_AC(0x300000000, UXL)
 #define HSTATUS_VSXL_SHIFT	32
 #endif
-#define HSTATUS_VTSR		_AC(0x00400000, UL)
-#define HSTATUS_VTW		_AC(0x00200000, UL)
-#define HSTATUS_VTVM		_AC(0x00100000, UL)
-#define HSTATUS_VGEIN		_AC(0x0003f000, UL)
+#define HSTATUS_VTSR		_AC(0x00400000, UXL)
+#define HSTATUS_VTW		_AC(0x00200000, UXL)
+#define HSTATUS_VTVM		_AC(0x00100000, UXL)
+#define HSTATUS_VGEIN		_AC(0x0003f000, UXL)
 #define HSTATUS_VGEIN_SHIFT	12
-#define HSTATUS_HU		_AC(0x00000200, UL)
-#define HSTATUS_SPVP		_AC(0x00000100, UL)
-#define HSTATUS_SPV		_AC(0x00000080, UL)
-#define HSTATUS_GVA		_AC(0x00000040, UL)
-#define HSTATUS_VSBE		_AC(0x00000020, UL)
+#define HSTATUS_HU		_AC(0x00000200, UXL)
+#define HSTATUS_SPVP		_AC(0x00000100, UXL)
+#define HSTATUS_SPV		_AC(0x00000080, UXL)
+#define HSTATUS_GVA		_AC(0x00000040, UXL)
+#define HSTATUS_VSBE		_AC(0x00000020, UXL)
 
 /* HGATP flags */
-#define HGATP_MODE_OFF		_AC(0, UL)
-#define HGATP_MODE_SV32X4	_AC(1, UL)
-#define HGATP_MODE_SV39X4	_AC(8, UL)
-#define HGATP_MODE_SV48X4	_AC(9, UL)
-#define HGATP_MODE_SV57X4	_AC(10, UL)
+#define HGATP_MODE_OFF		_AC(0, UXL)
+#define HGATP_MODE_SV32X4	_AC(1, UXL)
+#define HGATP_MODE_SV39X4	_AC(8, UXL)
+#define HGATP_MODE_SV48X4	_AC(9, UXL)
+#define HGATP_MODE_SV57X4	_AC(10, UXL)
 
 #define HGATP32_MODE_SHIFT	31
 #define HGATP32_VMID_SHIFT	22
-#define HGATP32_VMID		GENMASK(28, 22)
-#define HGATP32_PPN		GENMASK(21, 0)
+#define HGATP32_VMID		GENMASK_UXL(28, 22)
+#define HGATP32_PPN		GENMASK_UXL(21, 0)
 
 #define HGATP64_MODE_SHIFT	60
 #define HGATP64_VMID_SHIFT	44
-#define HGATP64_VMID		GENMASK(57, 44)
-#define HGATP64_PPN		GENMASK(43, 0)
+#define HGATP64_VMID		GENMASK_UXL(57, 44)
+#define HGATP64_PPN		GENMASK_UXL(43, 0)
 
 #define HGATP_PAGE_SHIFT	12
 
-#ifdef CONFIG_64BIT
+#if __riscv_xlen == 64
 #define HGATP_PPN		HGATP64_PPN
 #define HGATP_VMID_SHIFT	HGATP64_VMID_SHIFT
 #define HGATP_VMID		HGATP64_VMID
@@ -162,30 +174,30 @@
 
 /* VSIP & HVIP relation */
 #define VSIP_TO_HVIP_SHIFT	(IRQ_VS_SOFT - IRQ_S_SOFT)
-#define VSIP_VALID_MASK		((_AC(1, UL) << IRQ_S_SOFT) | \
-				 (_AC(1, UL) << IRQ_S_TIMER) | \
-				 (_AC(1, UL) << IRQ_S_EXT))
+#define VSIP_VALID_MASK		((_AC(1, UXL) << IRQ_S_SOFT) | \
+				 (_AC(1, UXL) << IRQ_S_TIMER) | \
+				 (_AC(1, UXL) << IRQ_S_EXT))
 
 /* AIA CSR bits */
 #define TOPI_IID_SHIFT		16
-#define TOPI_IID_MASK		GENMASK(11, 0)
-#define TOPI_IPRIO_MASK		GENMASK(7, 0)
+#define TOPI_IID_MASK		GENMASK_UXL(11, 0)
+#define TOPI_IPRIO_MASK		GENMASK_UXL(7, 0)
 #define TOPI_IPRIO_BITS		8
 
 #define TOPEI_ID_SHIFT		16
-#define TOPEI_ID_MASK		GENMASK(10, 0)
-#define TOPEI_PRIO_MASK		GENMASK(10, 0)
+#define TOPEI_ID_MASK		GENMASK_UXL(10, 0)
+#define TOPEI_PRIO_MASK		GENMASK_UXL(10, 0)
 
 #define ISELECT_IPRIO0		0x30
 #define ISELECT_IPRIO15		0x3f
-#define ISELECT_MASK		GENMASK(8, 0)
+#define ISELECT_MASK		GENMASK_UXL(8, 0)
 
 #define HVICTL_VTI		BIT(30)
-#define HVICTL_IID		GENMASK(27, 16)
+#define HVICTL_IID		GENMASK_UXL(27, 16)
 #define HVICTL_IID_SHIFT	16
 #define HVICTL_DPR		BIT(9)
 #define HVICTL_IPRIOM		BIT(8)
-#define HVICTL_IPRIO		GENMASK(7, 0)
+#define HVICTL_IPRIO		GENMASK_UXL(7, 0)
 
 /* xENVCFG flags */
 #define ENVCFG_STCE			(_AC(1, ULL) << 63)
@@ -438,14 +450,14 @@
 # define RV_IRQ_TIMER	IRQ_S_TIMER
 # define RV_IRQ_EXT		IRQ_S_EXT
 # define RV_IRQ_PMU	IRQ_PMU_OVF
-# define SIP_LCOFIP     (_AC(0x1, UL) << IRQ_PMU_OVF)
+# define SIP_LCOFIP     (_AC(0x1, UXL) << IRQ_PMU_OVF)
 
 #endif /* !CONFIG_RISCV_M_MODE */
 
 /* IE/IP (Supervisor/Machine Interrupt Enable/Pending) flags */
-#define IE_SIE		(_AC(0x1, UL) << RV_IRQ_SOFT)
-#define IE_TIE		(_AC(0x1, UL) << RV_IRQ_TIMER)
-#define IE_EIE		(_AC(0x1, UL) << RV_IRQ_EXT)
+#define IE_SIE		(_AC(0x1, UXL) << RV_IRQ_SOFT)
+#define IE_TIE		(_AC(0x1, UXL) << RV_IRQ_TIMER)
+#define IE_EIE		(_AC(0x1, UXL) << RV_IRQ_EXT)
 
 #ifndef __ASSEMBLY__
 
-- 
2.36.1


