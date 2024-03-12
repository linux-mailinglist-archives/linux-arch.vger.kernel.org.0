Return-Path: <linux-arch+bounces-2954-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 991A0879A28
	for <lists+linux-arch@lfdr.de>; Tue, 12 Mar 2024 18:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC5911C217AF
	for <lists+linux-arch@lfdr.de>; Tue, 12 Mar 2024 17:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6D013F451;
	Tue, 12 Mar 2024 17:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkJDfD8d"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7398213F43C;
	Tue, 12 Mar 2024 17:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710263028; cv=none; b=RQVxQtIrYHe/94jAEevfS8qEPgqRterFStoJfr/rxyB4ah0xYdRE9z7GWSeRwM152vAOnuAqGLZRZqXdQlmzbeOoE9zA+LryIqXAaLpf5roHVIdDL7rzD6uBI04DK2fBrcqwOxpXy+U7k0yVSzvOqrtlYDVJ63bfyTB8Jl2emlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710263028; c=relaxed/simple;
	bh=aXK16bg6wFU939Q5hQXiPa2mmiaErST3M/uq0N+/d0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aRyHv/mEPt/KonPt1qER8oQNO85l9v0dnw8Sxx/aKDi/nTnv4XdqG7S7fAXJBHQwuVi8Ix6fyb6LBMk3YXTPb/S/UIYdMYGfvHmIMeDoaUGMeCzaODNXzt/YYaEj2fA2XM4Z9kcH1og0NE2MiinHuFlTlHas/eT3SrWLO9rxmHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkJDfD8d; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dd9568fc51so22813665ad.2;
        Tue, 12 Mar 2024 10:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710263026; x=1710867826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6JeHPuNf2fPfe8/IgMEBFCbi+8s7x8ZP+Ypz6wTBFE=;
        b=AkJDfD8dIT0XkorCvtWCXld9660bxGyCxgYYHwK1dP6jTMwBiOoImKTxegP9eY/L2+
         ULyXUByH35/epJtHBmGHffmyV5gVlYDKXQl3zSiH7N/n2uY4qgpW2K4nM5xaOmx4xCiV
         IyiTqC5vYksM8XUli0sn2bU0b8+MvK3MtElZ8JP7hh/CiphchxYrBiMe5rSwsL1IIBXX
         h/9TngYVo9PGMPkoRF+ccYZ3wwqF1CoK3CEk2CO/+fO1CmZAk40KNzV8qJYNimkMs76r
         jalEiGaSMZ8XZqtiHc0VBcVCabby5+RVTNIC7DHd/Vgt352lf/UrPVWUSkzuvGlP74XX
         1IhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710263026; x=1710867826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f6JeHPuNf2fPfe8/IgMEBFCbi+8s7x8ZP+Ypz6wTBFE=;
        b=W003Q3DEGIw2ie+YE8i7XBizeG7QTiuW59A77BFB7NioJEFXNldOGEa9eYMlyC+stQ
         QYbRvQrkb5K2btceiEjTfClIC6CQETJhONclkI7P8/0DGZbaIvAuYEy/1fBvYP/YR3S0
         ZIAT99edEXzJeFlPfL0irAWGYnT7Cs3ONNC+S9ieH8ynzcw6PPfdQGBd+NnpNFeGm3JL
         h6VSI4rkKh0z5kb1epuFO+9/2UEm52zxyRrrfwU5B0T0YcmsQ4Uy/BfzgkmHhQTDmZEL
         EjLKEEnrZ1MJY2HtPsH/q5AG9rls4Jf5nRLf8lrb9/J8dO15hhT7ekOLa9zYIiHCqQ0u
         bxhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEp2okZOCa7sqE9hFnA8U04gwIbWULiO1u/KHQ6OOu+Q/BnSoBeiwXQbxJI5gsLkkKGVJlXFAuxpI4CPQl/ZmJTSyb3oBhkbApMIiTwO6M/YsPTljVZ8KV8GxdOL42DqlFbv/CO1unf82hE66ZBmtL0vwEGnKUzxxPqLjEimfZjDLbWIX4nkNc8r/akDUYySIL+X5sftOJb8qAKdi7jXgWHXB75fe5b2/GerQd7uo6WNA7yT2Ypr8RHW3XZ28LuGdElryYZp6+CuTy3DH2yh/lrsmdamCMbg==
X-Gm-Message-State: AOJu0YxAODUmli+DmE7cbfn9j6kpRL4tq78vRNEqkIe/OmBuOXFP6Egx
	SnyEc1Dm74cn9pHVB2ipaLH8F4vHSo6f74Ay+s2ppDf8xZMl0sFWeI/PGI8w
X-Google-Smtp-Source: AGHT+IFeKRBmX0VW7sv5rUHfZ0tynia7OwMdWO6tHkvskc+E+k+IhaoGejd1DMN70lLMBnMgohEXxQ==
X-Received: by 2002:a17:903:483:b0:1dc:fba1:1522 with SMTP id jj3-20020a170903048300b001dcfba11522mr6685263plb.41.1710263026027;
        Tue, 12 Mar 2024 10:03:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e10-20020a170902f1ca00b001dd75d4c78csm7006194plc.221.2024.03.12.10.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 10:03:44 -0700 (PDT)
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
Subject: [PATCH 14/14] powerpc: Add support for suppressing warning backtraces
Date: Tue, 12 Mar 2024 10:03:09 -0700
Message-Id: <20240312170309.2546362-15-linux@roeck-us.net>
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
 arch/powerpc/include/asm/bug.h | 37 +++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
index 1db485aacbd9..330d4983f90e 100644
--- a/arch/powerpc/include/asm/bug.h
+++ b/arch/powerpc/include/asm/bug.h
@@ -14,6 +14,9 @@
 	 .section __bug_table,"aw"
 5001:	 .4byte \addr - .
 	 .4byte 5002f - .
+#if IS_ENABLED(CONFIG_KUNIT)
+	 .4byte 0
+#endif
 	 .short \line, \flags
 	 .org 5001b+BUG_ENTRY_SIZE
 	 .previous
@@ -32,30 +35,46 @@
 #endif /* verbose */
 
 #else /* !__ASSEMBLY__ */
-/* _EMIT_BUG_ENTRY expects args %0,%1,%2,%3 to be FILE, LINE, flags and
-   sizeof(struct bug_entry), respectively */
+/* _EMIT_BUG_ENTRY expects args %0,%1,%2,%3,%4 to be FILE, __func__, LINE, flags
+   and sizeof(struct bug_entry), respectively */
 #ifdef CONFIG_DEBUG_BUGVERBOSE
+
+#if IS_ENABLED(CONFIG_KUNIT)
+# define HAVE_BUG_FUNCTION
+# define __BUG_FUNC_PTR	"	.4byte %1 - .\n"
+#else
+# define __BUG_FUNC_PTR
+#endif /* IS_ENABLED(CONFIG_KUNIT) */
+
 #define _EMIT_BUG_ENTRY				\
 	".section __bug_table,\"aw\"\n"		\
 	"2:	.4byte 1b - .\n"		\
 	"	.4byte %0 - .\n"		\
-	"	.short %1, %2\n"		\
-	".org 2b+%3\n"				\
+	__BUG_FUNC_PTR				\
+	"	.short %2, %3\n"		\
+	".org 2b+%4\n"				\
 	".previous\n"
 #else
 #define _EMIT_BUG_ENTRY				\
 	".section __bug_table,\"aw\"\n"		\
 	"2:	.4byte 1b - .\n"		\
-	"	.short %2\n"			\
-	".org 2b+%3\n"				\
+	"	.short %3\n"			\
+	".org 2b+%4\n"				\
 	".previous\n"
 #endif
 
+#ifdef HAVE_BUG_FUNCTION
+# define __BUG_FUNC	__func__
+#else
+# define __BUG_FUNC	NULL
+#endif
+
 #define BUG_ENTRY(insn, flags, ...)			\
 	__asm__ __volatile__(				\
 		"1:	" insn "\n"			\
 		_EMIT_BUG_ENTRY				\
-		: : "i" (__FILE__), "i" (__LINE__),	\
+		: : "i" (__FILE__), "i" (__BUG_FUNC),	\
+		  "i" (__LINE__),			\
 		  "i" (flags),				\
 		  "i" (sizeof(struct bug_entry)),	\
 		  ##__VA_ARGS__)
@@ -80,7 +99,7 @@
 		if (x)						\
 			BUG();					\
 	} else {						\
-		BUG_ENTRY(PPC_TLNEI " %4, 0", 0, "r" ((__force long)(x)));	\
+		BUG_ENTRY(PPC_TLNEI " %5, 0", 0, "r" ((__force long)(x)));	\
 	}							\
 } while (0)
 
@@ -90,7 +109,7 @@
 		if (__ret_warn_on)				\
 			__WARN();				\
 	} else {						\
-		BUG_ENTRY(PPC_TLNEI " %4, 0",			\
+		BUG_ENTRY(PPC_TLNEI " %5, 0",			\
 			  BUGFLAG_WARNING | BUGFLAG_TAINT(TAINT_WARN),	\
 			  "r" (__ret_warn_on));	\
 	}							\
-- 
2.39.2


