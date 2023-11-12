Return-Path: <linux-arch+bounces-151-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A38267E8EA0
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 07:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EBDA280CFC
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 06:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1BD440E;
	Sun, 12 Nov 2023 06:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GW5NoU+I"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9D4440A
	for <linux-arch@vger.kernel.org>; Sun, 12 Nov 2023 06:16:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1329EC433C7;
	Sun, 12 Nov 2023 06:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699769819;
	bh=qenSRo414Gnjw+wPdqdNQw1NfHZPaPnw9rVg2h6yowQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GW5NoU+InHnAHzio8lhZKosW6whn3JdHi4Q/dDOScdYFN7QjZKPUKXXs98dTQuw5h
	 45fW+a6Y1YPCVIa5T3cobF6lQUZPjawcP2Rzn99jvtgGE2vyakm09BCpPlZb+f/Wpq
	 V7/4h6YGJTPwA6oP6a40o0SLfLK1XOhj0GOTCKell0jihsJuECN2NX8iPeKiTVDdC3
	 Cuu39HlcRospB1qSF0c6582N41+vi7tkSLS1EraM9vhN/CiwbKNoyOwJUVU4DgYCVt
	 boYhSj6vK3kQM6iBLcEMiNPReyKIpaZOH1WO1KMsffukC32HjUXV4rWj7RpgPeJVkF
	 64h+bIhWZynBQ==
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
Subject: [RFC PATCH V2 15/38] riscv: s64ilp32: Add asid support
Date: Sun, 12 Nov 2023 01:14:51 -0500
Message-Id: <20231112061514.2306187-16-guoren@kernel.org>
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

The s32ilp32 uses 9 bits as asid_bits because of the xlen=32
limitation of CSR. The xlen of s64ilp32 is 64 bits in width, and
the SATP CSR format is the same for Sv32, Sv39, Sv48, and Sv57. So
this patch makes asid mechanism support s64ilp32 with maximum
num_asids.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/tlbflush.h |  2 +-
 arch/riscv/mm/context.c           | 16 ++++++++++------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index a09196f8de68..6793c3f835a0 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -12,7 +12,7 @@
 #include <asm/errata_list.h>
 
 #ifdef CONFIG_MMU
-extern unsigned long asid_mask;
+extern xlen_t asid_mask;
 
 static inline void local_flush_tlb_all(void)
 {
diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 12e22e7330e7..9eab9aa87dc6 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -20,9 +20,9 @@
 
 DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
 
-static unsigned long asid_bits;
+static xlen_t asid_bits;
 static unsigned long num_asids;
-unsigned long asid_mask;
+xlen_t asid_mask;
 
 static atomic_long_t current_version;
 
@@ -227,14 +227,18 @@ static inline void set_mm(struct mm_struct *prev,
 
 static int __init asids_init(void)
 {
-	unsigned long old;
+	xlen_t old;
 
 	/* Figure-out number of ASID bits in HW */
 	old = csr_read(CSR_SATP);
 	asid_bits = old | (SATP_ASID_MASK << SATP_ASID_SHIFT);
 	csr_write(CSR_SATP, asid_bits);
 	asid_bits = (csr_read(CSR_SATP) >> SATP_ASID_SHIFT)  & SATP_ASID_MASK;
-	asid_bits = fls_long(asid_bits);
+#if __riscv_xlen == 64
+	asid_bits = fls64(asid_bits);
+#else
+	asid_bits = fls(asid_bits);
+#endif
 	csr_write(CSR_SATP, old);
 
 	/*
@@ -267,9 +271,9 @@ static int __init asids_init(void)
 		static_branch_enable(&use_asid_allocator);
 
 		pr_info("ASID allocator using %lu bits (%lu entries)\n",
-			asid_bits, num_asids);
+			(ulong)asid_bits, num_asids);
 	} else {
-		pr_info("ASID allocator disabled (%lu bits)\n", asid_bits);
+		pr_info("ASID allocator disabled (%lu bits)\n", (ulong)asid_bits);
 	}
 
 	return 0;
-- 
2.36.1


