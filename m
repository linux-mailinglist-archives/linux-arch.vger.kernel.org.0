Return-Path: <linux-arch+bounces-11525-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78870A9A344
	for <lists+linux-arch@lfdr.de>; Thu, 24 Apr 2025 09:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B115E4486F3
	for <lists+linux-arch@lfdr.de>; Thu, 24 Apr 2025 07:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAA41F866B;
	Thu, 24 Apr 2025 07:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="zPLLprJi"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544EB1F4CA8
	for <linux-arch@vger.kernel.org>; Thu, 24 Apr 2025 07:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745479235; cv=none; b=CHW3/+z3A6Jk8RrKtE7F8TfO1D8AT/SXH+sartqetYCg183cD8KBQqGgqAj3SL04LlJxhgXG0mkEQ3zPbfnUBaKYwi500aSfhD3K5PMHW2bkWY5kWn8E9GnSVO54VreTZo3IEiqx4GL1ULpasqMtvVPrdVybtRVaUC1+fOm/v70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745479235; c=relaxed/simple;
	bh=YiI6TMs05N0ICwVw2FQ+LZvcu9OrjM2Y86NWT7pgk2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J2w/Y5eWuuQcrbtfx7ZxW0cfHUqoBkXU1heOcMd15ibB3yXB0P5O2JmIPmElweVAC8d+u5gOSBMMm2yloqWQ6jZUU4wxSx//OJA07Q2CZCaWuNkD/n1y6nSFLIpCgu/k7tLWt599VpKRExrPuH61YGR9WFCf4zupS9/QC9ellXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=zPLLprJi; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-227c7e57da2so5396265ad.0
        for <linux-arch@vger.kernel.org>; Thu, 24 Apr 2025 00:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745479231; x=1746084031; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=asCIAXUzDRo1up/0JSFmu+IjLgmwP2Bompu+f7bkHCo=;
        b=zPLLprJimVZtYp1z5bErsE+re7ZY3ZOVKlKEii8t5KiDc9T8dhtbPdv+v5PpXRwDWG
         aLVDp0vRyImr0q/ftxR6Vze3r9Cqi6FDYVekmOEgVOXITssSGEQj2abaTZ22F+cBcZrz
         l7xm8bjEL+ZfydN+wZSMmhDpegFmQrF1dM181NLAJS2d8E9pxN2XPhVE1n22LFVz2bzN
         p3yRfJ8bLbSjEjfcTVvfgp1TfvWsaO1sOBmq72c6Fx3lSmpzVtyOzBUbwNqOYXVEryuo
         g3P2ugQ8ITwhjHpJz7O/BuWfY9hbwkDXGt5aCcGx7gGQnZEQwrZv6t0ihjIo1TakNHNN
         iv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745479231; x=1746084031;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asCIAXUzDRo1up/0JSFmu+IjLgmwP2Bompu+f7bkHCo=;
        b=Wj4IkVpDjlwBbyFKX1Y9Z8DbgZ+1gmxXlL55aMXLKIcZ4HrQ6wAUyKHNA3qBTFTV3+
         pFCUU9tQ5DyrPxmVgBNWYJIHDa9GWIIhFMxBLBK46uYS46ua+jVLad3k13YU6p64mL62
         ThgjumvCDPuoEmSfigpZq5txThj3qqAF9//CzbUHTx7uZlkkKX77HeiMzEvMZeiFx7BZ
         npVMbUD9e9tFqwLApjLrkb6sAsC7dYmOQQbQ4ZxlJ1qn2vuD7+O9CX/8Cz1SJcgVO10g
         0yww42kxuQR6BKKyBs50uAlhK8slJDHjthbr4tYGzF0IFYolAgCo3XLsAczeEdDaKopz
         MCPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKUioO6T4oQIG/kSpXu+6guJfCDHkJItFKKaLv8mBc0/5TImXZr+VRwB4U+K5knoqzea/4jSv1kmci@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5YsTJ1b4kdufy24aj5b/D1a92NgXP9TTt3bwSRRTsUKdJQ1J4
	j7Qnn+JNSWBfJX7nV5QU6BOIKJ2oTJFCoDPD8rgKUgKNA6K4QGi8ffWDs0I9nvM=
X-Gm-Gg: ASbGnctiDv9d5Laps4iMCSLiDt1iTaN4ZS/8+Fy02ZOzGRLUSW84i+W97+RgsRvj1vf
	n3JfxC8NlMzYi/yE5yjHSJpy/kNj6O8wbiBtcpukCYy5w8z/5MAkioCNDLXMlwILsl65LMoN4Nh
	0O7/0TZFXVDwDKXWFWgUCon7oULo1EmoLKoMnhc5VCoAKRs1uiuovdxjcyTiLmwd3DM/Qz5QCQa
	YhVWe0yk95LY5GIQMlDKMQbtxI6+kakMIu4D+iCC6CVD1cURuuTYIHtKDabq7h4qtvqAL0p3JKL
	nNgjDg/cDQcwdsToQlKkU5QDWwm1EpcPRvTTeWlKk/H0YoIqq6pXUmlhJjfIfA==
X-Google-Smtp-Source: AGHT+IHtewISg2Qylh/d/NYNsAqReuiifVQYnNIETRLUu60z3NFTKSNENr9AYd/4nxJezDALdj+kzQ==
X-Received: by 2002:a17:903:22d1:b0:21f:4c8b:c514 with SMTP id d9443c01a7336-22db3d9c133mr21697835ad.45.1745479231231;
        Thu, 24 Apr 2025 00:20:31 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db52163d6sm6240765ad.214.2025.04.24.00.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 00:20:30 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 24 Apr 2025 00:20:18 -0700
Subject: [PATCH v13 03/28] riscv: zicfiss / zicfilp enumeration
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-v5_user_cfi_series-v13-3-971437de586a@rivosinc.com>
References: <20250424-v5_user_cfi_series-v13-0-971437de586a@rivosinc.com>
In-Reply-To: <20250424-v5_user_cfi_series-v13-0-971437de586a@rivosinc.com>
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
 Zong Li <zong.li@sifive.com>, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

This patch adds support for detecting zicfiss and zicfilp. zicfiss and
zicfilp stands for unprivleged integer spec extension for shadow stack
and branch tracking on indirect branches, respectively.

This patch looks for zicfiss and zicfilp in device tree and accordinlgy
lights up bit in cpu feature bitmap. Furthermore this patch adds detection
utility functions to return whether shadow stack or landing pads are
supported by cpu.

Reviewed-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/cpufeature.h | 12 ++++++++++++
 arch/riscv/include/asm/hwcap.h      |  2 ++
 arch/riscv/include/asm/processor.h  |  1 +
 arch/riscv/kernel/cpufeature.c      | 13 +++++++++++++
 4 files changed, 28 insertions(+)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 569140d6e639..603f4f23432e 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -137,4 +137,16 @@ static __always_inline bool riscv_cpu_has_extension_unlikely(int cpu, const unsi
 	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
 }
 
+static inline bool cpu_supports_shadow_stack(void)
+{
+	return (IS_ENABLED(CONFIG_RISCV_USER_CFI) &&
+		riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICFISS));
+}
+
+static inline bool cpu_supports_indirect_br_lp_instr(void)
+{
+	return (IS_ENABLED(CONFIG_RISCV_USER_CFI) &&
+		riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICFILP));
+}
+
 #endif
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 869da082252a..2dc4232bdb3e 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -100,6 +100,8 @@
 #define RISCV_ISA_EXT_ZICCRSE		91
 #define RISCV_ISA_EXT_SVADE		92
 #define RISCV_ISA_EXT_SVADU		93
+#define RISCV_ISA_EXT_ZICFILP		94
+#define RISCV_ISA_EXT_ZICFISS		95
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 5f56eb9d114a..e3aba3336e63 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -13,6 +13,7 @@
 #include <vdso/processor.h>
 
 #include <asm/ptrace.h>
+#include <asm/hwcap.h>
 
 #define arch_get_mmap_end(addr, len, flags)			\
 ({								\
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index c6ba750536c3..82065cc55822 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -150,6 +150,15 @@ static int riscv_ext_svadu_validate(const struct riscv_isa_ext_data *data,
 	return 0;
 }
 
+static int riscv_cfi_validate(const struct riscv_isa_ext_data *data,
+			      const unsigned long *isa_bitmap)
+{
+	if (!IS_ENABLED(CONFIG_RISCV_USER_CFI))
+		return -EINVAL;
+
+	return 0;
+}
+
 static const unsigned int riscv_zk_bundled_exts[] = {
 	RISCV_ISA_EXT_ZBKB,
 	RISCV_ISA_EXT_ZBKC,
@@ -333,6 +342,10 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicboz, RISCV_ISA_EXT_ZICBOZ, riscv_xlinuxenvcfg_exts,
 					  riscv_ext_zicboz_validate),
 	__RISCV_ISA_EXT_DATA(ziccrse, RISCV_ISA_EXT_ZICCRSE),
+	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicfilp, RISCV_ISA_EXT_ZICFILP, riscv_xlinuxenvcfg_exts,
+					  riscv_cfi_validate),
+	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicfiss, RISCV_ISA_EXT_ZICFISS, riscv_xlinuxenvcfg_exts,
+					  riscv_cfi_validate),
 	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
 	__RISCV_ISA_EXT_DATA(zicond, RISCV_ISA_EXT_ZICOND),
 	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),

-- 
2.43.0


