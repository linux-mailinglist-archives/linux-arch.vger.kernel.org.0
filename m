Return-Path: <linux-arch+bounces-13011-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88909B179DD
	for <lists+linux-arch@lfdr.de>; Fri,  1 Aug 2025 01:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4A561C80E05
	for <lists+linux-arch@lfdr.de>; Thu, 31 Jul 2025 23:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EF1280014;
	Thu, 31 Jul 2025 23:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="vqhWexpd"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757E928B408
	for <linux-arch@vger.kernel.org>; Thu, 31 Jul 2025 23:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754004025; cv=none; b=o/Mc4UqFOILWv3KlIENYWxwO5X2u7N++vxVz4uGvs7B05lXWqitLd8vZQ491EFBXM+FbYnmD+7l+aYkwMfLZZvJdpP6uiKb7IK44wBROYxdOFlWruHIW2URsH9y4lXGev4zB+eczBq39tySoqx0045fFbIS0s8FCFlGKPNAZBoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754004025; c=relaxed/simple;
	bh=4h1r4uU0fo8pM21Nf7WhkGBCaWXRTFD1KArxwOz1G48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g61rnL18x1ZfEzz3RB3qT71wCiT6FWrjNNFTLOcVcxgypsTa2St+Jzi19nSJ5jnD+zVOADs18spfBCyHFEKFIFimbxRcCJR/alLJk2mbcE+cKs+Y1zZsEX5/zDs0db/gXUnpklXJOjUASNi3a6CCVFMbDkvspa8BUeTqcReGOfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=vqhWexpd; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-31f255eb191so1378640a91.0
        for <linux-arch@vger.kernel.org>; Thu, 31 Jul 2025 16:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1754004023; x=1754608823; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y7zhOiw8hxjkY2w5hPCBsj8e5dMVUfbCJ3iXjsowIqM=;
        b=vqhWexpdbYGixYFsXssfZeVD1lzAejpa5A3fwewwZaljm82YZpuCE68kXgC2+3gTyR
         lnS2nsKmxIxUcYYQNOUMVxckb7ajiVV6gwAzhK95hswQCxYgf4WqAj0QMV0QlDYCJxBG
         ro/WfBzcXjUylEgLMllQ54IBc/w84vja1eeKe3ZnGdFxtWkMmWh0rZAKptcjfvgtSXOJ
         EFUhNBku6+ewoK7vkaiYNy9IPg4DauAFwWuz/RyYnKdnBfxIRGmmgL4m4Op31MCoCQ9M
         JvWwd2QgKZ4HNpjyVE2CvnicSVHojMVZgyErU8tyMw7HkOatua1afPAr2rv3ae5BdEoq
         paYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754004023; x=1754608823;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7zhOiw8hxjkY2w5hPCBsj8e5dMVUfbCJ3iXjsowIqM=;
        b=JE2/S/m6g2AL6etENbJlhOqdkjH1B/QllRUrV+8x4DNt8ijrm7zyRlRAQbA7+O9Bwr
         eUVC5tg9EDDw7zaetuT7qvDAcDNFoMVqGLIbvumfI7K5EnjEfNcXIfXz0vqx6uZv94gG
         b+goF3DXdb2DmFwozborUpGJDwCvCfM/Soayoz5tnq3Dtv+qKjRERFXgZVREItXgnGEq
         cjlTPNAMd4T7Jgo4BaginHxDgy2sHmwP3qURn3se29zJVksbiwbq/1Pk6KCS0Jou9FAG
         b1dHkar4T8VG4I0j7i0jOTn/Tcge9SfXF0eP9nKppQnPS+2iaO7sxpPpvHQ2nDNw4IMP
         qVnA==
X-Forwarded-Encrypted: i=1; AJvYcCVj9sk7S0YQWfB2XZYAzRPZolSZW9qFPwtDC8GoUiMFwN14BHtPsH/XFdNebMoTX7ZbePuTvoej/ZjM@vger.kernel.org
X-Gm-Message-State: AOJu0YwOFheKdB2AjNK16W7WpU8fJ+wrivN5YE4UhHDxFp2RMhBuVEWw
	qL3JHjAE+P3QnM8eGG2kCTdzlT3rBZ4lqNarpTKhzYl+UfV93/HLEmlPMJ6gHXPt9mU=
X-Gm-Gg: ASbGncs94RDbodDbXNDz+RpfBruLUTbn/i5ol6HH+mLOA2hLYJib5MF5jMHxW0V+eFA
	vafz+x5lgJxVOnY8z5DZ54u/XlR20Uz3KTvaIWfB3IMe9AkP6d579S3qycZukNBv7Oy55/ki18T
	mLYkC/x87fjudgX0Sg+r0HwYAWfUgjAW80oYD6maSui4TePgvwXTMtSo87Pz1nevd5esMndvevk
	9L/gE0OFcoFXCx1UVpwIlWMKdi73jYiFdCKJr/Y7IQ0wRZyH4F8xgwmyDUp2AdRWdlnahARUhWu
	tgFhZeHByT7Cr5nPH9qqVMfbbkYLhU707saw/3zrTWmrHwqI3Hcw1LL49fuwby35nD5P6GEJYNL
	kP/1KWF+Y9V3BMaQj74iBr/YXVsIhXpQH
X-Google-Smtp-Source: AGHT+IFb6cpAcJPsH+LUbeFd0vrkmWBYPTGi6FJej6weAXxvh0JJMsibgik4Cf8cTbGnwRHM/yFM7g==
X-Received: by 2002:a17:90b:48cf:b0:2fe:85f0:e115 with SMTP id 98e67ed59e1d1-31f5de6c834mr10940442a91.26.1754004022726;
        Thu, 31 Jul 2025 16:20:22 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63da8fcfsm5773085a91.7.2025.07.31.16.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 16:20:22 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 31 Jul 2025 16:19:31 -0700
Subject: [PATCH v19 21/27] riscv: kernel command line option to opt out of
 user cfi
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-v5_user_cfi_series-v19-21-09b468d7beab@rivosinc.com>
References: <20250731-v5_user_cfi_series-v19-0-09b468d7beab@rivosinc.com>
In-Reply-To: <20250731-v5_user_cfi_series-v19-0-09b468d7beab@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

This commit adds a kernel command line option using which user cfi can be
disabled. User backward cfi and forward cfi can be enabled independently.
Kernel command line parameter "riscv_nousercfi" can take below values:
 - "all" : Disable forward and backward cfi both.
 - "bcfi" : Disable backward cfi.
 - "fcfi" : Disable forward cfi

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  8 ++++
 arch/riscv/include/asm/usercfi.h                |  7 +++
 arch/riscv/kernel/cpufeature.c                  |  9 +++-
 arch/riscv/kernel/usercfi.c                     | 59 ++++++++++++++++++++-----
 4 files changed, 70 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f1f2c0874da9..62aee3fc2256 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6312,6 +6312,14 @@
 			replacement properties are not found. See the Kconfig
 			entry for RISCV_ISA_FALLBACK.
 
+	riscv_nousercfi=
+		all	Disable user cfi ABI to userspace even if cpu extension
+			are available.
+		bcfi	Disable user backward cfi ABI to userspace even if
+			shadow stack extension is available.
+		fcfi	Disable user forward cfi ABI to userspace even if landing
+			pad extension is available.
+
 	ro		[KNL] Mount root device read-only on boot
 
 	rodata=		[KNL,EARLY]
diff --git a/arch/riscv/include/asm/usercfi.h b/arch/riscv/include/asm/usercfi.h
index 54add512a4dc..afef69910601 100644
--- a/arch/riscv/include/asm/usercfi.h
+++ b/arch/riscv/include/asm/usercfi.h
@@ -5,6 +5,10 @@
 #ifndef _ASM_RISCV_USERCFI_H
 #define _ASM_RISCV_USERCFI_H
 
+#define CMDLINE_DISABLE_RISCV_USERCFI_FCFI	1
+#define CMDLINE_DISABLE_RISCV_USERCFI_BCFI	2
+#define CMDLINE_DISABLE_RISCV_USERCFI		3
+
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
 #include <linux/prctl.h>
@@ -83,6 +87,9 @@ void set_indir_lp_lock(struct task_struct *task);
 
 #endif /* CONFIG_RISCV_USER_CFI */
 
+bool is_user_shstk_enabled(void);
+bool is_user_lpad_enabled(void);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_RISCV_USERCFI_H */
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index d38136672650..08f2757340c6 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -28,6 +28,7 @@
 #include <asm/vector.h>
 #include <asm/vendor_extensions.h>
 #include <asm/vendor_extensions/thead.h>
+#include <asm/usercfi.h>
 
 #define NUM_ALPHA_EXTS ('z' - 'a' + 1)
 
@@ -45,6 +46,8 @@ struct riscv_isainfo hart_isa[NR_CPUS];
 
 u32 thead_vlenb_of;
 
+extern unsigned long riscv_nousercfi;
+
 /**
  * riscv_isa_extension_base() - Get base extension word
  *
@@ -277,7 +280,8 @@ static int riscv_ext_svadu_validate(const struct riscv_isa_ext_data *data,
 static int riscv_cfilp_validate(const struct riscv_isa_ext_data *data,
 			      const unsigned long *isa_bitmap)
 {
-	if (!IS_ENABLED(CONFIG_RISCV_USER_CFI))
+	if (!IS_ENABLED(CONFIG_RISCV_USER_CFI) ||
+	    (riscv_nousercfi & CMDLINE_DISABLE_RISCV_USERCFI_FCFI))
 		return -EINVAL;
 
 	return 0;
@@ -286,7 +290,8 @@ static int riscv_cfilp_validate(const struct riscv_isa_ext_data *data,
 static int riscv_cfiss_validate(const struct riscv_isa_ext_data *data,
 			      const unsigned long *isa_bitmap)
 {
-	if (!IS_ENABLED(CONFIG_RISCV_USER_CFI))
+	if (!IS_ENABLED(CONFIG_RISCV_USER_CFI) ||
+	    (riscv_nousercfi & CMDLINE_DISABLE_RISCV_USERCFI_BCFI))
 		return -EINVAL;
 
 	return 0;
diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
index 8bc3e1e3f712..92f536d46fc7 100644
--- a/arch/riscv/kernel/usercfi.c
+++ b/arch/riscv/kernel/usercfi.c
@@ -17,6 +17,8 @@
 #include <asm/csr.h>
 #include <asm/usercfi.h>
 
+unsigned long riscv_nousercfi;
+
 #define SHSTK_ENTRY_SIZE sizeof(void *)
 
 bool is_shstk_enabled(struct task_struct *task)
@@ -59,7 +61,7 @@ unsigned long get_active_shstk(struct task_struct *task)
 
 void set_shstk_status(struct task_struct *task, bool enable)
 {
-	if (!cpu_supports_shadow_stack())
+	if (!is_user_shstk_enabled())
 		return;
 
 	task->thread_info.user_cfi_state.ubcfi_en = enable ? 1 : 0;
@@ -89,7 +91,7 @@ bool is_indir_lp_locked(struct task_struct *task)
 
 void set_indir_lp_status(struct task_struct *task, bool enable)
 {
-	if (!cpu_supports_indirect_br_lp_instr())
+	if (!is_user_lpad_enabled())
 		return;
 
 	task->thread_info.user_cfi_state.ufcfi_en = enable ? 1 : 0;
@@ -259,7 +261,7 @@ SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsi
 	bool set_tok = flags & SHADOW_STACK_SET_TOKEN;
 	unsigned long aligned_size = 0;
 
-	if (!cpu_supports_shadow_stack())
+	if (!is_user_shstk_enabled())
 		return -EOPNOTSUPP;
 
 	/* Anything other than set token should result in invalid param */
@@ -306,7 +308,7 @@ unsigned long shstk_alloc_thread_stack(struct task_struct *tsk,
 	unsigned long addr, size;
 
 	/* If shadow stack is not supported, return 0 */
-	if (!cpu_supports_shadow_stack())
+	if (!is_user_shstk_enabled())
 		return 0;
 
 	/*
@@ -352,7 +354,7 @@ void shstk_release(struct task_struct *tsk)
 {
 	unsigned long base = 0, size = 0;
 	/* If shadow stack is not supported or not enabled, nothing to release */
-	if (!cpu_supports_shadow_stack() || !is_shstk_enabled(tsk))
+	if (!is_user_shstk_enabled() || !is_shstk_enabled(tsk))
 		return;
 
 	/*
@@ -381,7 +383,7 @@ int arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *st
 {
 	unsigned long bcfi_status = 0;
 
-	if (!cpu_supports_shadow_stack())
+	if (!is_user_shstk_enabled())
 		return -EINVAL;
 
 	/* this means shadow stack is enabled on the task */
@@ -395,7 +397,7 @@ int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status)
 	unsigned long size = 0, addr = 0;
 	bool enable_shstk = false;
 
-	if (!cpu_supports_shadow_stack())
+	if (!is_user_shstk_enabled())
 		return -EINVAL;
 
 	/* Reject unknown flags */
@@ -448,7 +450,7 @@ int arch_lock_shadow_stack_status(struct task_struct *task,
 				  unsigned long arg)
 {
 	/* If shtstk not supported or not enabled on task, nothing to lock here */
-	if (!cpu_supports_shadow_stack() ||
+	if (!is_user_shstk_enabled() ||
 	    !is_shstk_enabled(task) || arg != 0)
 		return -EINVAL;
 
@@ -461,7 +463,7 @@ int arch_get_indir_br_lp_status(struct task_struct *t, unsigned long __user *sta
 {
 	unsigned long fcfi_status = 0;
 
-	if (!cpu_supports_indirect_br_lp_instr())
+	if (!is_user_lpad_enabled())
 		return -EINVAL;
 
 	/* indirect branch tracking is enabled on the task or not */
@@ -474,7 +476,7 @@ int arch_set_indir_br_lp_status(struct task_struct *t, unsigned long status)
 {
 	bool enable_indir_lp = false;
 
-	if (!cpu_supports_indirect_br_lp_instr())
+	if (!is_user_lpad_enabled())
 		return -EINVAL;
 
 	/* indirect branch tracking is locked and further can't be modified by user */
@@ -498,7 +500,7 @@ int arch_lock_indir_br_lp_status(struct task_struct *task,
 	 * If indirect branch tracking is not supported or not enabled on task,
 	 * nothing to lock here
 	 */
-	if (!cpu_supports_indirect_br_lp_instr() ||
+	if (!is_user_lpad_enabled() ||
 	    !is_indir_lp_enabled(task) || arg != 0)
 		return -EINVAL;
 
@@ -506,3 +508,38 @@ int arch_lock_indir_br_lp_status(struct task_struct *task,
 
 	return 0;
 }
+
+bool is_user_shstk_enabled(void)
+{
+	return (cpu_supports_shadow_stack() &&
+		!(riscv_nousercfi & CMDLINE_DISABLE_RISCV_USERCFI_BCFI));
+}
+
+bool is_user_lpad_enabled(void)
+{
+	return (cpu_supports_indirect_br_lp_instr() &&
+		!(riscv_nousercfi & CMDLINE_DISABLE_RISCV_USERCFI_FCFI));
+}
+
+static int __init setup_global_riscv_enable(char *str)
+{
+	if (strcmp(str, "all") == 0)
+		riscv_nousercfi = CMDLINE_DISABLE_RISCV_USERCFI;
+
+	if (strcmp(str, "fcfi") == 0)
+		riscv_nousercfi |= CMDLINE_DISABLE_RISCV_USERCFI_FCFI;
+
+	if (strcmp(str, "bcfi") == 0)
+		riscv_nousercfi |= CMDLINE_DISABLE_RISCV_USERCFI_BCFI;
+
+	if (riscv_nousercfi)
+		pr_info("riscv user cfi disabled via cmdline"
+			"shadow stack status : %s, landing pad status : %s\n",
+			(riscv_nousercfi & CMDLINE_DISABLE_RISCV_USERCFI_BCFI) ? "disabled" :
+			"enabled", (riscv_nousercfi & CMDLINE_DISABLE_RISCV_USERCFI_FCFI) ?
+			"disabled" : "enabled");
+
+	return 1;
+}
+
+__setup("riscv_nousercfi=", setup_global_riscv_enable);

-- 
2.43.0


