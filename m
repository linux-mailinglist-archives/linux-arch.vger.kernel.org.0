Return-Path: <linux-arch+bounces-3322-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BE289143E
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 08:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1E8D2862C6
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 07:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4848355E4A;
	Fri, 29 Mar 2024 07:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="U7Y9Zlzt"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66A441206
	for <linux-arch@vger.kernel.org>; Fri, 29 Mar 2024 07:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711697106; cv=none; b=YhooYaG3v4yI2RwZGuZFtm1STWXyaLpjkOU/SmfLBdRjNqfoXvrMAPOJ5R9ySO3u+xCG0nVTh1k4dU6LgpwYVfgnMDfXmopvsIknX00TrfOOOPNEt8O91uH50cj+xvBjv6fs5lGU7moEL5eLlBM4gZlYM3Ys9OUfrJmS6Of4Y1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711697106; c=relaxed/simple;
	bh=kpa1yeFKUWqDA55hlpZXysxwBbXgX1S+zha/rueetK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VtE9RmMz+5uDScFO7CCha9g5urFSHm2mKdIQArd4EXvck5bsKf0x0FBNbEgdjDiHv9XdOsIrkxfZu/mNbSUcwghr2uY0tFXTfrUFgv4uDhP3DhOxazlBagGGkGiEm5qRtHkgZ6lBdXC48jVWLz6Rh3eo09BVnfQEGTBqhbfKb0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=U7Y9Zlzt; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-29f1686ff12so1334715a91.1
        for <linux-arch@vger.kernel.org>; Fri, 29 Mar 2024 00:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711697104; x=1712301904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxmfK/dV9iwtkx63gHffuqsF2FQECTKGikC6K6RCS1A=;
        b=U7Y9Zlzt6RyeGBerVrUZnzqMxIlEH1I8gyZr6jxSR+EYlgFk+UKcyjlvQLc7lx5Kv/
         T++25o+F5oFKBiGewKMEU2muh4Ufw+Pv+il5Cv2l4KvQhGkEiPGlDGv8Doq1ikKPLOID
         qItr2ISBwzg0IPK/bvgdtfc9VEb186UEJYC9asK62rWpR7E8ZerOwfX2H2Dbly+Dycyv
         nS2vUWWFHHCIt4UTglTSelBxM1wYIpB3euklkRKXYLoheHlPx8QIysdqAFCYX6MkY5P1
         rKUarWXFHQ/LWq6DSWczDrYfgFC8TnVvLAnXyYZth0Ztez8iPHUFtJ/GhAVPPvzCDx8Q
         4psw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711697104; x=1712301904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxmfK/dV9iwtkx63gHffuqsF2FQECTKGikC6K6RCS1A=;
        b=KEsLUDjhOqo0vLqs6qDz9Qj+tphZf47/SQ4NgR3wp9BiMTP1+h9hdIDzyC/I77XFrk
         dGKMaLgSgbk/BjbixuDBzn9q6OGv07KOmaZfepXofu8bupZsO+2Lu4pY0VJueLCtQB3v
         26DLE9+QKb3VJWGlIsQD35T9tWGIsrMNFRUOtT67ZF4eJl5JQpj3zP78dV5xk34EGRc+
         Mr9Glk49IBQlQCeFwmsSTMHhpSiQdl2iyU8YHDhsYMZI0OQtySs7CcJBvhYylFeO66XI
         ESguo/v4K3b2ZSog6W1UeLYQ//NnQlej4qqgcJwGy2RkV8k6ZU5LShf4ZMVsAWrUVWwd
         x9gQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAqQNgjurzFA+76+kSvpMtRJu0DLmbaa4p4C/uA6ZsDYr29nyiRUyHBBrNQm2Mr0C0pW/6sdHVeeJMusOuncFW0Kg4Qswpp7GfwQ==
X-Gm-Message-State: AOJu0Yyp5xb9YuyiADZgqoMpSrLczicSU0M44+RR7admQqAQT98iYl6W
	OPTJZvKhZC3HKbuAfxQXPmQ4zzq4ASBJVjQDzsLJc/jgCAxsL5DpZMtGlldYjEY=
X-Google-Smtp-Source: AGHT+IHpeVerdLnkB6vVIrwuNmVNMPefUfPXpMCtetpMqAC6/YKtxmEHNVWfJReDkAcL5lZnKsQNnw==
X-Received: by 2002:a17:90a:ff15:b0:2a0:4a22:3740 with SMTP id ce21-20020a17090aff1500b002a04a223740mr1338180pjb.49.1711697104041;
        Fri, 29 Mar 2024 00:25:04 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id b8-20020a17090a010800b0029ddac03effsm4971798pjb.11.2024.03.29.00.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 00:25:03 -0700 (PDT)
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
	Michael Ellerman <mpe@ellerman.id.au>,
	Alex Deucher <alexander.deucher@amd.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v4 12/15] drm/amd/display: Only use hard-float, not altivec on powerpc
Date: Fri, 29 Mar 2024 00:18:27 -0700
Message-ID: <20240329072441.591471-13-samuel.holland@sifive.com>
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

From: Michael Ellerman <mpe@ellerman.id.au>

The compiler flags enable altivec, but that is not required; hard-float
is sufficient for the code to build and function.

Drop altivec from the compiler flags and adjust the enable/disable code
to only enable FPU use.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v2)

Changes in v2:
 - New patch for v2

 drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c | 12 ++----------
 drivers/gpu/drm/amd/display/dc/dml/Makefile    |  2 +-
 drivers/gpu/drm/amd/display/dc/dml2/Makefile   |  2 +-
 3 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
index 4ae4720535a5..0de16796466b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
@@ -92,11 +92,7 @@ void dc_fpu_begin(const char *function_name, const int line)
 #if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
 		kernel_fpu_begin();
 #elif defined(CONFIG_PPC64)
-		if (cpu_has_feature(CPU_FTR_VSX_COMP))
-			enable_kernel_vsx();
-		else if (cpu_has_feature(CPU_FTR_ALTIVEC_COMP))
-			enable_kernel_altivec();
-		else if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
+		if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
 			enable_kernel_fp();
 #elif defined(CONFIG_ARM64)
 		kernel_neon_begin();
@@ -125,11 +121,7 @@ void dc_fpu_end(const char *function_name, const int line)
 #if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
 		kernel_fpu_end();
 #elif defined(CONFIG_PPC64)
-		if (cpu_has_feature(CPU_FTR_VSX_COMP))
-			disable_kernel_vsx();
-		else if (cpu_has_feature(CPU_FTR_ALTIVEC_COMP))
-			disable_kernel_altivec();
-		else if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
+		if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
 			disable_kernel_fp();
 #elif defined(CONFIG_ARM64)
 		kernel_neon_end();
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index c4a5efd2dda5..59d3972341d2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -31,7 +31,7 @@ dml_ccflags := $(dml_ccflags-y) -msse
 endif
 
 ifdef CONFIG_PPC64
-dml_ccflags := -mhard-float -maltivec
+dml_ccflags := -mhard-float
 endif
 
 ifdef CONFIG_ARM64
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/Makefile b/drivers/gpu/drm/amd/display/dc/dml2/Makefile
index acff3449b8d7..7b51364084b5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml2/Makefile
@@ -30,7 +30,7 @@ dml2_ccflags := $(dml2_ccflags-y) -msse
 endif
 
 ifdef CONFIG_PPC64
-dml2_ccflags := -mhard-float -maltivec
+dml2_ccflags := -mhard-float
 endif
 
 ifdef CONFIG_ARM64
-- 
2.44.0


