Return-Path: <linux-arch+bounces-12108-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA0DAC1C5A
	for <lists+linux-arch@lfdr.de>; Fri, 23 May 2025 07:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9F3C506B6A
	for <lists+linux-arch@lfdr.de>; Fri, 23 May 2025 05:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EEB28B7D3;
	Fri, 23 May 2025 05:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="lhPSdUlZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DEE28B51A
	for <linux-arch@vger.kernel.org>; Fri, 23 May 2025 05:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747978348; cv=none; b=pcVPGVO1hSUdy4PzB+IsmLFTB8s/CugP/CIxPUPW87yz+XJsm4YDdWEAqVUMHZf7adwzH4IExCk+b5EFRJmAAIcWkahvdEf/giQwE+VyhoL7DG+UU6OYgbsCSvQ+sY6FSNPIVmnkAiEuWB+u3giw2oTT0rZs+Nhutr8ddccO3f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747978348; c=relaxed/simple;
	bh=fgM4DxuXyswQwWUgiwSMnk3UHniH160971fZistB2MI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NUtRZNr/0Td3w4YViGVqLVDQLXXGKtwFuztpFby9P4J+G5W+J7SvxkQHlGoxbkXEfkLopnLJvUhQXD/ZCXte7Dew4w7org2Mvxa8XNwb3WOJ1nudFQGEdbzWeXpgux5OsB1wlWOgV8TeNYmkLQ0MMBxs9Ok8ge4YTIUYKTHrDRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=lhPSdUlZ; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-af548cb1f83so7440871a12.3
        for <linux-arch@vger.kernel.org>; Thu, 22 May 2025 22:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747978345; x=1748583145; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SRVZyg5TbDWDMLZOF7W+PGgxfQ2OnZA5ElwRPiEh+VA=;
        b=lhPSdUlZwvTIBJeaW9rgffp82ffsp3MMGZ8Ib75JxKRSw1p882QhJoPNOfRs6nieL+
         s99ez/+bzxjqEXTSqMVUJviF6O5X5Edlz9ScG7vMs4GZErHk1t31FV9iIFp9mfDCq2Pp
         1gyLK1M4SraaTlZRaH5CR2a40qFU6NvquK0aAOYNqYjwiXy/+tpwV3hKnqdIoz53zW62
         leQWnYIC30YO13DKwmKr6ExM2OvxtJ53j2+olJAuAtWSrPLpqPTJosWVaf7e2th46vsd
         sd1a1Vpa95W3xalvmvImNW7XxlsK3+o+znIPIyZdBzZh//x+TKe3fmEbWXIDJPZSkh0R
         +v8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747978345; x=1748583145;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SRVZyg5TbDWDMLZOF7W+PGgxfQ2OnZA5ElwRPiEh+VA=;
        b=KjqZlXutV63RTQSRffm4dZxekDVsLjND6psY3p8n0LHz9Ul1TEb/ruJB6QzqOJnDtq
         MwZ7UiMP+CnJ6TFTfQGkidpKOoiW6m3mumQF8eMMnLbkYNCYSqlF/SYWm69N5N8gt0tw
         o6aXVp6PFSg5BSGMhiMYNWU5KCqcTwHXg3Ey4TJsqUUvFAmwWinr5XhOK3jAE5WqnCDI
         SXMGm6EzGV/h6pvizHbRIHhBfh6f4F2xTwYslAJiXB1rfcb6AHSOGGXaRm46ALVddyJI
         pbw9E6A0+TZZdrNiNLkVoXjLxtP7mMe3VfFvF6hkkDJcdHO4n/5XLOUl+H/s+t6gGY7X
         acVw==
X-Forwarded-Encrypted: i=1; AJvYcCVnssOFfSod19txVelR1UnWWUgN7igUZUFnmWhH6lq2NHgp+saxS9bEEBxkIVRgM1q/aW9iMV9D+XIu@vger.kernel.org
X-Gm-Message-State: AOJu0YyInTQuZhxtGI+LMy9in4TEytKkWmHg64Lm1F9moUYQHrLaU0+v
	jern0kuTZwm47CeQ3Fpq3f1iQkMEhNGhfFh+8B1rCZKfK51Qd3P5BYQZqQz+Hds5K1A=
X-Gm-Gg: ASbGnctx3fyjtqFzMHd3fy1oc8By5GJR1G6ZunE8xLkAas7fQykLkE/RooaDvjL1SkK
	95HTAb4bScIiXDnS0nYkVblvdFREjmWP73u2ifB2HkUYuDI9yKjDaDLV8UksbQ4CNReLcIAlrAm
	eoG5zfMMUSPFXt/JSrweRT1LnFyoOdn2Ad31JmejIbD0P2ViVl7cvi2EIxm6Jaa5Ig750U+zPw1
	e2NCyyYDe3AGZQ6MG1z5E0Tad+wNZQqWVC2HKVd6DmEP+o190iTOcXWMLUJZwwoc4WqNcnsxWqN
	8OBd0nyKrI2ffiS2Hrv24XqhP3mrkeTVar38E4akiRAj6rIeqdgF8ZwKDnkqBQ==
X-Google-Smtp-Source: AGHT+IGgDsB+8A3CR4+XkLmuNbK4RRzT3we3lC5k1xa9cQRvQgCx14SHfbPxiY0t9umJbxGQZcGV5Q==
X-Received: by 2002:a05:6a20:cfa2:b0:204:4573:d856 with SMTP id adf61e73a8af0-216fba27c2cmr39932928637.4.1747978345559;
        Thu, 22 May 2025 22:32:25 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a982a0a4sm12474336b3a.101.2025.05.22.22.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 22:32:25 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 22 May 2025 22:31:25 -0700
Subject: [PATCH v16 22/27] riscv: enable kernel access to shadow stack
 memory via FWFT sbi call
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-v5_user_cfi_series-v16-22-64f61a35eee7@rivosinc.com>
References: <20250522-v5_user_cfi_series-v16-0-64f61a35eee7@rivosinc.com>
In-Reply-To: <20250522-v5_user_cfi_series-v16-0-64f61a35eee7@rivosinc.com>
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

Kernel will have to perform shadow stack operations on user shadow stack.
Like during signal delivery and sigreturn, shadow stack token must be
created and validated respectively. Thus shadow stack access for kernel
must be enabled.

In future when kernel shadow stacks are enabled for linux kernel, it must
be enabled as early as possible for better coverage and prevent imbalance
between regular stack and shadow stack. After `relocate_enable_mmu` has
been done, this is as early as possible it can enabled.

Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/kernel/asm-offsets.c |  6 ++++++
 arch/riscv/kernel/head.S        | 27 +++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index f33945432f8f..91738394f834 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -514,4 +514,10 @@ void asm_offsets(void)
 	DEFINE(FREGS_A6,	    offsetof(struct __arch_ftrace_regs, a6));
 	DEFINE(FREGS_A7,	    offsetof(struct __arch_ftrace_regs, a7));
 #endif
+#ifdef CONFIG_RISCV_SBI
+	DEFINE(SBI_EXT_FWFT, SBI_EXT_FWFT);
+	DEFINE(SBI_EXT_FWFT_SET, SBI_EXT_FWFT_SET);
+	DEFINE(SBI_FWFT_SHADOW_STACK, SBI_FWFT_SHADOW_STACK);
+	DEFINE(SBI_FWFT_SET_FLAG_LOCK, SBI_FWFT_SET_FLAG_LOCK);
+#endif
 }
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 356d5397b2a2..7eae9a172351 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -15,6 +15,7 @@
 #include <asm/image.h>
 #include <asm/scs.h>
 #include <asm/xip_fixup.h>
+#include <asm/usercfi.h>
 #include "efi-header.S"
 
 __HEAD
@@ -164,6 +165,19 @@ secondary_start_sbi:
 	call relocate_enable_mmu
 #endif
 	call .Lsetup_trap_vector
+#if defined(CONFIG_RISCV_SBI) && defined(CONFIG_RISCV_USER_CFI)
+	li a7, SBI_EXT_FWFT
+	li a6, SBI_EXT_FWFT_SET
+	li a0, SBI_FWFT_SHADOW_STACK
+	li a1, 1 /* enable supervisor to access shadow stack access */
+	li a2, SBI_FWFT_SET_FLAG_LOCK
+	ecall
+	beqz a0, 1f
+	la a1, riscv_nousercfi
+	li a0, CMDLINE_DISABLE_RISCV_USERCFI_BCFI
+	REG_S a0, (a1)
+1:
+#endif
 	scs_load_current
 	call smp_callin
 #endif /* CONFIG_SMP */
@@ -320,6 +334,19 @@ SYM_CODE_START(_start_kernel)
 	la tp, init_task
 	la sp, init_thread_union + THREAD_SIZE
 	addi sp, sp, -PT_SIZE_ON_STACK
+#if defined(CONFIG_RISCV_SBI) && defined(CONFIG_RISCV_USER_CFI)
+	li a7, SBI_EXT_FWFT
+	li a6, SBI_EXT_FWFT_SET
+	li a0, SBI_FWFT_SHADOW_STACK
+	li a1, 1 /* enable supervisor to access shadow stack access */
+	li a2, SBI_FWFT_SET_FLAG_LOCK
+	ecall
+	beqz a0, 1f
+	la a1, riscv_nousercfi
+	li a0, CMDLINE_DISABLE_RISCV_USERCFI_BCFI
+	REG_S a0, (a1)
+1:
+#endif
 	scs_load_current
 
 #ifdef CONFIG_KASAN

-- 
2.43.0


