Return-Path: <linux-arch+bounces-3314-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD5489142D
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 08:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7E3728612C
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 07:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E189747F7C;
	Fri, 29 Mar 2024 07:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KoClgjp9"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077C742054
	for <linux-arch@vger.kernel.org>; Fri, 29 Mar 2024 07:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711697091; cv=none; b=r5tGPZPs9m0kWqLueuiKy0Cq/QtfnNqZxvjDKqFZX1w0sqrr45Kk08LFnN4FM4lri+ez2+B/cSD01Y6Rjc14MFkjRV0HIFu1VYer8JoyJJMtMtObYoo2EhOM+QZNjtRurfgvYsSYDXVP0a2YLj/wMBiEMgug5wPwhuk2lp0prfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711697091; c=relaxed/simple;
	bh=D7Uft9YmOHR561uZNDC4DNCSuflFcrKCYb4nSPMUGXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MSC6hpmlIsqocE22r6FVlN3j/gvpQN5Sz7DfddGiSg0q2SEkEXiBPrk9mnEaDImm+vSFSnwXfWZikAzrrKBL5wrq7+4wsonytHwzzO1KnkACasv/DoeZhs9PG5LV6XWD+gklQqyPzmZ7TcQG9XRhQt2kNAIbRFneRdoZmWppL3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=KoClgjp9; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ea9a616cc4so1340490b3a.1
        for <linux-arch@vger.kernel.org>; Fri, 29 Mar 2024 00:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711697088; x=1712301888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BaG/5r11zMVVbJK9XMgdhlmzZC0nXZGHxxAlEP5YrDw=;
        b=KoClgjp9S4ZwCpcqg/7oaqO0Ow8LKo/hRFLLXf67uuNK6lF0K1glOHNtAJ8sAL+dAh
         ndg07+TP6XcjlRoyjEHF9rO39I+d5JKoctXOBvs2WyuVOBmrVgBCKnRu2K5MPVJP5eZp
         gYd1z60CICJsvBBZHyDq1oCMq8XKGecZ0oFARdcJMHpMELxzzF4yPvQkNJC9QOHMqeTh
         +OIyz+a/2OQj9HvS5RoyejYnNJmS/RfQCI5Zr9S2VoAR9ka9X4hdLc3hvLBuE9GG3Ig5
         Y2sOKFNev65N1AmChX0RoQFnv1DQq6tHAXg5n/YvlqRwNXSZjYrKUVCk5xkkiPYgM5vk
         obow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711697088; x=1712301888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BaG/5r11zMVVbJK9XMgdhlmzZC0nXZGHxxAlEP5YrDw=;
        b=jPwmdez1Cf8l3VW2myDeGiv2Q02N07N+wjcJIWeXEBy19Hhm3iWCqOQDiX+N9jon87
         1N4tDdiPPRt3x7D3llOuuaKPBsHOTW3Bhimxqg3IjtecbXj4K99DzxqL6XIz22X3G7nk
         tkOGF3fGK45+FW54KevnEycdMeqZQigE3j+UioKdWuQhtKBRO/+MkvNYKyKEV9ltw0HD
         8dyZ3cFm/c+zFsS34npVFwMGFA/4VeP1UeVGX+jKOTVfpTgw2fzwQRCP+H4AkyEHw1uj
         RBpepCOGI3U/DjObOoNGAQlShmyUR8sPH5Lm3uiwJOsQBuf/fWtzCZVhvRAEBiUFbIRh
         Aqug==
X-Forwarded-Encrypted: i=1; AJvYcCXKyRExIEQ2zp42uugnQ6S5Er0MscvSKSVVQ4A5bdr7JnADdmLJXFkiJjPRYYiESPJWfd/Ec+Kz/fa6BLWXI2QcXdOUuG6oZAj8IQ==
X-Gm-Message-State: AOJu0Yykf3yUAeoeL5XQPQZe6MZU3H2huBDDFZ8tq1QDuCsC3bxcKRbQ
	tFcNlvZHe6WnsLEnVooG/R84vRYCk2PfASsmMW9pY7i8fMZMR1PgjRkSTydsNj0=
X-Google-Smtp-Source: AGHT+IHyYuok2TNfdiOcE/l5igRa3fLGWQKdU9IqGK1Jb+NsKkae7YWqfCeB+c37aWtPbJ/1sA02qQ==
X-Received: by 2002:a05:6a21:6d9f:b0:1a3:55d2:1489 with SMTP id wl31-20020a056a216d9f00b001a355d21489mr1432790pzb.7.1711697088383;
        Fri, 29 Mar 2024 00:24:48 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id b8-20020a17090a010800b0029ddac03effsm4971798pjb.11.2024.03.29.00.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 00:24:48 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	loongarch@lists.linux.dev,
	amd-gfx@lists.freedesktop.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH v4 04/15] arm64: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
Date: Fri, 29 Mar 2024 00:18:19 -0700
Message-ID: <20240329072441.591471-5-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329072441.591471-1-samuel.holland@sifive.com>
References: <20240329072441.591471-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arm64 provides an equivalent to the common kernel-mode FPU API, but in a
different header and using different function names. Add a wrapper
header, and export CFLAGS adjustments as found in lib/raid6/Makefile.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v2)

Changes in v2:
 - Remove file name from header comment

 arch/arm64/Kconfig           |  1 +
 arch/arm64/Makefile          |  9 ++++++++-
 arch/arm64/include/asm/fpu.h | 15 +++++++++++++++
 3 files changed, 24 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/fpu.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7b11c98b3e84..67f0d3b5b7df 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -30,6 +30,7 @@ config ARM64
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_KCOV
+	select ARCH_HAS_KERNEL_FPU_SUPPORT if KERNEL_MODE_NEON
 	select ARCH_HAS_KEEPINITRD
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 0e075d3c546b..3e863e5b0169 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -36,7 +36,14 @@ ifeq ($(CONFIG_BROKEN_GAS_INST),y)
 $(warning Detected assembler with broken .inst; disassembly will be unreliable)
 endif
 
-KBUILD_CFLAGS	+= -mgeneral-regs-only	\
+# The GCC option -ffreestanding is required in order to compile code containing
+# ARM/NEON intrinsics in a non C99-compliant environment (such as the kernel)
+CC_FLAGS_FPU	:= -ffreestanding
+# Enable <arm_neon.h>
+CC_FLAGS_FPU	+= -isystem $(shell $(CC) -print-file-name=include)
+CC_FLAGS_NO_FPU	:= -mgeneral-regs-only
+
+KBUILD_CFLAGS	+= $(CC_FLAGS_NO_FPU) \
 		   $(compat_vdso) $(cc_has_k_constraint)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, psabi)
 KBUILD_AFLAGS	+= $(compat_vdso)
diff --git a/arch/arm64/include/asm/fpu.h b/arch/arm64/include/asm/fpu.h
new file mode 100644
index 000000000000..2ae50bdce59b
--- /dev/null
+++ b/arch/arm64/include/asm/fpu.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023 SiFive
+ */
+
+#ifndef __ASM_FPU_H
+#define __ASM_FPU_H
+
+#include <asm/neon.h>
+
+#define kernel_fpu_available()	cpu_has_neon()
+#define kernel_fpu_begin()	kernel_neon_begin()
+#define kernel_fpu_end()	kernel_neon_end()
+
+#endif /* ! __ASM_FPU_H */
-- 
2.44.0


