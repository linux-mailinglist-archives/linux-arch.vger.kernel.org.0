Return-Path: <linux-arch+bounces-2952-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13077879A11
	for <lists+linux-arch@lfdr.de>; Tue, 12 Mar 2024 18:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 372CC1C21F5B
	for <lists+linux-arch@lfdr.de>; Tue, 12 Mar 2024 17:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F111E13E7CB;
	Tue, 12 Mar 2024 17:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcI0Nb9P"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4DE13D314;
	Tue, 12 Mar 2024 17:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710263023; cv=none; b=bj+YRLVG90s0Vjw4wC8tmOR8trlMeW0p203vgyW/WYb9mJy5UyZCse/9hh3UrAcd8LLRISHMLrnKCnrs2J09uvYO2F/2O6kVkQHjoVJGT6FuBmOj1fOdJW9btOmty2fSOHA2xlnirBhfZcY4uw8ZC3BzqAvKmnlNaWogI69RKSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710263023; c=relaxed/simple;
	bh=jbZMWCS3DByK5SjjQJp5r57w18nrJ58+23RdL2gWKoc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m3JLULH/vLf/1LPXhjr08DdhLlHqQCQKbOPbsbF+vPCS3Nu/rOFNOnEMWU9BHa4q9aLYNIoq7Rzr9PXLZYi5co7pPbuJ71o/ram7yGD1xIwQtoPD6P4n2uJZXHdyz5QmOkIN4zhdvesaHos86x+vHCWaN1EOB5DB4lez7RTT0Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PcI0Nb9P; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e6adf257fdso573999b3a.0;
        Tue, 12 Mar 2024 10:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710263021; x=1710867821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXPfnReuSHXGXOVrQxZxvKsOYxRmb4ItarTkuVBwfPs=;
        b=PcI0Nb9P0NLswssNCZXz6UBWmFBIKgU+jsUizQXLs7At8lm45obiqPNmkpN3k9n+Ik
         R0QcawcdhDEI2/dvOfFJeBB2dDNgegT1P5nfr9NeeAdebsUjzPPzW7vyXrrw57XnsC2l
         4ED3dzwC3stgQiL5xdK+lfPXxNAxr4EZpTzpwc7jyL5RXeUlK/3sl9/IH1ixAEPm4yh/
         fXT8Nb7b1bUfi85HzbD5ihW9aJbwSOufWB8H1TZr/7SvEOYHIr08abmuvtauBGhP8aAE
         hVAdFpjochGg8C0jHWXhZSoiKJpAzfelJpF91YyOUGj3y6JCZch0jogdj9IJ7kyGdYIV
         gnIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710263021; x=1710867821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bXPfnReuSHXGXOVrQxZxvKsOYxRmb4ItarTkuVBwfPs=;
        b=JhdMtVDlsaCMLP9AG06B6qxaCNU9V3esow6H4gcSIo1iG4GXr62KN23+sCDQYypfTW
         5gKg9HB7PmCsYHoNz8WWAriH/0aYxpxqt0R8NS2KqFs/qhs74H4Gq8BGcbH3Lny4iYjU
         YWSf53DG54uIwFzUlvMApA/bbDiscGe3KrMfrB1r1VPex8mE7sxv0i/1Pt/zjiWRLOg7
         7kU1WazhozieQHpAlzKTAD8X0/9ByPiiXp7GoNW+EKXT8Qm3nuP042whiybMt4dDDXxL
         NhzuMff2OZSrqrFs0ttABY2nyLgYCdiTe3BEDZ3GtK7Nys1KLZbTlIIWrvLkFLJNah9t
         eTYg==
X-Forwarded-Encrypted: i=1; AJvYcCU2I3MWKBnFWVMdKJjivkO+EWg8K+OmWmiIblU24THQUtosnzBjlTp2HjKXbjB2Co0CU8RBN1WCzRTTnxHOCvCR3qdKYvGelOP8vYqyWaAJsCnKa9CWF6glPJ0UoXfVQZ8wF3nxIRfLWIOaTaASl9bEohvzOW2jPHYJ5FvwI4nfLBV3FplKe7qgEo4YTDP/yl60jWytUEwq0PkriUMn0+cW+2gdVDMPq5OfWR06yUt6TG9/k2osJ0F0vwCTpiLgafPmB/g/vRu82+zqGLeYV5Pgttuk8jzT2g==
X-Gm-Message-State: AOJu0YysKPK3NZ9g5j7gZMYkBWfykql7X2usVBwKXUOqzg7sV0ecXwcA
	s+h2bfAfSRY9tbNb5V4JTM7vV2xMGyr0LRxCKUnSBV2E/2tnc9tkEHeKIiPo
X-Google-Smtp-Source: AGHT+IE4fVqqJ6hNP2W9YJrC0c7a73CCPEj82DwWsP9/bD/wztKwzROAlQDxzJc7BU6W2bM1RSgz/A==
X-Received: by 2002:a05:6a20:9f06:b0:1a2:ba3f:e530 with SMTP id mk6-20020a056a209f0600b001a2ba3fe530mr11544554pzb.50.1710263020818;
        Tue, 12 Mar 2024 10:03:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g1-20020a056a000b8100b006e674ef94b2sm1453577pfj.159.2024.03.12.10.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 10:03:40 -0700 (PDT)
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
Subject: [PATCH 12/14] sh: Add support for suppressing warning backtraces
Date: Tue, 12 Mar 2024 10:03:07 -0700
Message-Id: <20240312170309.2546362-13-linux@roeck-us.net>
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
 arch/sh/include/asm/bug.h | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/sh/include/asm/bug.h b/arch/sh/include/asm/bug.h
index 05a485c4fabc..cadc335eb759 100644
--- a/arch/sh/include/asm/bug.h
+++ b/arch/sh/include/asm/bug.h
@@ -24,21 +24,36 @@
  * The offending file and line are encoded in the __bug_table section.
  */
 #ifdef CONFIG_DEBUG_BUGVERBOSE
+
+#if IS_ENABLED(CONFIG_KUNIT)
+# define HAVE_BUG_FUNCTION
+# define __BUG_FUNC_PTR	"\t.long %O2\n"
+#else
+# define __BUG_FUNC_PTR
+#endif /* IS_ENABLED(CONFIG_KUNIT) */
+
 #define _EMIT_BUG_ENTRY				\
 	"\t.pushsection __bug_table,\"aw\"\n"	\
 	"2:\t.long 1b, %O1\n"			\
-	"\t.short %O2, %O3\n"			\
-	"\t.org 2b+%O4\n"			\
+	__BUG_FUNC_PTR				\
+	"\t.short %O3, %O4\n"			\
+	"\t.org 2b+%O5\n"			\
 	"\t.popsection\n"
 #else
 #define _EMIT_BUG_ENTRY				\
 	"\t.pushsection __bug_table,\"aw\"\n"	\
 	"2:\t.long 1b\n"			\
-	"\t.short %O3\n"			\
-	"\t.org 2b+%O4\n"			\
+	"\t.short %O4\n"			\
+	"\t.org 2b+%O5\n"			\
 	"\t.popsection\n"
 #endif
 
+#ifdef HAVE_BUG_FUNCTION
+# define __BUG_FUNC	__func__
+#else
+# define __BUG_FUNC	NULL
+#endif
+
 #define BUG()						\
 do {							\
 	__asm__ __volatile__ (				\
@@ -47,6 +62,7 @@ do {							\
 		 :					\
 		 : "n" (TRAPA_BUG_OPCODE),		\
 		   "i" (__FILE__),			\
+		   "i" (__BUG_FUNC),			\
 		   "i" (__LINE__), "i" (0),		\
 		   "i" (sizeof(struct bug_entry)));	\
 	unreachable();					\
@@ -60,6 +76,7 @@ do {							\
 		 :					\
 		 : "n" (TRAPA_BUG_OPCODE),		\
 		   "i" (__FILE__),			\
+		   "i" (__BUG_FUNC),			\
 		   "i" (__LINE__),			\
 		   "i" (BUGFLAG_WARNING|(flags)),	\
 		   "i" (sizeof(struct bug_entry)));	\
@@ -85,6 +102,7 @@ do {							\
 		 :					\
 		 : "n" (TRAPA_BUG_OPCODE),		\
 		   "i" (__FILE__),			\
+		   "i" (__BUG_FUNC),			\
 		   "i" (__LINE__),			\
 		   "i" (BUGFLAG_UNWINDER),		\
 		   "i" (sizeof(struct bug_entry)));	\
-- 
2.39.2


