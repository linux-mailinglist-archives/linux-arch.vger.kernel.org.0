Return-Path: <linux-arch+bounces-12090-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25552AC1BF9
	for <lists+linux-arch@lfdr.de>; Fri, 23 May 2025 07:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0E0DA44C62
	for <lists+linux-arch@lfdr.de>; Fri, 23 May 2025 05:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B588225EF9C;
	Fri, 23 May 2025 05:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="CM8IhAzG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCCE2475F7
	for <linux-arch@vger.kernel.org>; Fri, 23 May 2025 05:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747978288; cv=none; b=akYA2TrdPkMwUtjTPDamMdpc2k8AvLTlxnPrrPOqq5vjcpxFhBTlHOeGo6h5zu1a+ufZs4yt7oAI1tQIr6ihbhDtRZszLHaOxNAaTMxX18d0tIIo76tN+6+GC74yVuR9EUa5OcFp6DqrKtpodSKRa3oGnLnTdaUVkYnHFWnZVqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747978288; c=relaxed/simple;
	bh=ynTUDLBp2gEKhFeiYfxgOCPe6wht1rOzpyg0Vu3jGXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=srevJkq0pM+hd04GgE7L4fQHeP116sciF3SphQ3sPzfiNzMqwSbgmu9/5DTyhr01us3sQyhThpfL6ZSexi2A58i+8k1AW26vyH3ogea7PcNbweXI8ojc5FK35GtHJONrUZsGvHKzIkUcZxzhOhGXCR8SqlUJu/HYLYrmsNXFuxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=CM8IhAzG; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7376dd56f8fso9952450b3a.2
        for <linux-arch@vger.kernel.org>; Thu, 22 May 2025 22:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747978286; x=1748583086; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ome3u7rmCNb01KyjL0hHySpySbFvJDab/QcqkVOgxo4=;
        b=CM8IhAzG5Sl7JMVuxVw3N0SbDQwmq56gNxvS/Z7TG8biZzuki/H6VvQaAzeufiMYdG
         hnUR05Q4x9+ZqpTTgy651LnZ0Nuk2GuC7N0f7KduWtFcNicJDmaL6TWZE0UufxpFYy85
         YWEZmq48UIo8wAaxJhKiLw08GIPzSsHu+F2EDoWJQBmXxGPtI/zL3TU85f/fhFpa43AX
         FM2L5ykB/NMYHOMb4cR30ZOgEzPdFprG8ZWYARJ2rNc5o2Y0+TQEqms74W4pX0vtZOeU
         A29XExBHONdp2IhCZ8YVrtz0bGQlXRWTGFKFv0kDupGLIYx/4TNy2gJhQ3hRJWs4ANl3
         gqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747978286; x=1748583086;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ome3u7rmCNb01KyjL0hHySpySbFvJDab/QcqkVOgxo4=;
        b=uoElGn1u4nQUa/RiBLQk4VRgV2E8g+1PmLosje9gtmwNxYdihBahp5xV6xpMRkGPTr
         MkIJQfqOm9H7TpFcRjRKMwrzhCmiP9A0FqwSp/Io1vidkmBbguoQ1bdx6+f56UMN7Tsf
         flw7/uKl9pQ38Ep1CxxJORU275mNJsR9Rz9HjeBR7GoP7iaELZjfymHZsyQH0UdrS3VF
         /hnedZcHh1/OErKUDNj/6NfiLzC0GWL18DSIyENmlwJQcapkgxKYLWWClY3Nm4omAtOT
         4EMon/LhiTDR5orkRCTonFm9eX2pXk6ee0WkAI7Q4ZZ79t9fgx6pK+gg8a6F8+StBXEQ
         a3TA==
X-Forwarded-Encrypted: i=1; AJvYcCUKsY9uGw/MYUZXUM1aoQxcNMw/2lTzFGDFzmMVrDybIja9U5ETPwIsuMjR2dakSuxvJvY9BSF5Z2N9@vger.kernel.org
X-Gm-Message-State: AOJu0YxaHFPEb6Sw1f5+7sBIZTChxasBvZeVAK77pkjpHqSjXp6mf1JE
	eOK23hMIgMRalVKyw9GMFRYaoK+sepff1XgcQlMc1xtCPgYhOZjJh0v98It5wmKs1Mw=
X-Gm-Gg: ASbGncvORdeQhuOmgRbKSVlqFqaZ2U9ZmMJQFPApzUC9jgjqD5Gb6/cMULYnV7+1kqO
	ue1OAFaDMcCEr+1WqVNCOGCGsSMbbmpVD6PBoWNUcmoiuNwZwTWgmg33k8YsLBtffI4P+d/cHal
	QwEtkvFeeVhj87FrOY6LLuZ9Cqf1Cc49DDuF++QvHql8kpzWeoNl7Wep4Z0DpVWhwl0LcYWH/l1
	0F+Nl77/AjV0MxKpuVvzHPqT+oDR0pCJmzXLtsEqScCx9tpfhJtR9btYZ8B8IToq4hqwlT+zJeG
	eKxhu4YhhRDbTUire+n9DXG3lWCsmygJNoGVhxjTzyrFVfRcFW0AlPrN2Y67e03t0NHagd6A
X-Google-Smtp-Source: AGHT+IFy9mwtZnQ/WjFKBdOPikCoEGl4650GUvlOy8QUpra7GcIJlslhC25l2UA+JFmADy0WTQ9Ftw==
X-Received: by 2002:a05:6a00:6f57:b0:73d:b1ff:c758 with SMTP id d2e1a72fcca58-742a98abbecmr38574133b3a.18.1747978286017;
        Thu, 22 May 2025 22:31:26 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a982a0a4sm12474336b3a.101.2025.05.22.22.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 22:31:25 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 22 May 2025 22:31:07 -0700
Subject: [PATCH v16 04/27] riscv: zicfiss / zicfilp extension csr and bit
 definitions
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-v5_user_cfi_series-v16-4-64f61a35eee7@rivosinc.com>
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
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

zicfiss and zicfilp extension gets enabled via b3 and b2 in *envcfg CSR.
menvcfg controls enabling for S/HS mode. henvcfg control enabling for VS
while senvcfg controls enabling for U/VU mode.

zicfilp extension extends *status CSR to hold `expected landing pad` bit.
A trap or interrupt can occur between an indirect jmp/call and target
instr. `expected landing pad` bit from CPU is recorded into xstatus CSR so
that when supervisor performs xret, `expected landing pad` state of CPU can
be restored.

zicfiss adds one new CSR
- CSR_SSP: CSR_SSP contains current shadow stack pointer.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 6fed42e37705..2f49b9663640 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -18,6 +18,15 @@
 #define SR_MPP		_AC(0x00001800, UL) /* Previously Machine */
 #define SR_SUM		_AC(0x00040000, UL) /* Supervisor User Memory Access */
 
+/* zicfilp landing pad status bit */
+#define SR_SPELP	_AC(0x00800000, UL)
+#define SR_MPELP	_AC(0x020000000000, UL)
+#ifdef CONFIG_RISCV_M_MODE
+#define SR_ELP		SR_MPELP
+#else
+#define SR_ELP		SR_SPELP
+#endif
+
 #define SR_FS		_AC(0x00006000, UL) /* Floating-point Status */
 #define SR_FS_OFF	_AC(0x00000000, UL)
 #define SR_FS_INITIAL	_AC(0x00002000, UL)
@@ -212,6 +221,8 @@
 #define ENVCFG_PMM_PMLEN_16		(_AC(0x3, ULL) << 32)
 #define ENVCFG_CBZE			(_AC(1, UL) << 7)
 #define ENVCFG_CBCFE			(_AC(1, UL) << 6)
+#define ENVCFG_LPE			(_AC(1, UL) << 2)
+#define ENVCFG_SSE			(_AC(1, UL) << 3)
 #define ENVCFG_CBIE_SHIFT		4
 #define ENVCFG_CBIE			(_AC(0x3, UL) << ENVCFG_CBIE_SHIFT)
 #define ENVCFG_CBIE_ILL			_AC(0x0, UL)
@@ -230,6 +241,11 @@
 #define SMSTATEEN0_HSENVCFG		(_ULL(1) << SMSTATEEN0_HSENVCFG_SHIFT)
 #define SMSTATEEN0_SSTATEEN0_SHIFT	63
 #define SMSTATEEN0_SSTATEEN0		(_ULL(1) << SMSTATEEN0_SSTATEEN0_SHIFT)
+/*
+ * zicfiss user mode csr
+ * CSR_SSP holds current shadow stack pointer.
+ */
+#define CSR_SSP                 0x011
 
 /* mseccfg bits */
 #define MSECCFG_PMM			ENVCFG_PMM

-- 
2.43.0


