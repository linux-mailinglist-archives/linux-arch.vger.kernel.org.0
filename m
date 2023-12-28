Return-Path: <linux-arch+bounces-1185-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C84681F3C6
	for <lists+linux-arch@lfdr.de>; Thu, 28 Dec 2023 02:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 384F3283E2F
	for <lists+linux-arch@lfdr.de>; Thu, 28 Dec 2023 01:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B4A63DC;
	Thu, 28 Dec 2023 01:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PUF+l61d"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3EB469D
	for <linux-arch@vger.kernel.org>; Thu, 28 Dec 2023 01:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6d099d316a8so5281251b3a.0
        for <linux-arch@vger.kernel.org>; Wed, 27 Dec 2023 17:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1703727749; x=1704332549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BoxXzLgzl7b5Y0xu5pjyo/VkU/XWb+SGTLxU4jp8p0k=;
        b=PUF+l61dULBFx9BqJizRUQY7BSXzK1zIywqoOajIVLWAfCtySt9aPUkDC/IgSBclRm
         iqDsd7U66v//+5QULCMm99mwLWnhP1gkKEalhz3J55IwPdcin5uhKNW2zTkXniFnJo2x
         hyfhsAE69ien/ff0dSVQiVB4NL/0ndLQeB/NKYJjDeN61YCO9glHmPYIx+L2wak463TE
         vDp4BM+gWhOKbocJ5a7noEPqUL7m3zqZ1KGgCAJ3O01x9/uWFxA2DY+CEZX3oHc/GWCA
         4uVczuRwLIq/osigNc/pWe6sgayCeWlJZTfD3Dia3MFWkCTSREYU8nQqqQ+Tf3ain4/h
         U9uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703727749; x=1704332549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BoxXzLgzl7b5Y0xu5pjyo/VkU/XWb+SGTLxU4jp8p0k=;
        b=hCv4A05tp39gAdq4YbA/r4ETb1WPW2+ucus6T8X6AkJujCApAOgBr3P7StotTc/yhh
         bVayl450V4dUx6e1Y0j8n4dcKTwpE4P10R0SLDeneI4Ti4hlJs1XdOgxXmm9wWcdDbxv
         UR/0wYnbOHyczAX2Ptn7600/ra/GCaaIGoSRL83NSVMyM2l7TeTLGwxLhltj/V6pNjNE
         xhRj0MQAGrPguWujriFiRY2QD2/zg4MOmkj/n+WSCgXHcKYrIKXA/diR+DdQr3CS6RyN
         ErgSMlGTNmA/wOvyO02K8eAD/SR5Zy3xim6vn4ESZ7ajonsCn+Y6DenRtl4v+PzqR6Qf
         WVnw==
X-Gm-Message-State: AOJu0YzsvxIgYy3e+FCRY7XxsHbhCudb24jkWmr43P6vVnsPokcpJSwz
	LvotEy70RnNzLnBPNRb4gK7e5FTTrsEwmQ==
X-Google-Smtp-Source: AGHT+IFXwothAr5BJIcCMrRvq4/mKzewsdDIu4/j3geKR8xiDFkrXQfFhz/93Qk1mZI7uGYnkNSdng==
X-Received: by 2002:a05:6a00:4c81:b0:6d9:bc67:82a with SMTP id eb1-20020a056a004c8100b006d9bc67082amr5349494pfb.54.1703727748958;
        Wed, 27 Dec 2023 17:42:28 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id g24-20020aa78758000000b006d49ed3effasm7335440pfo.63.2023.12.27.17.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 17:42:28 -0800 (PST)
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
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 05/14] arm64: crypto: Use CC_FLAGS_FPU for NEON CFLAGS
Date: Wed, 27 Dec 2023 17:41:55 -0800
Message-ID: <20231228014220.3562640-6-samuel.holland@sifive.com>
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

Now that CC_FLAGS_FPU is exported and can be used anywhere in the source
tree, use it instead of duplicating the flags here.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - New patch for v2

 arch/arm64/lib/Makefile | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index 29490be2546b..13e6a2829116 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -7,10 +7,8 @@ lib-y		:= clear_user.o delay.o copy_from_user.o		\
 
 ifeq ($(CONFIG_KERNEL_MODE_NEON), y)
 obj-$(CONFIG_XOR_BLOCKS)	+= xor-neon.o
-CFLAGS_REMOVE_xor-neon.o	+= -mgeneral-regs-only
-CFLAGS_xor-neon.o		+= -ffreestanding
-# Enable <arm_neon.h>
-CFLAGS_xor-neon.o		+= -isystem $(shell $(CC) -print-file-name=include)
+CFLAGS_xor-neon.o		+= $(CC_FLAGS_FPU)
+CFLAGS_REMOVE_xor-neon.o	+= $(CC_FLAGS_NO_FPU)
 endif
 
 lib-$(CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE) += uaccess_flushcache.o
-- 
2.42.0


