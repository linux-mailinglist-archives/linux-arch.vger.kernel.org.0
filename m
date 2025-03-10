Return-Path: <linux-arch+bounces-10635-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BA4A598E1
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 16:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5B58189090B
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 15:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B648423E25B;
	Mon, 10 Mar 2025 14:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="FlqsXr2t"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD7F23C8C7
	for <linux-arch@vger.kernel.org>; Mon, 10 Mar 2025 14:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741618411; cv=none; b=nR2fZ9Y21xFoPA8Xo1Jmrt03ndNJJPXjVFnnbs4Aq4vogIKht3dheNv0N1WyiNPRgkNeFeG1omYHOyyTHf7pGGaPRX+U+76SsA59lpwYvCDI0/m90ltGfvFyygwBxzgmEYy0RSKWqHGLDKAEveWqafxiiGeYDP8sFIJS8lszj08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741618411; c=relaxed/simple;
	bh=ZyOnJKWlzXtbmES+BvhM6pQYqEddvDRTqnmzVnKP/PM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rd/CYUWpRpXxCJu6q7mGIVUJe0itbS0bxlzJ77hxDsfhh3kvNnyEnIwxB418fHYxKyMKN5LzNtBqaKzqPowhmcUEG3wYKShiL1id0MEB1VqLpXPOoAnPDMyFTxcYOLkBoYYHyx6OO6/v+7hhkNlUE2gEW2+YiSZrrARJ5aPdN8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=FlqsXr2t; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-219f8263ae0so81552435ad.0
        for <linux-arch@vger.kernel.org>; Mon, 10 Mar 2025 07:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741618409; x=1742223209; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U5ByeyW+YvFTHyUcGUYHAQSBVf/eKXKcnHA82UZlOkk=;
        b=FlqsXr2t3BG149e5/H3c6GJX4gDschb0USesSOT/o/BDd7PlLc870z7XoWl7noRg0P
         ZEiScFswFIHkSRyT2/VmupApLjTlg9sWbF94sM3J5ll3d+UwspWsUbwvX/RCE8UJHeLO
         Cdnma9dot/xP1RQlweYhiWTszsEXLMHPEdlHZ4gDAfno9Z4OLhr6E/yvbiEbi9DPwE6i
         buN4fDvaSHT8blO7D5KMYtmJtJUzrCbEOxb38vTGnbCCcS/ZAG7p4RVXS0/ui7f/k5BW
         3PrCSUm7BSPpNPNQ0ZGUJSMDA2yzVDlxwRMyHmHGV088aiup8C1e3nOwGZJPOLuymPft
         HiiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741618409; x=1742223209;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5ByeyW+YvFTHyUcGUYHAQSBVf/eKXKcnHA82UZlOkk=;
        b=MKaaxjERt0PxdLPlaCTShVoKzwp+8pIUsuAwZnbbpiVOlT/eW3R6jrdOQ7PAlQf95O
         djfEdDIDmHZhVQlhjZ8OcxmD62JxlB6hMRXvfmxZCzGtCcBzooU3SKZ3UoiHK66QJLVt
         sIiWOnswmG9OCZd68qqdJtYBDPPzP+Gfa5c7OGcB7KXhEmaLTFBtXEgf2WNFXbqvKYhk
         3o5C4nUt7bPIAD+o5LPG43nXS+YompLalCT4NksMqFCQZI2JVLHj2pTGQ5GdWh5zYpNR
         smzqcFbe7A+DkRHmIz3DG43720/eKtzvG+dyShQBKCssW4fCcv9eo8T4JA4weCfustV5
         akhg==
X-Forwarded-Encrypted: i=1; AJvYcCV5AFbBZcdfkZ6Eq3T0r4oqESzusCJgtCDobLjz5wO4qPYdaJTZirYZGBGZCbj+um+qShtFTgrCDNS6@vger.kernel.org
X-Gm-Message-State: AOJu0YxZMPxF94KRVGnh5oy1jDxZ48SOfYdZA2p/eoTBrh4qdha59n5C
	970dcqTBCk2mVtY6m9TcK49qm/5l9Cov6fbrtabuqWHO5ycWmhW/xvhoxl3+xXQ=
X-Gm-Gg: ASbGncvt8y8ixeabV7a8u7a7l52Tw+sYokMQIk57+9EgIS/OdBoS/CUJ6WV6k1ivp63
	fA/GO7W3Mn5OUzOPh5RU7IcNq6pwu3gN1rbLFbQEobByUQJT852EMbLwKE9anBB6IOlWqFQMEVK
	hS0mkosAQWiCKYKnhl882oemfjJBvQvRH12WE5YD9xnzRRaXeBTiRVrUxcxnDz4yFG3WWw0n7gM
	cVUikcZEStrvAsI3J7osx858tjB/5p7Zlu1gWlUMpWH6ml2+4FKl6nYW2IlISGw94C816GZT8Y3
	AM15O96rxLBVXYvtOUq9oYzIve1QosaGccdVTFfJtClCLCYj0RdEuoA=
X-Google-Smtp-Source: AGHT+IGKXHgNMuKPuSz9mbzSVY6kbhzly1ukgPS10UZrRIAfMtlVXU0y2E7jj8WGEeH+e3hYVRFUmw==
X-Received: by 2002:a05:6a00:10d5:b0:736:47a5:e268 with SMTP id d2e1a72fcca58-736eb7b363bmr272521b3a.1.1741618408950;
        Mon, 10 Mar 2025 07:53:28 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736d11d4600sm2890275b3a.116.2025.03.10.07.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:53:28 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 10 Mar 2025 07:52:45 -0700
Subject: [PATCH v11 23/27] arch/riscv: compile vdso with landing pad
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-v5_user_cfi_series-v11-23-86b36cbfb910@rivosinc.com>
References: <20250310-v5_user_cfi_series-v11-0-86b36cbfb910@rivosinc.com>
In-Reply-To: <20250310-v5_user_cfi_series-v11-0-86b36cbfb910@rivosinc.com>
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

From: Jim Shu <jim.shu@sifive.com>

user mode tasks compiled with zicfilp may call indirectly into vdso (like
hwprobe indirect calls). Add landing pad compile support in vdso. vdso
with landing pad in it will be nop for tasks which have not enabled
landing pad.
This patch allows to run user mode tasks with cfi eanbled and do no harm.

Future work can be done on this to do below
 - labeled landing pad on vdso functions (whenever labeling support shows
   up in gnu-toolchain)
 - emit shadow stack instructions only in vdso compiled objects as part of
   kernel compile.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/Makefile                   |  7 +++++-
 arch/riscv/include/asm/assembler.h    | 44 +++++++++++++++++++++++++++++++++++
 arch/riscv/kernel/vdso/Makefile       | 12 ++++++++++
 arch/riscv/kernel/vdso/flush_icache.S |  4 ++++
 arch/riscv/kernel/vdso/getcpu.S       |  4 ++++
 arch/riscv/kernel/vdso/rt_sigreturn.S |  4 ++++
 arch/riscv/kernel/vdso/sys_hwprobe.S  |  4 ++++
 7 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 13fbc0f94238..ea9468af2cb4 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -87,10 +87,15 @@ riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZACAS) := $(riscv-march-y)_zacas
 
 # Check if the toolchain supports Zabha
 riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZABHA) := $(riscv-march-y)_zabha
+# Check if the toolchain supports Zihintpause extension
+riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZIHINTPAUSE) := $(riscv-march-y)_zihintpause
+
+KBUILD_BASE_ISA = -march=$(shell echo $(riscv-march-y) | sed -E 's/(rv32ima|rv64ima)fd([^v_]*)v?/\1\2/')
+export KBUILD_BASE_ISA
 
 # Remove F,D,V from isa string for all. Keep extensions between "fd" and "v" by
 # matching non-v and non-multi-letter extensions out with the filter ([^v_]*)
-KBUILD_CFLAGS += -march=$(shell echo $(riscv-march-y) | sed -E 's/(rv32ima|rv64ima)fd([^v_]*)v?/\1\2/')
+KBUILD_CFLAGS += $(KBUILD_BASE_ISA)
 
 KBUILD_AFLAGS += -march=$(riscv-march-y)
 
diff --git a/arch/riscv/include/asm/assembler.h b/arch/riscv/include/asm/assembler.h
index 44b1457d3e95..a058ea5e9c58 100644
--- a/arch/riscv/include/asm/assembler.h
+++ b/arch/riscv/include/asm/assembler.h
@@ -80,3 +80,47 @@
 	.endm
 
 #endif	/* __ASM_ASSEMBLER_H */
+
+#if defined(CONFIG_RISCV_USER_CFI) && (__riscv_xlen == 64)
+.macro vdso_lpad
+lpad 0
+.endm
+#else
+.macro vdso_lpad
+.endm
+#endif
+
+/*
+ * This macro emits a program property note section identifying
+ * architecture features which require special handling, mainly for
+ * use in assembly files included in the VDSO.
+ */
+#define NT_GNU_PROPERTY_TYPE_0  5
+#define GNU_PROPERTY_RISCV_FEATURE_1_AND 0xc0000000
+
+#define GNU_PROPERTY_RISCV_FEATURE_1_ZICFILP      (1U << 0)
+#define GNU_PROPERTY_RISCV_FEATURE_1_ZICFISS      (1U << 1)
+
+#if defined(CONFIG_RISCV_USER_CFI) && (__riscv_xlen == 64)
+#define GNU_PROPERTY_RISCV_FEATURE_1_DEFAULT \
+	(GNU_PROPERTY_RISCV_FEATURE_1_ZICFILP)
+#endif
+
+#ifdef GNU_PROPERTY_RISCV_FEATURE_1_DEFAULT
+.macro emit_riscv_feature_1_and, feat = GNU_PROPERTY_RISCV_FEATURE_1_DEFAULT
+	.pushsection .note.gnu.property, "a"
+	.p2align        3
+	.word           4
+	.word           16
+	.word           NT_GNU_PROPERTY_TYPE_0
+	.asciz          "GNU"
+	.word           GNU_PROPERTY_RISCV_FEATURE_1_AND
+	.word           4
+	.word           \feat
+	.word           0
+	.popsection
+.endm
+#else
+.macro emit_riscv_feature_1_and, feat = 0
+.endm
+#endif
diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index 9a1b555e8733..daa10c2b0dd1 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -13,12 +13,18 @@ vdso-syms += flush_icache
 vdso-syms += hwprobe
 vdso-syms += sys_hwprobe
 
+ifdef CONFIG_RISCV_USER_CFI
+LPAD_MARCH = _zicfilp
+endif
+
 # Files to link into the vdso
 obj-vdso = $(patsubst %, %.o, $(vdso-syms)) note.o
 
 ccflags-y := -fno-stack-protector
 ccflags-y += -DDISABLE_BRANCH_PROFILING
 ccflags-y += -fno-builtin
+ccflags-y += $(KBUILD_BASE_ISA)$(LPAD_MARCH)
+asflags-y += $(KBUILD_BASE_ISA)$(LPAD_MARCH)
 
 ifneq ($(c-gettimeofday-y),)
   CFLAGS_vgettimeofday.o += -fPIC -include $(c-gettimeofday-y)
@@ -40,6 +46,12 @@ endif
 CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
 CFLAGS_REMOVE_hwprobe.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
 
+# Disable profiling and instrumentation for VDSO code
+GCOV_PROFILE := n
+KCOV_INSTRUMENT := n
+KASAN_SANITIZE := n
+UBSAN_SANITIZE := n
+
 # Force dependency
 $(obj)/vdso.o: $(obj)/vdso.so
 
diff --git a/arch/riscv/kernel/vdso/flush_icache.S b/arch/riscv/kernel/vdso/flush_icache.S
index 8f884227e8bc..e4c56970905e 100644
--- a/arch/riscv/kernel/vdso/flush_icache.S
+++ b/arch/riscv/kernel/vdso/flush_icache.S
@@ -5,11 +5,13 @@
 
 #include <linux/linkage.h>
 #include <asm/unistd.h>
+#include <asm/assembler.h>
 
 	.text
 /* int __vdso_flush_icache(void *start, void *end, unsigned long flags); */
 SYM_FUNC_START(__vdso_flush_icache)
 	.cfi_startproc
+	vdso_lpad
 #ifdef CONFIG_SMP
 	li a7, __NR_riscv_flush_icache
 	ecall
@@ -20,3 +22,5 @@ SYM_FUNC_START(__vdso_flush_icache)
 	ret
 	.cfi_endproc
 SYM_FUNC_END(__vdso_flush_icache)
+
+emit_riscv_feature_1_and
diff --git a/arch/riscv/kernel/vdso/getcpu.S b/arch/riscv/kernel/vdso/getcpu.S
index 9c1bd531907f..5c1ecc4e1465 100644
--- a/arch/riscv/kernel/vdso/getcpu.S
+++ b/arch/riscv/kernel/vdso/getcpu.S
@@ -5,14 +5,18 @@
 
 #include <linux/linkage.h>
 #include <asm/unistd.h>
+#include <asm/assembler.h>
 
 	.text
 /* int __vdso_getcpu(unsigned *cpu, unsigned *node, void *unused); */
 SYM_FUNC_START(__vdso_getcpu)
 	.cfi_startproc
+	vdso_lpad
 	/* For now, just do the syscall. */
 	li a7, __NR_getcpu
 	ecall
 	ret
 	.cfi_endproc
 SYM_FUNC_END(__vdso_getcpu)
+
+emit_riscv_feature_1_and
diff --git a/arch/riscv/kernel/vdso/rt_sigreturn.S b/arch/riscv/kernel/vdso/rt_sigreturn.S
index 3dc022aa8931..e82987dc3739 100644
--- a/arch/riscv/kernel/vdso/rt_sigreturn.S
+++ b/arch/riscv/kernel/vdso/rt_sigreturn.S
@@ -5,12 +5,16 @@
 
 #include <linux/linkage.h>
 #include <asm/unistd.h>
+#include <asm/assembler.h>
 
 	.text
 SYM_FUNC_START(__vdso_rt_sigreturn)
 	.cfi_startproc
 	.cfi_signal_frame
+	vdso_lpad
 	li a7, __NR_rt_sigreturn
 	ecall
 	.cfi_endproc
 SYM_FUNC_END(__vdso_rt_sigreturn)
+
+emit_riscv_feature_1_and
diff --git a/arch/riscv/kernel/vdso/sys_hwprobe.S b/arch/riscv/kernel/vdso/sys_hwprobe.S
index 77e57f830521..f1694451a60c 100644
--- a/arch/riscv/kernel/vdso/sys_hwprobe.S
+++ b/arch/riscv/kernel/vdso/sys_hwprobe.S
@@ -3,13 +3,17 @@
 
 #include <linux/linkage.h>
 #include <asm/unistd.h>
+#include <asm/assembler.h>
 
 .text
 SYM_FUNC_START(riscv_hwprobe)
 	.cfi_startproc
+	vdso_lpad
 	li a7, __NR_riscv_hwprobe
 	ecall
 	ret
 
 	.cfi_endproc
 SYM_FUNC_END(riscv_hwprobe)
+
+emit_riscv_feature_1_and

-- 
2.34.1


