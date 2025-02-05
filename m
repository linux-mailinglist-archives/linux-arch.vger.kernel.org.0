Return-Path: <linux-arch+bounces-10029-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1613A28125
	for <lists+linux-arch@lfdr.de>; Wed,  5 Feb 2025 02:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2CB43A187D
	for <lists+linux-arch@lfdr.de>; Wed,  5 Feb 2025 01:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369FD22F3BC;
	Wed,  5 Feb 2025 01:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="jzkXzPWq"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8D422F380
	for <linux-arch@vger.kernel.org>; Wed,  5 Feb 2025 01:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738718557; cv=none; b=JKHzVwRXYw1CNi9Hv3WCCZPy97Inl/566L6rske4rnog3o9+/xyVRx5OmGiIPT6Ve0ofKRnwUjThXFu9mcabOWN0r5r14cFSQxZVNca16mFS4/KWUHGypOxnvscw9JeNPNl5RbgJelDHrLUfwIQl0Lp7fg3mKtcfso8ZLxP+6GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738718557; c=relaxed/simple;
	bh=eLCcCnwX3oMrnR0hoKevVmuVrExvCA/E4+w0/d6DmO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MGdgf22IxqenWj5OEWDPotMmRjGfcq4EC1FnK4Uh1B9/6ae6zGERcBoHhIY2SL8VEEURkVudHUcU0BeGFq4+ZX2SMGlqP577k1MBMHdOXDckrz/u08STjUPnF8qtIMpToLB+KsvkhrvG4yDfAVvfzZJbPTeTWNi1/oUhH+VvMDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=jzkXzPWq; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2f9d627b5fbso1449039a91.2
        for <linux-arch@vger.kernel.org>; Tue, 04 Feb 2025 17:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738718554; x=1739323354; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YHkNmM6XuphgUqeYDdwRc1f9MaOV9mSfy6OUDBv2dEo=;
        b=jzkXzPWqS9jRGxPPm2ky/LRBfLhC27265JBCf8SGXNdrpAsUoTYjimE0uxzLmk6j6u
         kF3m6QSZIiMA3jKHduK0WRCJYSw9jaAL6v3+wEPY3SzLq4dEBC4m41dGzrMast2UIflC
         NNDTvMt6IJA6yDKYPeSeMKCYKAjUPN3ebjYfDLvDiZQgjsKqmtFTvEC/8iQQ66tJEsBN
         hb5VD+DKFBvZPrxuMvNw4NUeVNI404dn+begFhmmtvRe983i4nfakTA0EOdiBxi5W0Il
         kpJsxqdPI6pe6sA9Fr2DkUKgEutQ6mVEfTJsTIQy/uTO91Q4WA7TxXQREPYJUbbEdY09
         pNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738718554; x=1739323354;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YHkNmM6XuphgUqeYDdwRc1f9MaOV9mSfy6OUDBv2dEo=;
        b=R5C6hoXx4s8UcYeKMmYx2KCeFO3OHdv84NhLTOQRywFsPnAX3nt4MG5+URYOk7mXO+
         Cdut088kLFED2VAElPUH/fQbdakH+Op3wFNsYT3QbsiPDmlV1uzPBg6YfUTm51O+jJ4R
         tzQyYZAXhx5G7zMT4b+OTgSBhSoM+DMehxdahnvUZfpHfQRbrJ7Lgx0917PidQJFvVdd
         Fe/G+HOS6w0EWCdRaWK5ywdHycpGGWMntQ2iEbzx+TkTd8ZLjFy7gOgc/xdBvuBBeihe
         D5SWEFWAzm3aBlCO44BT9JPiCptVOJBIO3wwW4S0XzsnYGyKRfWEk4GQ4HVnwrK90uL5
         d7fg==
X-Forwarded-Encrypted: i=1; AJvYcCX1+B0Bkzp0JMNu+vIT/4EFC34REijR83v0e8tgAJblEj3vd0migEKTKQWCjvBZe8D60taqr/HOPuvS@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4O7hzha9XOxxCWFljTWwoF/ZrADI16lZDc3xcvbj5GpdBAwHe
	MU6NBMPZunqjedSL6LDijkRI9EiNMFCaSLoL9RmGO79Z1mWWW7wXmajSnFteW38=
X-Gm-Gg: ASbGnct4XjPAhglqm3kdt9hjLfXwSXWniPEmiQG5J3Y0xc5rQt2QmTiLdBtJUd0PXtM
	3ysdtucPC9vykLqdfDuqVDFsH+M4cuxjME09p7x9JbabB60Fe1vkTcYiU6llMm7indisPW5EHEy
	417qUFW67k0Q48rCrREDOGP78RkCcqHAjdFbTAI9jNN6bJ6zgpCVV8/xizZvnrNduHS3G0WodWG
	P0lhjITwvX5nd+PReZUgFODc4BdiLbWn61PcrF13E5dDhcLZ4M1moWf/eb7L7zFNWBmkegI2FTi
	jfF57bo0+xpvtB/CFMxH7jX5mA==
X-Google-Smtp-Source: AGHT+IH0iBI7GsrizybTxNC+zOavZ1B/y8eyRteK7EdWTKItBlHpIizmBx4MRSyGuMGAUg4TIAF8EA==
X-Received: by 2002:a05:6a00:2e14:b0:725:ffe:4dae with SMTP id d2e1a72fcca58-73035122ac9mr1196692b3a.10.1738718554007;
        Tue, 04 Feb 2025 17:22:34 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69cec0fsm11457202b3a.137.2025.02.04.17.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 17:22:33 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 04 Feb 2025 17:22:08 -0800
Subject: [PATCH v9 21/26] riscv: enable kernel access to shadow stack
 memory via FWFT sbi call
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-v5_user_cfi_series-v9-21-b37a49c5205c@rivosinc.com>
References: <20250204-v5_user_cfi_series-v9-0-b37a49c5205c@rivosinc.com>
In-Reply-To: <20250204-v5_user_cfi_series-v9-0-b37a49c5205c@rivosinc.com>
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
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

Kernel will have to perform shadow stack operations on user shadow stack.
Like during signal delivery and sigreturn, shadow stack token must be
created and validated respectively. Thus shadow stack access for kernel
must be enabled.

In future when kernel shadow stacks are enabled for linux kernel, it must
be enabled as early as possible for better coverage and prevent imbalance
between regular stack and shadow stack. After `relocate_enable_mmu` has
been done, this is as early as possible it can enabled.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/kernel/asm-offsets.c |  4 ++++
 arch/riscv/kernel/head.S        | 12 ++++++++++++
 2 files changed, 16 insertions(+)

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
index 356d5397b2a2..6244408ca917 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -164,6 +164,12 @@ secondary_start_sbi:
 	call relocate_enable_mmu
 #endif
 	call .Lsetup_trap_vector
+	li a7, SBI_EXT_FWFT
+	li a6, SBI_EXT_FWFT_SET
+	li a0, SBI_FWFT_SHADOW_STACK
+	li a1, 1 /* enable supervisor to access shadow stack access */
+	li a2, SBI_FWFT_SET_FLAG_LOCK
+	ecall
 	scs_load_current
 	call smp_callin
 #endif /* CONFIG_SMP */
@@ -320,6 +326,12 @@ SYM_CODE_START(_start_kernel)
 	la tp, init_task
 	la sp, init_thread_union + THREAD_SIZE
 	addi sp, sp, -PT_SIZE_ON_STACK
+	li a7, SBI_EXT_FWFT
+	li a6, SBI_EXT_FWFT_SET
+	li a0, SBI_FWFT_SHADOW_STACK
+	li a1, 1 /* enable supervisor to access shadow stack access */
+	li a2, SBI_FWFT_SET_FLAG_LOCK
+	ecall
 	scs_load_current
 
 #ifdef CONFIG_KASAN

-- 
2.34.1


