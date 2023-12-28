Return-Path: <linux-arch+bounces-1187-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6510E81F3CB
	for <lists+linux-arch@lfdr.de>; Thu, 28 Dec 2023 02:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E92A4B23163
	for <lists+linux-arch@lfdr.de>; Thu, 28 Dec 2023 01:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039307473;
	Thu, 28 Dec 2023 01:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HRrYqQ1M"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F5C6FA5
	for <linux-arch@vger.kernel.org>; Thu, 28 Dec 2023 01:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bbbc6bcc78so1364729b6e.1
        for <linux-arch@vger.kernel.org>; Wed, 27 Dec 2023 17:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1703727751; x=1704332551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+RheApEuJN9kaaLRvICyPNbTjOVIvY5kEzb7DbTZjA=;
        b=HRrYqQ1M7T0XagVlhzUysvM9h33SsHQx78QCtwD64qF9ARhh6CyP41vp/N/j33EgIU
         mNz6+to30yKSSb20LzoHL2cPnBQD8Hc2n2kxzurBvj0nDOYXzQqmMoq4or1RxJXI7jty
         lGlV3AMjF4i87DGQRnIciQRHVy3TlSz+aBC1sBA0cd6Dxq2kwU9cEqdhklsKaL7Sgw0C
         nTj8VqriRvejZYFmTOxTOpjNwfm2Sj5TNf0N6+7dGXPqcFamMPQyJnxsott79G3oAGdl
         FP4CNfENvZz6Ki9qM/3kZ4rEurusCICr72v/yheVsCFvxj5reqYatDQ8gDYbwMreoMn+
         dOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703727751; x=1704332551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+RheApEuJN9kaaLRvICyPNbTjOVIvY5kEzb7DbTZjA=;
        b=gRjxeVU5SRAbTcMJdJXLWjwlNvscfXsWPyM5MGethgtxGU/Lm87T7bR5EUK6DCttcP
         dhUQ25e0uGWO7NwmwNLtVM79Dd13EZ1qcTAFswOxONoz251Y8rRYOPJGweYOVeeJTAJh
         ZFw7IaxQ4gemA7W/fEuDJNA2rBItf4JG8tKrYPMnfZkVO13mZLIp6CDNyglXlbAtVkSU
         /HdHVjVTwwMvex6nCV78j35axisOB6gMLlI9jErh+T4Ps/tJKMqk5d8UQJ1jdRHrWfeV
         ligjYVW0+3u2c3QBXOimG5Rr+FVbQE6vrmiSQRL2wWzDlcRF7pzx4VIowkYJeStmS3w8
         BDEw==
X-Gm-Message-State: AOJu0YzEzzjPPtbqKus64jdk0qPrHbmI0XV10TemY2DFEKN3wVLEDIY3
	CDCCagBMRFHqq7aNVu69SqwmwDv/dQKQ1w==
X-Google-Smtp-Source: AGHT+IFlYg0OgNqHd1istrtt2UTcBedE87vqCIVNtp3f0Z5ptnzM2zYPRY9OCADmqV6QIO1pVX8ZnQ==
X-Received: by 2002:a05:6808:6544:b0:3bb:b063:1afe with SMTP id fn4-20020a056808654400b003bbb0631afemr7698441oib.113.1703727751522;
        Wed, 27 Dec 2023 17:42:31 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id g24-20020aa78758000000b006d49ed3effasm7335440pfo.63.2023.12.27.17.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 17:42:31 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org,
	linux-riscv@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	linux-arch@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>,
	WANG Xuerui <git@xen0n.name>
Subject: [PATCH v2 07/14] LoongArch: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
Date: Wed, 27 Dec 2023 17:41:57 -0800
Message-ID: <20231228014220.3562640-8-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231228014220.3562640-1-samuel.holland@sifive.com>
References: <20231228014220.3562640-1-samuel.holland@sifive.com>
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

Acked-by: WANG Xuerui <git@xen0n.name>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

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
index 4ba8d67ddb09..1afe28feaba5 100644
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


