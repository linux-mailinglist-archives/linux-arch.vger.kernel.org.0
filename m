Return-Path: <linux-arch+bounces-14869-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D4889C69214
	for <lists+linux-arch@lfdr.de>; Tue, 18 Nov 2025 12:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C41274F42CE
	for <lists+linux-arch@lfdr.de>; Tue, 18 Nov 2025 11:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C783596FD;
	Tue, 18 Nov 2025 11:30:57 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC2D35580C;
	Tue, 18 Nov 2025 11:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763465457; cv=none; b=cvrA3mRt6vdOdnxJMR2uEvGtff4u3JHMd+7wDE+IVxcnHQ7vB9Wanbyn2yaPWs9q3vVALaBpbZrmAItFhVEXI76VKRVnFrw5j2Rrxf/HmfzqjdYi7LQ1Ur0gGBeWwtJLX/4vdK944a2MRdOETHiLVcWxy30FN1nDcZBQ69vJWLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763465457; c=relaxed/simple;
	bh=gTW5MUHQJdJz0s73Bcj2PjMEyFV25odKce/QT4kE3Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sVLfVbQoHlY8KhJDT7orFmey/vqqqXeb1UmFjBbetfnMVIy6IV2ZxzyisX5XGeN1BqHDc7+8ysAJNHW1FfMZVzCYkK5bxBBE2ti2bxKlXNspm6ifhXG+v4szyQGl5svAhDlfpCh0cKrvyquKYN5L7hHIeQ3gHx3NKzvF39Y2PQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52C4C116B1;
	Tue, 18 Nov 2025 11:30:52 +0000 (UTC)
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
Subject: [PATCH V2 12/14] LoongArch: Adjust VDSO/VSYSCALL for 32BIT/64BIT
Date: Tue, 18 Nov 2025 19:27:26 +0800
Message-ID: <20251118112728.571869-13-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251118112728.571869-1-chenhuacai@loongson.cn>
References: <20251118112728.571869-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjust VDSO/VSYSCALL because read_cpu_id() for 32BIT/64BIT are
different, and LoongArch32 doesn't support GENERIC_GETTIMEOFDAY now.

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


