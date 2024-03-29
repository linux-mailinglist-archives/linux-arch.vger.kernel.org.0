Return-Path: <linux-arch+bounces-3317-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEC3891434
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 08:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95D532863C1
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 07:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8795026A;
	Fri, 29 Mar 2024 07:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AxAST/U4"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55E647F47
	for <linux-arch@vger.kernel.org>; Fri, 29 Mar 2024 07:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711697095; cv=none; b=F41Qdxsav9gR4WdlThkYb72q1O33B9PF9PiX9hjXD5PH0sdf12Nos3Prvkkv6FzmbB3gkxUUGGJbft3DQA9DjU30KXw9kts6DSqIv+bHA6RwFJ+5MoVJiLMpHN0jBNbCCCrzYWwDIZDR5blj84HwffUb16NGTmmF0VgqR8PgaM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711697095; c=relaxed/simple;
	bh=gxAW0DTrkLtRtKQJA86gMhjr+tKNdgSukt4KSi/OgcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oTe5hXJq5ozbPnsfp3Ca49p6RrPdI0WOHkI67OrFEwnhTW/ThQf7dJrfLa4pf+rKr8oVNqbEQTXJrseMwTq+rRiJ9+pNt3aTKWTS2YNs4bF0xniWIrppZ9U7O3KPMIW2V45jz0gue82dsRIW41o6QChWdyuxHK9TIGsSkpUAMOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=AxAST/U4; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2a04ac98cf7so1254905a91.0
        for <linux-arch@vger.kernel.org>; Fri, 29 Mar 2024 00:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711697091; x=1712301891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqbtCYy6rKAgoCWJo/IDkaQi4Zmy7pvo/Tw1FadjoIk=;
        b=AxAST/U497xjGykVJDQvhnMeDzd0dLvtTxtiRbO83g4AIHBhVhLkurVPr1EHb+fmvT
         xFRSY2emLL2CM3qn4XuI5crOsXFAXGKGwW4BSgKyqSIWF6z7DAAGFa9nGXs6H4YkfiBQ
         ZuH3ueFn+tk/Mnm2IuecSuiAWFuWOqtIeXqUrNtlQAtcq9kB0eJU+JV/Ah8vuFaePHcL
         WED0U/ZuPHxEK6q155ciLDDsjVd7gpSRsG3TrzmnuP97d2B1rO6obc6YpME1k8/f5cfz
         2VZ4aguZtrj1qm6mjK7GxCbJYoMRpX+l9oJ15/1o8N4vbJzSBFEHF16zSJVclHXHai8e
         K80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711697091; x=1712301891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XqbtCYy6rKAgoCWJo/IDkaQi4Zmy7pvo/Tw1FadjoIk=;
        b=IXZ9n1ZR7dXnIxjuiVFS0Kk3O8GJ0KOoUHADhkrMTZ2Lq/A6K1EwueG88rl/tp1Umr
         fwLzzCVosaacCXEixQ8YH/WpWEm0/xxibw9jhcvcf/5Ykq2kQ5qJ9wXM3iwrViri0kxC
         n2cWXKntSGUb07rx0hgok9qARx/CztJoe9ELDru2zNtm2S2I2qj/HpWv4Zap1FaWYTEI
         /37GGFcWLMgJONH0fnDYOI4CfxoNtKWJ13chUPLdheZv01fTdoCOzBzpHwsZp7gdXZyx
         /Ex37QdOpge+PPjjQaobujUv6SnKUoybWoNM62w6jV4Wyx5fJ1VQeks678XsLHyVHAwG
         cz4g==
X-Forwarded-Encrypted: i=1; AJvYcCVIHHIU7GK5jgAmQeocsyGpaVdROtQpD1X0i5HGdk3bzR8fr1X66oJqd7l2y9nwE+DHc2j2Rjm//djCWiJ2ktnBoCKonJCw+dQHrw==
X-Gm-Message-State: AOJu0YwEbgENmlQF0lhBMvPlQ1zV+tjauirF1e6WkV0jByUg9b4FXIfd
	/oyJbSeEBJ/mUD12C8f7/it6JEomgWWUlzhVd/AAODuWY2q4p0S2Lps/lubsRdQ=
X-Google-Smtp-Source: AGHT+IFpgVY+di4cvDttsjDdGENlsS7ZbuG0wU7DGKwYbCO2yCZHbkcZgR0Ijs83aSucHtPBLyzxXQ==
X-Received: by 2002:a17:90a:d588:b0:2a0:3b1d:7c5 with SMTP id v8-20020a17090ad58800b002a03b1d07c5mr6633406pju.3.1711697091135;
        Fri, 29 Mar 2024 00:24:51 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id b8-20020a17090a010800b0029ddac03effsm4971798pjb.11.2024.03.29.00.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 00:24:50 -0700 (PDT)
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
	Russell King <linux@armlinux.org.uk>,
	Will Deacon <will@kernel.org>
Subject: [PATCH v4 06/15] lib/raid6: Use CC_FLAGS_FPU for NEON CFLAGS
Date: Fri, 29 Mar 2024 00:18:21 -0700
Message-ID: <20240329072441.591471-7-samuel.holland@sifive.com>
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

Now that CC_FLAGS_FPU is exported and can be used anywhere in the source
tree, use it instead of duplicating the flags here.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v4:
 - Add missed CFLAGS changes for recov_neon_inner.c
   (fixes arm build failures)

 lib/raid6/Makefile | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/lib/raid6/Makefile b/lib/raid6/Makefile
index 385a94aa0b99..0e88bfe6445b 100644
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
 
@@ -75,10 +56,16 @@ targets += vpermxor1.c vpermxor2.c vpermxor4.c vpermxor8.c
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
+CFLAGS_recov_neon_inner.o += $(CC_FLAGS_FPU)
+CFLAGS_REMOVE_neon1.o += $(CC_FLAGS_NO_FPU)
+CFLAGS_REMOVE_neon2.o += $(CC_FLAGS_NO_FPU)
+CFLAGS_REMOVE_neon4.o += $(CC_FLAGS_NO_FPU)
+CFLAGS_REMOVE_neon8.o += $(CC_FLAGS_NO_FPU)
+CFLAGS_REMOVE_recov_neon_inner.o += $(CC_FLAGS_NO_FPU)
 targets += neon1.c neon2.c neon4.c neon8.c
 $(obj)/neon%.c: $(src)/neon.uc $(src)/unroll.awk FORCE
 	$(call if_changed,unroll)
-- 
2.44.0


