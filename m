Return-Path: <linux-arch+bounces-6925-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 503C9968BF3
	for <lists+linux-arch@lfdr.de>; Mon,  2 Sep 2024 18:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0619F283D6D
	for <lists+linux-arch@lfdr.de>; Mon,  2 Sep 2024 16:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FBE1AB6F0;
	Mon,  2 Sep 2024 16:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NxHvZtrP"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11D91AB6D4
	for <linux-arch@vger.kernel.org>; Mon,  2 Sep 2024 16:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725293969; cv=none; b=l2Tmb86j1Na1YbHZbt9mvarTZSL6pObMYlV0F8t68R4SQpytirNc+7l0qw8bo84ARdCEhZVsg3PMJqerAa41ulaUvl+0gVPeLQkZ/pKzk/X6Q46C4umfYvBCq4BStqF4/GsHqxzG8/rP6JCLsCJ61oUROIvXg8zEUNHzmgxHMI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725293969; c=relaxed/simple;
	bh=CTg1HnpXMiVou2jm/6rfgRfO1zcdu2yEgoJ4xCcDd8Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lN70aCI0YigibPJRmT9WlO4Ff7z+TUFaf2fLKZoVARnd7V2e3qWx1HUlv9DK+c7lNxI8z4J9Kl81FbkMpgHoK5qwcR+8R503cSlr3Jg01e3Gy+4o1YfFMzx/ajugmv9iCGMiZfGOnOXdQ2W40pZKaIlNGO9wBa/krBCGDkBORrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NxHvZtrP; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-371941bbfb0so2836486f8f.0
        for <linux-arch@vger.kernel.org>; Mon, 02 Sep 2024 09:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725293963; x=1725898763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ie9W1L9uNFC23ZDP70zJ0oUPkgRwFshdvpGZOvbHuRQ=;
        b=NxHvZtrP3sNnfh0a9ys2BBon7JaqWTRIIchsQVl9/th1niL2cc7r/u/ZJpf72hWRvD
         GjKdkwdxUdFwoLUz87MbZf41XSbPg18BQ9qhOuG7nw59G+BD0YtWVIomN2wv/DaJQINy
         8fsv0R+Rq/6SQNBrIwwwtzNhhKHqWgOuZXT3N5RPiSY6iGkTy4W/v+ecPRmTCcZVpsA6
         t8RIiFTRAopnmhbG9cJsFgizAROu6IsL90+gPM3KIxuNy/4ZEgV2JeNAtxoFWxM/lxA+
         tkR3Gs3SDbh7fp+/P/BtUyBDh9Q9PIvpeOmwxWOfHoJyhwJq9cXzRk/icOG+NMpaPNaR
         hEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725293963; x=1725898763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ie9W1L9uNFC23ZDP70zJ0oUPkgRwFshdvpGZOvbHuRQ=;
        b=BF+3t1iH1Z5iVcI6C5eDTkTF8vnqhoRV1ad8dcEKWwz9TgwnZY7q6loujGP5btNeNo
         pEPnLYUVPiIa4YBxPvIcG+L91itjiwqBtwMjVR9q+TMieGZPZhI7yIx3YzrSQWEa6qDe
         zPMgjI1w1S9KxmZJHUlNO9YYNX5oXGo3xH5FATJySnSQWTWPTbBZYMVRT3GQ5OqcjkMv
         ynPmubeUOASRx/bV7cp83H7QHcdnJ3nduNMGjWSj3c5g/dn/TzH1SfOeP0Kz+3rvUdVC
         4flUy5jjc0fQCcHwFGHUu78AKMxnKnUTGuS7bC4/8qFfsZVz0K34W7kuRnKEn9umPSBI
         hvdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRFQqxEIpYLJXg3ESW/X4chYPqu6/zxb0YmYhHR20fO/MzWKfy/9k71fxvjgxt3uO8knf1iykVy61C@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1DXaPYrDUa1XOLnjH5xtGHOS3E2CbmodLl4Gb3RIRxHVLVgXx
	2unNTUnMGz5pbkLn6OJbkqFzRgfkrKDEGMNz+vHweNli7u13v8w3IH46S0fgGHk=
X-Google-Smtp-Source: AGHT+IH4phemO6lKDX8phDZWlIUpSXP7tWTANei7+Fbp85cS9vgDau+TxVHvHXo9nGtcthCFPr5IFw==
X-Received: by 2002:adf:f0cb:0:b0:374:c432:4971 with SMTP id ffacd0b85a97d-374c4324b58mr4193553f8f.16.1725293963228;
        Mon, 02 Sep 2024 09:19:23 -0700 (PDT)
Received: from ubuntu-vm.. (51-148-40-55.dsl.zen.co.uk. [51.148.40.55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6deb239sm145970065e9.5.2024.09.02.09.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 09:19:22 -0700 (PDT)
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
Subject: [PATCH v4 2/2] arm64: vdso: wire up getrandom() vDSO implementation
Date: Mon,  2 Sep 2024 16:15:47 +0000
Message-ID: <20240902161912.2751-3-adhemerval.zanella@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240902161912.2751-1-adhemerval.zanella@linaro.org>
References: <20240902161912.2751-1-adhemerval.zanella@linaro.org>
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
 arch/arm64/kernel/vdso/vgetrandom-chacha.S | 178 +++++++++++++++++++++
 arch/arm64/kernel/vdso/vgetrandom.c        |  15 ++
 tools/arch/arm64/vdso                      |   1 +
 tools/include/linux/compiler.h             |   4 +
 tools/testing/selftests/vDSO/Makefile      |   3 +-
 14 files changed, 294 insertions(+), 16 deletions(-)
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
index 000000000000..4e5f9c349522
--- /dev/null
+++ b/arch/arm64/kernel/vdso/vgetrandom-chacha.S
@@ -0,0 +1,178 @@
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
+	ldr		copy3_d, [x2]
+CPU_BE( rev64		copy3.4s, copy3.4s)
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
+CPU_BE( rev32		state0.16b, state0.16b)
+	/* output1 = state1 + state1 */
+	add		state1.4s, state1.4s, copy1.4s
+CPU_BE( rev32		state1.16b, state1.16b)
+	/* output2 = state2 + state2 */
+	add		state2.4s, state2.4s, copy2.4s
+CPU_BE( rev32		state2.16b, state2.16b)
+	/* output2 = state3 + state3 */
+	add		state3.4s, state3.4s, copy3.4s
+CPU_BE( rev32		state3.16b, state3.16b)
+	st1		{ state0.4s - state3.4s }, [x0]
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
+CPU_BE( rev64		copy3.4s, copy3.4s)
+	str		copy3_d, [x2]
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


