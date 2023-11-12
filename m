Return-Path: <linux-arch+bounces-153-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D03E7E8EA4
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 07:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0041B2096E
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 06:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E674440E;
	Sun, 12 Nov 2023 06:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBDFivBo"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6273F440A
	for <linux-arch@vger.kernel.org>; Sun, 12 Nov 2023 06:17:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AAE4C433C9;
	Sun, 12 Nov 2023 06:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699769831;
	bh=xvz1rya1E02xCfXGsQlwgCTl+atNWzPl7o+rS0iSLkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fBDFivBo3T7J24ZloTMhISNIG/bND0s7vrrL2C1z8x/tqG8opLe99Kjlqlz3jI79y
	 uhVNHaWLH1ArFXGXJEiub688pP0XTpJCHrrhV2xUf6gEw2MjHITF02A1OGHKPSvyMm
	 gNV7Nk3ktsoNitWRPxry1/3uJKsYM9LO/fesvwLysYBUXJAdctqslxu60+Xi3YOeZG
	 Nz4hNdgyJbdNDW+icuW/5mS5/HQq4rq8O/X2y7OsxXv5Ro6gNIRmAyXqNN58djw1sI
	 PbAF/PpwCCzWVyeqctUo5NQ6CWFpLrSM5VNtrKLDVlU2i4CyPLVAQfVkRd+2tI6xaF
	 ABhUyCTRybIjg==
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
Subject: [RFC PATCH V2 17/38] riscv: s64ilp32: Adjust TASK_SIZE for s64ilp32 kernel
Date: Sun, 12 Nov 2023 01:14:53 -0500
Message-Id: <20231112061514.2306187-18-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20231112061514.2306187-1-guoren@kernel.org>
References: <20231112061514.2306187-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Guo Ren <guoren@linux.alibaba.com>

The RV64ILP32 32-bit Linux kernel uses the same userspace address range
as the 64-bit Linux compat mode, about 2GB. They have no difference from
the hardware view, and all are running ILP32 on a 64-bit ISA. But the
standard 32ilp32 Linux has a slightly bigger userspace address space,
about 2.4GB.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/pgtable.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 75970ee2bda2..e5e7a929949a 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -839,20 +839,25 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
  * "load and store effective addresses, which are 64bits, must have bits
  * 63–48 all equal to bit 47, or else a page-fault exception will occur."
  */
+#define TASK_SIZE_32	(_AC(0x80000000, UL) - PAGE_SIZE)
+
 #ifdef CONFIG_64BIT
 #define TASK_SIZE_64	(PGDIR_SIZE * PTRS_PER_PGD / 2)
 #define TASK_SIZE_MIN	(PGDIR_SIZE_L3 * PTRS_PER_PGD / 2)
 
 #ifdef CONFIG_COMPAT
-#define TASK_SIZE_32	(_AC(0x80000000, UL) - PAGE_SIZE)
 #define TASK_SIZE	(test_thread_flag(TIF_32BIT) ? \
 			 TASK_SIZE_32 : TASK_SIZE_64)
 #else
 #define TASK_SIZE	TASK_SIZE_64
 #endif
 
+#else
+#ifdef CONFIG_ARCH_RV64ILP32
+#define TASK_SIZE	TASK_SIZE_32
 #else
 #define TASK_SIZE	FIXADDR_START
+#endif
 #define TASK_SIZE_MIN	TASK_SIZE
 #endif
 
-- 
2.36.1


