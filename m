Return-Path: <linux-arch+bounces-3292-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EE38912B2
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 05:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E78B6B23C34
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 04:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C8E481B1;
	Fri, 29 Mar 2024 04:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="uPiEyU3T"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C9A44C8B
	for <linux-arch@vger.kernel.org>; Fri, 29 Mar 2024 04:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711687590; cv=none; b=fL2YdxsLNy8oiiUaonuZ2Y7eG/PFIk5IMGSfkiN+jf5pD+UhbeW0qhRXdtIQyFFEh92G4e6EYlOsgrrCUOXKpFzlFJOUSF+Zsy2TX/sLU0AeCdwHVxleVd0FDJGAQ4X9uUYkUG9wipeac7pnapT6PHhB6lG9jf5vDI2lLCoc6Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711687590; c=relaxed/simple;
	bh=Mjj/W7YJP1oRliEKJvU21wwE+mKCGNlF947ECwK1HzU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NcVoG+njvH418aoYjbpX7tUgDFq92cFxjR578C0T+R0OBuBsGRdzyPbtN9C+3XW69E7SnkszR8hohMoxVSsuKuYtsPrlArRyU3/Ggm5ON73s3FRecMHXk/RCkoEslpJQ15Fgv2bwoS2XevgDK5EnXqs1DqA+nsZOAqEhwevR/ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=uPiEyU3T; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2228c4c5ac3so942992fac.0
        for <linux-arch@vger.kernel.org>; Thu, 28 Mar 2024 21:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1711687588; x=1712292388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRYuUV/HDlw+87fPFfw891sAepuDTsGv4tytTH7IM+U=;
        b=uPiEyU3TNDa6T9SK2m2EIvcqe5B0dFgGqnfJL3EDUn6AT1gcZVftnfbIN14CgSAfPS
         K7ucBJLitMfAZJ+7Yi2uMtU2hX/7mM5tNzsvkqZ1OfS6Ts4d3DpX4wp0Lg9CjpmHCXNx
         nPjvNY+2WGpsc/iFvWj+V4S2wfRa0pupnaWlHPUtEeg/ndUUtB3a7vWTRHIP5KTvoUnK
         S+412jXabqC2tApeJ7cbx9Tfu+wD+Y8YYi67UJoTfc2Se9i4Al/AoDGCj2mRcDeIOEXe
         Qn6PnZfX0fFuIF5/9+5cC7/nSMIFOeE//DAcZdhUJBoZm1GDFPweuPeNG8M6A8m84/lT
         jUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711687588; x=1712292388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tRYuUV/HDlw+87fPFfw891sAepuDTsGv4tytTH7IM+U=;
        b=eNAzHE7AKtqvJ17EDS+ChVdQkrBfYmtsiPd5YEvHJ++RXfwV4WNGg9UcFVI/cJo4NU
         ZoxAW/PHGaPdurIiTKMhymE9QJIkbofHa7wKJ3FdfUNIzJQEC/EAbHO7yhmv9jxCXO63
         en1okOrOQAk9hdcSeJvxl5Umk8u5t24GyWq2/IPlJQBtvKm3jmEhcOf98LW2DBr5uD3V
         BZVSpnGm9grKui9xsX4lpFfqdDwquasmJkyZzinBW3UUoR7QuFJDvfsR5dDbAMK8ppnV
         xqqh04QKjqORRZq5wR2yjm55VaY4Lsiz67Tyy6v2W9eIoh0AEznriOW1+JPp/AoUkiyI
         RCIg==
X-Forwarded-Encrypted: i=1; AJvYcCURvfYqQYio+O616S6b8qUKoaGBAhdt26aQ2wfBZz2JrpY0PguT1QVHeSJBv1HWBAFABtOcRf05tk14N/IG98d8i+DE3eNbx6mIaQ==
X-Gm-Message-State: AOJu0YzGzmXoh7nityQR1O30bBXWbt4BEPFQiDPttjiQ8J3KcgxNl9YI
	tAjcr7MnXMqghC92d0M2BzCHTFCXpc3RmfEgPMCNTOzqBty5PAmqWUMaAnX+1OCZ1y3XsK2tl/p
	LMjY=
X-Google-Smtp-Source: AGHT+IExHTclA4kNK7S7bjrk+V0W0UHQqweUym9pGZMbj3dJny2cMk1eOLNjAwq+8+i1fBbvmLIbAg==
X-Received: by 2002:a05:6870:c48:b0:22a:6ad4:5c4 with SMTP id lf8-20020a0568700c4800b0022a6ad405c4mr1448163oab.3.1711687588092;
        Thu, 28 Mar 2024 21:46:28 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id i18-20020aa78b52000000b006ea7e972947sm2217120pfd.130.2024.03.28.21.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 21:46:27 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: paul.walmsley@sifive.com,
	rick.p.edgecombe@intel.com,
	broonie@kernel.org,
	Szabolcs.Nagy@arm.com,
	kito.cheng@sifive.com,
	keescook@chromium.org,
	ajones@ventanamicro.com,
	conor.dooley@microchip.com,
	cleger@rivosinc.com,
	atishp@atishpatra.org,
	alex@ghiti.fr,
	bjorn@rivosinc.com,
	alexghiti@rivosinc.com,
	samuel.holland@sifive.com,
	palmer@sifive.com,
	conor@kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: corbet@lwn.net,
	tech-j-ext@lists.risc-v.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	oleg@redhat.com,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	ebiederm@xmission.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	lstoakes@gmail.com,
	shuah@kernel.org,
	brauner@kernel.org,
	debug@rivosinc.com,
	andy.chiu@sifive.com,
	jerry.shih@sifive.com,
	hankuan.chen@sifive.com,
	greentime.hu@sifive.com,
	evan@rivosinc.com,
	xiao.w.wang@intel.com,
	charlie@rivosinc.com,
	apatel@ventanamicro.com,
	mchitale@ventanamicro.com,
	dbarboza@ventanamicro.com,
	sameo@rivosinc.com,
	shikemeng@huaweicloud.com,
	willy@infradead.org,
	vincent.chen@sifive.com,
	guoren@kernel.org,
	samitolvanen@google.com,
	songshuaishuai@tinylab.org,
	gerg@kernel.org,
	heiko@sntech.de,
	bhe@redhat.com,
	jeeheng.sia@starfivetech.com,
	cyy@cyyself.name,
	maskray@google.com,
	ancientmodern4@gmail.com,
	mathis.salmen@matsal.de,
	cuiyunhui@bytedance.com,
	bgray@linux.ibm.com,
	mpe@ellerman.id.au,
	baruch@tkos.co.il,
	alx@kernel.org,
	david@redhat.com,
	catalin.marinas@arm.com,
	revest@chromium.org,
	josh@joshtriplett.org,
	shr@devkernel.io,
	deller@gmx.de,
	omosnace@redhat.com,
	ojeda@kernel.org,
	jhubbard@nvidia.com
Subject: [PATCH v2 13/27] riscv/mm: Implement map_shadow_stack() syscall
Date: Thu, 28 Mar 2024 21:44:45 -0700
Message-Id: <20240329044459.3990638-14-debug@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329044459.3990638-1-debug@rivosinc.com>
References: <20240329044459.3990638-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As discussed extensively in the changelog for the addition of this
syscall on x86 ("x86/shstk: Introduce map_shadow_stack syscall") the
existing mmap() and madvise() syscalls do not map entirely well onto the
security requirements for shadow stack memory since they lead to windows
where memory is allocated but not yet protected or stacks which are not
properly and safely initialised. Instead a new syscall map_shadow_stack()
has been defined which allocates and initialises a shadow stack page.

This patch implements this syscall for riscv. riscv doesn't require token
to be setup by kernel because user mode can do that by itself. However to
provide compatiblity and portability with other architectues, user mode can
specify token set flag.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/kernel/Makefile      |   2 +
 arch/riscv/kernel/usercfi.c     | 149 ++++++++++++++++++++++++++++++++
 include/uapi/asm-generic/mman.h |   1 +
 3 files changed, 152 insertions(+)
 create mode 100644 arch/riscv/kernel/usercfi.c

diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 604d6bf7e476..3bec82f4e94c 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -107,3 +107,5 @@ obj-$(CONFIG_COMPAT)		+= compat_vdso/
 
 obj-$(CONFIG_64BIT)		+= pi/
 obj-$(CONFIG_ACPI)		+= acpi.o
+
+obj-$(CONFIG_RISCV_USER_CFI) += usercfi.o
diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
new file mode 100644
index 000000000000..c4ed0d4e33d6
--- /dev/null
+++ b/arch/riscv/kernel/usercfi.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Rivos, Inc.
+ * Deepak Gupta <debug@rivosinc.com>
+ */
+
+#include <linux/sched.h>
+#include <linux/bitops.h>
+#include <linux/types.h>
+#include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/uaccess.h>
+#include <linux/sizes.h>
+#include <linux/user.h>
+#include <linux/syscalls.h>
+#include <linux/prctl.h>
+#include <asm/csr.h>
+#include <asm/usercfi.h>
+
+#define SHSTK_ENTRY_SIZE sizeof(void *)
+
+/*
+ * Writes on shadow stack can either be `sspush` or `ssamoswap`. `sspush` can happen
+ * implicitly on current shadow stack pointed to by CSR_SSP. `ssamoswap` takes pointer to
+ * shadow stack. To keep it simple, we plan to use `ssamoswap` to perform writes on shadow
+ * stack.
+ */
+static noinline unsigned long amo_user_shstk(unsigned long *addr, unsigned long val)
+{
+	/*
+	 * Since shadow stack is supported only in 64bit configuration,
+	 * ssamoswap.d is used below. CONFIG_RISCV_USER_CFI is dependent
+	 * on 64BIT and compile of this file is dependent on CONFIG_RISCV_USER_CFI
+	 * In case ssamoswap faults, return -1.
+	 * Never expect -1 on shadow stack. Expect return addresses and zero
+	 */
+	unsigned long swap = -1;
+
+	__enable_user_access();
+	asm goto(
+				".option push\n"
+				".option arch, +zicfiss\n"
+				"1: ssamoswap.d %[swap], %[val], %[addr]\n"
+				_ASM_EXTABLE(1b, %l[fault])
+				RISCV_ACQUIRE_BARRIER
+				".option pop\n"
+				: [swap] "=r" (swap), [addr] "+A" (*addr)
+				: [val] "r" (val)
+				: "memory"
+				: fault
+			);
+	__disable_user_access();
+	return swap;
+fault:
+	__disable_user_access();
+	return -1;
+}
+
+/*
+ * Create a restore token on the shadow stack.  A token is always XLEN wide
+ * and aligned to XLEN.
+ */
+static int create_rstor_token(unsigned long ssp, unsigned long *token_addr)
+{
+	unsigned long addr;
+
+	/* Token must be aligned */
+	if (!IS_ALIGNED(ssp, SHSTK_ENTRY_SIZE))
+		return -EINVAL;
+
+	/* On RISC-V we're constructing token to be function of address itself */
+	addr = ssp - SHSTK_ENTRY_SIZE;
+
+	if (amo_user_shstk((unsigned long __user *)addr, (unsigned long) ssp) == -1)
+		return -EFAULT;
+
+	if (token_addr)
+		*token_addr = addr;
+
+	return 0;
+}
+
+static unsigned long allocate_shadow_stack(unsigned long addr, unsigned long size,
+				unsigned long token_offset,
+				bool set_tok)
+{
+	int flags = MAP_ANONYMOUS | MAP_PRIVATE;
+	struct mm_struct *mm = current->mm;
+	unsigned long populate, tok_loc = 0;
+
+	if (addr)
+		flags |= MAP_FIXED_NOREPLACE;
+
+	mmap_write_lock(mm);
+	addr = do_mmap(NULL, addr, size, PROT_READ, flags,
+				VM_SHADOW_STACK | VM_WRITE, 0, &populate, NULL);
+	mmap_write_unlock(mm);
+
+	if (!set_tok || IS_ERR_VALUE(addr))
+		goto out;
+
+	if (create_rstor_token(addr + token_offset, &tok_loc)) {
+		vm_munmap(addr, size);
+		return -EINVAL;
+	}
+
+	addr = tok_loc;
+
+out:
+	return addr;
+}
+
+SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsigned int, flags)
+{
+	bool set_tok = flags & SHADOW_STACK_SET_TOKEN;
+	unsigned long aligned_size = 0;
+
+	if (!cpu_supports_shadow_stack())
+		return -EOPNOTSUPP;
+
+	/* Anything other than set token should result in invalid param */
+	if (flags & ~SHADOW_STACK_SET_TOKEN)
+		return -EINVAL;
+
+	/*
+	 * Unlike other architectures, on RISC-V, SSP pointer is held in CSR_SSP and is available
+	 * CSR in all modes. CSR accesses are performed using 12bit index programmed in instruction
+	 * itself. This provides static property on register programming and writes to CSR can't
+	 * be unintentional from programmer's perspective. As long as programmer has guarded areas
+	 * which perform writes to CSR_SSP properly, shadow stack pivoting is not possible. Since
+	 * CSR_SSP is writeable by user mode, it itself can setup a shadow stack token subsequent
+	 * to allocation. Although in order to provide portablity with other architecture (because
+	 * `map_shadow_stack` is arch agnostic syscall), RISC-V will follow expectation of a token
+	 * flag in flags and if provided in flags, setup a token at the base.
+	 */
+
+	/* If there isn't space for a token */
+	if (set_tok && size < SHSTK_ENTRY_SIZE)
+		return -ENOSPC;
+
+	if (addr && (addr % PAGE_SIZE))
+		return -EINVAL;
+
+	aligned_size = PAGE_ALIGN(size);
+	if (aligned_size < size)
+		return -EOVERFLOW;
+
+	return allocate_shadow_stack(addr, aligned_size, size, set_tok);
+}
diff --git a/include/uapi/asm-generic/mman.h b/include/uapi/asm-generic/mman.h
index 57e8195d0b53..0c0ac6214de6 100644
--- a/include/uapi/asm-generic/mman.h
+++ b/include/uapi/asm-generic/mman.h
@@ -19,4 +19,5 @@
 #define MCL_FUTURE	2		/* lock all future mappings */
 #define MCL_ONFAULT	4		/* lock all pages that are faulted in */
 
+#define SHADOW_STACK_SET_TOKEN (1ULL << 0)     /* Set up a restore token in the shadow stack */
 #endif /* __ASM_GENERIC_MMAN_H */
-- 
2.43.2


