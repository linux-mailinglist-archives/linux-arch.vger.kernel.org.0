Return-Path: <linux-arch+bounces-3234-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 279E088EFB2
	for <lists+linux-arch@lfdr.de>; Wed, 27 Mar 2024 21:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598C91C2F47E
	for <lists+linux-arch@lfdr.de>; Wed, 27 Mar 2024 20:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D810C15358C;
	Wed, 27 Mar 2024 20:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Ga9h2/Ay"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45473152519
	for <linux-arch@vger.kernel.org>; Wed, 27 Mar 2024 20:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711569727; cv=none; b=Q4UcF2uqTahqBX/yBnWU5Kv0XerbylyQ2FL152D8Z3cQIxxyUge6qXZzQufSMJILt9aJle1GveNTDrmdlW/7941PHCg7Q1G+AOb1pLJ8MRo3iga8BwYVUhaiXUSRpjZ3eUACQMe/EoMyXPJ3LBZo+aHaVZRqi/YfjmE9CbiMPoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711569727; c=relaxed/simple;
	bh=9cqIF+Bi5JTCjT1ojFORS3NgOriFIL4LCNqqaGMHGzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cXz33Fm370ObR3q2JwdmOKP3y2ENKcsXTEzSeMiBOetiLK+i4GFV7xiWf48DE6xgka2qoovixvHS3c4U3jCKItqelK3qq88ynhjvWjEPwLcPtZ/LqXcLgWKMZ5OcejevvP1qAMPXkkFqL8JruthPw7MF1YlNxOOiBGiAkt4qEYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Ga9h2/Ay; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e00d1e13a2so1945745ad.0
        for <linux-arch@vger.kernel.org>; Wed, 27 Mar 2024 13:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711569726; x=1712174526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9egB7QSoDAHRW6tgRYqVd+NUTiSQfL/JcKX7OjtD5w=;
        b=Ga9h2/AysoHBXC7z7wljFYPrdG0LrwrjAYe6MrT/ZDEcbQCZ/WFc2OTWc9x83RGAIF
         tCz0nY6SMtBtxranarM93mAB/XRL9HlA6ufuFkaCBnM6aqO60mypo2A2lIjmKQPF8KXt
         x8kZrKz2fcEWAXV3QMZRzmnO9sk6xBkizoyb1O1MkYSQ6lzqwfYaaXpCKL0WTrrMoT84
         48VfuwTHVpbbvwhGZGi4SlIPv/iL8MpN6kWx2pIUrnrVHsdjSpAcYSL3eUsx3N4nwcId
         SiAojdTOPq+DSpgySv69L3NHQbIYTe7wbUJ6OFwSkgjxAJKaYmt+rM9GQiHUJIoo3ukf
         t7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711569726; x=1712174526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9egB7QSoDAHRW6tgRYqVd+NUTiSQfL/JcKX7OjtD5w=;
        b=eOG8PFqQ0G4Q+BPVx55Y/N4bEv/toozIFTgOHdocon8RUOtRD5WlHs7DDEOWSPPcrf
         dM7hlI2chg5ocsAWrBHxqIUIzyU3a6UlQe7VNHhzfrd3YzpcQCM0P1y+KCdhgsPbMf47
         M8rS+0qgYKHFU20F6H0X3H2X7MPb6+hQ9zS334yF/9k5g037oL4sg0n64kLBvbIbALr6
         tl9mv0u5jDnWfbY1O97i39cSOu3lLXShX4O+hI+M8ckCMRkGuvakQq02Zwo+mmB/lUXI
         6nqd3w5oBbQzRvKsUqAL/BqjJpQG8D+VciJ8ASJzjJCqRzSuStMexSUJ4V9CINVWA/Ph
         hdQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWt3mj3CHA77vM1TrBCZYqPQ/9ur2X8yvJxc7lcnVF0jGigBd96ZJTPWah6avTc8ZWd4pcDX6qW9H+dI/QcHux43YLE6k1/XekFVA==
X-Gm-Message-State: AOJu0YwdOv1c/m+Z4pRAo4MiBaRBnhBsYSxe5DZgyLxBDhHCRX9s6Yxf
	LcJBT59CgBZDAXZ9n2aO8D9jAXOJIt02zIX+SA8/XVKgM0gUWc9O2GtwmIksv0HIL9wKJM79kyZ
	1
X-Google-Smtp-Source: AGHT+IFGHdi74bAZSMUCS5nBpcP7LI5Cfqz6VZFaIDx36rlYRojmLVaB4TIyZga5IdN5tuwaxR1nKA==
X-Received: by 2002:a17:903:2b05:b0:1dc:a605:5435 with SMTP id mc5-20020a1709032b0500b001dca6055435mr854470plb.31.1711569725718;
        Wed, 27 Mar 2024 13:02:05 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e5c400b001dd0d0d26a4sm9446459plf.147.2024.03.27.13.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 13:02:05 -0700 (PDT)
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
Subject: [PATCH v3 05/14] arm64: crypto: Use CC_FLAGS_FPU for NEON CFLAGS
Date: Wed, 27 Mar 2024 13:00:36 -0700
Message-ID: <20240327200157.1097089-6-samuel.holland@sifive.com>
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

(no changes since v2)

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
2.43.1


