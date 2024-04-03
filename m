Return-Path: <linux-arch+bounces-3387-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6DF89707A
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 15:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82C511C2091B
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 13:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B9E14A63B;
	Wed,  3 Apr 2024 13:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nu4h4TrH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F9914A602;
	Wed,  3 Apr 2024 13:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150401; cv=none; b=aC7k3kW99b5Bka3Oi3W2eSVXkRDx4QvnJmGFzKQ0IvFQUfRj8tVK65At8udJhJT2coNcHFyZ6nuuB7uWGuu3z6OhmR5HJoOA1x+Uyb4NJN7QTuF0Qg4739iHn1tjmfCa12RZlD0RgXurq9gwhUgFEC26X0DfLFC4vB0U1TE8TpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150401; c=relaxed/simple;
	bh=0fLvUVIM8hMnJqHuv9ZzGmXuFPtZa8t4XuuwICdw7MQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gmxNdwFWx4d3aKpaNxzQZSTWmTnP6aDFiIMgXut1mtxm0TtPIX4Hd48gtxLzKKNsoIbxsB49E208/6r6e1kmtcT+eDDb4LzOKaiQBPDr9YHcchCj6K7L/lrSJ05wx21pps8zWE2xrxEQKZS/FbNnLNa7VvG9axmgVBxL2PDkun8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nu4h4TrH; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e7425a6714so5223012b3a.0;
        Wed, 03 Apr 2024 06:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712150398; x=1712755198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4Cw0LtOjrrGR/zeu8wuFTPQ/EpLq4I/3itsXmN/APU=;
        b=Nu4h4TrHzw6HDvBQjtBm3Axj4w4ZsmMHl984Pby1VZ7P0SJAv/VAN4KJxl3Qn1/rXf
         ulvJvpOVUg6WEhlIHozTuOsRI9Rxpwe8JXcPoPnt1dEwcCxRb2A0Odmqf0novqR5z8f+
         4C3w416CqqVygXZua5K9IDhuAS4Xsn5dJrJBzQ+qc1rpWrvTN2ddnn3Pje8U3AJmGhP6
         dVdOk+YxUBIa1oXbTgI7iCxDoivyhSXlZG6kDGpqtYJn8OYTVLkq5eBpX06Y4h76uQ65
         RUKPep/yh4YS0nvJKaU1A+3XSnMwz6O0aA46ypYp6j8zrL6OBb7R5bD84e7iwD6iN154
         3FPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712150398; x=1712755198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W4Cw0LtOjrrGR/zeu8wuFTPQ/EpLq4I/3itsXmN/APU=;
        b=JlUWaeJch2h1jenU2gzuzukIPAtHUyzE/ah1oxY3fGOl6gpAn+N8ZSaCDQL/yKDGtz
         cR6IJeaB+AwKGftMftOFmHJyDk8Czmvuj4YIeWBQOEgMxxR/89FgBVGhdxivdmbJKZy9
         4G2L7yKgLpb2GUhwwLQgCX2ZK38gipGmAt1N2qMjq6EzHklIZ637JuFdsX0Jp1yiNYY6
         ULzeEuCAc3mV1LFEvgIb/7tjVNm3lxB8dtN20YyUyCed3Cvtlk4XANoikM4f7iqz2yhm
         POXO4t0/79fTKJbEqLYMV6XKL0UnkljbTS5wpszyj2ROUurrLm+7FSVyvCYWIjsNCbYU
         pM8w==
X-Forwarded-Encrypted: i=1; AJvYcCWskwg6iFlsXWTN9vpJOEtZzi4UDZJNIhdBWsqVEt14ut2xidLtCbN7B3fi6nnJYszN6wirixNs1JJEMGdFfInfQP4c1LAe64pFQVId4+Ru4w8X/RJrhNwQPZuO/0COPGVckeeSTXL2xjdrcd7BluBd+j5zVlMwhDqlUXvr51JruJjWe3/4+lDtVmYdWpBZfpj1QkZJUh1RbVK7n17mIaCxCnDh8vfuHB0IerGqCmSquRs+RMEXjXJi0Dons9WsRTSo4d1EZlO8IMenLVrYcdxiamJnkfzsfj5D6QmHg4xQG6IulW3NfnIpfCMEaw7w/Q==
X-Gm-Message-State: AOJu0Yx+MDsUFGPnmZQCO/q2LQ6SesPelNK1L+BWLmByv33Gx0XsKL6z
	vLm70lFxUn44yNXF5b/WGYIQDWuVoggkuBDnEkPc3O6yrd+Um4uPoooUlQrK
X-Google-Smtp-Source: AGHT+IFWFkTPmr0egylKtq40e/om3PfbjESX8Y3agDhfM9FAMg7tTYjJ0Fk7T/XrXLnOhqzCRkHQ4g==
X-Received: by 2002:a17:903:41c4:b0:1e0:a0d5:1d23 with SMTP id u4-20020a17090341c400b001e0a0d51d23mr17965782ple.29.1712150397884;
        Wed, 03 Apr 2024 06:19:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090332ca00b001e0f504a74csm13199577plr.269.2024.04.03.06.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 06:19:57 -0700 (PDT)
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
	netdev@vger.kernel.org,
	x86@kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH v3 09/15] loongarch: Add support for suppressing warning backtraces
Date: Wed,  3 Apr 2024 06:19:30 -0700
Message-Id: <20240403131936.787234-10-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403131936.787234-1-linux@roeck-us.net>
References: <20240403131936.787234-1-linux@roeck-us.net>
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
to the __bug_table section if both CONFIG_KUNIT_SUPPRESS_BACKTRACE and
CONFIG_DEBUG_BUGVERBOSE are enabled. Otherwise, the __func__ assembly
parameter is replaced with a (dummy) NULL parameter to avoid an image size
increase due to unused __func__ entries (this is necessary because __func__
is not a define but a virtual variable).

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2:
- Rebased to v6.9-rc1; resolved context conflict
- Added Tested-by:, Acked-by:, and Reviewed-by: tags
- Introduced KUNIT_SUPPRESS_BACKTRACE configuration option
v3:
- Rebased to v6.9-rc2; resolved context conflict

 arch/loongarch/include/asm/bug.h | 38 +++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/arch/loongarch/include/asm/bug.h b/arch/loongarch/include/asm/bug.h
index 08388876ade4..193f396d81a0 100644
--- a/arch/loongarch/include/asm/bug.h
+++ b/arch/loongarch/include/asm/bug.h
@@ -3,47 +3,63 @@
 #define __ASM_BUG_H
 
 #include <asm/break.h>
+#include <kunit/bug.h>
 #include <linux/stringify.h>
 
 #ifndef CONFIG_DEBUG_BUGVERBOSE
-#define _BUGVERBOSE_LOCATION(file, line)
+#define _BUGVERBOSE_LOCATION(file, func, line)
 #else
-#define __BUGVERBOSE_LOCATION(file, line)			\
+#ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
+# define HAVE_BUG_FUNCTION
+# define __BUG_FUNC_PTR(func)  .long func - .;
+#else
+# define __BUG_FUNC_PTR(func)
+#endif /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
+
+#define __BUGVERBOSE_LOCATION(file, func, line)			\
 		.pushsection .rodata.str, "aMS", @progbits, 1;	\
 	10002:	.string file;					\
 		.popsection;					\
 								\
 		.long 10002b - .;				\
+		__BUG_FUNC_PTR(func)				\
 		.short line;
-#define _BUGVERBOSE_LOCATION(file, line) __BUGVERBOSE_LOCATION(file, line)
+#define _BUGVERBOSE_LOCATION(file, func, line) __BUGVERBOSE_LOCATION(file, func, line)
 #endif
 
 #ifndef CONFIG_GENERIC_BUG
-#define __BUG_ENTRY(flags)
+#define __BUG_ENTRY(flags, func)
 #else
-#define __BUG_ENTRY(flags) 					\
+#define __BUG_ENTRY(flags, func)				\
 		.pushsection __bug_table, "aw";			\
 		.align 2;					\
 	10000:	.long 10001f - .;				\
-		_BUGVERBOSE_LOCATION(__FILE__, __LINE__)	\
+		_BUGVERBOSE_LOCATION(__FILE__, func, __LINE__)	\
 		.short flags; 					\
 		.popsection;					\
 	10001:
 #endif
 
-#define ASM_BUG_FLAGS(flags)					\
-	__BUG_ENTRY(flags)					\
+#define ASM_BUG_FLAGS(flags, func)				\
+	__BUG_ENTRY(flags, func)				\
 	break		BRK_BUG
 
-#define ASM_BUG()	ASM_BUG_FLAGS(0)
+#define ASM_BUG()	ASM_BUG_FLAGS(0, .)
+
+#ifdef HAVE_BUG_FUNCTION
+# define __BUG_FUNC    __func__
+#else
+# define __BUG_FUNC    NULL
+#endif
 
 #define __BUG_FLAGS(flags)					\
-	asm_inline volatile (__stringify(ASM_BUG_FLAGS(flags)));
+	asm_inline volatile (__stringify(ASM_BUG_FLAGS(flags, %0)) : : "i" (__BUG_FUNC));
 
 #define __WARN_FLAGS(flags)					\
 do {								\
 	instrumentation_begin();				\
-	__BUG_FLAGS(BUGFLAG_WARNING|(flags));			\
+	if (!IS_SUPPRESSED_WARNING(__func__))			\
+		__BUG_FLAGS(BUGFLAG_WARNING|(flags));		\
 	annotate_reachable();					\
 	instrumentation_end();					\
 } while (0)
-- 
2.39.2


