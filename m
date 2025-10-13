Return-Path: <linux-arch+bounces-14063-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD93BD66F2
	for <lists+linux-arch@lfdr.de>; Mon, 13 Oct 2025 23:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14ACC407935
	for <lists+linux-arch@lfdr.de>; Mon, 13 Oct 2025 21:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBFE3093C4;
	Mon, 13 Oct 2025 21:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="M7S3UxZe"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8477C2FDC42
	for <linux-arch@vger.kernel.org>; Mon, 13 Oct 2025 21:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760392569; cv=none; b=Pc2vX2cjjjyYCavbfZld5FQYo/f0xBPT4z36Wh4nBOlx5lPsagemT5a5rcZ5DAbEPgqRgGuHmNgkFR8TGxMZ21JwvpAUKaFG3wnm+JrhqItr9efr4p2WJOw5CrHez6NeoX635PYRC/KCfFIiwYfngzPH/9WZ4KxFEpmUbKwScNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760392569; c=relaxed/simple;
	bh=kcKAh3qiYa6u+vavoC8VVP4XbgP0FdaLB3/LKiPnoo8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ds9Di0o5f/VWGbxxAnqMrSMFAyKgWHvD784dgxWaA8ZOUuxGeVMxe3CGwymAOZ30kUgwCvV9fvaZ6FaRC6D8j2GUl8bT0oESkGf8JMaShKkv5gYOxeHaK3hcTJDE+/jlic+sfWWMKwqBdhivxBUf+M2yyKYzvWpk2wKhmHVZXto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=M7S3UxZe; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-330631e534eso5041045a91.0
        for <linux-arch@vger.kernel.org>; Mon, 13 Oct 2025 14:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760392567; x=1760997367; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VM5DlrQCbRYqN6WQC0IO67CheqmNFMHVu1qXR64a+aw=;
        b=M7S3UxZe7hFGWfgNneqeQQbb09etUMsP1GAKYhIvdzV//Rof733krKGwOVdZsmTtd2
         g47wnUVzp4sPaERd4Gy6Y/ysVsWK0fJnVPlNoJn+c7zZ01LaM+EzF//1x7ZwS+cvwu6q
         OSKOg0oNEtqeVzrpTtb9n+v55GNxnadvdD6SJbJmrez2jfIGDuIrx44KliexoFulHIcP
         ycVfDnoARZqtY2lCpxmx/HB5+1SXtPsfXX5DCghuZXTTtT+ZvIhTtXhl0VpSp5Sbd7Ct
         38TTPTalT614s08JMJC6AVYdYfBPHrBJe+tKG93X3BwLkbHXZJG+2QOQE5QP/hvme/Y2
         dmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760392567; x=1760997367;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VM5DlrQCbRYqN6WQC0IO67CheqmNFMHVu1qXR64a+aw=;
        b=XJYG2EjuRyirebJGLqv2zkhE6ktGlElCcDfRp9MSuIkOzncogflY+4wR0YRS9ZcGJP
         fb4PFbvQrw3K5C2eSYTImVIeSerMXDphmb+QYkv88FK7Fd8mZWucD298cRsH/l8xR2+I
         17mZNZjJRDHezptB8x8hUfbytVzgNy7cDEzCzuBQyvBEGyi3xvRlrZQ4GlBvuBfc5rUl
         Z3fRcb/82Rjg3OfumTydllKIPebrHaCQkNIsoxWfaiLQGAkBog+9HDMR5eQ8YMRRHUJV
         q9l17GdEE/kYbUqj6pBXsXPl8MLHPHBaZN+rQU8OqRBS9KbZ0grPItXJnjWudu/Ykrez
         ZzJw==
X-Forwarded-Encrypted: i=1; AJvYcCUji/qzUYvqR1nWmvVLlTSpNXot0CwisCL++JecIkCNuSpQhUnZ7P+osje/P/JE7BVxqDTSq62zOsYN@vger.kernel.org
X-Gm-Message-State: AOJu0YzI+F/h7fyUzpOoJgegTX6sFQw06tiSS8VQidJViLPvuS3TOO2u
	EKlH8YsTFoc7G46iGWJ+0qi75eKQxUVacDbqMSszrgzysXetTYre7MIZFZajN8EJbuE=
X-Gm-Gg: ASbGncsdrSiwcjXfylTPZ1KwYxUrzIXe4/SqhRZh/2LB+PnM81wl/+Rhm3f4DxdKE02
	TKS5UoesiQxgDHqV97uuRJlSi3CTl+drOBulfLIRuEObtjkvUkGJ5n5vfoiU6nnuGympcqE1Q3M
	OPyc7eAKe9GBcw/okYuUAyo3LXp2Ra6f1tdAI3J9Gqot7nUeT5j3YOektPb+rgxJdlWn94gKzzs
	zXUEjwgLqGrubbbpjAyUIkpBFFBxnc9JmDY76Co6y8DcNASPVAfQ0VcqNKD8RfCq+/Qh3Hnw5nP
	9VJZaywiA/yumivSDG2HgwmQKNw41G2geLUGGFdZDqTd6e5GY0h/tGuQ2EnzaxHk51tqk4kyEr+
	oKiV9H/9r2deaaNX68NI/CJYYHnX2d0rY5OhWvVUyp7+eGC2Bhtg=
X-Google-Smtp-Source: AGHT+IEk8C0wXtpiaSerIOmMVJ34V19j3qCgt/dP0k/QOvSZF8SGdHByWOIwcunMLrrPAiMMdWB6bA==
X-Received: by 2002:a17:90b:1d85:b0:32b:623d:ee91 with SMTP id 98e67ed59e1d1-33b5138623dmr30507133a91.27.1760392566692;
        Mon, 13 Oct 2025 14:56:06 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626bb49esm13143212a91.12.2025.10.13.14.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 14:56:06 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 13 Oct 2025 14:55:56 -0700
Subject: [PATCH v20 04/28] riscv: zicfiss / zicfilp extension csr and bit
 definitions
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-v5_user_cfi_series-v20-4-b9de4be9912e@rivosinc.com>
References: <20251013-v5_user_cfi_series-v20-0-b9de4be9912e@rivosinc.com>
In-Reply-To: <20251013-v5_user_cfi_series-v20-0-b9de4be9912e@rivosinc.com>
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
index 4a37a98398ad..78f573ab4c53 100644
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


