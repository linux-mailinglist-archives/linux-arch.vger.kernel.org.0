Return-Path: <linux-arch+bounces-14309-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDC9C01701
	for <lists+linux-arch@lfdr.de>; Thu, 23 Oct 2025 15:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E823F188C906
	for <lists+linux-arch@lfdr.de>; Thu, 23 Oct 2025 13:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAB2335BCC;
	Thu, 23 Oct 2025 13:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="evRE9FBn"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6346A336EC9
	for <linux-arch@vger.kernel.org>; Thu, 23 Oct 2025 13:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225969; cv=none; b=DDy0V/lavKTaMMfu9kCywM7ZRM4UC4KeHev+kcsorT6CqPFyH3eF+fKx5SelT2/MLZlPeFnhWWdwfov5kbF6D/U8lF6U6QbDsX9hGl1TP7bNnRlM5MHzXusHtpLLMvx4TR+wpT7l7Bo65vw6uyfzEAoxVgXUf3/vK27FRavu014=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225969; c=relaxed/simple;
	bh=z5xdZaKwg2qUwtrY22O4fobOm82lvR70DFtbPBo8Rjw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G2e4XUhRroOw7XvVnNljwEmRVGClrkEf2+CtHO5ikYxskOqM3DrpH6QwC0iw3vRlbozeH7TtACKhySizvS2vnJlR6m3IUW6ilBgcX66OV+bVdQxL/JQ8fxjqb9FBvMYqwnghWs13vld1UuYmc9xIhWwQW8Yrte2hd8JC754rAy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=evRE9FBn; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-279e2554c8fso7792605ad.2
        for <linux-arch@vger.kernel.org>; Thu, 23 Oct 2025 06:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1761225964; x=1761830764; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N8Y+4xiTK5mTni2vvSY1onztmzVgzR7f1DB/I4yf/kY=;
        b=evRE9FBntvMZ0vWASEjDN8hCeuh362V39XG/I/R1Ty5ekNuSYF6PhaTR6NPansIuWN
         GohVkpxV//Yh4eZdiiIbFHvvpAoGlXEWZ4Jl6ltfPD7q94vUn0gK3hn0GeBO7UrAnEb+
         ORWcR33jZ0dPn/RK/iSyqFIaiSn2QShdcYlUp6tPsLPu8J75fOYVUVVjR/yF3XoFVYix
         RDNTuz+h2YJ9VFOegEXczFWcf5M3SYSN8t97e4XlFS9hiHzZrCKjGOsu5k2sYuKK/RRR
         1P8UlhnuSUCzP8F2auxlM4hwL2WjmhRkR6QXcdRwDFYV+xHDz/ARwPtv67pXnRxRL13v
         CENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761225964; x=1761830764;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N8Y+4xiTK5mTni2vvSY1onztmzVgzR7f1DB/I4yf/kY=;
        b=fgp3YiBrKkVEGpfntl4RqSe8gj7QRt9VJHgnQrC6JNskNXb7kfC6Z3VEd3LUbEulD2
         ja13Ji+yok/x1fBeb7SNBKrvahkS1c2hSoatFwp3Lr0JjVsxOIh9i/vab0cbTeQ+//MM
         OLZ9B00oo6tgT39y8+B0gHj4ZVhpLVee0c5dIMZFrB1O+wKAiTcbdtmZN0hKYSDhgtQy
         LLue1F5ienryd4BI/WR4imcihxxZ0KKWHXm9AU3zxaUCkg2Mu4svQrUGtTxGQXnDyzjF
         2rLbPn2eoW+PZKAKkUhcxlUF9CRVujkSbiaCNsZQ+OZneo2jKynGMsank5kQ1IzaDciW
         3P8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+r8yrSv2FkejnljdLQpf0VnbNAo8sA1AEt0KINo/WghQTSm987R6jhWaOaRjf40g+PoPnR1fl0WRw@vger.kernel.org
X-Gm-Message-State: AOJu0YyTueDEaEN2H6qRdSpMjenak+TH1xU5cZBZWdXDh7h6iPig7je0
	c5VHFR108AgYNYF2+4QD8iaIXdYJr41N3GQl8UT2V3oHkfCVKBCLC1sZNDgs3CMGJLw=
X-Gm-Gg: ASbGncuWJ+NrUrKTACGLkKd9Y1gXeLGxMH/pYZb9UhKmjZfxh0GQ3eSldlLs3siIOWn
	JYNYzUJsGeeSBuxfL2WAgU2N9omeQcbWzCewUwD9Me+Ny62uIpF9ck7SZawITZRCqqdOKOJK1Wu
	N09yJQfYeNJuU0QGkDxRxTu+CVPYX0dOymKV5XccmTfDy+Nj4aA9y4QhaFQRokhX3JVxZ74NZVH
	8UMgPkFzC7JNgX+hzXElYCy4gxioiNcMiO9figjlGBIiXzVIM85dUVX2Iipmyfa7lb4FJcstuTs
	DsVqSVo+yY1r0TiywTAa9YS+efHXekWCmtkBba6H0x47tLLPWbit80OEHfu11bxjX8Am1ZV3a2D
	XFa7pzHrY/7BbkwNeidPYuqeuhoK51zHxKMsacUp3tOsVjTtydvfpd3sFJHrLcwzS/zGLKeBrVC
	ObGB2hgR6Ov8m8TGJ5vV5U
X-Google-Smtp-Source: AGHT+IHSHhFiDofheEjB31cD7iHH7i9OsHDZfn7XLmotrZ1ZDXi21vk18KkxwZGcj6OI1Isc19SQPA==
X-Received: by 2002:a17:903:2309:b0:272:c95c:866 with SMTP id d9443c01a7336-290c9cb6305mr349108695ad.20.1761225964134;
        Thu, 23 Oct 2025 06:26:04 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e23e4b3sm23432035ad.103.2025.10.23.06.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 06:26:03 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 23 Oct 2025 06:25:41 -0700
Subject: [PATCH v22 12/28] riscv: Implements arch agnostic shadow stack
 prctls
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-v5_user_cfi_series-v22-12-1d53ce35d8fd@rivosinc.com>
References: <20251023-v5_user_cfi_series-v22-0-1d53ce35d8fd@rivosinc.com>
In-Reply-To: <20251023-v5_user_cfi_series-v22-0-1d53ce35d8fd@rivosinc.com>
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
 Zong Li <zong.li@sifive.com>, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

Implement architecture agnostic prctls() interface for setting and getting
shadow stack status.

prctls implemented are PR_GET_SHADOW_STACK_STATUS,
PR_SET_SHADOW_STACK_STATUS and PR_LOCK_SHADOW_STACK_STATUS.

As part of PR_SET_SHADOW_STACK_STATUS/PR_GET_SHADOW_STACK_STATUS, only
PR_SHADOW_STACK_ENABLE is implemented because RISCV allows each mode to
write to their own shadow stack using `sspush` or `ssamoswap`.

PR_LOCK_SHADOW_STACK_STATUS locks current configuration of shadow stack
enabling.

Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/usercfi.h |  16 ++++++
 arch/riscv/kernel/process.c      |   8 +++
 arch/riscv/kernel/usercfi.c      | 110 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 134 insertions(+)

diff --git a/arch/riscv/include/asm/usercfi.h b/arch/riscv/include/asm/usercfi.h
index a16a5dff8b0e..d71093f414df 100644
--- a/arch/riscv/include/asm/usercfi.h
+++ b/arch/riscv/include/asm/usercfi.h
@@ -7,6 +7,7 @@
 
 #ifndef __ASSEMBLER__
 #include <linux/types.h>
+#include <linux/prctl.h>
 
 struct task_struct;
 struct kernel_clone_args;
@@ -14,6 +15,7 @@ struct kernel_clone_args;
 #ifdef CONFIG_RISCV_USER_CFI
 struct cfi_state {
 	unsigned long ubcfi_en : 1; /* Enable for backward cfi. */
+	unsigned long ubcfi_locked : 1;
 	unsigned long user_shdw_stk; /* Current user shadow stack pointer */
 	unsigned long shdw_stk_base; /* Base address of shadow stack */
 	unsigned long shdw_stk_size; /* size of shadow stack */
@@ -26,6 +28,12 @@ void set_shstk_base(struct task_struct *task, unsigned long shstk_addr, unsigned
 unsigned long get_shstk_base(struct task_struct *task, unsigned long *size);
 void set_active_shstk(struct task_struct *task, unsigned long shstk_addr);
 bool is_shstk_enabled(struct task_struct *task);
+bool is_shstk_locked(struct task_struct *task);
+bool is_shstk_allocated(struct task_struct *task);
+void set_shstk_lock(struct task_struct *task);
+void set_shstk_status(struct task_struct *task, bool enable);
+
+#define PR_SHADOW_STACK_SUPPORTED_STATUS_MASK (PR_SHADOW_STACK_ENABLE)
 
 #else
 
@@ -41,6 +49,14 @@ bool is_shstk_enabled(struct task_struct *task);
 
 #define is_shstk_enabled(task) false
 
+#define is_shstk_locked(task) false
+
+#define is_shstk_allocated(task) false
+
+#define set_shstk_lock(task) do {} while (0)
+
+#define set_shstk_status(task, enable) do {} while (0)
+
 #endif /* CONFIG_RISCV_USER_CFI */
 
 #endif /* __ASSEMBLER__ */
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 72d35adc6e0e..a137d3483646 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -156,6 +156,14 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
 	regs->epc = pc;
 	regs->sp = sp;
 
+	/*
+	 * clear shadow stack state on exec.
+	 * libc will set it later via prctl.
+	 */
+	set_shstk_status(current, false);
+	set_shstk_base(current, 0, 0);
+	set_active_shstk(current, 0);
+
 #ifdef CONFIG_64BIT
 	regs->status &= ~SR_UXL;
 
diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
index ec3d78efd6f3..08620bdae696 100644
--- a/arch/riscv/kernel/usercfi.c
+++ b/arch/riscv/kernel/usercfi.c
@@ -24,6 +24,16 @@ bool is_shstk_enabled(struct task_struct *task)
 	return task->thread_info.user_cfi_state.ubcfi_en;
 }
 
+bool is_shstk_allocated(struct task_struct *task)
+{
+	return task->thread_info.user_cfi_state.shdw_stk_base;
+}
+
+bool is_shstk_locked(struct task_struct *task)
+{
+	return task->thread_info.user_cfi_state.ubcfi_locked;
+}
+
 void set_shstk_base(struct task_struct *task, unsigned long shstk_addr, unsigned long size)
 {
 	task->thread_info.user_cfi_state.shdw_stk_base = shstk_addr;
@@ -42,6 +52,26 @@ void set_active_shstk(struct task_struct *task, unsigned long shstk_addr)
 	task->thread_info.user_cfi_state.user_shdw_stk = shstk_addr;
 }
 
+void set_shstk_status(struct task_struct *task, bool enable)
+{
+	if (!cpu_supports_shadow_stack())
+		return;
+
+	task->thread_info.user_cfi_state.ubcfi_en = enable ? 1 : 0;
+
+	if (enable)
+		task->thread.envcfg |= ENVCFG_SSE;
+	else
+		task->thread.envcfg &= ~ENVCFG_SSE;
+
+	csr_write(CSR_ENVCFG, task->thread.envcfg);
+}
+
+void set_shstk_lock(struct task_struct *task)
+{
+	task->thread_info.user_cfi_state.ubcfi_locked = 1;
+}
+
 /*
  * If size is 0, then to be compatible with regular stack we want it to be as big as
  * regular stack. Else PAGE_ALIGN it and return back
@@ -261,3 +291,83 @@ void shstk_release(struct task_struct *tsk)
 	vm_munmap(base, size);
 	set_shstk_base(tsk, 0, 0);
 }
+
+int arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *status)
+{
+	unsigned long bcfi_status = 0;
+
+	if (!cpu_supports_shadow_stack())
+		return -EINVAL;
+
+	/* this means shadow stack is enabled on the task */
+	bcfi_status |= (is_shstk_enabled(t) ? PR_SHADOW_STACK_ENABLE : 0);
+
+	return copy_to_user(status, &bcfi_status, sizeof(bcfi_status)) ? -EFAULT : 0;
+}
+
+int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status)
+{
+	unsigned long size = 0, addr = 0;
+	bool enable_shstk = false;
+
+	if (!cpu_supports_shadow_stack())
+		return -EINVAL;
+
+	/* Reject unknown flags */
+	if (status & ~PR_SHADOW_STACK_SUPPORTED_STATUS_MASK)
+		return -EINVAL;
+
+	/* bcfi status is locked and further can't be modified by user */
+	if (is_shstk_locked(t))
+		return -EINVAL;
+
+	enable_shstk = status & PR_SHADOW_STACK_ENABLE;
+	/* Request is to enable shadow stack and shadow stack is not enabled already */
+	if (enable_shstk && !is_shstk_enabled(t)) {
+		/* shadow stack was allocated and enable request again
+		 * no need to support such usecase and return EINVAL.
+		 */
+		if (is_shstk_allocated(t))
+			return -EINVAL;
+
+		size = calc_shstk_size(0);
+		addr = allocate_shadow_stack(0, size, 0, false);
+		if (IS_ERR_VALUE(addr))
+			return -ENOMEM;
+		set_shstk_base(t, addr, size);
+		set_active_shstk(t, addr + size);
+	}
+
+	/*
+	 * If a request to disable shadow stack happens, let's go ahead and release it
+	 * Although, if CLONE_VFORKed child did this, then in that case we will end up
+	 * not releasing the shadow stack (because it might be needed in parent). Although
+	 * we will disable it for VFORKed child. And if VFORKed child tries to enable again
+	 * then in that case, it'll get entirely new shadow stack because following condition
+	 * are true
+	 *  - shadow stack was not enabled for vforked child
+	 *  - shadow stack base was anyways pointing to 0
+	 * This shouldn't be a big issue because we want parent to have availability of shadow
+	 * stack whenever VFORKed child releases resources via exit or exec but at the same
+	 * time we want VFORKed child to break away and establish new shadow stack if it desires
+	 *
+	 */
+	if (!enable_shstk)
+		shstk_release(t);
+
+	set_shstk_status(t, enable_shstk);
+	return 0;
+}
+
+int arch_lock_shadow_stack_status(struct task_struct *task,
+				  unsigned long arg)
+{
+	/* If shtstk not supported or not enabled on task, nothing to lock here */
+	if (!cpu_supports_shadow_stack() ||
+	    !is_shstk_enabled(task) || arg != 0)
+		return -EINVAL;
+
+	set_shstk_lock(task);
+
+	return 0;
+}

-- 
2.43.0


