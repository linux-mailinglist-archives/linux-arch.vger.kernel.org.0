Return-Path: <linux-arch+bounces-7532-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BC798C282
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 18:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B97221C24035
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 16:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0FC1CDA1C;
	Tue,  1 Oct 2024 16:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="swUzBBIN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BE21CDA13
	for <linux-arch@vger.kernel.org>; Tue,  1 Oct 2024 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727798847; cv=none; b=M187+ExKxCaf3ETyiYnFgSPH5cnRgS29/MhfTK4RXcmHMX9vHG9QT8ZwFDOpNYPgfvlBEAW4C4KRlO6ivR1eKWBJZkmBIO7iyhFUwUHJKrMOeRqFlY9OcAA50eIWHQmfUpYgyfPG2VuxojFUPhlPiOwL5R9bTH8jV5moeG6SlQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727798847; c=relaxed/simple;
	bh=DQZ+f8skAijkGaQUPxzGElVLvVkTCbU5tb3LJJ3G8+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qnlZ9oRX01KW7LwHUv4afmAXxqRkAYnE8zUEcKXBH2GjMAQhB0PSEZM4zKNCL6b+ioWQeOm18Xh93MP6aGWgRIr/4b/UKVIWqAxDh/6X3ui99XyoyliIqEiUSEZHQniqHIcxwC1I6jAGVqOGyVcE1Pl0S9/S9pXed1Dxmy3pb3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=swUzBBIN; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e137183587so1802656a91.3
        for <linux-arch@vger.kernel.org>; Tue, 01 Oct 2024 09:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1727798843; x=1728403643; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YzRPf3gSm1oBJZUnyk2tQznTd/0pm5tuC+PNjTYOgOw=;
        b=swUzBBINQbmShGfxFr2JISxgRXZlkc7/9kiNKpfS49hnAedY7burpc5owwFYmfWYkt
         O02p1k+atEDGYC3nxDfnx3lXYQ1PXRtaI68s5a4PIXHpYArRB3VXWyo7L7KSRuCBu3Gs
         AJoGRF2uYGuz6F2hJXokr+jWX873qqwKuk2V1kbWcp4o6Fu4zFwlqFesKyuGZFm5IQX0
         TnOak5Vy0BBWxj0oWH6J7RC+dOWv1cUlvtqAahfTrWyYOvl93Egg0y4iFnBJn0Tskvb4
         cTZn4HpipdAQnukufhUxpeSG3TqihVBYUT6weIE+BR+x3nuHCLWNRzYZoFjY/cVTnRxE
         Qyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727798843; x=1728403643;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzRPf3gSm1oBJZUnyk2tQznTd/0pm5tuC+PNjTYOgOw=;
        b=qU5FpWdh9XALKIaE9Vmtt8LYiCa/7aYyC3rIFJKR+/DWeEsG45ftcYokqVSNjySAvp
         0BrRLCVde56uB76euBBlXLgw34SSpkVVOhql8p1daQZGlN2xT/yE/5QUbxf+7TGjL0Hz
         lWCIKht7CJ9lnQDPEW5CWXDq7Q5tMxz+ipukNZFwKewBvOz16rURObh6sCLsZI2kZNJD
         sk1/bS0f1vYS+r9tZGvuFIY5aH4La/zXNj2k483Ig8H6oZaXpTOVl5apEfGI5LdXSoUI
         IXxMhqxb2RBK6aXO5mJHZmnp6nduWrUmxQIiXN9AD/9NA24nkg+K8sAeNTkvnYbymJqr
         c3vw==
X-Forwarded-Encrypted: i=1; AJvYcCWnuICnsEdY3qbGvG/ufpE9S2ROQfnyEr+Ep1cUpu4lg9ITyiPAOsjB4wlzBekqR/ezRGyeymQ93de5@vger.kernel.org
X-Gm-Message-State: AOJu0YzcxChOovxRAhluhtGcFuIb08pmHHynDc9r7sCbmnlgVhMZZt+d
	em9+FH11IkELVSmcrO9A4UXPpkPtUVeWBYYHvgBHaL6UOdYTZ5yYScYrV0dsuRI=
X-Google-Smtp-Source: AGHT+IFUtHGSqw39cY/b30rSSzM+TWp/wCUKZ0BHqFADXvXCzXnqk0YyVIrTqxVHl/zzcyJlxVk2Ag==
X-Received: by 2002:a17:90a:7103:b0:2dd:6a40:dd86 with SMTP id 98e67ed59e1d1-2e18468601cmr227883a91.16.1727798843238;
        Tue, 01 Oct 2024 09:07:23 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e1d7d47sm13843973a91.28.2024.10.01.09.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 09:07:22 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 01 Oct 2024 09:06:14 -0700
Subject: [PATCH 09/33] riscv: zicfiss / zicfilp extension csr and bit
 definitions
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-v5_user_cfi_series-v1-9-3ba65b6e550f@rivosinc.com>
References: <20241001-v5_user_cfi_series-v1-0-3ba65b6e550f@rivosinc.com>
In-Reply-To: <20241001-v5_user_cfi_series-v1-0-3ba65b6e550f@rivosinc.com>
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
index 25966995da04..af7ed9bedaee 100644
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
@@ -197,6 +206,8 @@
 #define ENVCFG_PBMTE			(_AC(1, ULL) << 62)
 #define ENVCFG_CBZE			(_AC(1, UL) << 7)
 #define ENVCFG_CBCFE			(_AC(1, UL) << 6)
+#define ENVCFG_LPE			(_AC(1, UL) << 2)
+#define ENVCFG_SSE			(_AC(1, UL) << 3)
 #define ENVCFG_CBIE_SHIFT		4
 #define ENVCFG_CBIE			(_AC(0x3, UL) << ENVCFG_CBIE_SHIFT)
 #define ENVCFG_CBIE_ILL			_AC(0x0, UL)
@@ -215,6 +226,11 @@
 #define SMSTATEEN0_HSENVCFG		(_ULL(1) << SMSTATEEN0_HSENVCFG_SHIFT)
 #define SMSTATEEN0_SSTATEEN0_SHIFT	63
 #define SMSTATEEN0_SSTATEEN0		(_ULL(1) << SMSTATEEN0_SSTATEEN0_SHIFT)
+/*
+ * zicfiss user mode csr
+ * CSR_SSP holds current shadow stack pointer.
+ */
+#define CSR_SSP                 0x011
 
 /* symbolic CSR names: */
 #define CSR_CYCLE		0xc00

-- 
2.45.0


