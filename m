Return-Path: <linux-arch+bounces-14203-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 667A2BF3667
	for <lists+linux-arch@lfdr.de>; Mon, 20 Oct 2025 22:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0562A425BB5
	for <lists+linux-arch@lfdr.de>; Mon, 20 Oct 2025 20:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC5C332913;
	Mon, 20 Oct 2025 20:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="Js5mAXYZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC962E0415
	for <linux-arch@vger.kernel.org>; Mon, 20 Oct 2025 20:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760991769; cv=none; b=Nh/u3bGcaf2Ivk0s7+uPDmbIaTJtyLA7M8b5uQiVuC3Oyh0ZIt2Qi/yFF8iAcMx+DgT9Mn7+zdFuXZEp950dSGxLGOFyz3WFIvqeJHYRewIKLuP1AnNUFVL0A8KIPro/HIopjGS4WBc4mr0ysNafsyk86fqOLQO4v81kHbsKGxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760991769; c=relaxed/simple;
	bh=6O/Y7lNaPncL3CoLRCG/BrN84szVrA2SetULdeO50IQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NfhkhuK/h06TDQsUssW6c4k8ovDcwRtFDLVHaJAVp7rDfTmTv13++p8IjqnkUw6Aq7pWjmiMvN+AZlJe6fSzsx4zGmNFhPY7d+Gs2i20cEbFHO2G0JN6cV5og+RV2eSI4tq3yZYeY1DdVBcCaptPxPMg8y4p6alS5d8m9uAPBHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=Js5mAXYZ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-781997d195aso3638545b3a.3
        for <linux-arch@vger.kernel.org>; Mon, 20 Oct 2025 13:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760991766; x=1761596566; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bNLdHsHLApoBXgPow7nD4EiYKLadWrqIeWAFyfWBQTM=;
        b=Js5mAXYZ7U8UU25CQAwshK63xIuZT1dOg0zimQBjr9NMFaM5GjHMeE/fcGOAaANGD0
         LHQ8iK1Ks8QYT55vv/hkiVNAhp+TFjI+Ju+v4+14EwkvIz/vYAtmsxLUSgrpcj9qCU/J
         sfNQLzSi1R6JOJ6ztCgprmCTatkOyS/MyfRfh3kDfmFt9X29Zqm0CnFE+nJD/rPhemYf
         PEsrZUsL0JYftVu01efoTowg3ln7FjL1Lw1l3/AhYLS+DypzuQonUSSj0/l4/hiKJZpe
         JRXEOfVU49NguENecp2P0jAYKCELmP+5x468P9lYxNigV7hOYj4AZCPJQIQ+tc5qLpEw
         0B0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760991766; x=1761596566;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bNLdHsHLApoBXgPow7nD4EiYKLadWrqIeWAFyfWBQTM=;
        b=gLXFKUTwvoxTfzb27liSu6mvRPX7+M6wuGAo52TYGiArXzZIE7timR0ov1bEpoEiEO
         gK9JlBJ5J0WNyqxxf2G6iNQVMV6nIucPoXsSVWH4Kbv6XWIAMO1h39knw09GLAIbz2LI
         xsVT/Id4jJJ5uRcsLqTA4Uk5n766nRkx4rteCnm+EL0meIsLgqD6PKPKT92pe1l8dTxA
         I4MrISxGKOBLQoYJuvULEsBlWRSWsR1271mrUkknC/e4IOBBAOwcRNuU5paXIC1Cp1eg
         0I355BM/73D2LLfOohQ9bOqe1gG4OAO/PsKpsye1t9NqWGwEtlOlmjzL7veytLBxWiAN
         pJQg==
X-Forwarded-Encrypted: i=1; AJvYcCVqXJgKSbMpndf4enGgOXjhbMNsgIXS+y12vNqlbw69YTLn7x0wZYKwsmqn+jV0SWYWwm/w/PrsNQ+n@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3mWAdTInEwkj9Bj0DzXpkUx7ywHzAUoUze2LUk8euxnzhY8Yh
	jEx29ZbnOg59qdJfvbIRUAf6CG0A+B6xuDSBLHAKVGIHAKvKdV1u9qSn5L/xPZN8RiU=
X-Gm-Gg: ASbGncvO3a5I+zWS/j8194rrdTS8Tc6NYE51/zjAw5u4ELtNldO1TaCwK7E95sMNKWi
	Sn/fRO2tVfT61UZQBQtEtDwZ4nomyLibGTJbRyLy5QfDAV8A5ggr7j0QULg8/rDJCAwW3a/ZT45
	kgvbyhR5IY4V29HVsupCc2wGt9qeraOTjnoL/Vl1q2C02udlnODIeVANpA0kTVzq4lfxToGvXYK
	r/0wT4DJhPn/GRL0uE+UxpC5CsP6pm7J7dkL6AMijZJE0UMQaJ3N4bvVZMUFs26hanZtYW6CRgj
	O9XmaSsVL1pmiHpfrbuVZWwYe/QR1pBQ1ECF60jZH9LdpxvLXV9bngLZVy5T9MLDGMkgMnR4P9+
	ASnOMbkVbWOzwQqMVV/sY+4BlHod2yV0pdAH8w/gLVhDIFa1VPzMFS9PGv1tOSdi5UwfZGrmbZg
	QZYqf/HLd+xim20mHmFUWs
X-Google-Smtp-Source: AGHT+IGEGkQ/GC8t0NOwkUogPjF7cO1kT60SXt/VRwKMgl2Ot2MJzGp+Dj2kvvgz4fiB3gPv8XWB0A==
X-Received: by 2002:a17:90b:2781:b0:32b:9750:10e4 with SMTP id 98e67ed59e1d1-33bcf8f9844mr16500269a91.27.1760991766307;
        Mon, 20 Oct 2025 13:22:46 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a766745dasm8443240a12.14.2025.10.20.13.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 13:22:45 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 20 Oct 2025 13:22:33 -0700
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
Message-Id: <20251020-v5_user_cfi_series-v22-4-66732256ad8f@rivosinc.com>
References: <20251020-v5_user_cfi_series-v22-0-66732256ad8f@rivosinc.com>
In-Reply-To: <20251020-v5_user_cfi_series-v22-0-66732256ad8f@rivosinc.com>
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
2.45.0


