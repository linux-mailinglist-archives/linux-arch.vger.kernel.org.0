Return-Path: <linux-arch+bounces-3237-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A418088EFB8
	for <lists+linux-arch@lfdr.de>; Wed, 27 Mar 2024 21:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5B8298000
	for <lists+linux-arch@lfdr.de>; Wed, 27 Mar 2024 20:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B123815383B;
	Wed, 27 Mar 2024 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="a+zvewvk"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D42153814
	for <linux-arch@vger.kernel.org>; Wed, 27 Mar 2024 20:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711569731; cv=none; b=FDACA4hLRTa9Dox415Hd/2M6JnFv/ASHkejMmkP1Dp4OEg26wTwyJIMPydIgn9JyLEnmjEZqIDuIv8pOsZrZB3V8QzomE2n5hVyu7JHbD/v70cKqRGeae17HbH1JV5jPaXBydnvaG4K+7JA6eyVTwKGestVYz8miawiSfkc6TCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711569731; c=relaxed/simple;
	bh=Fw4bnCEbYOWgBUe7aXSYgGws+NbNxp0fhExNVQAWEbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BeIb0vXhfK6uHUZjo7hGKYGZtXN1wGYccvclcsr+uSMNSJMqo70xfhtbCy17TUanl+r57c3/3DaFZzWEJ4RVuwhwY/eqLmzJPQyJ1A4SSGWQJpk+cW3Z+y2P8x28p0UnK3nWqj6WrJH/HT4pLDxrASrwsq5xz0icZHk4yxvtM20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=a+zvewvk; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e0025ef1efso1870415ad.1
        for <linux-arch@vger.kernel.org>; Wed, 27 Mar 2024 13:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711569729; x=1712174529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m88RK+Z/il7UccpWfFZJ13Lz8O1oGIqhXeprohKD33g=;
        b=a+zvewvkRZ16W9B3hQMjxRA6roFHMtTuXOcbAAl2UVHLzt9L8pWb/IvZXs6YwyCo/w
         mdAmk2Ropp8ueAoi8mF+bSWKvEtZe3JP/TnX0IdN9NyxIy5hRK+tjJKv9IT0Gyfd8usH
         2UXmotfupvOzqv0d59ufki8HMgGJ0hRMObEhDqmne6Ckv2seYZlN5fRH1I8mwbLB4bHn
         iZKJVFUyrWcTfclDkuROstWeL2DlW5u0OHzExwA3gHijHV0USvnH5O0IURbWKoEFX8/Z
         LD1j/Z3sYQZvmugZrKIlbDFYN0sWXs7biaITyMPirfRhvlkM0ZR3rpiDTjekaEcXxbMu
         dCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711569729; x=1712174529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m88RK+Z/il7UccpWfFZJ13Lz8O1oGIqhXeprohKD33g=;
        b=kBvH792ge3OJYx/4efAVyB6jYpE+UwGZGvfpF6SGuzhmkwXN1o7VZr33lrEb9egrMe
         Tx50YsoUuK0PwfbrUzf33CZGNPMKlYWbz4nd1AkYXO6XRuaVaGvBhI0i9osEd3hiRLCQ
         Y2jEZhp705JQzlU0REt8ORx2+/c7ucX8OS2EGaoxjRn/BgSDNW4CojJTRHed8a2VFAsf
         u0KQk95Ff/FNuGm9E2MxvVnraXjNksHzUgIJu8Bkau3i7h+GZ+iBdlDnzG+HVMRFPbpB
         D/Sk3a7UmPgxEASmVi6OUYiyr6bwCcZdxJddHzmxa/HBRRngFatmGN3IZWXXw8nXra2R
         i3Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWJxq+o6YVlALgMxLgmKevXOjclZBu8Mnp1R+OXEd+AsiXivUVmgD/W25QpA27BG42z2jYySgxpy48PJQPz+Ym2O4mh/8te1fvnew==
X-Gm-Message-State: AOJu0Ywm6/a+SWrU4xaJCcSoCTUx2N67ICn0CSqpX+VjvsC2D8Vo7esU
	QLKjt7kZQWl2aKKF6UNuIzeriPxXXbWvqVWp/dy0dCRSQyWSH/2ZkWHcBSXL8Js=
X-Google-Smtp-Source: AGHT+IH0VAZKrv/13SGM5UcmUSkWC7Cq+3cYLh6cyOWJKLLcWVjV8z3mPcOJjmVufYLvLYoh5WS5fQ==
X-Received: by 2002:a17:903:245:b0:1e0:e70:4264 with SMTP id j5-20020a170903024500b001e00e704264mr785470plh.33.1711569729552;
        Wed, 27 Mar 2024 13:02:09 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e5c400b001dd0d0d26a4sm9446459plf.147.2024.03.27.13.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 13:02:09 -0700 (PDT)
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
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v3 08/14] powerpc: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
Date: Wed, 27 Mar 2024 13:00:39 -0700
Message-ID: <20240327200157.1097089-9-samuel.holland@sifive.com>
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

PowerPC provides an equivalent to the common kernel-mode FPU API, but in
a different header and using different function names. The PowerPC API
also requires a non-preemptible context. Add a wrapper header, and
export the CFLAGS adjustments.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

 arch/powerpc/Kconfig           |  1 +
 arch/powerpc/Makefile          |  5 ++++-
 arch/powerpc/include/asm/fpu.h | 28 ++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/include/asm/fpu.h

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 1c4be3373686..c42a57b6839d 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -137,6 +137,7 @@ config PPC
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_HUGEPD			if HUGETLB_PAGE
 	select ARCH_HAS_KCOV
+	select ARCH_HAS_KERNEL_FPU_SUPPORT	if PPC_FPU
 	select ARCH_HAS_MEMBARRIER_CALLBACKS
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_MEMREMAP_COMPAT_ALIGN	if PPC_64S_HASH_MMU
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 65261cbe5bfd..93d89f055b70 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -153,6 +153,9 @@ CFLAGS-$(CONFIG_PPC32)	+= $(call cc-option, $(MULTIPLEWORD))
 
 CFLAGS-$(CONFIG_PPC32)	+= $(call cc-option,-mno-readonly-in-sdata)
 
+CC_FLAGS_FPU		:= $(call cc-option,-mhard-float)
+CC_FLAGS_NO_FPU		:= $(call cc-option,-msoft-float)
+
 ifdef CONFIG_FUNCTION_TRACER
 ifdef CONFIG_ARCH_USING_PATCHABLE_FUNCTION_ENTRY
 KBUILD_CPPFLAGS	+= -DCC_USING_PATCHABLE_FUNCTION_ENTRY
@@ -174,7 +177,7 @@ asinstr := $(call as-instr,lis 9$(comma)foo@high,-DHAVE_AS_ATHIGH=1)
 
 KBUILD_CPPFLAGS	+= -I $(srctree)/arch/powerpc $(asinstr)
 KBUILD_AFLAGS	+= $(AFLAGS-y)
-KBUILD_CFLAGS	+= $(call cc-option,-msoft-float)
+KBUILD_CFLAGS	+= $(CC_FLAGS_NO_FPU)
 KBUILD_CFLAGS	+= $(CFLAGS-y)
 CPP		= $(CC) -E $(KBUILD_CFLAGS)
 
diff --git a/arch/powerpc/include/asm/fpu.h b/arch/powerpc/include/asm/fpu.h
new file mode 100644
index 000000000000..ca584e4bc40f
--- /dev/null
+++ b/arch/powerpc/include/asm/fpu.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023 SiFive
+ */
+
+#ifndef _ASM_POWERPC_FPU_H
+#define _ASM_POWERPC_FPU_H
+
+#include <linux/preempt.h>
+
+#include <asm/cpu_has_feature.h>
+#include <asm/switch_to.h>
+
+#define kernel_fpu_available()	(!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
+
+static inline void kernel_fpu_begin(void)
+{
+	preempt_disable();
+	enable_kernel_fp();
+}
+
+static inline void kernel_fpu_end(void)
+{
+	disable_kernel_fp();
+	preempt_enable();
+}
+
+#endif /* ! _ASM_POWERPC_FPU_H */
-- 
2.43.1


