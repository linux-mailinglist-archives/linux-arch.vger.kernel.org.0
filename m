Return-Path: <linux-arch+bounces-3388-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EAD897084
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 15:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6695B1C255AD
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 13:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C300B14B08F;
	Wed,  3 Apr 2024 13:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwCPn0rP"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0353514A63A;
	Wed,  3 Apr 2024 13:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150402; cv=none; b=ai5qga1eJZVwAQr9WHNzUi0MGHlrd9wi3XHKEq55AKEqfvHJOrowNxRMGw7cz7SKKiP2Ix92koSvAAKghTxp0NCHPQzuwm24O9z6eaowz+xMuzXdhUQWcPMKBvaeCPtelxbiNkHb/6GTvlQlci7+LBDvTSeH+QtVfEy6oxoVTYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150402; c=relaxed/simple;
	bh=mB5dRAwCZwGdxvivIII9kjFblTdf+kQMWEar8P8iGWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MgXz8YDEC46DljSk0jfUVDGv33Y/LHx7/IucNyAP5HV7/My4HwW/eVXk3SlApqM1z3SW0+G2xyLlM2glfs5nW1LK1hQW1EE5iOf10vSsUr5pXBx7cgKBVo7m7R2Ynv6xnnzbmAJpWxeLmkXgx8yNhQrt/kmfRm9kqeZ0uabM02s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwCPn0rP; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e0d8403257so49724345ad.1;
        Wed, 03 Apr 2024 06:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712150399; x=1712755199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dfx4BAIsIiEeZYorwHVQiaeI+Aj0IBngtjLPvcVHyE=;
        b=hwCPn0rPqFZsGGuPZTuRFpRmHiMkoMaSeZnr5bGI60aWED8YRy0B9flsJb7g2/cpaX
         SelFx0m5PmhgfxKlaeTqiuRMOgPvtBNj+/qW0qL3EVyVky5/Kdl9XjoaUi0zPp5zKmOD
         Rj/AScUkaRIa3boh4YcenGID8OnParTeKfZtd9S//JOpTUImoh1ZD04/W9IedZ2NNsRj
         1kavt6i4hmujjhdSQVzq6HgB1jMswvj4B5FvaEz5HuxvrdGA94yvUpVcJCRYSgr87Qa9
         615t9QPfIX5BOzPdRSx6KoLPOYFq7oU4xtZ7tX38tCP2fowR+PLzp8XH84B/PSJljpzz
         Ri9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712150399; x=1712755199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9dfx4BAIsIiEeZYorwHVQiaeI+Aj0IBngtjLPvcVHyE=;
        b=A+NEQ+lZzMdO7A7bLaB+8+fEAfEdHrVzKnJBeJqMai8ScJdTiXA1uIOSF4XASF2OCe
         txMJo079e4GpcsEb1AXrXNduToVrba4UAPu3y1uMDO3tbG0kieEi5VJwqS+YvgO2rLsM
         VlNIf4XRBsnXEhR+BwtqHEiVFu09jW/WyKWFbESLaa01fVy+rpKEvgAEjaIgnDiUU9P0
         DHVqH4U4XGBHWUjAm51kvukOrNw0W48NDOc0gkD+pWA3751hMI0aYrjOSagrUkRM/m5q
         OzSLBodUz/RYNMojl4iLcnr/NvnnpSpdiAFB9Z50virHX0NvWTtfSis1kTaCG3tBAhJB
         nK0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSNpS5Ad3zdUSNWqRPrkdhar2ciRtu4QGHpHQiPgn5aXsm6pD7q5cP4vXxcm73ck6uYhrJKK61kwk6Pdmtvf1OOz4/pIdr1Ssc9g29RdXSzmvNFGu4fqSOJp6KDhwGQYDRTMmCLmlgznJw8fLsjII/gxfPUcZ0kOsPwjgDyjGjZ+PMqBU5+lXwLBPmEqwL/9rqWqf3oGkJNGw30ZcmxtqmnYDWjaQtGI+DF4sqo0l6uYvmksqPzMdSpIGeBEJ8EhdoiZZLN4NT2g8A5mYxKDPUN1scGuA79qqM4zx1pefk6oHOoh/gmdOeOvNPAljENQ==
X-Gm-Message-State: AOJu0YxHQjf4+DfXGzOkgZAE5qAlOs2hMLOTt3fGi7TTMg005eQYAci/
	DwezFzPH20S0FzDgdCMOCbMpUk8NkPzbRce+S0XB4quWO8irp1SynArLyGEC
X-Google-Smtp-Source: AGHT+IGbWkjRTcooZ5OE5cFx+wdKtwDNdTLrjwriJaWh51uLS/GGpEV8fzA7vGhwR64nNp+19Aq+wg==
X-Received: by 2002:a17:902:d4c4:b0:1e2:a0cf:c3dd with SMTP id o4-20020a170902d4c400b001e2a0cfc3ddmr376556plg.7.1712150399532;
        Wed, 03 Apr 2024 06:19:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l11-20020a170903120b00b001dddaa7d046sm13268622plh.29.2024.04.03.06.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 06:19:58 -0700 (PDT)
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
	Helge Deller <deller@gmx.de>
Subject: [PATCH v3 10/15] parisc: Add support for suppressing warning backtraces
Date: Wed,  3 Apr 2024 06:19:31 -0700
Message-Id: <20240403131936.787234-11-linux@roeck-us.net>
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

While at it, declare assembler parameters as constants where possible.
Refine .blockz instructions to calculate the necessary padding instead
of using fixed values.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
Acked-by: Helge Deller <deller@gmx.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2:
- Rebased to v6.9-rc1
- Added Tested-by:, Acked-by:, and Reviewed-by: tags
- Introduced KUNIT_SUPPRESS_BACKTRACE configuration option
v3:
- Rebased to v6.9-rc2

 arch/parisc/include/asm/bug.h | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/arch/parisc/include/asm/bug.h b/arch/parisc/include/asm/bug.h
index 833555f74ffa..b59c3f7380bf 100644
--- a/arch/parisc/include/asm/bug.h
+++ b/arch/parisc/include/asm/bug.h
@@ -23,8 +23,17 @@
 # define __BUG_REL(val) ".word " __stringify(val)
 #endif
 
-
 #ifdef CONFIG_DEBUG_BUGVERBOSE
+
+#ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
+# define HAVE_BUG_FUNCTION
+# define __BUG_FUNC_PTR	__BUG_REL(%c1)
+# define __BUG_FUNC	__func__
+#else
+# define __BUG_FUNC_PTR
+# define __BUG_FUNC	NULL
+#endif /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
+
 #define BUG()								\
 	do {								\
 		asm volatile("\n"					\
@@ -33,10 +42,12 @@
 			     "\t.align 4\n"				\
 			     "2:\t" __BUG_REL(1b) "\n"			\
 			     "\t" __BUG_REL(%c0)  "\n"			\
-			     "\t.short %1, %2\n"			\
-			     "\t.blockz %3-2*4-2*2\n"			\
+			     "\t" __BUG_FUNC_PTR  "\n"			\
+			     "\t.short %c2, %c3\n"			\
+			     "\t.blockz %c4-(.-2b)\n"			\
 			     "\t.popsection"				\
-			     : : "i" (__FILE__), "i" (__LINE__),	\
+			     : : "i" (__FILE__), "i" (__BUG_FUNC),	\
+			     "i" (__LINE__),				\
 			     "i" (0), "i" (sizeof(struct bug_entry)) );	\
 		unreachable();						\
 	} while(0)
@@ -58,10 +69,12 @@
 			     "\t.align 4\n"				\
 			     "2:\t" __BUG_REL(1b) "\n"			\
 			     "\t" __BUG_REL(%c0)  "\n"			\
-			     "\t.short %1, %2\n"			\
-			     "\t.blockz %3-2*4-2*2\n"			\
+			     "\t" __BUG_FUNC_PTR  "\n"			\
+			     "\t.short %c2, %3\n"			\
+			     "\t.blockz %c4-(.-2b)\n"			\
 			     "\t.popsection"				\
-			     : : "i" (__FILE__), "i" (__LINE__),	\
+			     : : "i" (__FILE__), "i" (__BUG_FUNC),	\
+			     "i" (__LINE__),				\
 			     "i" (BUGFLAG_WARNING|(flags)),		\
 			     "i" (sizeof(struct bug_entry)) );		\
 	} while(0)
@@ -74,7 +87,7 @@
 			     "\t.align 4\n"				\
 			     "2:\t" __BUG_REL(1b) "\n"			\
 			     "\t.short %0\n"				\
-			     "\t.blockz %1-4-2\n"			\
+			     "\t.blockz %c1-(.-2b)\n"			\
 			     "\t.popsection"				\
 			     : : "i" (BUGFLAG_WARNING|(flags)),		\
 			     "i" (sizeof(struct bug_entry)) );		\
-- 
2.39.2


