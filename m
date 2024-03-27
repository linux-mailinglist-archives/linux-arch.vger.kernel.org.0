Return-Path: <linux-arch+bounces-3240-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D67D88EFC0
	for <lists+linux-arch@lfdr.de>; Wed, 27 Mar 2024 21:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69E5CB26C8D
	for <lists+linux-arch@lfdr.de>; Wed, 27 Mar 2024 20:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D12154444;
	Wed, 27 Mar 2024 20:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WXTcuH8u"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55919153BED
	for <linux-arch@vger.kernel.org>; Wed, 27 Mar 2024 20:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711569735; cv=none; b=l6/8WmaN361r/YLATyjXXd63gdpAeZCu1UMyMN/ldizcLws3x652tUe6PuukhrKPmpauMDfyQv6EcYev2IWeSq8oUUKawHczPmlXQ8/YIvGz+u4wSiny+bnymCzPojCeBRvC6RqsgqF6A3FN8gtQZ5fRYpP4xzXi3VEE5g/tP2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711569735; c=relaxed/simple;
	bh=91qMtAnZtTeg2i7QDjR/G11+PwQHwDTtJmPnZfMaIks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4C44Keu0UY6bG2Y4Eweq/k7NL7zHSucrlrcTi3PRMw9E4s8LD0+gYKaUG8x18tyW1RypHvC/N01xHK5zEJtJ2liGWEg0JVfoKvUlhXMfuIBZm5dn8fsQo0Qk1hbArFvPFL5dcTAKwgtVjeXUk9y0ASSU8R7pkLxRcPUq9V7yg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=WXTcuH8u; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1def59b537cso1591805ad.2
        for <linux-arch@vger.kernel.org>; Wed, 27 Mar 2024 13:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711569734; x=1712174534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kt5T6f5KKlAqEBrctbVWHiZ4yWz8xGfDOuoPShtqdto=;
        b=WXTcuH8uUzuIGT/od+Pd8SV6DHBLHYq6QrHDL02qsGiRffe0oX3Jpkfs+M46K7JwfD
         WRsTlx6HRVC7APzTJW/wRCnrTd5GXjwlg7v0uFo+TfKce6H1BoQ8B8svLFUdK9BEYKVr
         Ic1RYgatbgyzR68zJCvF39324ViwBqzBhx0dvzYyCpb6qJKhijMhAtAzRiGmi02FS+kj
         eF9k18UeRb7P8ff3pjkI3DiSxFBI0hkr6wZkgltf7ZC1QnOPkVKWs+gdneJDEWXExaxE
         RuLRzMJAS1KkJ+B/qHgk3o9K/8UJAC6E/Q4KLxlgr/zXJ7wegzC3XueOJoJ6hL4f+Kg5
         +PPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711569734; x=1712174534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kt5T6f5KKlAqEBrctbVWHiZ4yWz8xGfDOuoPShtqdto=;
        b=GqbS6FKJRijVibmFWbtF4NXwEQ0kkuybGcHywATupNabyYQbnXWF0kGIO9cDyv+yPp
         Ss1tkM+B0TtUvfQ5gzgD4AiWM0WHuqbvMpaT8WF22fWztOv+D7YJSg8Rl4F5Aig9Rs2F
         WKCds3j6FB3BmZp/ZJJwjck4mskyUfxFBNcvCwNywTsGQoyM+9Hpic+Xvd9oUQ0SFt+q
         1mAjAR70IR6+uIyY32VPTaf+qDqZ6JWTGS70tcGyfeUIsQv1Cn279ag/ypIwnZmfTLMj
         Pxmp97mTYb78GbXkCBlRtK4j2gjlCVeVxWVqrumk4qBlKO5U9TCFaJChNve7hGyI4j2d
         4BfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkucnoi0pWeMTq+jwfaERfhuxW9B9f7lI2oGrT980PPw/sdGgXqULAayilcc7o/zjp69MPNvV8MRG7AyiU0mK81XfxHnNJ2r/iqQ==
X-Gm-Message-State: AOJu0YwsWKbmTxIud9OEnfFzSsdO54oNYjGkJC5MZFYfsk4QYIOmYhaN
	uAgiTnhdtTVl7MRFS8Y6+IoIMSbI4rZx8aTwKLceR3AP48Az5tyEC9rZfSV0Hcw=
X-Google-Smtp-Source: AGHT+IGvbXfMD3NpHBvc61C4JrxkXrP2UbmyeCXEZSqIACFIDKyEi0FLcpBAl7w+qDDaJ12IbzUk9g==
X-Received: by 2002:a17:903:1211:b0:1e0:afa0:cc9c with SMTP id l17-20020a170903121100b001e0afa0cc9cmr851093plh.2.1711569733842;
        Wed, 27 Mar 2024 13:02:13 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e5c400b001dd0d0d26a4sm9446459plf.147.2024.03.27.13.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 13:02:13 -0700 (PDT)
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
Subject: [PATCH v3 11/14] drm/amd/display: Only use hard-float, not altivec on powerpc
Date: Wed, 27 Mar 2024 13:00:42 -0700
Message-ID: <20240327200157.1097089-12-samuel.holland@sifive.com>
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
2.43.1


