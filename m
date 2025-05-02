Return-Path: <linux-arch+bounces-11825-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD7BAA7D06
	for <lists+linux-arch@lfdr.de>; Sat,  3 May 2025 01:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70661C04BA1
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 23:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49902676DC;
	Fri,  2 May 2025 23:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="h0ONOTQr"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA48266577
	for <linux-arch@vger.kernel.org>; Fri,  2 May 2025 23:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746228685; cv=none; b=EyYgPVj+gAJVFGR7n4pJj+W0z4BVuI0WVVLaC4XAVIufOvuZ/PM+ls4E1ptunOOluTxZHRu2422T5cX31Bq6ugRUhsNdC7oNYdKvsfOoaf5b96rCNe1jRZlghj1elX1IPfIR1k9dteawOa0nfBR2vC5tuQf3HM3OgRibZ5WPFTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746228685; c=relaxed/simple;
	bh=324Gi+TgnuaZF4Pqcfmf4w7PT4F+syG7qr9CaVrA77s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ULnLQRq++YMT/BeqDl8BbO3x9HqsMA/rkWdYUENLiifNPFlCTu/MWasP58f2VjhNCLIoWkBEaLm76Hx/h8ytXZSrhWyYsbbhcPaJkZ1b9b1WOD/c4SvwLE2W0fB/9w9s0wsUbw+ATYyJs+0nZ+l7f7wAfZzCJG89zpbpyP+7cf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=h0ONOTQr; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-227b828de00so28425965ad.1
        for <linux-arch@vger.kernel.org>; Fri, 02 May 2025 16:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1746228683; x=1746833483; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQhD4RGrPvN5KDVlO784BlCXFf+Afq7++TBvXb/ZOFY=;
        b=h0ONOTQrgqXTcAyqLo8zOeHfSsrPMThyoAqxvVOzFoG6GDb2/ktmTTxVy6CxTmPHZ3
         9JWDq36dD8H2Fut5NVCy1wCLlnz2jxl882/uk47oFsDJg1blp+o6SIxbuudXjTwMP4/J
         NPto6naIppop56JIkG/DbFrbrxQWgXz3wuQ71qJ5oHm4Lyg78QoYeb79i6T0M/robtW3
         u9VeuNJNHLrmPePdY0SU7n7iT4bNyDPs8apoRbFP+OGS49JTNkA2+RHZgNroSqNe5wVS
         f9uXI4MgK3VZO/B0fSxgM8iLXjhjtVnGAXTsSU7cHVEZIX35UrT1kPg7AFFSDgZbDs7j
         CQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746228683; x=1746833483;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQhD4RGrPvN5KDVlO784BlCXFf+Afq7++TBvXb/ZOFY=;
        b=sbRkyMljZq58swKan+pSdGMGuDdyVMpaPLRsWoHWqiQcae1RfmT6VW9mRUYF1VDQi8
         iCbzPy1zJtdmX6kxGvbpsn+KvwijrTpIUJhSd7lc9AUa3KphFkwKD6MmguoommbX9wjH
         /qed4S7dVgBAW+rxm1M+3I8gsaGjpg522gKh3EnyEs/Q37CHuBNUC0g3u1Pzc3c8qPxn
         cDxQ0F80YBB6Bj/QA8LZ/c743z7RrvH3acV9RSKXqIulJ6r2Z8/h7Y0SGgcK1zebSl/N
         XiwF+RNm/+2OJajWTkBCAZ2XsxZI1y0j/mLhdYJd97CCIs9My8CggmFxDt+JjYvohPRK
         52mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhL5GclT4a3NWhllOe75NVXgtlNCz5PqPkapl5CfISxoI8EfO2c6zifU42gVjTLWaII4bI4IZom7QM@vger.kernel.org
X-Gm-Message-State: AOJu0Yxikq95T8rhbl93vA5o6N3QVoZ7q1f6div+3e0dQYDZY1lVLsAz
	zuHULEFJRNJbEKmfA1yoxIBaxGNBE4cbUI6Ylrb21deLWj79TxiwwpVB9k07TJ8=
X-Gm-Gg: ASbGncswq1LC+VNl3vLjBzC4M24i5CNCC0qc81OBJNGifgelkFWtHeo6JV1uk4deHh0
	x+hZvWfzFumKbgjzuoAsldM/0wRC/Qyo908CbCPzW556p26MTvsnyzyLTnjSJlvi5F+FkaMxh2k
	MZDkZr5Xv7QA0o7l2R1H5aQKKzJTEj7SiPcE2+Rd5vBuE4HlLq9zqclK71DbsYLCkGn78o46hMU
	lk9qDEX38jScIf+6X7FRzYjLtycWaVHwfc4CnbN3wXXpHPG2/Q+To9RZAFei8sA1jG7sQNzMSSt
	bMYyeRKbEw2wtPHueAoAMq4qOJvlMyENVa5VH0Ofe+f/kTehZtQ=
X-Google-Smtp-Source: AGHT+IEnEyQfv6rXkDwks926L8ASoKvWOxJUNSFNEvrInJy36miwJqftmRV2Neid4SzPOgI5CvSgow==
X-Received: by 2002:a17:903:234d:b0:223:3396:15e8 with SMTP id d9443c01a7336-22e18bdf9f4mr14330285ad.22.1746228683100;
        Fri, 02 May 2025 16:31:23 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15228ff2sm13367055ad.180.2025.05.02.16.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 16:31:22 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 02 May 2025 16:30:45 -0700
Subject: [PATCH v15 14/27] riscv: Implements arch agnostic indirect branch
 tracking prctls
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-v5_user_cfi_series-v15-14-914966471885@rivosinc.com>
References: <20250502-v5_user_cfi_series-v15-0-914966471885@rivosinc.com>
In-Reply-To: <20250502-v5_user_cfi_series-v15-0-914966471885@rivosinc.com>
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

prctls implemented are:
PR_SET_INDIR_BR_LP_STATUS, PR_GET_INDIR_BR_LP_STATUS and
PR_LOCK_INDIR_BR_LP_STATUS

Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/usercfi.h | 14 +++++++
 arch/riscv/kernel/entry.S        |  2 +-
 arch/riscv/kernel/process.c      |  5 +++
 arch/riscv/kernel/usercfi.c      | 79 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 99 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/usercfi.h b/arch/riscv/include/asm/usercfi.h
index b530ff5baa6e..cea7908cdb3a 100644
--- a/arch/riscv/include/asm/usercfi.h
+++ b/arch/riscv/include/asm/usercfi.h
@@ -16,6 +16,8 @@ struct kernel_clone_args;
 struct cfi_state {
 	unsigned long ubcfi_en : 1; /* Enable for backward cfi. */
 	unsigned long ubcfi_locked : 1;
+	unsigned long ufcfi_en : 1; /* Enable for forward cfi. Note that ELP goes in sstatus */
+	unsigned long ufcfi_locked : 1;
 	unsigned long user_shdw_stk; /* Current user shadow stack pointer */
 	unsigned long shdw_stk_base; /* Base address of shadow stack */
 	unsigned long shdw_stk_size; /* size of shadow stack */
@@ -32,6 +34,10 @@ bool is_shstk_locked(struct task_struct *task);
 bool is_shstk_allocated(struct task_struct *task);
 void set_shstk_lock(struct task_struct *task);
 void set_shstk_status(struct task_struct *task, bool enable);
+bool is_indir_lp_enabled(struct task_struct *task);
+bool is_indir_lp_locked(struct task_struct *task);
+void set_indir_lp_status(struct task_struct *task, bool enable);
+void set_indir_lp_lock(struct task_struct *task);
 
 #define PR_SHADOW_STACK_SUPPORTED_STATUS_MASK (PR_SHADOW_STACK_ENABLE)
 
@@ -57,6 +63,14 @@ void set_shstk_status(struct task_struct *task, bool enable);
 
 #define set_shstk_status(task, enable)
 
+#define is_indir_lp_enabled(task) false
+
+#define is_indir_lp_locked(task) false
+
+#define set_indir_lp_status(task, enable)
+
+#define set_indir_lp_lock(task)
+
 #endif /* CONFIG_RISCV_USER_CFI */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index c4bfe2085c41..978115567bca 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -169,7 +169,7 @@ SYM_CODE_START(handle_exception)
 	 * Disable the FPU/Vector to detect illegal usage of floating point
 	 * or vector in kernel space.
 	 */
-	li t0, SR_SUM | SR_FS_VS
+	li t0, SR_SUM | SR_FS_VS | SR_ELP
 
 	REG_L s0, TASK_TI_USER_SP(tp)
 	csrrc s1, CSR_STATUS, t0
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index cd11667593fe..4587201dd81d 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -160,6 +160,11 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
 	set_shstk_status(current, false);
 	set_shstk_base(current, 0, 0);
 	set_active_shstk(current, 0);
+	/*
+	 * disable indirect branch tracking on exec.
+	 * libc will enable it later via prctl.
+	 */
+	set_indir_lp_status(current, false);
 
 #ifdef CONFIG_64BIT
 	regs->status &= ~SR_UXL;
diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
index 08620bdae696..2ebe789caa6b 100644
--- a/arch/riscv/kernel/usercfi.c
+++ b/arch/riscv/kernel/usercfi.c
@@ -72,6 +72,35 @@ void set_shstk_lock(struct task_struct *task)
 	task->thread_info.user_cfi_state.ubcfi_locked = 1;
 }
 
+bool is_indir_lp_enabled(struct task_struct *task)
+{
+	return task->thread_info.user_cfi_state.ufcfi_en;
+}
+
+bool is_indir_lp_locked(struct task_struct *task)
+{
+	return task->thread_info.user_cfi_state.ufcfi_locked;
+}
+
+void set_indir_lp_status(struct task_struct *task, bool enable)
+{
+	if (!cpu_supports_indirect_br_lp_instr())
+		return;
+
+	task->thread_info.user_cfi_state.ufcfi_en = enable ? 1 : 0;
+
+	if (enable)
+		task->thread.envcfg |= ENVCFG_LPE;
+	else
+		task->thread.envcfg &= ~ENVCFG_LPE;
+
+	csr_write(CSR_ENVCFG, task->thread.envcfg);
+}
+
+void set_indir_lp_lock(struct task_struct *task)
+{
+	task->thread_info.user_cfi_state.ufcfi_locked = 1;
+}
 /*
  * If size is 0, then to be compatible with regular stack we want it to be as big as
  * regular stack. Else PAGE_ALIGN it and return back
@@ -371,3 +400,53 @@ int arch_lock_shadow_stack_status(struct task_struct *task,
 
 	return 0;
 }
+
+int arch_get_indir_br_lp_status(struct task_struct *t, unsigned long __user *status)
+{
+	unsigned long fcfi_status = 0;
+
+	if (!cpu_supports_indirect_br_lp_instr())
+		return -EINVAL;
+
+	/* indirect branch tracking is enabled on the task or not */
+	fcfi_status |= (is_indir_lp_enabled(t) ? PR_INDIR_BR_LP_ENABLE : 0);
+
+	return copy_to_user(status, &fcfi_status, sizeof(fcfi_status)) ? -EFAULT : 0;
+}
+
+int arch_set_indir_br_lp_status(struct task_struct *t, unsigned long status)
+{
+	bool enable_indir_lp = false;
+
+	if (!cpu_supports_indirect_br_lp_instr())
+		return -EINVAL;
+
+	/* indirect branch tracking is locked and further can't be modified by user */
+	if (is_indir_lp_locked(t))
+		return -EINVAL;
+
+	/* Reject unknown flags */
+	if (status & ~PR_INDIR_BR_LP_ENABLE)
+		return -EINVAL;
+
+	enable_indir_lp = (status & PR_INDIR_BR_LP_ENABLE);
+	set_indir_lp_status(t, enable_indir_lp);
+
+	return 0;
+}
+
+int arch_lock_indir_br_lp_status(struct task_struct *task,
+				 unsigned long arg)
+{
+	/*
+	 * If indirect branch tracking is not supported or not enabled on task,
+	 * nothing to lock here
+	 */
+	if (!cpu_supports_indirect_br_lp_instr() ||
+	    !is_indir_lp_enabled(task) || arg != 0)
+		return -EINVAL;
+
+	set_indir_lp_lock(task);
+
+	return 0;
+}

-- 
2.43.0


