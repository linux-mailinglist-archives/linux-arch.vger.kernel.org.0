Return-Path: <linux-arch+bounces-15043-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E7DC7C683
	for <lists+linux-arch@lfdr.de>; Sat, 22 Nov 2025 05:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5C317361A00
	for <lists+linux-arch@lfdr.de>; Sat, 22 Nov 2025 04:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74D4257843;
	Sat, 22 Nov 2025 04:40:29 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EAD23A58B;
	Sat, 22 Nov 2025 04:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763786429; cv=none; b=W51wtns9eo2xLUHlvxPJZ2BPPuY8jJc9G+MKzipmH8SzBLk3AvGlnKBCp8RS9fpiiCcwXeVKVEnYWPfjgNV4VVrwxzxC9XCtdyfkDZiz3TQOptRkEtWqFnAfpLyCAhjXx+upcL/ILwSYpaluCUdkDdjdsz/KNcF/kPhQ03wBWxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763786429; c=relaxed/simple;
	bh=DwQ2wgcvLxZ3EH9QpbXhwz+CxDuf427+QtHUhK+h5uM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OTUOIatzSevN0AZWncJSKJsSQvuSym49bip4GAOF6k1alM0oOXZE4EBhXj3KimFe26o6iGPZjfl0N6X7p9sPL/UEQ+tJoKLB1sjZbGXgHg8gn8RRbryDrZgzkGoG0sjvKYRpZzhYraRrQShVdE1TMJP8nbgcIP9TYxcqLIMByy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814D9C4CEF5;
	Sat, 22 Nov 2025 04:40:26 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Arnd Bergmann <arnd@arndb.de>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-arch@vger.kernel.org,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V3 09/14] LoongArch: Adjust system call for 32BIT/64BIT
Date: Sat, 22 Nov 2025 12:36:29 +0800
Message-ID: <20251122043634.3447854-10-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251122043634.3447854-1-chenhuacai@loongson.cn>
References: <20251122043634.3447854-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjust system call for both 32BIT and 64BIT, including: add the uapi
unistd_{32,64}.h and syscall_table_{32,64}.h inclusion, add sys_mmap2()
definition, change the system call entry routines, etc.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/Kbuild        |  1 +
 arch/loongarch/include/uapi/asm/Kbuild   |  1 +
 arch/loongarch/include/uapi/asm/unistd.h |  6 ++++++
 arch/loongarch/kernel/Makefile.syscalls  |  1 +
 arch/loongarch/kernel/entry.S            | 22 +++++++++++-----------
 arch/loongarch/kernel/syscall.c          | 13 +++++++++++++
 6 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/arch/loongarch/include/asm/Kbuild b/arch/loongarch/include/asm/Kbuild
index b04d2cef935f..9034b583a88a 100644
--- a/arch/loongarch/include/asm/Kbuild
+++ b/arch/loongarch/include/asm/Kbuild
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+syscall-y += syscall_table_32.h
 syscall-y += syscall_table_64.h
 generated-y += orc_hash.h
 
diff --git a/arch/loongarch/include/uapi/asm/Kbuild b/arch/loongarch/include/uapi/asm/Kbuild
index 517761419999..89ac01faa5ae 100644
--- a/arch/loongarch/include/uapi/asm/Kbuild
+++ b/arch/loongarch/include/uapi/asm/Kbuild
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
+syscall-y += unistd_32.h
 syscall-y += unistd_64.h
diff --git a/arch/loongarch/include/uapi/asm/unistd.h b/arch/loongarch/include/uapi/asm/unistd.h
index 1f01980f9c94..e19c7f2f9f87 100644
--- a/arch/loongarch/include/uapi/asm/unistd.h
+++ b/arch/loongarch/include/uapi/asm/unistd.h
@@ -1,3 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 
+#include <asm/bitsperlong.h>
+
+#if __BITS_PER_LONG == 32
+#include <asm/unistd_32.h>
+#else
 #include <asm/unistd_64.h>
+#endif
diff --git a/arch/loongarch/kernel/Makefile.syscalls b/arch/loongarch/kernel/Makefile.syscalls
index ab7d9baa2915..cd46c2b69c7f 100644
--- a/arch/loongarch/kernel/Makefile.syscalls
+++ b/arch/loongarch/kernel/Makefile.syscalls
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
 # No special ABIs on loongarch so far
+syscall_abis_32 +=
 syscall_abis_64 +=
diff --git a/arch/loongarch/kernel/entry.S b/arch/loongarch/kernel/entry.S
index 47e1db9a1ce4..b53d333a7c42 100644
--- a/arch/loongarch/kernel/entry.S
+++ b/arch/loongarch/kernel/entry.S
@@ -23,24 +23,24 @@ SYM_CODE_START(handle_syscall)
 	UNWIND_HINT_UNDEFINED
 	csrrd		t0, PERCPU_BASE_KS
 	la.pcrel	t1, kernelsp
-	add.d		t1, t1, t0
+	PTR_ADD		t1, t1, t0
 	move		t2, sp
-	ld.d		sp, t1, 0
+	PTR_L		sp, t1, 0
 
-	addi.d		sp, sp, -PT_SIZE
+	PTR_ADDI	sp, sp, -PT_SIZE
 	cfi_st		t2, PT_R3
 	cfi_rel_offset	sp, PT_R3
-	st.d		zero, sp, PT_R0
+	LONG_S		zero, sp, PT_R0
 	csrrd		t2, LOONGARCH_CSR_PRMD
-	st.d		t2, sp, PT_PRMD
+	LONG_S		t2, sp, PT_PRMD
 	csrrd		t2, LOONGARCH_CSR_CRMD
-	st.d		t2, sp, PT_CRMD
+	LONG_S		t2, sp, PT_CRMD
 	csrrd		t2, LOONGARCH_CSR_EUEN
-	st.d		t2, sp, PT_EUEN
+	LONG_S		t2, sp, PT_EUEN
 	csrrd		t2, LOONGARCH_CSR_ECFG
-	st.d		t2, sp, PT_ECFG
+	LONG_S		t2, sp, PT_ECFG
 	csrrd		t2, LOONGARCH_CSR_ESTAT
-	st.d		t2, sp, PT_ESTAT
+	LONG_S		t2, sp, PT_ESTAT
 	cfi_st		ra, PT_R1
 	cfi_st		a0, PT_R4
 	cfi_st		a1, PT_R5
@@ -51,7 +51,7 @@ SYM_CODE_START(handle_syscall)
 	cfi_st		a6, PT_R10
 	cfi_st		a7, PT_R11
 	csrrd		ra, LOONGARCH_CSR_ERA
-	st.d		ra, sp, PT_ERA
+	LONG_S		ra, sp, PT_ERA
 	cfi_rel_offset	ra, PT_ERA
 
 	cfi_st		tp, PT_R2
@@ -67,7 +67,7 @@ SYM_CODE_START(handle_syscall)
 #endif
 
 	move		u0, t0
-	li.d		tp, ~_THREAD_MASK
+	LONG_LI		tp, ~_THREAD_MASK
 	and		tp, tp, sp
 
 	move		a0, sp
diff --git a/arch/loongarch/kernel/syscall.c b/arch/loongarch/kernel/syscall.c
index ab94eb5ce039..1249d82c1cd0 100644
--- a/arch/loongarch/kernel/syscall.c
+++ b/arch/loongarch/kernel/syscall.c
@@ -34,9 +34,22 @@ SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len, unsigned long,
 	return ksys_mmap_pgoff(addr, len, prot, flags, fd, offset >> PAGE_SHIFT);
 }
 
+SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len, unsigned long,
+		 prot, unsigned long, flags, unsigned long, fd, unsigned long, offset)
+{
+	if (offset & (~PAGE_MASK >> 12))
+		return -EINVAL;
+
+	return ksys_mmap_pgoff(addr, len, prot, flags, fd, offset >> (PAGE_SHIFT - 12));
+}
+
 void *sys_call_table[__NR_syscalls] = {
 	[0 ... __NR_syscalls - 1] = sys_ni_syscall,
+#ifdef CONFIG_32BIT
+#include <asm/syscall_table_32.h>
+#else
 #include <asm/syscall_table_64.h>
+#endif
 };
 
 typedef long (*sys_call_fn)(unsigned long, unsigned long,
-- 
2.47.3


