Return-Path: <linux-arch+bounces-3313-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 756F4891429
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 08:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30F8C285E6F
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 07:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674414206B;
	Fri, 29 Mar 2024 07:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TYYxwge7"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CEF40BEF
	for <linux-arch@vger.kernel.org>; Fri, 29 Mar 2024 07:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711697089; cv=none; b=Ydet08sP6hRgrLAgZ6N7MkfpWZR7m6A8Qm1zA2dtvO4vqFB4Cfq02iG+F6TumNjoPbnOQXLLpa38aiCUMmLPACd4q4hLjeA3gfgsJEOEWwXnYEGe8Cw53kWixtHOyWvvQfwEQGNusUHp7iwjiXGy82TXbOw5eOgb2lZM3sqF5rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711697089; c=relaxed/simple;
	bh=RJd5BlsAAxF5X8VrsYLoWuX4V8CXbuiKI9CxD4Htyqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zm7LBeBgY8Nw82arjHDEx46Q54WwbakEdZRsoZC1n/LhBjR3f0m0RMlhXwh4WuWO87fdTeDdIUdu7CYqqEusNroOZqeiodjwxE5F/DFfeWURvuk46SAykgv96DeQPlWMYQPCet1X13W78dLnHqhkBRxQJ2287HjCy4rYRBCqe28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=TYYxwge7; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5d4a1e66750so1061254a12.0
        for <linux-arch@vger.kernel.org>; Fri, 29 Mar 2024 00:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711697087; x=1712301887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDl3drvCV8mQminB8cd0FWY5ZeQD5iRDfGVHISUC3N8=;
        b=TYYxwge7GMLc2eJ0SzKwv8AKKFwZyVStS6nI4in3WQN4GQDt5YQ0TS3KOIFx7RvKzi
         hr66BifDtM46dV0iMZ0/aP5glOGZCpa9cPmxNbpxiqDo9GzV4/S/GzgecdU1pqzcwRh8
         3g/sqQHS/2kW6TYHgZCv7a4BlwblG4AiA1AzcItZpOBaFzEI3Yoo5kwjfIjLrbef1f9u
         4G2Q1RFjzp1QcP0Bscr0s7qE5B/i4Zo8RpRRTFNwfBNuNx72YNy6gN/sSPZZjTOEPWvF
         hChdCdsased1KxnstAyihyKGNocBckEqpok2cQ6kbP/iNrPj4v6keb4NIbfjSK5uFLTL
         huBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711697087; x=1712301887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDl3drvCV8mQminB8cd0FWY5ZeQD5iRDfGVHISUC3N8=;
        b=vjrwXUa0RqX2L4I1YtZQJVhkGKRSPuS1IX0BRBAXuJrn1J+Dhq6lFx5lBSDSLuAVky
         yTIvb/byUEf2MSJL/qRVBCLZI+kjvHb4588eB3BImTOVfki+PVa+BRso7dkfXn4uojm9
         +IXmtNsDlDemwP3yQNIuZ92XojTVllMocAlKzPHp1QGjQmppl42cUNiNBty/uBUarBEb
         AdpL5hyGhChgJy+nYm3npQ0P18qOxgDgLN/r/xL/V+rwEYR1VN74DI82yjE/WwyZfRcn
         tvIuyR3YOvvsCWNwglorX0igRqFvhHOMPfT6shdgBUqsIUFYXOluCJrR96kT3FI8Ge8e
         n1vQ==
X-Forwarded-Encrypted: i=1; AJvYcCUACp0OMmMx50q7mn/ZMxk2Su17p0HdAh6eJu7l0OkCyCa0qmjRgZ+oQ2AEKptoxB9gQsEpmzdfEzwu6isxoEHNxM3qHMe14WnQ1g==
X-Gm-Message-State: AOJu0Yytn/cWc8KinI/eN7Bk1SmgVSyA4d2FrYfsceXae81uI+bON+9Z
	JCXxNntGwFqasSiQFHIFAvzJJF27wGV5Ix9NkZX5bZZOrCOPGiuGkKw01MlfPBY=
X-Google-Smtp-Source: AGHT+IF+FV+uMuQXtJuoJZDILLDfziMVBq/KUES3aiEW6OY8o73iJ5kWmw5SdybGS1gXP7gvN622NQ==
X-Received: by 2002:a05:6a20:394d:b0:1a3:647b:b895 with SMTP id r13-20020a056a20394d00b001a3647bb895mr1477372pzg.47.1711697087156;
        Fri, 29 Mar 2024 00:24:47 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id b8-20020a17090a010800b0029ddac03effsm4971798pjb.11.2024.03.29.00.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 00:24:46 -0700 (PDT)
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
Subject: [PATCH v4 03/15] ARM: crypto: Use CC_FLAGS_FPU for NEON CFLAGS
Date: Fri, 29 Mar 2024 00:18:18 -0700
Message-ID: <20240329072441.591471-4-samuel.holland@sifive.com>
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
2.44.0


