Return-Path: <linux-arch+bounces-15046-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFCAC7C689
	for <lists+linux-arch@lfdr.de>; Sat, 22 Nov 2025 05:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 616A93A72A5
	for <lists+linux-arch@lfdr.de>; Sat, 22 Nov 2025 04:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BB722CBC0;
	Sat, 22 Nov 2025 04:41:57 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C780936D4F6;
	Sat, 22 Nov 2025 04:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763786517; cv=none; b=UwEuTKNPiy3HCwgA/8mjuWS8ZcU4lxo5mHSeYl4cPi0jTiAKCXMfj24YECin+fhVcyvoqxW1+r7agAaNUchfTFGqBTurlwAhTIkPOlTXCOa+FqMYn3BcB3b7F4VQQLoq/eB03OjG+AYy0hiS2Tw+v4GL5tLRHlzVrICQ4sFoJw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763786517; c=relaxed/simple;
	bh=7o9qPwjb/FCkf7nuG8/kVz3m9lUqo+mDFIEK2BWZtFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wg8msMeEUFPjtGj2uRgWfMlyZ0sLKIqzFI5PHtwZRZzi6RO1Sn7lx/vaeUT1Fjxgp+k8F017k86RNKs0VgV5Oh6p6z4Qb7RH9MeSuD10vVP202o7cIrng8q8JFKaAetVYaLJzhNbKhc8Bh2RmqPSs2QO1GD3jtvQeIaiMM8Rksk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D39C4CEF5;
	Sat, 22 Nov 2025 04:41:54 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Arnd Bergmann <arnd@arndb.de>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-arch@vger.kernel.org,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V3 12/14] LoongArch: Adjust VDSO/VSYSCALL for 32BIT/64BIT
Date: Sat, 22 Nov 2025 12:36:32 +0800
Message-ID: <20251122043634.3447854-13-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251122043634.3447854-1-chenhuacai@loongson.cn>
References: <20251122043634.3447854-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjust VDSO/VSYSCALL because read_cpu_id() for 32BIT/64BIT are
different, and LoongArch32 doesn't support GENERIC_GETTIMEOFDAY now
(will be supported in future).

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/vdso/gettimeofday.h | 4 ++++
 arch/loongarch/kernel/time.c                   | 2 ++
 arch/loongarch/vdso/Makefile                   | 7 ++++++-
 arch/loongarch/vdso/vdso.lds.S                 | 4 ++--
 arch/loongarch/vdso/vgetcpu.c                  | 8 ++++++++
 5 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/include/asm/vdso/gettimeofday.h b/arch/loongarch/include/asm/vdso/gettimeofday.h
index dcafabca9bb6..bae76767c693 100644
--- a/arch/loongarch/include/asm/vdso/gettimeofday.h
+++ b/arch/loongarch/include/asm/vdso/gettimeofday.h
@@ -12,6 +12,8 @@
 #include <asm/unistd.h>
 #include <asm/vdso/vdso.h>
 
+#ifdef CONFIG_GENERIC_GETTIMEOFDAY
+
 #define VDSO_HAS_CLOCK_GETRES		1
 
 static __always_inline long gettimeofday_fallback(
@@ -89,6 +91,8 @@ static inline bool loongarch_vdso_hres_capable(void)
 }
 #define __arch_vdso_hres_capable loongarch_vdso_hres_capable
 
+#endif /* CONFIG_GENERIC_GETTIMEOFDAY */
+
 #endif /* !__ASSEMBLER__ */
 
 #endif /* __ASM_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
index 5892f6da07a5..dbaaabcaf6f0 100644
--- a/arch/loongarch/kernel/time.c
+++ b/arch/loongarch/kernel/time.c
@@ -212,7 +212,9 @@ static struct clocksource clocksource_const = {
 	.read = read_const_counter,
 	.mask = CLOCKSOURCE_MASK(64),
 	.flags = CLOCK_SOURCE_IS_CONTINUOUS,
+#ifdef CONFIG_GENERIC_GETTIMEOFDAY
 	.vdso_clock_mode = VDSO_CLOCKMODE_CPU,
+#endif
 };
 
 int __init constant_clocksource_init(void)
diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
index d8316f993482..a8ac0e811e39 100644
--- a/arch/loongarch/vdso/Makefile
+++ b/arch/loongarch/vdso/Makefile
@@ -4,8 +4,9 @@
 # Include the generic Makefile to check the built vdso.
 include $(srctree)/lib/vdso/Makefile.include
 
-obj-vdso-y := elf.o vgetcpu.o vgettimeofday.o vgetrandom.o \
+obj-vdso-y := elf.o vgetcpu.o vgetrandom.o \
               vgetrandom-chacha.o sigreturn.o
+obj-vdso-$(CONFIG_GENERIC_GETTIMEOFDAY) += vgettimeofday.o
 
 # Common compiler flags between ABIs.
 ccflags-vdso := \
@@ -16,6 +17,10 @@ ccflags-vdso := \
 	$(CLANG_FLAGS) \
 	-D__VDSO__
 
+ifdef CONFIG_32BIT
+ccflags-vdso += -DBUILD_VDSO32
+endif
+
 cflags-vdso := $(ccflags-vdso) \
 	-isystem $(shell $(CC) -print-file-name=include) \
 	$(filter -W%,$(filter-out -Wa$(comma)%,$(KBUILD_CFLAGS))) \
diff --git a/arch/loongarch/vdso/vdso.lds.S b/arch/loongarch/vdso/vdso.lds.S
index 8ff986499947..ac537e02beb1 100644
--- a/arch/loongarch/vdso/vdso.lds.S
+++ b/arch/loongarch/vdso/vdso.lds.S
@@ -7,8 +7,6 @@
 #include <generated/asm-offsets.h>
 #include <vdso/datapage.h>
 
-OUTPUT_FORMAT("elf64-loongarch", "elf64-loongarch", "elf64-loongarch")
-
 OUTPUT_ARCH(loongarch)
 
 SECTIONS
@@ -63,9 +61,11 @@ VERSION
 	LINUX_5.10 {
 	global:
 		__vdso_getcpu;
+#ifdef CONFIG_GENERIC_GETTIMEOFDAY
 		__vdso_clock_getres;
 		__vdso_clock_gettime;
 		__vdso_gettimeofday;
+#endif
 		__vdso_getrandom;
 		__vdso_rt_sigreturn;
 	local: *;
diff --git a/arch/loongarch/vdso/vgetcpu.c b/arch/loongarch/vdso/vgetcpu.c
index 5301cd9d0f83..73af49242ecd 100644
--- a/arch/loongarch/vdso/vgetcpu.c
+++ b/arch/loongarch/vdso/vgetcpu.c
@@ -10,11 +10,19 @@ static __always_inline int read_cpu_id(void)
 {
 	int cpu_id;
 
+#ifdef CONFIG_64BIT
 	__asm__ __volatile__(
 	"	rdtime.d $zero, %0\n"
 	: "=r" (cpu_id)
 	:
 	: "memory");
+#else
+	__asm__ __volatile__(
+	"	rdtimel.w $zero, %0\n"
+	: "=r" (cpu_id)
+	:
+	: "memory");
+#endif
 
 	return cpu_id;
 }
-- 
2.47.3


