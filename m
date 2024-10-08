Return-Path: <linux-arch+bounces-7876-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 420F6995ADD
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2024 00:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEFDD2898C5
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 22:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1208227B98;
	Tue,  8 Oct 2024 22:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="o8W5vJHE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A262B227B82
	for <linux-arch@vger.kernel.org>; Tue,  8 Oct 2024 22:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728427148; cv=none; b=a++arHPVfmoF9fr+LtfkBUaT/qlkIVhPCwzC9D7+SOAS/ke6053E3tFq4Dyc/Xxe7yBQM53e+x8pX5MXGLQCTqrMdazsv3v/SvSMnT3/xrSUL78H+g8iyYAwwgYEbtTxh25zM+6y5eMr2hk4ZGf7SMvAMzrXC8dtoTyRKwj6JUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728427148; c=relaxed/simple;
	bh=0axzMG+jMLcPTkOotz3/NOaUKJsXbFkqFClsPN+H9FI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H37xuldRopWJNdixmLXGtRnYm3atPTnSjP7BKFM2U6vw9guipi3V4SIfvNoiUgtB/Q+uIG8sH1NX7Qgm4WaTq15FaDiEcmZeDhvkNncM+dQ4bOVRkhplgU08DrMcxCFgzIOfMeVWx9WAr+g6Tu73Hvk5Mo7kvsAuIllFxTfgzBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=o8W5vJHE; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71de9e1f374so3229909b3a.1
        for <linux-arch@vger.kernel.org>; Tue, 08 Oct 2024 15:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728427146; x=1729031946; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=COCNpmNzP6WC0TkslCp4YYWczFrCYYnCulBqOF+s4dc=;
        b=o8W5vJHEGeOl+DyyKVaFNZ+b5AE+AqZ40gGzKZr0afnxAiKW9Sba1oKW190eMSs6qT
         Mba4HDmmYGjg7sA1TLR8y2vyIbFMUvK30WA7LL8RoKgb7OchrNNzVJnd9OhvOVpA74lw
         MJn5KfLazI1ojIUPHaLq7lTOHXUHLtBSQi+iJjKMJLR/lZ66+OQUPxXtVhMEe7Or6PrS
         Bx0yymatiLcTAZJl/5QzkrLZEdA/rENP3g/9pnB06yej4NF/YgH13F/2j5tuW/NYCDqI
         ekk9pOkRRSXk2729h8aqbhyUPm7cbMd6wV0tS2tPjEDVTA3MAdOweCONglAylXj8FdZb
         XXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728427146; x=1729031946;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=COCNpmNzP6WC0TkslCp4YYWczFrCYYnCulBqOF+s4dc=;
        b=FvRRNqN60pJVqgzbPxOFjr1qrN+17hfaGNiFfKPVNxTvPfzjlY4Vw98AZTTiFgLj1h
         IfAs9kDKs3phQL4rG/ry0KWBW7DlSxIPZ0R7rdD/+R4cacVZqtW1to1RC1CgbkuL9FBK
         v89einvdhhxDO7IgY8caxoHEMDD2t6/R8aftCKjUXVF5bY4/EgKwpQX4CKku4u2K1jFg
         AvoX2F0BT5dul3i5U7QkjZAZbrl8uTn3uomPhXib7iKf3JVo96igH+OzrbdG0VKpuutA
         9dgj8OccCKDYMBlmLsiEMzLavkVAZ9gPsunXM88FTwmj5Il+OZYZfdNfX7htXuaeD4e6
         YoXw==
X-Forwarded-Encrypted: i=1; AJvYcCVl+f6AqH2TQiiUlE45EKOorx1KruWVQsvrH8JhmAQZJetvVkMFP4loU15ukVA0SuKsevW6uX7FFoiq@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7wupb0T3oLrYKTEzcRI3RpO1GtgvHu1rdaxPgbVhORDvtogFU
	koIQR+5PFdYw2QCh++BT/7xdMsEtTyCEFE1/8n33qXRBKZKCYlxmFMoe0Lhy4Kk=
X-Google-Smtp-Source: AGHT+IG6yIXYzR9JD2NjDYdt+nbX1nqBZC/ZCSHomZxkbURMdjlHvJ/tAFXpjz5XbsMyqRUISAOAUw==
X-Received: by 2002:a05:6a00:1487:b0:71e:49b:59c9 with SMTP id d2e1a72fcca58-71e1dbc7550mr621721b3a.24.1728427145912;
        Tue, 08 Oct 2024 15:39:05 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0ccc4b2sm6591270b3a.45.2024.10.08.15.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 15:39:05 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 08 Oct 2024 15:37:10 -0700
Subject: [PATCH v6 28/33] riscv: enable kernel access to shadow stack
 memory via FWFT sbi call
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-v5_user_cfi_series-v6-28-60d9fe073f37@rivosinc.com>
References: <20241008-v5_user_cfi_series-v6-0-60d9fe073f37@rivosinc.com>
In-Reply-To: <20241008-v5_user_cfi_series-v6-0-60d9fe073f37@rivosinc.com>
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
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
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
index 766bd33f10cb..a22ab8a41672 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -517,4 +517,8 @@ void asm_offsets(void)
 	DEFINE(FREGS_A6,	    offsetof(struct ftrace_regs, a6));
 	DEFINE(FREGS_A7,	    offsetof(struct ftrace_regs, a7));
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
2.45.0


