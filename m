Return-Path: <linux-arch+bounces-159-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C13F67E8EAD
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 07:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ADD4280CED
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 06:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304B8440E;
	Sun, 12 Nov 2023 06:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3mYKvvV"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14999440A
	for <linux-arch@vger.kernel.org>; Sun, 12 Nov 2023 06:17:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A01C433D9;
	Sun, 12 Nov 2023 06:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699769867;
	bh=DJd0JPnD4tdXPL2F5/pVMn7+3pGHc/BdFV5e1StNJ0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u3mYKvvVcCXgok8Svx8v4kF7mGHdEIkfptFpvN3AkwLdtO3ntnvI1tFetv8IzkGud
	 QsqcEzsuLOpPvYOMq//OcMmUt1bX8nDoBgAPmTAQ3RWqjuHAZ6Dde0eSs6C2/y+VxI
	 PDCLedfjiu12dGTFD/L2dYd544DJHkuziYtfgdvNe+TXgj8RPvV5f8jK6eJT4fAhxf
	 aqzzh/LVK8k8ktL94w2cpBMh0gvgCZ0CJTHTeQQHWNyUaWzvHLESSAINDdDCvDxL1V
	 uaLDgFyGRBaolDP18QX6VtyYB/IDSyturZGmHAbMRjanSPG5ujOcv/4DT0ZxwCN0zU
	 kKb1zgIB6qstA==
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
Subject: [RFC PATCH V2 23/38] riscv: s64ilp32: Enable native atomic64
Date: Sun, 12 Nov 2023 01:14:59 -0500
Message-Id: <20231112061514.2306187-24-guoren@kernel.org>
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

The traditional rv32 Linux (s32ilp32) uses a generic version of the
lib/atomic64.c, which are inaccurate atomic64 primitives and couldn't
co-work with READ_ONCE/WRITE_ONCE,  atomic_8/16/32. The s64ilp32 could
use native AMO instructions to implement accurate atomic64 primitives.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/Kconfig              | 2 +-
 arch/riscv/include/asm/atomic.h | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index f364d2436b1d..0fc03aa076e6 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -65,7 +65,7 @@ config RISCV
 	select CPU_PM if CPU_IDLE || HIBERNATION
 	select EDAC_SUPPORT
 	select GENERIC_ARCH_TOPOLOGY
-	select GENERIC_ATOMIC64 if !64BIT
+	select GENERIC_ATOMIC64 if ARCH_RV32I
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_ENTRY
diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index f5dfef6c2153..8f6579b33ecc 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -16,6 +16,12 @@
 # endif
 #endif
 
+#ifdef CONFIG_ARCH_RV64ILP32
+typedef struct {
+	s64 counter;
+} atomic64_t;
+#endif
+
 #include <asm/cmpxchg.h>
 #include <asm/barrier.h>
 
-- 
2.36.1


