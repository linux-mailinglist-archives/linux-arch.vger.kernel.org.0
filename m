Return-Path: <linux-arch+bounces-1184-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9AB81F3C3
	for <lists+linux-arch@lfdr.de>; Thu, 28 Dec 2023 02:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D3C51C2161B
	for <lists+linux-arch@lfdr.de>; Thu, 28 Dec 2023 01:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0205244;
	Thu, 28 Dec 2023 01:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="IRj4wDWM"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A793C3B
	for <linux-arch@vger.kernel.org>; Thu, 28 Dec 2023 01:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-204f50f305cso146803fac.3
        for <linux-arch@vger.kernel.org>; Wed, 27 Dec 2023 17:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1703727748; x=1704332548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJe+2iWG7zhbu2gjOAPKG3r+a1/tBb6PXcWtzUfSG2Y=;
        b=IRj4wDWMchpe5e/SlDtZMjWCwEWx6bf7LCeVjTNfmaCvVOOK0CNgHJ0+I5Ttx1qYfw
         IJa6H5PuBZ4y+0P/lRAdb90JZKw9KnYAaRErnR6Rpj6xq8Vfc0JmK3I2GJqRe/jIbVqF
         gYUTK63PSAJhI13bAxb5gwp4Ti3d+gAPlaz6TSULeYg2LCA//Tq05BpUDWNOT8hDnfdp
         aRL4i+pJ9NP4gaNohjf+05d3bwlDk32npHj/GxiO/xCnWEBj0TASIGagmkTURtqd3kPn
         aNbZlCDfe/OMtBhOfA/Uy6bBjk0ciqWNRa37xEwqdsNnGUd0JH40B45m7mG3vNC4LPaQ
         eXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703727748; x=1704332548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJe+2iWG7zhbu2gjOAPKG3r+a1/tBb6PXcWtzUfSG2Y=;
        b=VzHaYrhmCYL41OQgoasuBDQG/QlIr424UC1elpVMGq5WqpRrUGTDvy6/dcxZOugIkq
         hzQVqkN31IWkF18iwcmZt8+9kMTb7aHUseTjPG1kCRIRTkTVBf+00Bdf2lSMmMKUlZrQ
         fr9mumaTJWjawNtLUSefiOBBtakv8rZncM8S9C/hO6ah7YL0TCZ9tnPEFZNt1yPhfYq8
         C/z8KkyRJ4oHUMEUdB44gbIRvhMcxB8DvW98Vdj0jUVI3FjiCIf/isUaJw6VQ1vDxCPG
         UTUU4+U1+TSFYICNmrnVIBqtgYhFcckX8/VNLDdIikxTR+5THK2P/slSgkEspZNdUNWL
         n5wQ==
X-Gm-Message-State: AOJu0YzOTmqMye3u4sjTvNZSYTdYvqe/QWQmeEfQjFzQN9CekcASmSfY
	IfGRkxl3H3vnNYfwVIXmSIaBrSoW5ei9Vg==
X-Google-Smtp-Source: AGHT+IHYZaSMdp2QaO80SoY2qT34DsaM+IszcA+ix/EbDuC7szn+dKwMtM8zlpfibfh9dbJ1h4v/ng==
X-Received: by 2002:a05:6870:355:b0:203:e0bc:5e11 with SMTP id n21-20020a056870035500b00203e0bc5e11mr10237951oaf.70.1703727746413;
        Wed, 27 Dec 2023 17:42:26 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id g24-20020aa78758000000b006d49ed3effasm7335440pfo.63.2023.12.27.17.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 17:42:26 -0800 (PST)
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
Subject: [PATCH v2 03/14] ARM: crypto: Use CC_FLAGS_FPU for NEON CFLAGS
Date: Wed, 27 Dec 2023 17:41:53 -0800
Message-ID: <20231228014220.3562640-4-samuel.holland@sifive.com>
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
2.42.0


