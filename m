Return-Path: <linux-arch+bounces-3233-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3850E88EFB0
	for <lists+linux-arch@lfdr.de>; Wed, 27 Mar 2024 21:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6953B1C2A8E9
	for <lists+linux-arch@lfdr.de>; Wed, 27 Mar 2024 20:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9C915350E;
	Wed, 27 Mar 2024 20:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="kbjvTRce"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0338D1534EF
	for <linux-arch@vger.kernel.org>; Wed, 27 Mar 2024 20:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711569726; cv=none; b=nRgowZotb4iwF2xUVonAX7OExGxZkJbQ6HuDWM9W/s+4A7h7NFgvbeVHwxu2hlYfQVfxq6eo7/95WcOUhHF+mVZ4cMfDIs/pvwiGHmllvBpLACYo6J5pdB9zD51xz7D6Wc8nsQ9n0HzFOMMzFXcPoEd+xo85KqcXw0sTDzXH6gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711569726; c=relaxed/simple;
	bh=wYz6G8q6oWeJ4Uvu53c3haCJoG+yI+ujZ5wIFjhs26U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ee1iZF+ISOax9c2gLMLOOFRiZH/UFlSYDSza412dG8lNkIWwUTFOW69WdLWZUSzJF3h+D1j+P1mWxfJVEQlaZrolWbQazKcHwCEPoRY7TfYnnFQbBLZ2nJO0dZeqtno2bc6iIEjeJF/fCq/hu6xwgaXPboNeNUJ976eYxq/cCi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=kbjvTRce; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e00d1e13acso1824525ad.0
        for <linux-arch@vger.kernel.org>; Wed, 27 Mar 2024 13:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711569724; x=1712174524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YKNt/WF/wnD0YRJEikw0HuScFyU0745kXYQrNfvXV8=;
        b=kbjvTRceVPI80nSKlwxxQxmdyyUwEef69KmqydvyjtbVVq+36C9OakICJY0NuWVmdK
         m6m9vEaxaDt0YXpODh7YuzbsLw1OUrFtuiCuZuvKnYUwV/2WlIxaVsyPmKxJgn7iemtP
         7nPIz/gKZ8nRT5UntUgpyJUM6Zlv3JQGu1pzlFjzqw1HYWQwM9JmrJfkIVK9YFUEPDp9
         hS56XIHd4dc67gLz6WsO5u3oqf+VCP/IrpRCm1hdrZuY7T7txIyYd1nxUaNXuKX0Lh9Q
         d4a8d17eaUDEXWFwuW4c6Ln5SKS/lKjzXDGh7dK4oROhWWLSypjPVFBUu9CWT1C6kDFe
         oByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711569724; x=1712174524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7YKNt/WF/wnD0YRJEikw0HuScFyU0745kXYQrNfvXV8=;
        b=aC/vk3zxzOMsHZCHEYzP/Sop5a5vgr1iDZHqQ/cJnWBix0H57vsZ2Gheg9d9+ZqZxH
         piCa4RgJHJG4+TXkFRluoBBSTnfeXiSrzQT2WoRrZnwifiRV2/66MT9OiJKLNai1TVN0
         DqMn8bXb0cagmKpIbAyTnIVpGcprr1A0hYH768CBtaSE4ckkb+jALOBpEnkiUHkESISd
         eS5GzLmdUOWlRAvgGDM9VqRZcv3HbQSvoGxJNR7LcngAwxxqKeMA8BbFWbbjm+hdNYWU
         5CZUr1vbrQMei2zXsneUvVOwnaTQ/cmmo99RhJ529hejQRMsXRuONUJjELIca24/lWgd
         10ww==
X-Forwarded-Encrypted: i=1; AJvYcCXLCXa7zPc1JoVUVA1yY9JrZsL4MD9P8Gug2Q2eeHwPrnVO/R0KZCrYFqWOmUqT+TJ+MiaVHnnILTaxXm9nmdg/cM/L2G+JBdeABw==
X-Gm-Message-State: AOJu0YwqbOYOPqsWd4PYmrvytgjnMQ8fO/l/2wgoxcoZhsX1EW9eQeY8
	EannYt+bxYiCU0MkkyT/MA+DVoxIDsqn6xf+4pQTxwEaryUsOyAI3YWH2d5slco=
X-Google-Smtp-Source: AGHT+IFfqF0zaQyhJG4fHFNgO9YCVd9dAMtKWVHSa8WQRo1J9B12INfMAAQOQNi7OQwx6x82eCY8tA==
X-Received: by 2002:a17:903:8c3:b0:1e0:b874:1e5f with SMTP id lk3-20020a17090308c300b001e0b8741e5fmr850196plb.65.1711569724329;
        Wed, 27 Mar 2024 13:02:04 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e5c400b001dd0d0d26a4sm9446459plf.147.2024.03.27.13.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 13:02:03 -0700 (PDT)
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
Subject: [PATCH v3 04/14] arm64: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
Date: Wed, 27 Mar 2024 13:00:35 -0700
Message-ID: <20240327200157.1097089-5-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240327200157.1097089-1-samuel.holland@sifive.com>
References: <20240327200157.1097089-1-samuel.holland@sifive.com>
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
2.43.1


