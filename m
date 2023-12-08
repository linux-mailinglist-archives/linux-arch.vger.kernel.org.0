Return-Path: <linux-arch+bounces-784-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF33E809BF8
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 06:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F8B11F21340
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 05:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C46A6ADF;
	Fri,  8 Dec 2023 05:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Dk8xWHfZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27A1171E
	for <linux-arch@vger.kernel.org>; Thu,  7 Dec 2023 21:55:04 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5c5f0e325a6so1235285a12.1
        for <linux-arch@vger.kernel.org>; Thu, 07 Dec 2023 21:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1702014904; x=1702619704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cT/f+zG+eBk9GDNM3PRDRS7FWs4vWVwDUJpda1v2enk=;
        b=Dk8xWHfZUEGYbcq4rBFQOt5NQX1WON5x0U03CMOa1gXwmiOHsQ1+cjsCrw58iIsRMg
         IKnXNYpyf6ARFQkPvi9k/8Xcmp4eSXf83/eKRPBJTAxyuhx/Jk1eKduJ6mcQ3OH6cCP8
         eFi6iM35kXFxXlsKMAWkmXDWbgXm9p7UYUZE7Ha8n4gWb7q/ZSvuJthn8sojYk38IOMK
         9ybjvw9uSUar+rl1fer5qNtkEPSVoKyeidlKAPogOFxNC9JgTf81nyLr1Wg1SR1AOtas
         xVW1CVKp2r6T916J6rhLHiclSqifFTC5LJJ0Z0NZpMFHTIZzFxVnBRMhcs0HmWRvpAyB
         ynew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702014904; x=1702619704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cT/f+zG+eBk9GDNM3PRDRS7FWs4vWVwDUJpda1v2enk=;
        b=cxWLtO8EEJOEGFz7L+6DdTM7b1OojDuGww2hKGT2p/0TusEPrbhEc67KPGIqfhjSMd
         nFmO1wQDx5fctv4V63eUKD90Zz1TYQJ7+cm6dy+rf6xsavma6ei9NUmG1ycLhGA0IkrG
         0DMQRHz+uwyPzI/UnTcJQruyTYnBp9RLvJ0LahLEp7tfoZtGiKPHx6VsKIQFsvgEAmeS
         TWUcPubsrQkmF2q6EkNeJ1XOGyeb4y2cCtY+0PBA3MYKqaqQUUxW0XMYmH6+TIGlOp+b
         Ara3t5lBouz2r5X2rGhq7vI/5QmfQC4VF6ggW0bGlAOwZbitjaplv/bWm77XfVW4LotP
         zoSg==
X-Gm-Message-State: AOJu0Ywb2zVZgHbkjs5mhjWcpxxtpkDJb0OTB7fQBupAImQs5KzitFrt
	3vDOQXVa4BJBLuf4GWG/B26YGw==
X-Google-Smtp-Source: AGHT+IHjHZOPQupU2gBIY1LJy6ZLE2Spe4muScdMLjHj9er/qEsoCLB+Of3eLXhwYzBMH5NUihe96w==
X-Received: by 2002:a05:6a20:160a:b0:190:14d9:4797 with SMTP id l10-20020a056a20160a00b0019014d94797mr1355279pzj.4.1702014904099;
        Thu, 07 Dec 2023 21:55:04 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id s22-20020a170902989600b001ce5b859a59sm786250plp.305.2023.12.07.21.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 21:55:03 -0800 (PST)
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
Subject: [RFC PATCH 01/12] arch: Add ARCH_HAS_KERNEL_FPU_SUPPORT
Date: Thu,  7 Dec 2023 21:54:31 -0800
Message-ID: <20231208055501.2916202-2-samuel.holland@sifive.com>
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

Several architectures provide an API to enable the FPU and run
floating-point SIMD code in kernel space. However, the function names,
header locations, and semantics are inconsistent across architectures,
and FPU support may be gated behind other Kconfig options.

Provide a standard way for architectures to declare that kernel space
FPU support is available. Architectures selecting this option must
implement what is currently the most common API (kernel_fpu_begin() and
kernel_fpu_end(), plus a new function kernel_fpu_available()) and
provide the appropriate CFLAGS for compiling floating-point C code.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 Makefile     | 4 ++++
 arch/Kconfig | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/Makefile b/Makefile
index 511b5616aa41..e65c186cf2c9 100644
--- a/Makefile
+++ b/Makefile
@@ -969,6 +969,10 @@ KBUILD_CFLAGS	+= $(CC_FLAGS_CFI)
 export CC_FLAGS_CFI
 endif
 
+# Architectures can define flags to add/remove for floating-point support
+export CC_FLAGS_FPU
+export CC_FLAGS_NO_FPU
+
 ifneq ($(CONFIG_FUNCTION_ALIGNMENT),0)
 KBUILD_CFLAGS += -falign-functions=$(CONFIG_FUNCTION_ALIGNMENT)
 endif
diff --git a/arch/Kconfig b/arch/Kconfig
index f4b210ab0612..6df834e18e9c 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1478,6 +1478,15 @@ config ARCH_HAS_NONLEAF_PMD_YOUNG
 	  address translations. Page table walkers that clear the accessed bit
 	  may use this capability to reduce their search space.
 
+config ARCH_HAS_KERNEL_FPU_SUPPORT
+	bool
+	help
+	  An architecture should select this option if it supports running
+	  floating-point code in kernel space. It must export the functions
+	  kernel_fpu_available(), kernel_fpu_begin(), and kernel_fpu_end() from
+	  <asm/fpu.h>, and define CC_FLAGS_FPU and/or CC_FLAGS_NO_FPU as
+	  necessary in its Makefile.
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
-- 
2.42.0


