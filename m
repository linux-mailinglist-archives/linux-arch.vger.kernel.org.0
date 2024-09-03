Return-Path: <linux-arch+bounces-6945-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 948C4969D0B
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 14:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B90C31C22E75
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 12:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7911D094F;
	Tue,  3 Sep 2024 12:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RB3g657o"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD9B1CB52B
	for <linux-arch@vger.kernel.org>; Tue,  3 Sep 2024 12:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725365401; cv=none; b=al9QEFubtamh3BnP2j0/EHyGaFv4eLL/NkDJT62WEi+vsjE8IjLiOVNI7fBpD9X2b9QCAN92eXZnb7oZJ+HVG8fwJF9VRyQPC/rTABThmWRyJJnWQa17xjOUFWgdgX5pH3Z5GJYSTdy6MeS991MRi6nj3WVpd3Ox6XzKwHwOHp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725365401; c=relaxed/simple;
	bh=/dtH8NQWYGs/6wB+SovTG5WvxO83hwk2c3UoIG11oCw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LEgQ8pu6zD6mXNH4V30WVR1pHk2mseVMOvGjTs2nO+x4P4ldlz0tfmc6dcOE+j6msS+v7jf621Xpjp4q2O84P7TxFYVu69N1QhnzH/bOgAiHKcAzuu4/pKrGB+3TarJYRaLjNLMXmuIGi+gs3Jc2zxahy4da6TuelbSwG/9qZpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RB3g657o; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42bbd16fcf2so35836495e9.2
        for <linux-arch@vger.kernel.org>; Tue, 03 Sep 2024 05:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725365398; x=1725970198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wLj40Nf8YibgNZMB9On75HaYaGbTXtDUPlooZmG8XoE=;
        b=RB3g657o1iAOXFVmt99fiW4wlfRLpodZZAwtCNnnTsEfZpBwSjuIgutBFL5JbIn28Y
         tqvBfSfzMIMz2iB/ttHj5KOVP/zr9zHBTyJJGnoXbTMG1Z7DPJzIMVuqfRzXQpRG11s5
         ottGY7mb+8j2PH1lVQzAZTRt5HQIKVDX56XC9PMHwcE2Lw9poLTFW+ea30+u+Rq+UuzN
         EczHh6WnyTS0VaR/n19S3OtzWV2yEbSZddxZtgSaNAc/TKwG2SQuzDHwTOSi7cmNRIm7
         L3jAd1dS6ThpK8PtVJJx+yFdvMEeWuEy6d+R14H0S5cCgbrzx6vEcU4bdHlDGuU8T2RQ
         qBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725365398; x=1725970198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLj40Nf8YibgNZMB9On75HaYaGbTXtDUPlooZmG8XoE=;
        b=tHxDp55RCH2YJExw1VNJjWXMbksnwst/X1+j0KUr+tQffyJGgEcL5M1ha6FRy+m3Hr
         Kve965JpWG1DCxkDEGUuMDl3g3VuZKdjeD9JOyJgfWkf0KWAzdGVXvnzoLeZ5iWZDrXG
         13TRZvBKZHUSWH0n19iudnW3icX04HgYMZHNOnMAIYoW667NHXKxl1SoxnKLmKtAoP70
         EqTeCmj5xdNs8d85DK/QG5fiTrqR+z8iI2KPV+kk2YbXkw97fL5ir9+nrfHXiuiJYJiw
         oYbKHHbrGwOdtq+Nms0kPTBQrnip3A26ZAYLTWWmXVQ9qfTtHZq3QkY7PN0rWMuuL76h
         k2Bg==
X-Forwarded-Encrypted: i=1; AJvYcCV1bV7lVFwbC6bOPJHTj0dCZEFJjF+38C7eiFqMEvkLkI8wwY92ph9xP4qfTLWHjDo3zgLUZrDhnTs4@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+/WDzrfZVnW35i1BjJrBIVpJxaaB7Bw1R+sDBM479wv49qNNn
	mh46+r6gXQIV02T7Qr6LpT/4FBujyJSaDYapczFkiTJZFmC9q5wCPsF1kGtgp1E=
X-Google-Smtp-Source: AGHT+IHEzrVzyTdGni+GTTj5dahQO9a3LHOHva8uPpanagm0NVIlpPPSHx9hb1kr1WIv+WiHKePnhA==
X-Received: by 2002:adf:ea09:0:b0:374:c1be:bf2e with SMTP id ffacd0b85a97d-374c1bec8ecmr6971821f8f.62.1725365397790;
        Tue, 03 Sep 2024 05:09:57 -0700 (PDT)
Received: from ubuntu-vm.. (51-148-40-55.dsl.zen.co.uk. [51.148.40.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee4a55fsm14069238f8f.10.2024.09.03.05.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 05:09:57 -0700 (PDT)
From: Adhemerval Zanella <adhemerval.zanella@linaro.org>
To: "Jason A . Donenfeld" <Jason@zx2c4.com>,
	Theodore Ts'o <tytso@mit.edu>,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Biggers <ebiggers@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v5 2/2] arm64: vdso: wire up getrandom() vDSO implementation
Date: Tue,  3 Sep 2024 12:09:17 +0000
Message-ID: <20240903120948.13743-3-adhemerval.zanella@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903120948.13743-1-adhemerval.zanella@linaro.org>
References: <20240903120948.13743-1-adhemerval.zanella@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hook up the generic vDSO implementation to the aarch64 vDSO data page.
The _vdso_rng_data required data is placed within the _vdso_data vvar
page, by using a offset larger than the vdso_data.

The vDSO function requires a ChaCha20 implementation that does not write
to the stack, and that can do an entire ChaCha20 permutation.  The one
provided uses NEON on the permute operation, with a fallback to the
syscall for chips that do not support AdvSIMD.

This also passes the vdso_test_chacha test along with
vdso_test_getrandom. The vdso_test_getrandom bench-single result on
Neoverse-N1 shows:

   vdso: 25000000 times in 0.783884250 seconds
   libc: 25000000 times in 8.780275399 seconds
syscall: 25000000 times in 8.786581518 seconds

A small fixup to arch/arm64/include/asm/mman.h was required to avoid
pulling kernel code into the vDSO, similar to what's already done in
arch/arm64/include/asm/rwonce.h.

Signed-off-by: Adhemerval Zanella <adhemerval.zanella@linaro.org>
---
 arch/arm64/Kconfig                         |   1 +
 arch/arm64/include/asm/mman.h              |   6 +-
 arch/arm64/include/asm/vdso.h              |   6 +
 arch/arm64/include/asm/vdso/getrandom.h    |  50 ++++++
 arch/arm64/include/asm/vdso/vsyscall.h     |  10 ++
 arch/arm64/kernel/vdso.c                   |   6 -
 arch/arm64/kernel/vdso/Makefile            |  25 ++-
 arch/arm64/kernel/vdso/vdso                |   1 +
 arch/arm64/kernel/vdso/vdso.lds.S          |   4 +
 arch/arm64/kernel/vdso/vgetrandom-chacha.S | 172 +++++++++++++++++++++
 arch/arm64/kernel/vdso/vgetrandom.c        |  15 ++
 tools/arch/arm64/vdso                      |   1 +
 tools/include/linux/compiler.h             |   4 +
 tools/testing/selftests/vDSO/Makefile      |   3 +-
 14 files changed, 288 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm64/include/asm/vdso/getrandom.h
 create mode 120000 arch/arm64/kernel/vdso/vdso
 create mode 100644 arch/arm64/kernel/vdso/vgetrandom-chacha.S
 create mode 100644 arch/arm64/kernel/vdso/vgetrandom.c
 create mode 120000 tools/arch/arm64/vdso

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a2f8ff354ca6..7f7424d1b3b8 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -262,6 +262,7 @@ config ARM64
 	select TRACE_IRQFLAGS_NMI_SUPPORT
 	select HAVE_SOFTIRQ_ON_OWN_STACK
 	select USER_STACKTRACE_SUPPORT
+	select VDSO_GETRANDOM
 	help
 	  ARM 64-bit (AArch64) Linux support.
 
diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
index 5966ee4a6154..ceb4370a69c5 100644
--- a/arch/arm64/include/asm/mman.h
+++ b/arch/arm64/include/asm/mman.h
@@ -2,9 +2,11 @@
 #ifndef __ASM_MMAN_H__
 #define __ASM_MMAN_H__
 
+#include <uapi/asm/mman.h>
+
+#ifndef BUILD_VDSO
 #include <linux/compiler.h>
 #include <linux/types.h>
-#include <uapi/asm/mman.h>
 
 static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
 	unsigned long pkey __always_unused)
@@ -60,4 +62,6 @@ static inline bool arch_validate_flags(unsigned long vm_flags)
 }
 #define arch_validate_flags(vm_flags) arch_validate_flags(vm_flags)
 
+#endif /* !BUILD_VDSO */
+
 #endif /* ! __ASM_MMAN_H__ */
diff --git a/arch/arm64/include/asm/vdso.h b/arch/arm64/include/asm/vdso.h
index 4305995c8f82..18407b757c95 100644
--- a/arch/arm64/include/asm/vdso.h
+++ b/arch/arm64/include/asm/vdso.h
@@ -16,6 +16,12 @@
 
 #ifndef __ASSEMBLY__
 
+enum vvar_pages {
+	VVAR_DATA_PAGE_OFFSET,
+	VVAR_TIMENS_PAGE_OFFSET,
+	VVAR_NR_PAGES,
+};
+
 #include <generated/vdso-offsets.h>
 
 #define VDSO_SYMBOL(base, name)						   \
diff --git a/arch/arm64/include/asm/vdso/getrandom.h b/arch/arm64/include/asm/vdso/getrandom.h
new file mode 100644
index 000000000000..6cda64e6da83
--- /dev/null
+++ b/arch/arm64/include/asm/vdso/getrandom.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_VDSO_GETRANDOM_H
+#define __ASM_VDSO_GETRANDOM_H
+
+#ifndef __ASSEMBLY__
+
+#include <asm/vdso.h>
+#include <asm/unistd.h>
+#include <vdso/datapage.h>
+
+/**
+ * getrandom_syscall - Invoke the getrandom() syscall.
+ * @buffer:	Destination buffer to fill with random bytes.
+ * @len:	Size of @buffer in bytes.
+ * @flags:	Zero or more GRND_* flags.
+ * Returns:	The number of random bytes written to @buffer, or a negative value indicating an error.
+ */
+static __always_inline ssize_t getrandom_syscall(void *_buffer, size_t _len, unsigned int _flags)
+{
+	register void *buffer asm ("x0") = _buffer;
+	register size_t len asm ("x1") = _len;
+	register unsigned int flags asm ("x2") = _flags;
+	register long ret asm ("x0");
+	register long nr asm ("x8") = __NR_getrandom;
+
+	asm volatile(
+	"       svc #0\n"
+	: "=r" (ret)
+	: "r" (buffer), "r" (len), "r" (flags), "r" (nr)
+	: "memory");
+
+	return ret;
+}
+
+static __always_inline const struct vdso_rng_data *__arch_get_vdso_rng_data(void)
+{
+	/*
+	 * The RNG data is in the real VVAR data page, but if a task belongs to a time namespace
+	 * then VVAR_DATA_PAGE_OFFSET points to the namespace-specific VVAR page and VVAR_TIMENS_
+	 * PAGE_OFFSET points to the real VVAR page.
+	 */
+	if (IS_ENABLED(CONFIG_TIME_NS) && _vdso_data->clock_mode == VDSO_CLOCKMODE_TIMENS)
+		return (void *)&_vdso_rng_data + VVAR_TIMENS_PAGE_OFFSET * (1UL << CONFIG_PAGE_SHIFT);
+	return &_vdso_rng_data;
+}
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __ASM_VDSO_GETRANDOM_H */
diff --git a/arch/arm64/include/asm/vdso/vsyscall.h b/arch/arm64/include/asm/vdso/vsyscall.h
index f94b1457c117..b4241510dc36 100644
--- a/arch/arm64/include/asm/vdso/vsyscall.h
+++ b/arch/arm64/include/asm/vdso/vsyscall.h
@@ -2,8 +2,11 @@
 #ifndef __ASM_VDSO_VSYSCALL_H
 #define __ASM_VDSO_VSYSCALL_H
 
+#define __VDSO_RND_DATA_OFFSET  480
+
 #ifndef __ASSEMBLY__
 
+#include <asm/vdso.h>
 #include <linux/timekeeper_internal.h>
 #include <vdso/datapage.h>
 
@@ -21,6 +24,13 @@ struct vdso_data *__arm64_get_k_vdso_data(void)
 }
 #define __arch_get_k_vdso_data __arm64_get_k_vdso_data
 
+static __always_inline
+struct vdso_rng_data *__arm64_get_k_vdso_rnd_data(void)
+{
+	return (void *)vdso_data + __VDSO_RND_DATA_OFFSET;
+}
+#define __arch_get_k_vdso_rng_data __arm64_get_k_vdso_rnd_data
+
 static __always_inline
 void __arm64_update_vsyscall(struct vdso_data *vdata, struct timekeeper *tk)
 {
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 89b6e7840002..706c9c3a7a50 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -34,12 +34,6 @@ enum vdso_abi {
 	VDSO_ABI_AA32,
 };
 
-enum vvar_pages {
-	VVAR_DATA_PAGE_OFFSET,
-	VVAR_TIMENS_PAGE_OFFSET,
-	VVAR_NR_PAGES,
-};
-
 struct vdso_abi_info {
 	const char *name;
 	const char *vdso_code_start;
diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index d11da6461278..35685c036044 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -9,7 +9,7 @@
 # Include the generic Makefile to check the built vdso.
 include $(srctree)/lib/vdso/Makefile
 
-obj-vdso := vgettimeofday.o note.o sigreturn.o
+obj-vdso := vgettimeofday.o note.o sigreturn.o vgetrandom.o vgetrandom-chacha.o
 
 # Build rules
 targets := $(obj-vdso) vdso.so vdso.so.dbg
@@ -34,19 +34,28 @@ ccflags-y := -fno-common -fno-builtin -fno-stack-protector -ffixed-x18
 ccflags-y += -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO
 
 # -Wmissing-prototypes and -Wmissing-declarations are removed from
-# the CFLAGS of vgettimeofday.c to make possible to build the
-# kernel with CONFIG_WERROR enabled.
-CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) \
-				$(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS) \
-				$(CC_FLAGS_LTO) $(CC_FLAGS_CFI) \
-				-Wmissing-prototypes -Wmissing-declarations
+# the CFLAGS to make possible to build the kernel with CONFIG_WERROR enabled.
+CC_FLAGS_REMOVE_VDSO := $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) \
+			$(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS) \
+			$(CC_FLAGS_LTO) $(CC_FLAGS_CFI) \
+			-Wmissing-prototypes -Wmissing-declarations
 
-CFLAGS_vgettimeofday.o = -O2 -mcmodel=tiny -fasynchronous-unwind-tables
+CC_FLAGS_ADD_VDSO := -O2 -mcmodel=tiny -fasynchronous-unwind-tables
+
+CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_REMOVE_VDSO)
+CFLAGS_REMOVE_vgetrandom.o = $(CC_FLAGS_REMOVE_VDSO)
+
+CFLAGS_vgettimeofday.o = $(CC_FLAGS_ADD_VDSO)
+CFLAGS_vgetrandom.o = $(CC_FLAGS_ADD_VDSO)
 
 ifneq ($(c-gettimeofday-y),)
   CFLAGS_vgettimeofday.o += -include $(c-gettimeofday-y)
 endif
 
+ifneq ($(c-getrandom-y),)
+  CFLAGS_vgetrandom.o += -include $(c-getrandom-y)
+endif
+
 targets += vdso.lds
 CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
 
diff --git a/arch/arm64/kernel/vdso/vdso b/arch/arm64/kernel/vdso/vdso
new file mode 120000
index 000000000000..233c7a26f6e5
--- /dev/null
+++ b/arch/arm64/kernel/vdso/vdso
@@ -0,0 +1 @@
+../../../arch/arm64/kernel/vdso
\ No newline at end of file
diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
index 45354f2ddf70..f204a9ddc833 100644
--- a/arch/arm64/kernel/vdso/vdso.lds.S
+++ b/arch/arm64/kernel/vdso/vdso.lds.S
@@ -11,7 +11,9 @@
 #include <linux/const.h>
 #include <asm/page.h>
 #include <asm/vdso.h>
+#include <asm/vdso/vsyscall.h>
 #include <asm-generic/vmlinux.lds.h>
+#include <vdso/datapage.h>
 
 OUTPUT_FORMAT("elf64-littleaarch64", "elf64-bigaarch64", "elf64-littleaarch64")
 OUTPUT_ARCH(aarch64)
@@ -19,6 +21,7 @@ OUTPUT_ARCH(aarch64)
 SECTIONS
 {
 	PROVIDE(_vdso_data = . - __VVAR_PAGES * PAGE_SIZE);
+	PROVIDE(_vdso_rng_data = _vdso_data + __VDSO_RND_DATA_OFFSET);
 #ifdef CONFIG_TIME_NS
 	PROVIDE(_timens_data = _vdso_data + PAGE_SIZE);
 #endif
@@ -102,6 +105,7 @@ VERSION
 		__kernel_gettimeofday;
 		__kernel_clock_gettime;
 		__kernel_clock_getres;
+		__kernel_getrandom;
 	local: *;
 	};
 }
diff --git a/arch/arm64/kernel/vdso/vgetrandom-chacha.S b/arch/arm64/kernel/vdso/vgetrandom-chacha.S
new file mode 100644
index 000000000000..72186edfbffa
--- /dev/null
+++ b/arch/arm64/kernel/vdso/vgetrandom-chacha.S
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/linkage.h>
+#include <asm/cache.h>
+#include <asm/assembler.h>
+
+	.text
+
+#define state0		v0
+#define state1		v1
+#define state2		v2
+#define state3		v3
+#define copy0		v4
+#define copy0_q		q4
+#define copy1		v5
+#define copy2		v6
+#define copy3		v7
+#define copy3_d		d7
+#define one_d		d16
+#define one_q		q16
+#define one_v		v16
+#define tmp		v17
+#define rot8		v18
+
+/*
+ * ARM64 ChaCha20 implementation meant for vDSO.  Produces a given positive
+ * number of blocks of output with nonce 0, taking an input key and 8-bytes
+ * counter.  Importantly does not spill to the stack.
+ *
+ * This implementation avoids d8-d15 because they are callee-save in user
+ * space.
+ *
+ * void __arch_chacha20_blocks_nostack(uint8_t *dst_bytes,
+ *				       const uint8_t *key,
+ * 				       uint32_t *counter,
+ *				       size_t nblocks)
+ *
+ * 	x0: output bytes
+ *	x1: 32-byte key input
+ *	x2: 8-byte counter input/output
+ *	x3: number of 64-byte block to write to output
+ */
+SYM_FUNC_START(__arch_chacha20_blocks_nostack)
+
+	/* copy0 = "expand 32-byte k" */
+	mov_q		x8, 0x3320646e61707865
+	mov_q		x9, 0x6b20657479622d32
+	mov		copy0.d[0], x8
+	mov		copy0.d[1], x9
+
+	/* copy1,copy2 = key */
+	ld1		{ copy1.4s, copy2.4s }, [x1]
+	/* copy3 = counter || zero nonce  */
+	ld1		{copy3.2s}, [x2]
+
+	movi		one_v.2s, #1
+	uzp1		one_v.4s, one_v.4s, one_v.4s
+
+.Lblock:
+	/* copy state to auxiliary vectors for the final add after the permute.  */
+	mov		state0.16b, copy0.16b
+	mov		state1.16b, copy1.16b
+	mov		state2.16b, copy2.16b
+	mov		state3.16b, copy3.16b
+
+	mov		w4, 20
+.Lpermute:
+	/*
+	 * Permute one 64-byte block where the state matrix is stored in the four NEON
+	 * registers state0-state3.  It performs matrix operations on four words in parallel,
+	 * but requires shuffling to rearrange the words after each round.
+	 */
+
+.Ldoubleround:
+	/* state0 += state1, state3 = rotl32(state3 ^ state0, 16) */
+	add		state0.4s, state0.4s, state1.4s
+	eor		state3.16b, state3.16b, state0.16b
+	rev32		state3.8h, state3.8h
+
+	/* state2 += state3, state1 = rotl32(state1 ^ state2, 12) */
+	add		state2.4s, state2.4s, state3.4s
+	eor		tmp.16b, state1.16b, state2.16b
+	shl		state1.4s, tmp.4s, #12
+	sri		state1.4s, tmp.4s, #20
+
+	/* state0 += state1, state3 = rotl32(state3 ^ state0, 8) */
+	add		state0.4s, state0.4s, state1.4s
+	eor		tmp.16b, state3.16b, state0.16b
+	shl		state3.4s, tmp.4s, #8
+	sri		state3.4s, tmp.4s, #24
+
+	/* state2 += state3, state1 = rotl32(state1 ^ state2, 7) */
+	add		state2.4s, state2.4s, state3.4s
+	eor		tmp.16b, state1.16b, state2.16b
+	shl		state1.4s, tmp.4s, #7
+	sri		state1.4s, tmp.4s, #25
+
+	/* state1[0,1,2,3] = state1[1,2,3,0] */
+	ext		state1.16b, state1.16b, state1.16b, #4
+	/* state2[0,1,2,3] = state2[2,3,0,1] */
+	ext		state2.16b, state2.16b, state2.16b, #8
+	/* state3[0,1,2,3] = state3[1,2,3,0] */
+	ext		state3.16b, state3.16b, state3.16b, #12
+
+	/* state0 += state1, state3 = rotl32(state3 ^ state0, 16) */
+	add		state0.4s, state0.4s, state1.4s
+	eor		state3.16b, state3.16b, state0.16b
+	rev32		state3.8h, state3.8h
+
+	/* state2 += state3, state1 = rotl32(state1 ^ state2, 12) */
+	add		state2.4s, state2.4s, state3.4s
+	eor		tmp.16b, state1.16b, state2.16b
+	shl		state1.4s, tmp.4s, #12
+	sri		state1.4s, tmp.4s, #20
+
+	/* state0 += state1, state3 = rotl32(state3 ^ state0, 8) */
+	add		state0.4s, state0.4s, state1.4s
+	eor		tmp.16b, state3.16b, state0.16b
+	shl		state3.4s, tmp.4s, #8
+	sri		state3.4s, tmp.4s, #24
+
+	/* state2 += state3, state1 = rotl32(state1 ^ state2, 7) */
+	add		state2.4s, state2.4s, state3.4s
+	eor		tmp.16b, state1.16b, state2.16b
+	shl		state1.4s, tmp.4s, #7
+	sri		state1.4s, tmp.4s, #25
+
+	/* state1[0,1,2,3] = state1[3,0,1,2] */
+	ext		state1.16b, state1.16b, state1.16b, #12
+	/* state2[0,1,2,3] = state2[2,3,0,1] */
+	ext		state2.16b, state2.16b, state2.16b, #8
+	/* state3[0,1,2,3] = state3[1,2,3,0] */
+	ext		state3.16b, state3.16b, state3.16b, #4
+
+	subs		w4, w4, #2
+	b.ne		.Ldoubleround
+
+	/* output0 = state0 + state0 */
+	add		state0.4s, state0.4s, copy0.4s
+	/* output1 = state1 + state1 */
+	add		state1.4s, state1.4s, copy1.4s
+	/* output2 = state2 + state2 */
+	add		state2.4s, state2.4s, copy2.4s
+	/* output2 = state3 + state3 */
+	add		state3.4s, state3.4s, copy3.4s
+	st1		{ state0.16b - state3.16b }, [x0]
+
+	/*
+	 * ++copy3.counter, the 'add' clears the upper half of the SIMD register
+	 * which is the expected behaviour here.
+	 */
+	add		copy3_d, copy3_d, one_d
+
+	/* output += 64, --nblocks */
+	add		x0, x0, 64
+	subs		x3, x3, #1
+	b.ne		.Lblock
+
+	/* counter = copy3.counter */
+	st1		{ copy3.2s }, [x2]
+
+	/* Zero out the potentially sensitive regs, in case nothing uses these again. */
+	movi		state0.16b, #0
+	movi		state1.16b, #0
+	movi		state2.16b, #0
+	movi		state3.16b, #0
+	movi		copy1.16b, #0
+	movi		copy2.16b, #0
+	ret
+SYM_FUNC_END(__arch_chacha20_blocks_nostack)
+
+emit_aarch64_feature_1_and
diff --git a/arch/arm64/kernel/vdso/vgetrandom.c b/arch/arm64/kernel/vdso/vgetrandom.c
new file mode 100644
index 000000000000..832fe195292b
--- /dev/null
+++ b/arch/arm64/kernel/vdso/vgetrandom.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <uapi/asm-generic/errno.h>
+
+typeof(__cvdso_getrandom) __kernel_getrandom;
+
+ssize_t __kernel_getrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state, size_t opaque_len)
+{
+	if (alternative_has_cap_likely(ARM64_HAS_FPSIMD))
+		return __cvdso_getrandom(buffer, len, flags, opaque_state, opaque_len);
+
+	if (unlikely(opaque_len == ~0UL && !buffer && !len && !flags))
+		return -ENOSYS;
+	return getrandom_syscall(buffer, len, flags);
+}
diff --git a/tools/arch/arm64/vdso b/tools/arch/arm64/vdso
new file mode 120000
index 000000000000..233c7a26f6e5
--- /dev/null
+++ b/tools/arch/arm64/vdso
@@ -0,0 +1 @@
+../../../arch/arm64/kernel/vdso
\ No newline at end of file
diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
index 6f7f22ac9da5..4366da278033 100644
--- a/tools/include/linux/compiler.h
+++ b/tools/include/linux/compiler.h
@@ -2,6 +2,8 @@
 #ifndef _TOOLS_LINUX_COMPILER_H_
 #define _TOOLS_LINUX_COMPILER_H_
 
+#ifndef __ASSEMBLY__
+
 #include <linux/compiler_types.h>
 
 #ifndef __compiletime_error
@@ -224,4 +226,6 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
 	__asm__ ("" : "=r" (var) : "0" (var))
 #endif
 
+#endif /* __ASSEMBLY__ */
+
 #endif /* _TOOLS_LINUX_COMPILER_H */
diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index 04930125035e..3c6fafbd83a6 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -9,7 +9,7 @@ ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
 TEST_GEN_PROGS += vdso_standalone_test_x86
 endif
 TEST_GEN_PROGS += vdso_test_correctness
-ifeq ($(ARCH)$(CONFIG_X86_32),$(filter $(ARCH)$(CONFIG_X86_32),x86 x86_64 loongarch))
+ifeq ($(ARCH)$(CONFIG_X86_32),$(filter $(ARCH)$(CONFIG_X86_32),x86 x86_64 loongarch arm64))
 TEST_GEN_PROGS += vdso_test_getrandom
 TEST_GEN_PROGS += vdso_test_chacha
 endif
@@ -40,5 +40,6 @@ $(OUTPUT)/vdso_test_getrandom: CFLAGS += -isystem $(top_srcdir)/tools/include \
 $(OUTPUT)/vdso_test_chacha: $(top_srcdir)/tools/arch/$(SRCARCH)/vdso/vgetrandom-chacha.S
 $(OUTPUT)/vdso_test_chacha: CFLAGS += -idirafter $(top_srcdir)/tools/include \
                                       -idirafter $(top_srcdir)/arch/$(SRCARCH)/include \
+                                      -idirafter $(top_srcdir)/arch/$(SRCARCH)/include/generated \
                                       -idirafter $(top_srcdir)/include \
                                       -D__ASSEMBLY__ -Wa,--noexecstack
-- 
2.43.0


