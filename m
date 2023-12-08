Return-Path: <linux-arch+bounces-783-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C39DB809BF6
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 06:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 007731C20D18
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 05:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A29F6FD0;
	Fri,  8 Dec 2023 05:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OQ4gmhmB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178D51723
	for <linux-arch@vger.kernel.org>; Thu,  7 Dec 2023 21:55:07 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1d0c93b1173so12966625ad.2
        for <linux-arch@vger.kernel.org>; Thu, 07 Dec 2023 21:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1702014906; x=1702619706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqG7sh4TEQnomN1Pb8iughMffScuejFKYmgaMeTCLmM=;
        b=OQ4gmhmBPL0W5BEgW+wQeXghXZv4uH3M9RVBmJrBXd23gYpG6UtKr30pzNrZRWvRLZ
         OeCByuJhUIYj9o7x0VgIP9JySXtTdl/un9zeWq7D5j6aFqeISRPeb89P4Znq8qbN7RT0
         NZKA4dCgx77EMwBuWvyMQkXcFdNib+PJDk0DBYRk5D1jGv+3+z3MwGFNzIMhK1Z4nqD4
         7Hnl+vjpCVMvPUTLEtPb+APMw7yzLFQ6mzVZL6Z4IS53yjgDAhn9r6t+gkrVKDeCWC0M
         CRnjvINgwKkAvBxH3QMZUtC0jWDdzhYZmSAdUUoWVmlBJ2g2R7Gy9pvn1RbHjqUjXrjr
         oeRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702014906; x=1702619706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LqG7sh4TEQnomN1Pb8iughMffScuejFKYmgaMeTCLmM=;
        b=usK7uuwI74MIDSs5ENRJcyi1L8I6ZgG9VtF7XYzB0/ocLJ7t1ULOvWc2iERMhfErmk
         1hVBGyxeQ4AEUPJAPn6tfeYu9qqQG1vViis4OEQSs7ogp71JCKNydddMHmgtSH9jilNq
         0/VFf2IYkM+RdkRcwwC9/r9GcOcHDpJT4/CllO+TRNOpq0uTN7xkDpJnWKwey/AOL6qp
         wCVcRSvviXy+dGiiBSUF/lsgh3TrxXHYLc84ria+ROnFOCVuNuy71abPsYRwdw1q8FUx
         STxut2iP+azwBrLRn2wJAsO54BbySZDQ4n6p331SBI1EfPyeg6Ay1l5L6KwSCFvA76rx
         8kSg==
X-Gm-Message-State: AOJu0Yw8/6GwaZz8LpjEuJbPRLDUvgRK4eQvQvkoiMtAQ1cfUn420LqS
	5Op+BLpUARSgF6AM3nM6jqlOQzVEL6wYhSXIGXQ=
X-Google-Smtp-Source: AGHT+IFmoFC5Jy7QDutaZzebMhgROVCbFnFB+FkSDZrKf0b9QQV81pWWj0y7Aq09xAemAJ7UXgVmYQ==
X-Received: by 2002:a17:902:ee45:b0:1d0:6ffd:f205 with SMTP id 5-20020a170902ee4500b001d06ffdf205mr3064563plo.91.1702014906581;
        Thu, 07 Dec 2023 21:55:06 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id s22-20020a170902989600b001ce5b859a59sm786250plp.305.2023.12.07.21.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 21:55:06 -0800 (PST)
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
Subject: [RFC PATCH 03/12] ARM: crypto: Use CC_FLAGS_FPU for NEON CFLAGS
Date: Thu,  7 Dec 2023 21:54:33 -0800
Message-ID: <20231208055501.2916202-4-samuel.holland@sifive.com>
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


