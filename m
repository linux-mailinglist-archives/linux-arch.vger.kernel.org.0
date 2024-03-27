Return-Path: <linux-arch+bounces-3232-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9D788EFAD
	for <lists+linux-arch@lfdr.de>; Wed, 27 Mar 2024 21:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2ACBB2281D
	for <lists+linux-arch@lfdr.de>; Wed, 27 Mar 2024 20:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8E6152E1B;
	Wed, 27 Mar 2024 20:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="apkzLDLG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B19152E01
	for <linux-arch@vger.kernel.org>; Wed, 27 Mar 2024 20:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711569725; cv=none; b=KspuxCckjFbBetX/XKVZKdrJsGZiX6qRXyG5wScYaHnvljV3ueKGrpvLurHTowEpTgOTDeiw7bHriSYCLkX14zyYR/uiEyqRIEUARwJAKIF3yCgyX5H7pp0gonT8mF66Z8IofUhnrxPRsMDW3kuWVXXWeUdta+j6EkDbrC9zSig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711569725; c=relaxed/simple;
	bh=JFTn7HBH7Lnt1aUxkwHzbnUdwmlaZ5Y72ysNp/iIKHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nlwzHY7GA9qnLIIHFwXHVSI4aJqMsdpjAg/OgB1wewJZHIgHRZj3yik25NrVllxppYvynkX2izCSgl/9csR19fuaocMe7APB1nPGAD89EesoWb4q6Ud4lqtagJtm7I4k9JoCSQTLZ1o+954ZsN2VOg3HPrnDLag4zsvMoOsIWhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=apkzLDLG; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1def59b537cso1590275ad.2
        for <linux-arch@vger.kernel.org>; Wed, 27 Mar 2024 13:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711569723; x=1712174523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3VQJildZHY1Bgj6r2iljFMqpw+vWq4Si7He8vtNBY4=;
        b=apkzLDLGri6I/KIu6YyYeNeivENKcZhXqyTQ5B52eDguME+M/+R1oHSdZrROI0i04B
         0VJt7pn7h55cg0dZGji+nMVzki38fTRq1MdnNL96YNgWjk+GJzShG6PT4CGarKHo9P/V
         1PhKr4QeI9W9EMTfb5deKTeuwTBZTb6ygW/ll7+pFVucrfka/OCwbxnEBA0cgfRl1041
         VrXn0q/fjgO2ErN5NrYS9IQRmq5n6G/+vIayUDWfKkC48Q3Fsca3hjEZz8b/AEOsaZnX
         wTBLb0k09KZpmjgReW+NThiYtYWINmAX8PGpx6GMPecfy6EtkBRkXZ5Qc3KpQjb9TDWe
         3xsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711569723; x=1712174523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z3VQJildZHY1Bgj6r2iljFMqpw+vWq4Si7He8vtNBY4=;
        b=UGrFsr9MwQyErXD3NThEQ5fBFUjPYOVBKjY2kUO/AKMap6QyVsGN5Dk1o8VU6z8G+b
         iJmSki/dqlgmlw8J7q4z93+GfX/+Hax/lubQny79iEqyuefu9lh9ym5hIvGjaxPMOZ3S
         jP8tui2vzjfItSrS3kmTSXnEmiNlfY6575ZHrxUwmbGd/+rPLTN6NmVZIxurscIuCdvl
         6A4gZrRcypDfqOrTXop5kpFz5hjj5FedSN3Jheh6xg3PPp6hFhh4Cm5gba13Ez0Tw5iL
         /g7ta+LbRluCT6eqiwsUgOF2zerf5eu8ei5WvHX1fXgYCHAI+ku1strSP+jZ+f2+ZFj3
         TIDA==
X-Forwarded-Encrypted: i=1; AJvYcCVne+Nzll1I1PQJvfekWJmP0tr8BIkzu23+f9iuG6xGOdLaAzd/JUzxm+o36OEHnIl7H/HRLB60NePV7u9zgoo4imgvBhSAohADLg==
X-Gm-Message-State: AOJu0Yx8niaWYoMwIiOmp6YmlX8pv44meL2/64sA4jghjnZSM47bvLPs
	D8zd0b5lbAUe78tgJveeCW8VdszeDMB0ME4BEwM52XeCi3nD3I7+xXutihPFllw=
X-Google-Smtp-Source: AGHT+IHYrCNFuZi7JM5PzLehk0tocOhYuLDObxCk9XIqMJvg9sySawc5MBuX1NvDT7qWP/3i+9Szlw==
X-Received: by 2002:a17:902:cece:b0:1dd:c7ea:81f3 with SMTP id d14-20020a170902cece00b001ddc7ea81f3mr964085plg.1.1711569722972;
        Wed, 27 Mar 2024 13:02:02 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e5c400b001dd0d0d26a4sm9446459plf.147.2024.03.27.13.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 13:02:02 -0700 (PDT)
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
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH v3 03/14] ARM: crypto: Use CC_FLAGS_FPU for NEON CFLAGS
Date: Wed, 27 Mar 2024 13:00:34 -0700
Message-ID: <20240327200157.1097089-4-samuel.holland@sifive.com>
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

 arch/arm/lib/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 650404be6768..0ca5aae1bcc3 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -40,8 +40,7 @@ $(obj)/csumpartialcopy.o:	$(obj)/csumpartialcopygeneric.S
 $(obj)/csumpartialcopyuser.o:	$(obj)/csumpartialcopygeneric.S
 
 ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
-  NEON_FLAGS			:= -march=armv7-a -mfloat-abi=softfp -mfpu=neon
-  CFLAGS_xor-neon.o		+= $(NEON_FLAGS)
+  CFLAGS_xor-neon.o		+= $(CC_FLAGS_FPU)
   obj-$(CONFIG_XOR_BLOCKS)	+= xor-neon.o
 endif
 
-- 
2.43.1


