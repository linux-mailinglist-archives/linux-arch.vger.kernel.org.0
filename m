Return-Path: <linux-arch+bounces-10860-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A480A61F0E
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 22:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 740BB46304E
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 21:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768A0205AC4;
	Fri, 14 Mar 2025 21:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="jQRQsLrG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E7621480A
	for <linux-arch@vger.kernel.org>; Fri, 14 Mar 2025 21:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988427; cv=none; b=ri/+KEj3j1uypyViSscRFbCyM/w6j284tqX1ctU4SI5RbFeJEAl/vzTAGItJqxktL8PzUYv5Emb1bK/C8OqvwLtRqr4Nwd4DXmYfBakvblSSIRxKfL7CWEVWUoR86cSdTDnBX7VY4+iiIW4e12svfOSuI/rc1NmctnNYz+qWpJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988427; c=relaxed/simple;
	bh=xHMyt2C9hOJNXtWSk0pvUfAY/rCrfKN2n6/Ch1918s0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nxSllJpD0kd6iYtotwX1s/UvPAzMMYy2RqpBNNEbKgLH9qVrJ2L0VTt9ubQ8LbALcDXyr+nfT5ugLZ5ctfs51a5r2ziR3Y+vNKKte+p9XKul0utWfTzg2GZRBxjFrtLqYicTtbYWXqDarMF6I4YrWgFBMSLY5QKuyatCMPQEbTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=jQRQsLrG; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2240b4de12bso69480415ad.2
        for <linux-arch@vger.kernel.org>; Fri, 14 Mar 2025 14:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741988425; x=1742593225; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E9n3/K4KBqR/53b0jV+O9N/MxE5W9V2LBO7V34JU3SY=;
        b=jQRQsLrGes/JEvPuSMahd7tKRT7MjStgpWhhVMSewiBo7udyIFqHLZGlRJPOj1rf2k
         0uGFs6GNPoxfy7mpkMzT+pa2awgrvcFI3jAafPTBxxCgNMqTtcpC11Godx2Qq9IFkEVc
         HewRqa9TLNmiuXn5N4OQuX2l9Kc9uSNBa4gVPV5jjFOt39D8rZGSknoW6Bup1Afuea/R
         QjbcRyH3O3Gt7ZAs9XO4OaR/1L2YuUI2xxvXnMIwqDJTy8/uWnQk4FM6bIURlxygu+V6
         QlJWJ1cncaRuBp7EN51ijLzkW6sIzxQXRt/EI4jRlT8hlOn+PqTRmHA5JVaeHvB0l3us
         q5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741988425; x=1742593225;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E9n3/K4KBqR/53b0jV+O9N/MxE5W9V2LBO7V34JU3SY=;
        b=pacd8hZtplmvSvqiOoQUs8FxYQrSUO9cP0VI9EAAocB1befTjPWqxwWQibRQLXsK/i
         vpcpzjmc2jz1nvs9NSbcROAruOmq/YQMgo/Xst6pPz0cyKdYooiv1ZU0ufB64AENJ2ci
         EEQ9Gq4+H13z7dhA0ZCrZ8C1Mnf49LeYjgsUB2zQgX/34zsPlv7HPusXURN3oNzzL/zD
         g4cayCxfnrR6fYxSF+Gz/ElPXtodCgCezqbOA8Gi9hHDvoWthSmWpo6SPDNxOCy3FQS/
         jTDrHYiuLkhC1VHvGTin06wvc6I3XnlMs6at2Es/eckztsXpm2bJVhaSPH+daw4qyqc6
         58cw==
X-Forwarded-Encrypted: i=1; AJvYcCVQfs7fMH+a09qqVn6KZbaEErcqKlahxjpIBfp2/4zmzQweEiZBf15vbPmyVz/UxZurnVjrK2cN1eqV@vger.kernel.org
X-Gm-Message-State: AOJu0YzapTVmtnb+2UTy77QuqpZQKRoKRO7RtLygGmAbXr0Mt0yKRwiE
	A8YY0VwPMGq7SOf0im+H8lhKcVUhCAuAfUsNct5t/eDqZOxaBYuYksSUICJTB/s=
X-Gm-Gg: ASbGncvxNoEutdtTCDGzeqd3WBgHyF8JiFHAUF5w0leMSMQGKw5xcYxM+sqZG8qEGuB
	BrUasXthwihbnBCB36aOhuwKs/WPcV+S9hB8z7j9dyMGW/UVkJnC/cNyL1trwI7Ki9mweF8r1TZ
	OVXPjV19PSzbBSjkl2lcVWvL1KHmLU0gdCxD+yUlpTIkzdvB2QmpiSFE7v6e6YUP9ImGQJur8Kp
	QjyqMNUV2AdH9mvO+DPkJiNhOYfON4/l+wPdN++hBJjFAeCrGJTxr1flRcgvQkJT73JvH1J1CC4
	4lJVkN8qgCLJXVFnEg7sqRhrxE/xSwqJtMiepvdv8FZCNmVEPU1BSVIIGFd5z/gKFQ==
X-Google-Smtp-Source: AGHT+IElyciILdjHw/3i0RPFBnjTqOBGsA25cCwm/QkQU1/hQmx1TwMvm2SBws42y5o8HIBP24yMlw==
X-Received: by 2002:a17:902:f645:b0:216:3c36:69a7 with SMTP id d9443c01a7336-225e0b4970dmr65622535ad.45.1741988425325;
        Fri, 14 Mar 2025 14:40:25 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a6e09sm33368855ad.55.2025.03.14.14.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 14:40:24 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 14 Mar 2025 14:39:41 -0700
Subject: [PATCH v12 22/28] riscv: enable kernel access to shadow stack
 memory via FWFT sbi call
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-v5_user_cfi_series-v12-22-e51202b53138@rivosinc.com>
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
In-Reply-To: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
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
 rick.p.edgecombe@intel.com, Zong Li <zong.li@sifive.com>, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

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


