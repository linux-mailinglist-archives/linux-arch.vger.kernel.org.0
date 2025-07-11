Return-Path: <linux-arch+bounces-12696-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4803B02512
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 21:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FE391CC248D
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 19:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8FF2F7D11;
	Fri, 11 Jul 2025 19:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="rVKoUYkc"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54192F7CF7
	for <linux-arch@vger.kernel.org>; Fri, 11 Jul 2025 19:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752263216; cv=none; b=NtJRvdRUwA8/wQSFiBXC3wiyBwcJpj0vRBZCXr170SbJLzlGIl7gI+QK0tNDtapQodDzTMX0C2exI5eM1+THIyPJ/bbaGtywyonUWaKdAXQNUBj3xHnHRfiWgPsQgIGneubF/sF/lI6Awl9TopoxHwAr2PcFaDvE89qC2SmxcS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752263216; c=relaxed/simple;
	bh=ykSXz3wnLGRA/+3+A2mDa3RMmU6JkcBGLDfL5CZd3kk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E4tbG9Jm4tLyDshZsEqN77cWhZ2Ax4NxKpWL5INgsocUdWxjBEgbhJ3gIDK2itmiiAY+GQbjf7FZ01xaq2xcO/P2cFJckX32+U3iJEio/Cl022AJemY9UmPRllz/D+FEHStclxbnTFdvsZWg+FgXQU8RFWAEC2RTvsFIgqPR114=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=rVKoUYkc; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-748d982e97cso2276311b3a.1
        for <linux-arch@vger.kernel.org>; Fri, 11 Jul 2025 12:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1752263214; x=1752868014; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Zc5n/fmBFqSLzd2InHh+oo1/6vhMJLkVEGctgWUI64=;
        b=rVKoUYkcjfoe9IIdQ/p85SNlTjm3Xnk2bKjloXmo5o6Wli++c3OeWH44fYBBAFfWm5
         Ik5GEBng2q7fn8Nm3aTvO4Wn+/CV2bLjFtRYU76QTZicLzZUQckekSm2f982hxJkdjJt
         B6qOWd27xBgT2y5FdbAQS6qLApsKzUtI0SkAcdmrurwcqS976x2v/VVjMO2SM6y0RtMe
         NuDQfEtmeR6ibl/m8fq8gM8kdATu5N/j7y6jA+86ij+zP7LPJe0AUb/LijfdIbQwMjyc
         8R9uYPQYIBaepCYeNhd1KiZEkQ3Siz7dIAyOF87oj1XI6UHZa17U3ha3jj20WASsugBd
         aH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752263214; x=1752868014;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Zc5n/fmBFqSLzd2InHh+oo1/6vhMJLkVEGctgWUI64=;
        b=S6MCJIDf8tUlimIa8Oducqjmwr17q841P2aPUn5XX5RSUIolAFLT7GjSpnIWBXEClA
         ycE1/GF5X8ID0xvQWtBbjiR8gzhz+ueb4bmblB9IK1pWsZV+GK2ysM0Z/Zhtnh/tUL2N
         W1/qTY45l6L1jajqBwK3KmYXTk5EVIw6Qrac1IxDQjt9/D6bOKVqH6IGRLCMXa126oLJ
         LDhE1S0Y+hE7EmUa1k7C9znWoZn7y4lupFiTMsGusBQ1e0uG5kjFMxRrMtZWJaBQjJVR
         0H5YAZcb2TdAZMfwyR50+SEitB6B2hRNOoKhquu8I6eUTsSVWc0ZBkBOIXG5DDbTp7fu
         L+kQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJzg9nHnqmbr+m09wMqrexlLv5CO1zWrX4Le8oGIBb6CmTYKZi31BqKE0rSGsYBsBCdPVyLditblKx@vger.kernel.org
X-Gm-Message-State: AOJu0YyRfTlzPizJESUFs57ni5yIEwRG50geoDWAH+6a3l2pbPODkKuW
	iBOEjvrz6HPVljdihJ7gE879+ejjh3eO3qN9ncFNZSNwP8eKbhN0uoXUy1xBHj7MmOw=
X-Gm-Gg: ASbGncubpKIQzwYRY38vdDanFDJt+bmXe5YNhQE+nhiLIV6DCgL8B3M9lmzCfuLD3ia
	cTFOZQ+ZF2lOXRIpZ1fpJrttIrK9f37jn6avV2jI6cgliKvA6YDJfD88XIOqVKGJ7EqCNwabUrJ
	WKNquGWBkeig6t9gfI36mRDSXt/G4jvpxX89mJsPBm0kUFgUzN6XOue9oN+Q39YiV+KgG6M9B1z
	wtJ1/HAaOIbmSWtfu8xqEgrDq1H1RLnqoOxo7bYQz3Uy5EhWWf4zXxSC4hF+EIl5SAZ3v3Tvt7w
	QJOvnYPi7fj3M0oh3uHoYkyrfPZkOgHK6RWIgyVZaK6+HnJOfYgfCK4sR/VsqQAhO41+TFBcjQj
	Xev4MOiswiPauVCLC8KyBdY2BM1/TpMKb
X-Google-Smtp-Source: AGHT+IG9YESao8E3E+NAefGQdBa7e8A7i1d/GjNrpQQsGCEH+wr+b7VKqJz9UJMRxEMoKnBp2VxK8Q==
X-Received: by 2002:a05:6a21:689:b0:230:d674:e906 with SMTP id adf61e73a8af0-2311f61b48bmr9002009637.34.1752263213908;
        Fri, 11 Jul 2025 12:46:53 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e06995sm5840977b3a.38.2025.07.11.12.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 12:46:53 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 11 Jul 2025 12:46:18 -0700
Subject: [PATCH v18 13/27] prctl: arch-agnostic prctl for indirect branch
 tracking
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-v5_user_cfi_series-v18-13-a8ee62f9f38e@rivosinc.com>
References: <20250711-v5_user_cfi_series-v18-0-a8ee62f9f38e@rivosinc.com>
In-Reply-To: <20250711-v5_user_cfi_series-v18-0-a8ee62f9f38e@rivosinc.com>
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

Three architectures (x86, aarch64, riscv) have support for indirect branch
tracking feature in a very similar fashion. On a very high level, indirect
branch tracking is a CPU feature where CPU tracks branches which uses
memory operand to perform control transfer in program. As part of this
tracking on indirect branches, CPU goes in a state where it expects a
landing pad instr on target and if not found then CPU raises some fault
(architecture dependent)

x86 landing pad instr - `ENDBRANCH`
arch64 landing pad instr - `BTI`
riscv landing instr - `lpad`

Given that three major arches have support for indirect branch tracking,
This patch makes `prctl` for indirect branch tracking arch agnostic.

To allow userspace to enable this feature for itself, following prtcls are
defined:
 - PR_GET_INDIR_BR_LP_STATUS: Gets current configured status for indirect
   branch tracking.
 - PR_SET_INDIR_BR_LP_STATUS: Sets a configuration for indirect branch
   tracking.
   Following status options are allowed
       - PR_INDIR_BR_LP_ENABLE: Enables indirect branch tracking on user
         thread.
       - PR_INDIR_BR_LP_DISABLE; Disables indirect branch tracking on user
         thread.
 - PR_LOCK_INDIR_BR_LP_STATUS: Locks configured status for indirect branch
   tracking for user thread.

Reviewed-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 include/linux/cpu.h        |  4 ++++
 include/uapi/linux/prctl.h | 27 +++++++++++++++++++++++++++
 kernel/sys.c               | 30 ++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index e6089abc28e2..e94cd69825e2 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -208,4 +208,8 @@ static inline bool cpu_mitigations_auto_nosmt(void)
 }
 #endif
 
+int arch_get_indir_br_lp_status(struct task_struct *t, unsigned long __user *status);
+int arch_set_indir_br_lp_status(struct task_struct *t, unsigned long status);
+int arch_lock_indir_br_lp_status(struct task_struct *t, unsigned long status);
+
 #endif /* _LINUX_CPU_H_ */
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 43dec6eed559..9cbb37afccda 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -371,4 +371,31 @@ struct prctl_mm_map {
 # define PR_FUTEX_HASH_GET_SLOTS	2
 # define PR_FUTEX_HASH_GET_IMMUTABLE	3
 
+/*
+ * Get the current indirect branch tracking configuration for the current
+ * thread, this will be the value configured via PR_SET_INDIR_BR_LP_STATUS.
+ */
+#define PR_GET_INDIR_BR_LP_STATUS      79
+
+/*
+ * Set the indirect branch tracking configuration. PR_INDIR_BR_LP_ENABLE will
+ * enable cpu feature for user thread, to track all indirect branches and ensure
+ * they land on arch defined landing pad instruction.
+ * x86 - If enabled, an indirect branch must land on `ENDBRANCH` instruction.
+ * arch64 - If enabled, an indirect branch must land on `BTI` instruction.
+ * riscv - If enabled, an indirect branch must land on `lpad` instruction.
+ * PR_INDIR_BR_LP_DISABLE will disable feature for user thread and indirect
+ * branches will no more be tracked by cpu to land on arch defined landing pad
+ * instruction.
+ */
+#define PR_SET_INDIR_BR_LP_STATUS      80
+# define PR_INDIR_BR_LP_ENABLE		   (1UL << 0)
+
+/*
+ * Prevent further changes to the specified indirect branch tracking
+ * configuration.  All bits may be locked via this call, including
+ * undefined bits.
+ */
+#define PR_LOCK_INDIR_BR_LP_STATUS      81
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index adc0de0aa364..af6c28dc6b71 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2341,6 +2341,21 @@ int __weak arch_lock_shadow_stack_status(struct task_struct *t, unsigned long st
 	return -EINVAL;
 }
 
+int __weak arch_get_indir_br_lp_status(struct task_struct *t, unsigned long __user *status)
+{
+	return -EINVAL;
+}
+
+int __weak arch_set_indir_br_lp_status(struct task_struct *t, unsigned long status)
+{
+	return -EINVAL;
+}
+
+int __weak arch_lock_indir_br_lp_status(struct task_struct *t, unsigned long status)
+{
+	return -EINVAL;
+}
+
 #define PR_IO_FLUSHER (PF_MEMALLOC_NOIO | PF_LOCAL_THROTTLE)
 
 #ifdef CONFIG_ANON_VMA_NAME
@@ -2824,6 +2839,21 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case PR_FUTEX_HASH:
 		error = futex_hash_prctl(arg2, arg3, arg4);
 		break;
+	case PR_GET_INDIR_BR_LP_STATUS:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = arch_get_indir_br_lp_status(me, (unsigned long __user *)arg2);
+		break;
+	case PR_SET_INDIR_BR_LP_STATUS:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = arch_set_indir_br_lp_status(me, arg2);
+		break;
+	case PR_LOCK_INDIR_BR_LP_STATUS:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = arch_lock_indir_br_lp_status(me, arg2);
+		break;
 	default:
 		trace_task_prctl_unknown(option, arg2, arg3, arg4, arg5);
 		error = -EINVAL;

-- 
2.43.0


