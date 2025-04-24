Return-Path: <linux-arch+bounces-11545-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B79FA9A3C8
	for <lists+linux-arch@lfdr.de>; Thu, 24 Apr 2025 09:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA660463EE5
	for <lists+linux-arch@lfdr.de>; Thu, 24 Apr 2025 07:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D2E22A1E2;
	Thu, 24 Apr 2025 07:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="n6JlNIZM"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64462288D2
	for <linux-arch@vger.kernel.org>; Thu, 24 Apr 2025 07:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745479300; cv=none; b=H6/+YeCokcYa8GZp8PvZaOZTXDcDji0gcyLeGb4Vt+PTPkG6Lo1+ka8GjrW8eR7enIuzsbf2ULktCvPm7z29WkMPpTDSptZBnKUgm2xSLIkfCVHVCENlF6NMv5VJeQ72Xf9lZtTDHqctcnvn6zSUeFyok2V4s3kOVEmwMkupf18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745479300; c=relaxed/simple;
	bh=MwtlwJBNUHFndna04P1tlZjfQuYyDCB9oWGnKPvf18Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CTnWNyAU3bvpLSBNRGsbdJeTj0ZdWwCXeZ6jOJRv+VmDwfoRaIkkzCTLOm4uuszeQhRwwIPqfFApGmDzNVFWtcB9ftMIkrgYzCvM8EY8qfepie8IMtX+6LNbhchDRWvP214JTMwXPPKaSM/oU7GjD+IYUEnUhn474Toc6L0Sv1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=n6JlNIZM; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2295d78b433so7001235ad.2
        for <linux-arch@vger.kernel.org>; Thu, 24 Apr 2025 00:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745479298; x=1746084098; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cFz+/4buGG21gqDMlIHIpI2LyTeJMnqyc0qHyBDGzIU=;
        b=n6JlNIZMFkBAQsFPTPLa5Yv/BnVlaEtPh25DsHByIMDVdNPNen5hp0R6MqAkZH4WWU
         nPCffgCi9lkyDn25HLe6Wdnu4633O8M1m8tzJ//yGoewzKEVttMr6XZD076KWt+017vl
         0/DFujBzTC6k6nYZfHqgbeqTvo+7PrM2Co6MbU0fJmr/6lkTFAf1oLO47zrwMl+aNyZs
         G5RFyDpQw+t7X8y6/yZr+HN2yellrIU5TCGcGbh2b2lauMtDjFJrkTjBGrWWbmWslLwL
         6aFiG5AJ7cDX2d+Zd/cLB1vkyU2NXEF34cKrpVxvNHCEqqBE2TEQkJx+cCh5fTkTiF2t
         7d3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745479298; x=1746084098;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cFz+/4buGG21gqDMlIHIpI2LyTeJMnqyc0qHyBDGzIU=;
        b=pi43Cx8g2jPGdhJGL4XrdH5iaBSTU+MhRpYOiLZlAF4W6uxHThQyvVmN3Bq/Zb5hlK
         r5u1uHgg4nhNTRMadbXRKF8/vWDqK/zB+UXohOdsEGVoVnNO7ULXGJLLICU5Tuw6zIvo
         7qXS1V4u2Ie8w6mJqFR8hK6VlGOLXiwqwXDwHbW0vvM19JDMyShovM3/ifscs4Zias0k
         qq19vQgeprvC8NJ9o5/pCZW5MqV9Am75EL7GY0+PNH2XWux8wmXiCz6RRR1CmQ7DhXl7
         sleJAy6kQrtoehrq1tEvc+xT51ogYQksFI+plHdQJfcHOstplFRrThJGDIX8NyJSzHg+
         xP1w==
X-Forwarded-Encrypted: i=1; AJvYcCV3TRKD55sEERepH6Eq5j9fzAydMMH5WTagneDTgojgNNLp0HH3SN3z00/AsfFkXniqyUNo4RwMkgX9@vger.kernel.org
X-Gm-Message-State: AOJu0YyBQyTCXsNnh1RJAYALmf2lknCYpd/LBU+WvCfLSnnuj/zwCgxq
	xddt9gnjUGRIVKsAHSrrEtSUDjZ1g5tmTrCYAwv3/ns+86obrzuwSg3UWqcvTrA=
X-Gm-Gg: ASbGncugBYQndxkL0qHKuyIrilQkjm6w9vboK5+lmPmKHk9nuzgMMQby726aRp8lnLe
	PhmsiQPFJA0ZF/unmSGxouQ9dGQQJWeGmQDHcF0MUyVWJazjG8016WlI4/MaMWsFF8U8OX8CIH7
	J8zKKiSJKERT/a+A/nnI2UzSIhfWSwwmEHqVa0+BnzmuXsADngg6QsTRnb6ZnrwmAR164WiU9R+
	hvjXLpGFCSrUCQLLEJz+kXZfe8DiL6JRfHZolt0jgYZnjTgicxhkZe81c+jhnynoNEfpdu7V5H5
	UppxOeskEEpXaG44/BPYeSPh05Dg8ESwl2gaLzVSgXIb0Yvcw2I=
X-Google-Smtp-Source: AGHT+IEO8Xd4tVdyUa9PjnzD8nPNNIzaFyukV8ZkIipYXkGmr/TGbVqh3iRHaB96zvxslBoo9AWYIQ==
X-Received: by 2002:a17:902:e74c:b0:22d:b240:34c9 with SMTP id d9443c01a7336-22db3dc845cmr26466965ad.53.1745479298272;
        Thu, 24 Apr 2025 00:21:38 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db52163d6sm6240765ad.214.2025.04.24.00.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 00:21:37 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 24 Apr 2025 00:20:38 -0700
Subject: [PATCH v13 23/28] riscv: enable kernel access to shadow stack
 memory via FWFT sbi call
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-v5_user_cfi_series-v13-23-971437de586a@rivosinc.com>
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
 arch/riscv/kernel/asm-offsets.c |  4 ++++
 arch/riscv/kernel/head.S        | 23 +++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index 0c188aaf3925..21f99d5757b6 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -515,4 +515,8 @@ void asm_offsets(void)
 	DEFINE(FREGS_A6,	    offsetof(struct __arch_ftrace_regs, a6));
 	DEFINE(FREGS_A7,	    offsetof(struct __arch_ftrace_regs, a7));
 #endif
+	DEFINE(SBI_EXT_FWFT, SBI_EXT_FWFT);
+	DEFINE(SBI_EXT_FWFT_SET, SBI_EXT_FWFT_SET);
+	DEFINE(SBI_FWFT_SHADOW_STACK, SBI_FWFT_SHADOW_STACK);
+	DEFINE(SBI_FWFT_SET_FLAG_LOCK, SBI_FWFT_SET_FLAG_LOCK);
 }
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 356d5397b2a2..d47876eca637 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -15,6 +15,7 @@
 #include <asm/image.h>
 #include <asm/scs.h>
 #include <asm/xip_fixup.h>
+#include <asm/usercfi.h>
 #include "efi-header.S"
 
 __HEAD
@@ -164,6 +165,17 @@ secondary_start_sbi:
 	call relocate_enable_mmu
 #endif
 	call .Lsetup_trap_vector
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
 	scs_load_current
 	call smp_callin
 #endif /* CONFIG_SMP */
@@ -320,6 +332,17 @@ SYM_CODE_START(_start_kernel)
 	la tp, init_task
 	la sp, init_thread_union + THREAD_SIZE
 	addi sp, sp, -PT_SIZE_ON_STACK
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
 	scs_load_current
 
 #ifdef CONFIG_KASAN

-- 
2.43.0


