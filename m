Return-Path: <linux-arch+bounces-10083-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4A3A2FA17
	for <lists+linux-arch@lfdr.de>; Mon, 10 Feb 2025 21:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7BCD18867D0
	for <lists+linux-arch@lfdr.de>; Mon, 10 Feb 2025 20:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1816253345;
	Mon, 10 Feb 2025 20:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="tyUxnTe5"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C3B253320
	for <linux-arch@vger.kernel.org>; Mon, 10 Feb 2025 20:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739219214; cv=none; b=pp0LUzx6z97cZ3mXbsXAY6PR/67yKGbjvM1JTCCciCYnM9IzlRnh9kjkYw8sLcaxQ6ACQwTTBJRLrgJTIJaDu9dQ84ztwSOKBK2VPIwBMKE4cNbo4+7dmaDo+m6bVnKZseSK9GWYHygKIMw9BFYoGXoCZ1wqRv0uSgk2BzunRf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739219214; c=relaxed/simple;
	bh=f+s1qRILk5w2zoTzbSGEFuSk9CM1mNXrrF3BbhojAEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=futUtnEKQE1VyMQlX7W11knmr5vCUQyMGYSWUEvgNr+ckzYCZEPDhSIbiPupARdA6/dUuPt0KlydMzjiMmJWOLJZYRsIqg1mUDcEiH/QDT1AosUcQH3C+a8v3/uHvTKIbusGHS5Mffqxh4lwA0+QMDBVUEEyT0210GKC8VpbDWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=tyUxnTe5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f62cc4088so49822695ad.3
        for <linux-arch@vger.kernel.org>; Mon, 10 Feb 2025 12:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739219212; x=1739824012; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n3DM8zy+WllPP0TujEXFZ0Ycc0zGrpNRrMRWPkPmGZc=;
        b=tyUxnTe5k/O8VxBHNAU9eC5D16+SjAX9+p8FPxv9pAeb7+/WWor1uYommRoZGmKDfe
         tMdqBz/OBw9zS8z6TUtqJ/Goy2ehY8fF9qLtGj5MiU6aIEieZ8edHXJL50diWdSmEdyW
         eJVA+ovlOxkM+dRQgY7zMNTpHycGSyFlHAw+2BSU8ykYV9W/q0RTgARsBP4hVQRMfSFG
         jHnCQyGN6SrN+Xp5qQGLDXW1Hc9rnbpE6odBrwNovwb5yEYa4Cqzh4dsXYZ617DllOma
         IPz5RirijB/vExSt6IjqF1hf7aQhkEAbQhPwhPKwMIwyIA7WcIb7Oz0GBCdD/H+pLj1c
         K+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739219212; x=1739824012;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3DM8zy+WllPP0TujEXFZ0Ycc0zGrpNRrMRWPkPmGZc=;
        b=QGcUpIne0KeoPM9UbvVTiDEz0kDCkWi6NpClx4anCNciKtTAZi4TXILWqbVzIXXEKc
         dWFZ68P1s8+cmGSB3lTIzvTMpCIk/olRYYinfHr00N/fQPMUyiQ0DVvvQG6GA0N7ejii
         1G4UrjQfpDIdu45WiTgLW1FWOvj4hQO2oqiDQ7OU4wfMzuzMcQoYeA3LuMi+sXr9kRpU
         Wc71EzbTcnoslRABgL0K0WW7QcV+BmSlcqc4NUg0K+ArBSernQ1OmUgdUuXqHASzA/Qk
         LSvqEpsZVAX/t+UNVwQn2kzO/UKpqvUgnS3u7mnPRzqQ45bnIN5xyrfeU75bGORQ25JG
         wLvA==
X-Forwarded-Encrypted: i=1; AJvYcCXExphak5Ge7nij0ZQWH5zwLCXNehER9YtXb20br2O6osJ5SmOoJqHRNQ2sV51lbO2Uw1w/rUZbRd24@vger.kernel.org
X-Gm-Message-State: AOJu0YzMa9/uSdxEK27L1kaBHqIxkQGZHWcZIxZK60o9kYP+8PcITDfQ
	6dFzdjfhE7hZPPD5eaGxDbJbNv6xm54rAoL6UPtoCbaVop+XufvdEu+o1tqHNGQ=
X-Gm-Gg: ASbGncuV2ut76uCDH7R41YrQUQKMLQm06LLzzbr1ty6PQdQ2IyHfD0mN8XajBGAj/hk
	L5ho4Ba9KfOjqolR9TwRtoONlg3GAtWngI0rISOJrWPpv8yj4PWZ9+VUyfeDN/Ex9KmUxQqui4S
	wn68au0d+3JVwRB7QFdG3ooQLfD1Yu7lSBA/P0dxGhBz47yKNHSufKum/TaEBaAF9MO6XsYPUhH
	Ghu2oBUD/71Vh7HJgpV4x/4xmWx7M+o6uV1Ml1IufTKXHRdSDwv2iLAXPgCEXNAv9FKWT4YrYa/
	cZQUsN56h9deFdZOFP9xPczbCw==
X-Google-Smtp-Source: AGHT+IGtT2BfpGC+pxbWvm2Qtn55Phvbe3Ks/NAXxmbZaEXtXhWUE3SuxobC1K+zZICcAG0d87INng==
X-Received: by 2002:a17:903:32cb:b0:21f:dd1:8359 with SMTP id d9443c01a7336-21f4e6d2642mr247925115ad.29.1739219211966;
        Mon, 10 Feb 2025 12:26:51 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3687c187sm83711555ad.168.2025.02.10.12.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 12:26:51 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 10 Feb 2025 12:26:37 -0800
Subject: [PATCH v10 04/27] riscv: zicfiss / zicfilp extension csr and bit
 definitions
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-v5_user_cfi_series-v10-4-163dcfa31c60@rivosinc.com>
References: <20250210-v5_user_cfi_series-v10-0-163dcfa31c60@rivosinc.com>
In-Reply-To: <20250210-v5_user_cfi_series-v10-0-163dcfa31c60@rivosinc.com>
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
2.34.1


