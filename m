Return-Path: <linux-arch+bounces-3166-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 093DB88ADFA
	for <lists+linux-arch@lfdr.de>; Mon, 25 Mar 2024 19:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C65B1F61B29
	for <lists+linux-arch@lfdr.de>; Mon, 25 Mar 2024 18:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6361213C67C;
	Mon, 25 Mar 2024 17:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KO2ez7Sv"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8558813AA3A;
	Mon, 25 Mar 2024 17:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389197; cv=none; b=bDo8KZlN1Khe5b2VpJMAqJNxSZgUIsjFJTbR4PmhRBvhpEsXcgom2ep+Cr38iqTVZTUAHX5QhO9r8Otv+zgfq9JfhexlLgK3UPawgln83mFgcDg8ay/qLov75GxW0I7x18ITZ7cezL6QRuGcgo0djIGR71syTp0xrNj/K3U7fr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389197; c=relaxed/simple;
	bh=A5b2LvLAMqDa3tfzhsOvBq7xlErnTWSCJfRbwCKdC64=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=exm/lxBUEYzHhbt3VsX5/mjsLj1AGE3r+pQmcfh1BLeqI4qBg4tyHOqKWw+3pp8AwBG5NpPWpApdMTHQlfjykzIjgxyVseVplkmmJGop7O/n/1Pa+cRRx6YRNb7fyYwyfx044HekB4Mlaeds8mlOD20YdfDJO425Prt2rTNAnHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KO2ez7Sv; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5a51c063f99so1241683eaf.0;
        Mon, 25 Mar 2024 10:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711389193; x=1711993993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ND8lqpveiFX6xmjgwVdwzXmzEkzcSSVNG8THPWMqf7Y=;
        b=KO2ez7SvA8oZa2/jMC0bYxgzzv0dDoH+jg254UpIDdTW1/Eqb4dhzi81TXicRbYVSQ
         QMv5qSlFfPCBtuer/crkXnPBw59RirHhMnCmU1FpnD/1la+KwqXBeYNThRB6JX6JIYuk
         EjxQnydwDZW4SGfsgjdeLSjTU48BLvot6A9xchoHoatEN2VpemY6ceIzYcTB/Py1yqrj
         0aUwPkjS5bB8WbSq2kqWapsSpNT8itK33e7dmOcpy+wlS3fxYEtlt+2GcijByF0D0s0f
         Ss8o4NHqYBwUVZjvK62eXjrdIvzrS3XcFsNJIM1r9/JQ35Sp2XLNR14wgU2oKLVRnfG+
         wX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711389193; x=1711993993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ND8lqpveiFX6xmjgwVdwzXmzEkzcSSVNG8THPWMqf7Y=;
        b=IAc5ca7gFSgQyH2Op1dhuj3Xt3Vle35fEEEQRHxvpDJ/lHtJeYBS1AcFXdS7LQKrxM
         1wqQ39yNogLfs0o/MNURsKUuKEGJThCC+S2HgHX4OjmsQZDGS/MmWxMKGpBWfKhegH2g
         DZd3SCD5cA/TgcGpFnhzt3LgAFJhfMOLfel4KRYkw3puoA0bAEc1eSUIP6tuIfN1Qp6I
         Oi++y0AhVSGXzwkFRDb6Dt2e9MRjUyLdPWfvubPzE42xvtS2RIxQIeppV69xKAGRrVBL
         8sq7KCnDBSGxCK5Uh7UuyIIAAq8HqTeSiOFCAwopE2ezEHhJHNTwRvw3WlJHHaNScJ+F
         hZ/w==
X-Forwarded-Encrypted: i=1; AJvYcCWM73GPnshGsRF9bgb32IrfU27BoHit2IqPx4MDYhirjYCk3nmgXaQBExZ+jGdAY5C/vpqE0g3FdAKPWwPQosVC/wt3z1sNhR2Pj1RAxnroDkbg6QDhNtd7Zd6CSWe9arMtR5MaYlJtOVL4c8OOph+kjV1Z0SuHsaLge0JnojtssxA1mstWjkfnHNsy/Ss+yRNBHnOxxBaxwk9NBE0q0l9e7tTUJdPc5svvpQ07HxO/IRPmKZzTiH7qD6RP8MPubFVX6eCZOFh0QNaiItDHlKNufczUdOMueyOy2j/8S5PGeusHaoN5duEm0soAxPyEFQ==
X-Gm-Message-State: AOJu0YzXLAXFBWtiFsaHNlaZdh3bIjyFFS5x5lgE0fysGEEQazMiofZi
	3GRNqEH6ZTYUr7CXztMXcfaRRQNz6PDZtR9IRMpsAqpg4Yyn7VbHoZKBhFJy
X-Google-Smtp-Source: AGHT+IGv1aIgA06o9Fu8TIRgx/HOB3QdMC5g6WhXly0xhlmCYycmN3i4bcD6kTp8Utc1wDwGC1lc7A==
X-Received: by 2002:a05:6358:fac6:b0:17f:729a:8562 with SMTP id ts6-20020a056358fac600b0017f729a8562mr2827009rwb.3.1711389192937;
        Mon, 25 Mar 2024 10:53:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w189-20020a6362c6000000b005e438ea2a5asm6051492pgb.53.2024.03.25.10.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 10:53:12 -0700 (PDT)
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
	Guenter Roeck <linux@roeck-us.net>,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH v2 11/14] s390: Add support for suppressing warning backtraces
Date: Mon, 25 Mar 2024 10:52:45 -0700
Message-Id: <20240325175248.1499046-12-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240325175248.1499046-1-linux@roeck-us.net>
References: <20240325175248.1499046-1-linux@roeck-us.net>
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
increase due to unused __func__ entries (this is necessary because
__func__ is not a define but a virtual variable).

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
- Rebased to v6.9-rc1 (simplified assembler changes after upstream commit
  3938490e78f4 ("s390/bug: remove entry size from __bug_table section")
- Added Tested-by:, Acked-by:, and Reviewed-by: tags
- Introduced KUNIT_SUPPRESS_BACKTRACE configuration option

 arch/s390/include/asm/bug.h | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/bug.h b/arch/s390/include/asm/bug.h
index c500d45fb465..44d4e9f24ae0 100644
--- a/arch/s390/include/asm/bug.h
+++ b/arch/s390/include/asm/bug.h
@@ -8,6 +8,15 @@
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 
+#ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
+# define HAVE_BUG_FUNCTION
+# define __BUG_FUNC_PTR	"	.long	%0-.\n"
+# define __BUG_FUNC	__func__
+#else
+# define __BUG_FUNC_PTR
+# define __BUG_FUNC	NULL
+#endif /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
+
 #define __EMIT_BUG(x) do {					\
 	asm_inline volatile(					\
 		"0:	mc	0,0\n"				\
@@ -17,10 +26,12 @@
 		".section __bug_table,\"aw\"\n"			\
 		"2:	.long	0b-.\n"				\
 		"	.long	1b-.\n"				\
-		"	.short	%0,%1\n"			\
-		"	.org	2b+%2\n"			\
+		__BUG_FUNC_PTR					\
+		"	.short	%1,%2\n"			\
+		"	.org	2b+%3\n"			\
 		".previous\n"					\
-		: : "i" (__LINE__),				\
+		: : "i" (__BUG_FUNC),				\
+		    "i" (__LINE__),				\
 		    "i" (x),					\
 		    "i" (sizeof(struct bug_entry)));		\
 } while (0)
-- 
2.39.2


