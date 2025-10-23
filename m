Return-Path: <linux-arch+bounces-14301-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BBAC01641
	for <lists+linux-arch@lfdr.de>; Thu, 23 Oct 2025 15:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FEDE1891F99
	for <lists+linux-arch@lfdr.de>; Thu, 23 Oct 2025 13:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84531329C51;
	Thu, 23 Oct 2025 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="VgfPjWwC"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2AC323411
	for <linux-arch@vger.kernel.org>; Thu, 23 Oct 2025 13:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225948; cv=none; b=b2k3wlk+809BV4nLvCieZXP6ci+8xfCyH6K321U+obkqBRBqJNjEM9TkcEQwUeBbeSirj5R9Q+yQszt7/j+/PGpgQkmC9itALD9kLRNepWVw4Vipg0H4HR03SRnrSyDgVHYDvsxRYZp379QIWbq+60BR1kzkFL16uLyk3tXGdU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225948; c=relaxed/simple;
	bh=kcKAh3qiYa6u+vavoC8VVP4XbgP0FdaLB3/LKiPnoo8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bJS3frBFGL1qsucHAYthDc+o00z+wpRF1iWqBE+QD1V+v+PPElfSlOc+m2uWoCNSQB8mSTtnAeWTIQp5q02kIL/70tYh+RGKc/aXSf+d10/TLVqELEjILAX7XD9lRYntLOlQ4DdxwqHHui0xygoDPuqf+NkI1lqY3h3qvLpzY9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=VgfPjWwC; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-27eceb38eb1so9064405ad.3
        for <linux-arch@vger.kernel.org>; Thu, 23 Oct 2025 06:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1761225945; x=1761830745; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VM5DlrQCbRYqN6WQC0IO67CheqmNFMHVu1qXR64a+aw=;
        b=VgfPjWwCoWA5PqEl6Lqc+gy38UGSzEaV2xrm9WRqT2ck0Em9QQKq9E32nrwPCK0Uaw
         NC5L8s3ua0BbIcE42bl3sqqaEpiYmzOwJoJsQR8+oMimBm+4tiIiWlS0M8Wjh/WKzw/q
         cvinAHVyE9dpbduFzw8tvLYqZrp7d72z7nyefpgt8Or5kATkY7eJd9T1W5QMh/Pprkhi
         2pNS2//NpNbWWbdBzUhTjoRJVpO4az6yrzHxcg2hNEngy9HmSaOLW45GTQfddQtFwNpG
         EQkolhJ6ihrX9KkbBcP+e5yki32ASDpwYSltbYt7xsKuc6GEQKqNcPFmbOgK4tFxWE/L
         UnRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761225945; x=1761830745;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VM5DlrQCbRYqN6WQC0IO67CheqmNFMHVu1qXR64a+aw=;
        b=H/mSm9GFp2bhMmfgbVkb6+9oyhJCxFSdYvRJDlgvYDTCpinr+CIjQeSxMcse3e2d68
         M2S5y6XS/f4upuMRIf6WB010PqfZ3mUmP/u7f+KvIRDu8J/vrsB50/OoJksyVNa6UjF4
         5KU6Wwf/sy1MaAhvc9ssxcuwMJYMuvNKG+iQIidwfioLALfns/aPtqHxrr88f6Q8wvwi
         mM7WSDqPnbPHwesZxfD4r0sIPE3HugElbz194g6eyXdiWVzNqfR/uWTCNNk5QHIwAnH4
         tSUOSYs3yomL8s8H8r2z+b1r6UOG0lPWtaKg5yDmVF/poNOlK/o9T+Um4jpyPuvEGAqA
         45aQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmc10VMv/8sryBK+sYAps4ngA9svXgD0jWEnk/fr4bPGggPHVcPLRLknQTstZamCMGIkOuweKc2FaI@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkd9s2OPAqGLLcL1u69Dbbc06Cyp+ySPhiwGQp2GWA3bONWooN
	myFBfsmT0gdiPRStKG2M9kn3c9BulJGHEvm8OBY7o2MSBhhyHJVlVKwdmjwp9OYr2LI=
X-Gm-Gg: ASbGncse3BKG7RZ0rSVBcpUfY5CyXAnJxY1QR/qOYxAO2Fw7iCGuEpu995px0nK1b2m
	Z7aKmh+DeySRAItseLyc7fe+QX//l3Ewik8aupkW7+ZZBJCvDdAdQSPecLHBOtIw3nZOnjbjEZQ
	ep4+9I5xWkjuI9UPsZ+lDdd19TtY7D3t+N2Mg7+mpHYZDK+8OzdK/MHOzuuAnj3oKS1OV3E2ZsT
	r8lavjDbrBg0PR7U7xSPcC6AL7I08vYedtrC7fYWN/1kyGoS0KPhi9xFqq2evusC1glkCvDXnVT
	fGok3lTwlSzif86rArXbcjYCmnghnxv6vSaVXkcajBsV8eFgA1w+NDZwMxfbOHMRMph9bZUJSC0
	rwplhjn7IyXtWOkYfADpDlvP61MFn/Srq+OC32z8Aw/49q7QGBFi2xScirNt5dzrvFWk4onlkFl
	SnjFgj8SGPl0/snhiRDE3L
X-Google-Smtp-Source: AGHT+IEy3qLITcuChtDM79cXlP4i162rfKSR20rjSZYhE6w88AMJ5HcNN3dCkLwwo8KQPtiBjUNHgw==
X-Received: by 2002:a17:902:e88e:b0:27e:f018:d312 with SMTP id d9443c01a7336-290c9cf350amr320485415ad.1.1761225945527;
        Thu, 23 Oct 2025 06:25:45 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e23e4b3sm23432035ad.103.2025.10.23.06.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 06:25:45 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 23 Oct 2025 06:25:33 -0700
Subject: [PATCH v22 04/28] riscv: zicfiss / zicfilp extension csr and bit
 definitions
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-v5_user_cfi_series-v22-4-1d53ce35d8fd@rivosinc.com>
References: <20251023-v5_user_cfi_series-v22-0-1d53ce35d8fd@rivosinc.com>
In-Reply-To: <20251023-v5_user_cfi_series-v22-0-1d53ce35d8fd@rivosinc.com>
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


