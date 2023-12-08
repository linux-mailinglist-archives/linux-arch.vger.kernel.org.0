Return-Path: <linux-arch+bounces-786-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B119A809BFA
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 06:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AA2E1F211F7
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 05:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C5D6FAD;
	Fri,  8 Dec 2023 05:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="C5d+xgNa"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D732A171D
	for <linux-arch@vger.kernel.org>; Thu,  7 Dec 2023 21:55:10 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1d0a7b72203so15560665ad.2
        for <linux-arch@vger.kernel.org>; Thu, 07 Dec 2023 21:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1702014910; x=1702619710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kq9/CzymS2t6cI6IAaf6StcamgWHCvrnQt5+bd0vsJ4=;
        b=C5d+xgNa+bd/wBsXAzgYPwyVmwfbfPYqJyTxOoQHV/imaBbdWWjpFdrSyfw5NIYZzi
         GI8+7ygk5JAA/X+/Q6y+vkMcjHtjh33AJtoNI07auVjS2gZgRNgO6itVBYxOF1NK/tOP
         gSj5m4yNeVVBcw+AbsiZNezvDKQNILD9O34vRXwGAXK3GHguscwrywOIV5Scq5J6hXjq
         Xaqwoq/5bEqwEUFf8DFu6Oe+B2r01CkWN4g3eHMTc+XgXl0ih5SP2/V81W3gVoF6a/d9
         GhY/zAibT/1/b9DydcFVak4NJDD+WKiEgmYdsXmBDNc8H9iw/oImIM8/7o+m/rZmU+84
         DiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702014910; x=1702619710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kq9/CzymS2t6cI6IAaf6StcamgWHCvrnQt5+bd0vsJ4=;
        b=rX5AuNKwWBIQ8hRj3cjvRZEJ6I9hxyI0JXojRDsWBMi8XYEqegfKNU0GIrvZUC3/sj
         FPHwG3gWLfYCzs19E31scOWCISqdnVegHITOU6tIJXxcVJyMgYqqkErwh/2oZd0WlAC5
         c29k9/mR4YOrah4GtBXkVQQdf8VtDjdgE0ZpJ6Ks1XpVN6dVYnGNGQgC0lTLwp4jXBwo
         pYZ4UxvIVrUPp27SJXP/Kaewx0Nj7UIkeEsN9X0d0Er61vbjyW1b27o/2bd4vIue1pgV
         qblECkCjOPBrtG/DaCCNsmqs2QpB2XawhSWFdy3nsF8bSvR7XuE5o0/s9PswiUW+YNlJ
         Xk2w==
X-Gm-Message-State: AOJu0Yyqp4QmpNUzh4fuc1IQ+qZhpOMLD4sM1Fbuo/aTZvB0I2Qc5y3R
	YU2ZuzZkEajf83BL1YVKZxEq3bHcSciR3DgFBDA=
X-Google-Smtp-Source: AGHT+IHV6F7Dn38rHWvZV+XaXS58Ch7TWuC4F5MVn7OmuYlLci2zlP9Fr0nUwpZzieoBTkpnbrTn6A==
X-Received: by 2002:a17:903:2290:b0:1b8:90bd:d157 with SMTP id b16-20020a170903229000b001b890bdd157mr4496557plh.26.1702014910345;
        Thu, 07 Dec 2023 21:55:10 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id s22-20020a170902989600b001ce5b859a59sm786250plp.305.2023.12.07.21.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 21:55:09 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org,
	linux-riscv@lists.infradead.org,
	Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	linux-arch@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [RFC PATCH 06/12] LoongArch: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
Date: Thu,  7 Dec 2023 21:54:36 -0800
Message-ID: <20231208055501.2916202-7-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231208055501.2916202-1-samuel.holland@sifive.com>
References: <20231208055501.2916202-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LoongArch already provides kernel_fpu_begin() and kernel_fpu_end() in
asm/fpu.h, so it only needs to add kernel_fpu_available() and export
the CFLAGS adjustments.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/loongarch/Kconfig           | 1 +
 arch/loongarch/Makefile          | 5 ++++-
 arch/loongarch/include/asm/fpu.h | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index ee123820a476..65d4475565b8 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -15,6 +15,7 @@ config LOONGARCH
 	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_KCOV
+	select ARCH_HAS_KERNEL_FPU_SUPPORT if CPU_HAS_FPU
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PTE_SPECIAL
diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index 204b94b2e6aa..f5c4f7e921db 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -25,6 +25,9 @@ endif
 32bit-emul		= elf32loongarch
 64bit-emul		= elf64loongarch
 
+CC_FLAGS_FPU		:= -mfpu=64
+CC_FLAGS_NO_FPU		:= -msoft-float
+
 ifdef CONFIG_DYNAMIC_FTRACE
 KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
 CC_FLAGS_FTRACE := -fpatchable-function-entry=2
@@ -46,7 +49,7 @@ ld-emul			= $(64bit-emul)
 cflags-y		+= -mabi=lp64s
 endif
 
-cflags-y			+= -pipe -msoft-float
+cflags-y			+= -pipe $(CC_FLAGS_NO_FPU)
 LDFLAGS_vmlinux			+= -static -n -nostdlib
 
 # When the assembler supports explicit relocation hint, we must use it.
diff --git a/arch/loongarch/include/asm/fpu.h b/arch/loongarch/include/asm/fpu.h
index c2d8962fda00..3177674228f8 100644
--- a/arch/loongarch/include/asm/fpu.h
+++ b/arch/loongarch/include/asm/fpu.h
@@ -21,6 +21,7 @@
 
 struct sigcontext;
 
+#define kernel_fpu_available() cpu_has_fpu
 extern void kernel_fpu_begin(void);
 extern void kernel_fpu_end(void);
 
-- 
2.42.0


