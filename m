Return-Path: <linux-arch+bounces-2948-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2977D8799EE
	for <lists+linux-arch@lfdr.de>; Tue, 12 Mar 2024 18:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60BE4B21393
	for <lists+linux-arch@lfdr.de>; Tue, 12 Mar 2024 17:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A2D13B787;
	Tue, 12 Mar 2024 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxIw98IB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3838613B2B0;
	Tue, 12 Mar 2024 17:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710263014; cv=none; b=ZDM0+dqOlp3/OVnF2aztlRxUDfE4B8ks35IYlPISoQMoKRTc4Nmicu1Lm6ygIFOvSUas1FshRI8rMNe4yLVwsgYhKAS1owMVzSt1zt2dmIDdu0YIkcO5UhcWKQiLniFOfKPT7V3MMrvnD45x7Tc8rHCI9B2H5We+HWwEf6k2uBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710263014; c=relaxed/simple;
	bh=uZZ0pxvUudvGaQrFvHsY/MGGWPShLhBfmN2ecn70snU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qCb1qEtcTRVHk/H4tlbIbjuYWuBYIvjW+GLM+wpqwcao6tuip2RHkTpd+Sv1C7YOvcB/OmTCaXYG1yPMZpXpwTMgyNezJRxPcqq4yxOBZMDjH4wbpX3/xC78RsWkZwWW1klWcpOcnoctLR4ujuK0omQzGGxpUeN/0m3j12DpCGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxIw98IB; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e5a232fe80so45165b3a.0;
        Tue, 12 Mar 2024 10:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710263012; x=1710867812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgfFEM0oJIh4ATTR993DWw0sPyKQH24EY/4/QOUPczo=;
        b=KxIw98IBPFvBUKPyIUxvRBJuBcqQnpSZCDaCqY0kKSvifF1KQfRexk1sokOU1UOL35
         N0QDSdk98/cHstpOxBuPyoKWHPTSyBjYE59EBh5MMdh6bOAttgtr44Ii7sgY2uVo/p5q
         RBIcSnO7AQzLArzoYL7OSM42XOT1XEpkKgzdn46l/wIba3JKXnvyiyIih/H/pnsDLXL6
         godBC758E50dj6JGQ27Jvuo3zRxFMSQn0WLozGbfTs7mmSXoPYDr+4aI81Hssh5Os4RV
         LWNNG4mRlfZ3J/myQorPgkuO4/SYuDo7uJy598Q9ejOEUyjuOQgV4ccH33IkcS5LuTsR
         oBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710263012; x=1710867812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mgfFEM0oJIh4ATTR993DWw0sPyKQH24EY/4/QOUPczo=;
        b=V1gjtWBPBSFYKMq/x+0X0AaZtBvPb2panayfnbOlgTjM6FvnmrS/5jGgQ/wSv0MEaj
         NYH5Rnzz1TVYT7EFDlWD3FjRD/0HIEZYNh124848NhUJlppwB0wkKQzMSKUKGk1YzHZi
         ATB91pO+fl5O8jLU0pyls2AeLB/R0NVjH2Z8N8F14c4YQ3b2ioFnR3DdkhwobKhRnEcc
         Llb8bcnzwTql+CI39S1pt2Yx0VLQWlRn7Eg/W9jWw8V8Pakd4Tjoy033V0K7L7Zxb5cT
         Zxv1IvTGOseYOKvm6fCW/5nlEFCrnALbx+jZ0rF3XV6V9ip29QPhEahKW655YS3iQgi1
         uokQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLoXMH7hhNX8tBnlfvEIwENLg1cMgjpDCOlrp9KacVik7Nl9AjjH9UXmlbnmCiS32npGOlibQ6CYe5IBkaFqbnPiuhYQwBXnEwJyWOKRaYTmzXuYasSJ8l78HpecnHCmPQEZSIc2YF9NUEW7O+u31Yc3ldVz2a7LQo2DtLbfuSLVjL5ssU2YTGqJDZ9AwqWUJXlgqSAhrp0u/yx9DFmgAyJDZaU0LgxZUH/pd6nvZbVhv+f/KE23WjeLeD8LD3tZmS6kmSKE3gipXz9AmNfEzglYSyARVSkw==
X-Gm-Message-State: AOJu0YyC/IlkFJ5f9H5agGfkPjvybNlOI7wKiLQLBmYA0I+z04PpIzAf
	RmwjpqciNQMCsJ7ovZA5ZLkZutzO7IVjDxiXMeO/npgsuRBeMqs6iHdRkHc/
X-Google-Smtp-Source: AGHT+IFq2CL0ds18qlKLUiBCru+tEydVmq2O3jl6A2X5cUl3NOOBJhsozkjJ4JcvCmlm7vgxw0hJ7g==
X-Received: by 2002:a05:6a00:3a0c:b0:6e6:96cb:3ab8 with SMTP id fj12-20020a056a003a0c00b006e696cb3ab8mr29726pfb.10.1710263011492;
        Tue, 12 Mar 2024 10:03:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 29-20020a63125d000000b005dc98d9114bsm6228742pgs.43.2024.03.12.10.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 10:03:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-kselftest@vger.kernel.org
Cc: David Airlie <airlied@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Kees Cook <keescook@chromium.org>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	David Gow <davidgow@google.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	kunit-dev@googlegroups.com,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	loongarch@lists.linux.dev,
	netdev@lists.linux.dev,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 08/14] arm64: Add support for suppressing warning backtraces
Date: Tue, 12 Mar 2024 10:03:03 -0700
Message-Id: <20240312170309.2546362-9-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240312170309.2546362-1-linux@roeck-us.net>
References: <20240312170309.2546362-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add name of functions triggering warning backtraces to the __bug_table
object section to enable support for suppressing WARNING backtraces.

To limit image size impact, the pointer to the function name is only added
to the __bug_table section if both CONFIG_KUNIT and CONFIG_DEBUG_BUGVERBOSE
are enabled. Otherwise, the __func__ assembly parameter is replaced with a
(dummy) NULL parameter to avoid an image size increase due to unused
__func__ entries (this is necessary because __func__ is not a define but a
virtual variable).

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/arm64/include/asm/asm-bug.h | 29 +++++++++++++++++++----------
 arch/arm64/include/asm/bug.h     |  8 +++++++-
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/asm-bug.h b/arch/arm64/include/asm/asm-bug.h
index c762038ba400..6884089a7191 100644
--- a/arch/arm64/include/asm/asm-bug.h
+++ b/arch/arm64/include/asm/asm-bug.h
@@ -8,36 +8,45 @@
 #include <asm/brk-imm.h>
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
-#define _BUGVERBOSE_LOCATION(file, line) __BUGVERBOSE_LOCATION(file, line)
-#define __BUGVERBOSE_LOCATION(file, line)			\
+
+#if IS_ENABLED(CONFIG_KUNIT)
+# define HAVE_BUG_FUNCTION
+# define __BUG_FUNC_PTR(func)	.long func - .;
+#else
+# define __BUG_FUNC_PTR(func)
+#endif
+
+#define _BUGVERBOSE_LOCATION(file, func, line) __BUGVERBOSE_LOCATION(file, func, line)
+#define __BUGVERBOSE_LOCATION(file, func, line)		\
 		.pushsection .rodata.str,"aMS",@progbits,1;	\
 	14472:	.string file;					\
 		.popsection;					\
 								\
 		.long 14472b - .;				\
+		__BUG_FUNC_PTR(func)				\
 		.short line;
 #else
-#define _BUGVERBOSE_LOCATION(file, line)
+#define _BUGVERBOSE_LOCATION(file, func, line)
 #endif
 
 #ifdef CONFIG_GENERIC_BUG
 
-#define __BUG_ENTRY(flags) 				\
+#define __BUG_ENTRY(flags, func)			\
 		.pushsection __bug_table,"aw";		\
 		.align 2;				\
 	14470:	.long 14471f - .;			\
-_BUGVERBOSE_LOCATION(__FILE__, __LINE__)		\
-		.short flags; 				\
+_BUGVERBOSE_LOCATION(__FILE__, func, __LINE__)		\
+		.short flags;				\
 		.popsection;				\
 	14471:
 #else
-#define __BUG_ENTRY(flags)
+#define __BUG_ENTRY(flags, func)
 #endif
 
-#define ASM_BUG_FLAGS(flags)				\
-	__BUG_ENTRY(flags)				\
+#define ASM_BUG_FLAGS(flags, func)			\
+	__BUG_ENTRY(flags, func)			\
 	brk	BUG_BRK_IMM
 
-#define ASM_BUG()	ASM_BUG_FLAGS(0)
+#define ASM_BUG()	ASM_BUG_FLAGS(0, .)
 
 #endif /* __ASM_ASM_BUG_H */
diff --git a/arch/arm64/include/asm/bug.h b/arch/arm64/include/asm/bug.h
index 28be048db3f6..044c5e24a17d 100644
--- a/arch/arm64/include/asm/bug.h
+++ b/arch/arm64/include/asm/bug.h
@@ -11,8 +11,14 @@
 
 #include <asm/asm-bug.h>
 
+#ifdef HAVE_BUG_FUNCTION
+# define __BUG_FUNC	__func__
+#else
+# define __BUG_FUNC	NULL
+#endif
+
 #define __BUG_FLAGS(flags)				\
-	asm volatile (__stringify(ASM_BUG_FLAGS(flags)));
+	asm volatile (__stringify(ASM_BUG_FLAGS(flags, %c0)) : : "i" (__BUG_FUNC));
 
 #define BUG() do {					\
 	__BUG_FLAGS(0);					\
-- 
2.39.2


