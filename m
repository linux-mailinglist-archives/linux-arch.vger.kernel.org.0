Return-Path: <linux-arch+bounces-787-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B81F809BFB
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 06:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C70C71F2125F
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 05:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E826FDF;
	Fri,  8 Dec 2023 05:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="eSoaiv3R"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F559172C
	for <linux-arch@vger.kernel.org>; Thu,  7 Dec 2023 21:55:09 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6ce831cbba6so1082183b3a.2
        for <linux-arch@vger.kernel.org>; Thu, 07 Dec 2023 21:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1702014909; x=1702619709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJ/tAo5hDwQPfRruz9afcRfXvkx00dxKddYKFVNcdvc=;
        b=eSoaiv3RAbbY2NaBNjD878XjrSAtvRe+3gHiselTxD5LVxCdzAFJf3dY3hr/jLeYk7
         PekZeG3b5R+Lmmx9dNz9Wq/CHdjgfDr7R1sQ0s8pz8crm88wE8ASkmflaBxGJfDCU6dJ
         A0hVT1oPsgguypJ9Id+kQMcPMgmWiwzWKPByYuv14A7eZ4lmnjVsKX+VJ5CXCIh4+2pl
         EsC8EsynuDG0k8s6zxAhLj6Eogtxp62jGP6/561coWy1rkOTpDRkRuYSCyqPXER73H7P
         3rebnT7DlUAm6M8RF/g3LnFxcRZ0QfUS2lVfOHFExBEJN6FzaGhhyKC+3oRfzdy2NNd6
         s5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702014909; x=1702619709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oJ/tAo5hDwQPfRruz9afcRfXvkx00dxKddYKFVNcdvc=;
        b=EOn4NRGMj09lQKY/FS/jUQAme8w7KlFe0GYDO8+GMVps5Jrm76cdef+NYMG6HjEHwV
         k5YvPHZKd8AWjfn+SPWRwnCXChjl7sBB6CsJc2ygO1EyBMwz3X999YWcGXSHXK9tBT2M
         LJMm0RFYVKM8dmZspOmU2W30uozkUDij2dCcXO38iZiHqrsW7JCyKdZpSkaOXNcJt7N8
         wfQ3D/b2W6hNgVTjqmuqXsw1U3cpNK0l0eG3YCmx9WFHz0KJKS/Vv78/AenDkJh3P/x5
         pKhcHpFmyDAvufFH6g30wKH+oZi/VXVfTiRkK+FFaTZXkXA1R55ZrYshqgHqdTs97I6s
         6kpA==
X-Gm-Message-State: AOJu0YyA25YtA4SIoUZlYNF11gcIzLG1DTjfzzqEoxtI30I4HGQT7YQN
	xRW12UfsmaPWeesEcelW9LGytA==
X-Google-Smtp-Source: AGHT+IHgMEmtold3cNsq0/10/gSamuXTn7dqDmNr7pkUJjR3cZZJuyMG6U/Bp0CgIPL33Lkbwgh+tw==
X-Received: by 2002:a05:6a20:4282:b0:181:74fe:ba83 with SMTP id o2-20020a056a20428200b0018174feba83mr4264495pzj.40.1702014909013;
        Thu, 07 Dec 2023 21:55:09 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id s22-20020a170902989600b001ce5b859a59sm786250plp.305.2023.12.07.21.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 21:55:08 -0800 (PST)
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
Subject: [RFC PATCH 05/12] lib/raid6: Use CC_FLAGS_FPU for NEON CFLAGS
Date: Thu,  7 Dec 2023 21:54:35 -0800
Message-ID: <20231208055501.2916202-6-samuel.holland@sifive.com>
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

Now that CC_FLAGS_FPU is exported and can be used anywhere in the source
tree, use it instead of duplicating the flags here.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 lib/raid6/Makefile | 31 ++++++++-----------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/lib/raid6/Makefile b/lib/raid6/Makefile
index 1c5420ff254e..309fea97efc6 100644
--- a/lib/raid6/Makefile
+++ b/lib/raid6/Makefile
@@ -33,25 +33,6 @@ CFLAGS_REMOVE_vpermxor8.o += -msoft-float
 endif
 endif
 
-# The GCC option -ffreestanding is required in order to compile code containing
-# ARM/NEON intrinsics in a non C99-compliant environment (such as the kernel)
-ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
-NEON_FLAGS := -ffreestanding
-# Enable <arm_neon.h>
-NEON_FLAGS += -isystem $(shell $(CC) -print-file-name=include)
-ifeq ($(ARCH),arm)
-NEON_FLAGS += -march=armv7-a -mfloat-abi=softfp -mfpu=neon
-endif
-CFLAGS_recov_neon_inner.o += $(NEON_FLAGS)
-ifeq ($(ARCH),arm64)
-CFLAGS_REMOVE_recov_neon_inner.o += -mgeneral-regs-only
-CFLAGS_REMOVE_neon1.o += -mgeneral-regs-only
-CFLAGS_REMOVE_neon2.o += -mgeneral-regs-only
-CFLAGS_REMOVE_neon4.o += -mgeneral-regs-only
-CFLAGS_REMOVE_neon8.o += -mgeneral-regs-only
-endif
-endif
-
 quiet_cmd_unroll = UNROLL  $@
       cmd_unroll = $(AWK) -v N=$* -f $(srctree)/$(src)/unroll.awk < $< > $@
 
@@ -75,10 +56,14 @@ targets += vpermxor1.c vpermxor2.c vpermxor4.c vpermxor8.c
 $(obj)/vpermxor%.c: $(src)/vpermxor.uc $(src)/unroll.awk FORCE
 	$(call if_changed,unroll)
 
-CFLAGS_neon1.o += $(NEON_FLAGS)
-CFLAGS_neon2.o += $(NEON_FLAGS)
-CFLAGS_neon4.o += $(NEON_FLAGS)
-CFLAGS_neon8.o += $(NEON_FLAGS)
+CFLAGS_neon1.o += $(CC_FLAGS_FPU)
+CFLAGS_neon2.o += $(CC_FLAGS_FPU)
+CFLAGS_neon4.o += $(CC_FLAGS_FPU)
+CFLAGS_neon8.o += $(CC_FLAGS_FPU)
+CFLAGS_REMOVE_neon1.o += $(CC_FLAGS_NO_FPU)
+CFLAGS_REMOVE_neon2.o += $(CC_FLAGS_NO_FPU)
+CFLAGS_REMOVE_neon4.o += $(CC_FLAGS_NO_FPU)
+CFLAGS_REMOVE_neon8.o += $(CC_FLAGS_NO_FPU)
 targets += neon1.c neon2.c neon4.c neon8.c
 $(obj)/neon%.c: $(src)/neon.uc $(src)/unroll.awk FORCE
 	$(call if_changed,unroll)
-- 
2.42.0


