Return-Path: <linux-arch+bounces-11534-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7900CA9A37C
	for <lists+linux-arch@lfdr.de>; Thu, 24 Apr 2025 09:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1B28462A98
	for <lists+linux-arch@lfdr.de>; Thu, 24 Apr 2025 07:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F006C21A454;
	Thu, 24 Apr 2025 07:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="DIHCN+Rg"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B207B218EB7
	for <linux-arch@vger.kernel.org>; Thu, 24 Apr 2025 07:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745479263; cv=none; b=Ve/GxUj7lkFVeNER8Vhw0GRYDim4xWcZ6JM5zzcRpaw+iwzwNzQNLhOqrwRPbe3mmgNMvQ1d+kA4clJBJ/RGNUZWQegB8Hjkh10SjexeEtJuq4uOEEnw6g4lYgLDebshj0rMJzrxIPGTuL7UiuSCTPBqKrPLdjKEzS2UdfXa1uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745479263; c=relaxed/simple;
	bh=WYvCfYoqPAsVL7uxAGBvriu5nZ59DfxULBHPiQkQLiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XvLUC5+xXs3FxCh+owFhrcxQevDIgsWwoDcdDjBeEfemietUkSvEPq3VR2mJNVlO0usT3zYRIkpQDlhoOB2QP2Xi6uaAOGlVbUnLmBU4GIdTpVshE25HO+jTi8aGFnEb3lsnp6Qi2fNY7semmYvsPUo3Zf/LYQ7mcbG9jxpvTrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=DIHCN+Rg; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22c33677183so6493015ad.2
        for <linux-arch@vger.kernel.org>; Thu, 24 Apr 2025 00:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745479261; x=1746084061; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FXRgJQQTIltTZtvXjLQKOFjSJ5/VYtElzs6cRgkZXmg=;
        b=DIHCN+RgMmkrUpQHOVPLL81MP+wo0N5OCppCtM1A7pZiFP+bn9zJ/35rw9eYRxxGCh
         TjDbDJ+QNqHZWcNdj8o1gNVVF6rbdBhWCPUBzguJ0Xzv+aOFMzqVPY9538Y9WjUjhv1G
         OeUY0lLOLHA9uQDvEqnRmZuadllFW0/L8XoYDGpccAzbddXcn9RF4chEgKo0U51+Q/P/
         Wl8UKy6qsHmdbCb7H+mOVfsRXz3CHXXw1r3oAbqHcuGsgjqIwPRwB7RvBbbuuomgM5z1
         D598VaR4AQT3Fu0IRLKRXSLLCL2FPaPpzzpgHJq8L4EW8fWvBH+WUg0Xjn1wENCeWZTU
         WPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745479261; x=1746084061;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXRgJQQTIltTZtvXjLQKOFjSJ5/VYtElzs6cRgkZXmg=;
        b=T3ZSurHDmL+oWFb/FHW1Y620Krcw5Izo0Zid82TDS6BOa5yFBdGT8VZ1PLp4EcWPdf
         nkLvkAfU2bWZn/lYT9uLYTzeXThKF3bGxQAscsKE8ru3Ehr8MMllzrz8xiTTF5C0QWi6
         1dujCrzftAUFa8tlgXtZPys1ozASTShUwsZ1KRkuqSelFOCjqwnO7hM8j5+Q2xqT2knn
         hfevCs1/gK5YFxzCpmzPW+96m0PQdd9gBNCBWUtIQuDe7oYMpJBIJMjX+Bw5zVnWzIvw
         M61DHhhNAujXVi54iB8lnFVjcbp9ZbXLldZr2T36u++49vsmn5emxqwkli7KwzPttBwC
         lRnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU76n9kvwtvw/dHgRRa937qvBD3fi4OxlTfAny60Jw2Mb3uIHAB/dtvbTaL5v9cIuz+AetCUR1SJ3FO@vger.kernel.org
X-Gm-Message-State: AOJu0YzGuHnqm9vHqXQpTZ88xho4TB5fmvJPbuUaSTWxdyHV6yTV6uoc
	uwG4ynQzZmfKI+d/WK7nSznuFGlW4ApkJJEx66d4QBMC8jlGQ9rLjbRB0He/uTg=
X-Gm-Gg: ASbGnctrzXpOaHhBWknRq/8TMiC9M3hh22BUkACi3KwfFF2xFThrc5u0698hEDnEUdH
	anTeHbPYEfpZiWL/XPaQa6+SdpWfTOArEtFGMGUK13JLF7ZxwMgTCf2kb5t/9XYVinOvRX8rtqe
	hu+9xHzMtk+BNH839l9J/ujKbT9DOl+Ws0t87CmgTfM/8hcpjYy1+kswLsGYzxvFTILNDkI69mL
	TL+P5l/6eRZb4rk+SHqygUC2G/00IRynTM5yv1qHu64yH56zIym4vNNDLfDG+547HZF1pR9GxFZ
	zk79tyASuJEyfim+SCY3FwskdoNeBjTRH3u5jyw4YDMTFWn16N4=
X-Google-Smtp-Source: AGHT+IHL7x0iPR7lyQQWO/z10aN1zmxsOzuENrkXELFl4URl9qpz0RScJ7K4TYuMAkD0FxY4bYumUA==
X-Received: by 2002:a17:903:19c7:b0:224:1eab:97b2 with SMTP id d9443c01a7336-22db3db9430mr27781355ad.53.1745479261172;
        Thu, 24 Apr 2025 00:21:01 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db52163d6sm6240765ad.214.2025.04.24.00.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 00:21:00 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 24 Apr 2025 00:20:27 -0700
Subject: [PATCH v13 12/28] riscv: Implements arch agnostic shadow stack
 prctls
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-v5_user_cfi_series-v13-12-971437de586a@rivosinc.com>
References: <20250424-v5_user_cfi_series-v13-0-971437de586a@rivosinc.com>
In-Reply-To: <20250424-v5_user_cfi_series-v13-0-971437de586a@rivosinc.com>
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
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
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
 arch/riscv/include/asm/usercfi.h |  18 ++++++-
 arch/riscv/kernel/process.c      |   8 +++
 arch/riscv/kernel/usercfi.c      | 110 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 135 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/usercfi.h b/arch/riscv/include/asm/usercfi.h
index 82d28ac98d76..c4dcd256f19a 100644
--- a/arch/riscv/include/asm/usercfi.h
+++ b/arch/riscv/include/asm/usercfi.h
@@ -7,6 +7,7 @@
 
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
+#include <linux/prctl.h>
 
 struct task_struct;
 struct kernel_clone_args;
@@ -14,7 +15,8 @@ struct kernel_clone_args;
 #ifdef CONFIG_RISCV_USER_CFI
 struct cfi_status {
 	unsigned long ubcfi_en : 1; /* Enable for backward cfi. */
-	unsigned long rsvd : ((sizeof(unsigned long) * 8) - 1);
+	unsigned long ubcfi_locked : 1;
+	unsigned long rsvd : ((sizeof(unsigned long) * 8) - 2);
 	unsigned long user_shdw_stk; /* Current user shadow stack pointer */
 	unsigned long shdw_stk_base; /* Base address of shadow stack */
 	unsigned long shdw_stk_size; /* size of shadow stack */
@@ -27,6 +29,12 @@ void set_shstk_base(struct task_struct *task, unsigned long shstk_addr, unsigned
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
 
@@ -42,6 +50,14 @@ bool is_shstk_enabled(struct task_struct *task);
 
 #define is_shstk_enabled(task) false
 
+#define is_shstk_locked(task) false
+
+#define is_shstk_allocated(task) false
+
+#define set_shstk_lock(task)
+
+#define set_shstk_status(task, enable)
+
 #endif /* CONFIG_RISCV_USER_CFI */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 99acb6342a37..cd11667593fe 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -153,6 +153,14 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
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


