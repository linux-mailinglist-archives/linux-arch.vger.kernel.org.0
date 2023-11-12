Return-Path: <linux-arch+bounces-154-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A137E8EA5
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 07:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 458FAB2097B
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 06:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE4B440E;
	Sun, 12 Nov 2023 06:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXWH+71B"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725B5440A
	for <linux-arch@vger.kernel.org>; Sun, 12 Nov 2023 06:17:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2DD9C433D9;
	Sun, 12 Nov 2023 06:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699769837;
	bh=yJ53jomTLG+j+rzKLDFglTmPOzUq4xATJqhV03Y8NDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uXWH+71BlkB0gLhz3M2X15BE4B4oEYB9gyycQqZ8+FdLYqMz3funNQkzHc0Dy9XBp
	 8ObE/BWmXibABF2C3xM83Jafy7ZAcI0Mt/kEddZ5fp3qHw4s8Sm5JNY7WKFOnwlTHF
	 XebaLVFboE5rnhqBdO5/ZdqxwmPOogqsgCllKNUnGJo0WlEBkq4RTDjX8YLafHMWJ5
	 5PqFLGR5t8hI3HrTmU+l0D0GDKxB0il/JGfS2b455jexb153+6vOha/HJiAAaVRPMD
	 JUj6goF6Ow1Gm47Z17xP/gMVRHN6sFy0NoVDBX0XwqO3xDgrIkSCjn1gSZSqBbhqhi
	 fdcFURboW9taw==
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
Subject: [RFC PATCH V2 18/38] riscv: s64ilp32: Add ebpf jit support
Date: Sun, 12 Nov 2023 01:14:54 -0500
Message-Id: <20231112061514.2306187-19-guoren@kernel.org>
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

The s64ilp32 uses the rv64 ISA instruction set, not the rv32 ISA. So
bpf_jit_comp32.c can't be used for s64ilp32, and we use bpf_jit_comp64.c
instead. This patch makes s64ilp32 ebpf jit correct and improves the
performance because bpf_jit_comp32.c has significant gaps in mapping
ebpf 64-bit ISA.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/extable.h | 2 +-
 arch/riscv/net/Makefile          | 6 +++---
 arch/riscv/net/bpf_jit_comp64.c  | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/include/asm/extable.h b/arch/riscv/include/asm/extable.h
index 3eb5c1f7bf34..7e22bb520309 100644
--- a/arch/riscv/include/asm/extable.h
+++ b/arch/riscv/include/asm/extable.h
@@ -38,7 +38,7 @@ bool fixup_exception(struct pt_regs *regs);
 static inline bool fixup_exception(struct pt_regs *regs) { return false; }
 #endif
 
-#if defined(CONFIG_BPF_JIT) && defined(CONFIG_ARCH_RV64I)
+#if defined(CONFIG_BPF_JIT) && !defined(CONFIG_ARCH_RV32I)
 bool ex_handler_bpf(const struct exception_table_entry *ex, struct pt_regs *regs);
 #else
 static inline bool
diff --git a/arch/riscv/net/Makefile b/arch/riscv/net/Makefile
index 9a1e5f0a94e5..907edce21acc 100644
--- a/arch/riscv/net/Makefile
+++ b/arch/riscv/net/Makefile
@@ -2,8 +2,8 @@
 
 obj-$(CONFIG_BPF_JIT) += bpf_jit_core.o
 
-ifeq ($(CONFIG_ARCH_RV64I),y)
-	obj-$(CONFIG_BPF_JIT) += bpf_jit_comp64.o
-else
+ifeq ($(CONFIG_ARCH_RV32I),y)
 	obj-$(CONFIG_BPF_JIT) += bpf_jit_comp32.o
+else
+	obj-$(CONFIG_BPF_JIT) += bpf_jit_comp64.o
 endif
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index c648864c8cd1..ec0b7fb6982b 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -126,7 +126,7 @@ static u8 rv_tail_call_reg(struct rv_jit_context *ctx)
 
 static bool is_32b_int(s64 val)
 {
-	return -(1L << 31) <= val && val < (1L << 31);
+	return -(1LL << 31) <= val && val < (1LL << 31);
 }
 
 static bool in_auipc_jalr_range(s64 val)
@@ -135,8 +135,8 @@ static bool in_auipc_jalr_range(s64 val)
 	 * auipc+jalr can reach any signed PC-relative offset in the range
 	 * [-2^31 - 2^11, 2^31 - 2^11).
 	 */
-	return (-(1L << 31) - (1L << 11)) <= val &&
-		val < ((1L << 31) - (1L << 11));
+	return (-(1LL << 31) - (1LL << 11)) <= val &&
+		val < ((1LL << 31) - (1LL << 11));
 }
 
 /* Emit fixed-length instructions for address */
-- 
2.36.1


