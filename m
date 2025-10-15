Return-Path: <linux-arch+bounces-14127-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C6262BE0089
	for <lists+linux-arch@lfdr.de>; Wed, 15 Oct 2025 20:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A486F4EF444
	for <lists+linux-arch@lfdr.de>; Wed, 15 Oct 2025 18:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5EC33CEB2;
	Wed, 15 Oct 2025 18:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="YYVlZAuc"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3383376B7
	for <linux-arch@vger.kernel.org>; Wed, 15 Oct 2025 18:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760552033; cv=none; b=K2G+BRf/8DJIxl8wh2hjMvHiH88wjVOpTKKOayJk1EF7S59wRWChAFgUjG8gGWltpw353to9ol04QjCqR/60m2d6JM5f6WnKDLjwIgxwwyqnQ9hRQXjtfBwer+PH6SQ8PGukwkY0rGvZZEaUEEfqFdtsT9YN3BOmzlOAe6PCxU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760552033; c=relaxed/simple;
	bh=kcKAh3qiYa6u+vavoC8VVP4XbgP0FdaLB3/LKiPnoo8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lLr+e/VJzur+pKnHWJqaPvkftYoW6V5BH0UG8jiFVSe58GsTP6WECHV0tXVb4aSYTpMV42/95DMgWGKRkk3MmydTlcDOOHcWoKE4lHYj2xEsd/qts0DdNyOeohkclpDCcu9ySR1y5MlB6QvBqYRaBRJ37ecg4Umg4l8/GaAUKHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=YYVlZAuc; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2909448641eso2517475ad.1
        for <linux-arch@vger.kernel.org>; Wed, 15 Oct 2025 11:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760552032; x=1761156832; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VM5DlrQCbRYqN6WQC0IO67CheqmNFMHVu1qXR64a+aw=;
        b=YYVlZAuc1Hooeh7Ud423yJ3UP1OckwMABO1ArJjh0YHZ/m5siTm7R4Rd+VmrBChUMe
         xY0iSrlmUOkp6tuXJN1oDMAX1iuZRrQYgH2omfjNDbX7wzC3JVe/rea+2kopP1a3J3WL
         uKIvoS6FHVG26y1TWla6wO2Tl/SwXc41AFz5LMZeFxbeatdvUc06KrTIi45cK5A4xukM
         au5bz2ZHqY86Jni3iDuVeuB/W/R6zFMIiESr9BBNdlSeTRBKbP0A+tBbnRYCKnCQlLjT
         eVIxNXI2PuE/ngJip7iWLi2Axo3OsAjVE3YN6shd42qOwOkKJd+DJLwNa8ft1RBEqDVg
         OgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760552032; x=1761156832;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VM5DlrQCbRYqN6WQC0IO67CheqmNFMHVu1qXR64a+aw=;
        b=ezcheyrOcT1JVAmSznszCJW+3wnu7jlUie0WQRwuWO6zclry9uoP3pnrVQdGuJbMJ8
         9Jj8PxhYJZ44pwrNeG2Pve/7U2Ep1Em0yGOOn53Zd2beogWdOa8ztdHZyilvIcyhED/q
         LX/iC8K/QQzryvCgU5CG4Dwzcq7US3bEx/eEYwLF6BAFvrg8wN1HOXaCDkwjRKy0Vop4
         BQr2seBkpOl+t9Wa4mIahn3Btgaa7oYJo8dH63fPE8nb9mbqBuWYyx6i4nKR4nLlhaGa
         iu4HzthwTgQ2n0N/OlS9rT1PBN1V8JhVwAyC65q+W+f4KE4khblWwUq8PzaKxd27F0uD
         WMSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaah3m4rBUNkACtMZ/smeJ7so1+bS3YjZS8vhClLPYI1HXBv0dMly3LmSuuT2skhQ/70eSOJmb+T+H@vger.kernel.org
X-Gm-Message-State: AOJu0Yysy6VB/2nNwQdTCpWTZpmVE+dkWa0Mge6gHOORxFCwf9gMC6Cn
	6MENQTYdrbgkEu2RMvF2FRF95WJa1BltWWZOVl8PKpcebzWXSHwdO1WmUXmVKdwuZJo=
X-Gm-Gg: ASbGncs3mqdxwCW2oi+05S3PkSjkEolR10EihGaXvUuFY+usg73yHALI3UlR/zRuRf/
	YZSgpQwmRL2lw8OuPuhCAhHu4HOhyTiXugUGBIiukKUTKb+4c4Y/x9EY5pD5k1QOV1K5CM/V/jd
	3QaDcEAkVaxZgOzG8r3VKtpli8t8f0D+xGBEMKC7essueodwbj0ZZHRE6ekt/6X6c6VbWDi2s5U
	2q7cve0I+4/jw08Y1XQgha5L/sYlOdMoXxxSCea9+Pm7QvT0bZNXJ5sGq7pUlB+TEdqDvnUTnBq
	JQAGcZxYjnmn7qT/kEJdHfgpVl6M5scSPXSvvdt/xGKh8Vq2dHbuqnhuHJiyPiXr+Lx5Rf22ZNL
	zqGdRFs20Mqwu6CnfLzm2Xg/Y4YjnV4HaP7I4F9Rn756hsySSx+dWWJfso/ditA==
X-Google-Smtp-Source: AGHT+IHf9VCcJrzomY2w47NOGMiIFXsiRbHA2ENGQOPxL+quuCn9bNzo4PbiKvmN4fVVPNoVKadYVQ==
X-Received: by 2002:a17:902:ecc2:b0:281:fd60:807d with SMTP id d9443c01a7336-290919d5389mr11770165ad.2.1760552031474;
        Wed, 15 Oct 2025 11:13:51 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909930a72esm3126625ad.21.2025.10.15.11.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 11:13:51 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 15 Oct 2025 11:13:36 -0700
Subject: [PATCH v21 04/28] riscv: zicfiss / zicfilp extension csr and bit
 definitions
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-v5_user_cfi_series-v21-4-6a07856e90e7@rivosinc.com>
References: <20251015-v5_user_cfi_series-v21-0-6a07856e90e7@rivosinc.com>
In-Reply-To: <20251015-v5_user_cfi_series-v21-0-6a07856e90e7@rivosinc.com>
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


