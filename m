Return-Path: <linux-arch+bounces-3235-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0EE88EFB5
	for <lists+linux-arch@lfdr.de>; Wed, 27 Mar 2024 21:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 140AB292C1C
	for <lists+linux-arch@lfdr.de>; Wed, 27 Mar 2024 20:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F518152DF0;
	Wed, 27 Mar 2024 20:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Xt3mXEg/"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D733153587
	for <linux-arch@vger.kernel.org>; Wed, 27 Mar 2024 20:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711569730; cv=none; b=esHs2/LcYXWyfHGkEMgRvzk+QSGB2+mKeizyvW6R42FZo4mHHCxkpgieuZ7LEr4He0Bxd8e91ZDMrsP2xd/q+tNQuOuS3T/q7IZzPKTRpWa2VvLDS9ANb0hBA1A01SRBPE/UJu6KhnTsOqV8hfYO8yjC/xI6OEUeUYtcRKopHYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711569730; c=relaxed/simple;
	bh=TbFyk0hacvmJ9olxKFdeN1kGuF2ppBFDV7NUTUOGoKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mq0ResAUyWuE/5o/y9tt04M9YzjokE11TmI+eTI1LAwUs5muTMz7N8xkoi3DCQAYS+JKPYcz3eCyZZxZ6EyXtX2UqLy0TJSXQKiBV3GVmRgruP+ffyMq2BIlVrnBNepA6Ja4keeY3PlKKetOtRl4YSLqSC/iCgCMqfBvwvdaz8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Xt3mXEg/; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1de0f92e649so2047045ad.0
        for <linux-arch@vger.kernel.org>; Wed, 27 Mar 2024 13:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711569727; x=1712174527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhRrF1Pu1wTofDEF5NDtSjXNjQrJmyXSgj6gSsLdD3o=;
        b=Xt3mXEg/59MBFTRdgHTEq6/YUBntsUb86f4GlFSntwg4zCn7YLTDRbgitWNGYkIf/1
         1ie1g41LPK9JPsrf+60jqIQtnVuU93cQ/JqZjAXruvYz9FTGPSpcUj+NprMiCR8Bz8VV
         cD1LLe3T05hoNGVyOG+VHrjbdGHmJ1Qe2NxAN11s4L9uEuOuyc1Vtm07cPGwihE1zrCH
         DG9bRmtcnxyq4Mr0ODh2tailJPdeMwK5Z4LOVqPZ6Gyi0Qh935qTTbTgoR3va3YV1q02
         vqGaj0sqCNweTnEBCNN1Rv/FTHsHPqj++I2FMbtDN8OKE2dj8VAtQ8OdAmC5hOp2GE74
         BbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711569727; x=1712174527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JhRrF1Pu1wTofDEF5NDtSjXNjQrJmyXSgj6gSsLdD3o=;
        b=Teqo4Wj7MG48FIebd9ggJpMqqlflD/hYtkUC6WpEwY96jTCmrWWOP7mBTiShU1lYkn
         WjTWrc9X3lUZ00ieIBermqcL/rMkoR8wa3PVybICyNx1Q8vulCyfyIB5fyImSL4g0wve
         vObLl10xFz/uO4kl7v21g2IZtgZcQ/ftl96JzkLLjaeZ2Zu9QawEkYOUI8Um9lk90pz3
         3SDeoKBjwbAHTpsDB8o4yAcDzX61VIbQU9irN23HInNcVgdlAueY1zMRvdr2Cbo7jfcn
         6O4bG3agYpnZiH8VA33B1OrC32XnHh3MHJHJI/WVAhKPcSiDia7yO55b0xjI2FO/qral
         E8Ng==
X-Forwarded-Encrypted: i=1; AJvYcCV4nypJM9kKNFEUEfobkdLPZQ/iZiPWsmR5aRKMw5qZV9uWCqHic06zafxwdh3QWW+6FAKRCuG7YDjq9FZZqqDMP4AH6pQMPnUOrg==
X-Gm-Message-State: AOJu0YyLSYwwx1OmKwmeWgr/3p/iOW/Duuc4MdT9GSdk1bfhANNHJteE
	yrK1tjgNy6VQxQOldrwARemyJtv8kMH4kAvSFez2k4lFU60duQgfhfm3CgewYP4=
X-Google-Smtp-Source: AGHT+IFTdj+7xjr/hkuUZrog62OKlzxWVPjf6p/E+DdPaik3Rv7nG00gWJ8Kh9j7qP1eqTQJrGE0sw==
X-Received: by 2002:a17:902:650e:b0:1de:eca6:483d with SMTP id b14-20020a170902650e00b001deeca6483dmr724908plk.27.1711569726983;
        Wed, 27 Mar 2024 13:02:06 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e5c400b001dd0d0d26a4sm9446459plf.147.2024.03.27.13.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 13:02:06 -0700 (PDT)
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
Subject: [PATCH v3 06/14] lib/raid6: Use CC_FLAGS_FPU for NEON CFLAGS
Date: Wed, 27 Mar 2024 13:00:37 -0700
Message-ID: <20240327200157.1097089-7-samuel.holland@sifive.com>
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

Now that CC_FLAGS_FPU is exported and can be used anywhere in the source
tree, use it instead of duplicating the flags here.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

 lib/raid6/Makefile | 31 ++++++++-----------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/lib/raid6/Makefile b/lib/raid6/Makefile
index 385a94aa0b99..c71984e04c4d 100644
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
2.43.1


