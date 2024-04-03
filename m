Return-Path: <linux-arch+bounces-3390-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FD7897091
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 15:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 395F128B4BB
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 13:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB29A14C5A3;
	Wed,  3 Apr 2024 13:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m29Hj2RB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3EB14A621;
	Wed,  3 Apr 2024 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150405; cv=none; b=PXZ5XxDUVKS0Jih4H8MAX76jKZ+GKNj7eyrkyvtjDCyLr2mNOzubHK5tKnWs3+hQi6oGQ/L3ZTOiJ/hV/vXFD1Ym3Q57/M+iKhuh/2aannb0fexnxo6rOKP0+H11UslL4sBa2tTWMIkRkojuIf7qJtYUSvQ1wZ23YXqsx/3dRcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150405; c=relaxed/simple;
	bh=ZgmrdIG6yAEONHV4JnGuj9TrKexMhxErWuY9DJdDsqY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fYORVKN9IuboWJ+EiWAdJEq9XjKNj4IQDdZyc2DZ/zBH0aVsitBo2d+5gHvKXgHgiu/zLAYAhxpOJfXRlTomM/HjRwUKxnOHgdwtQUKjNM+fzB32K8dCgrSxkWyiW7/FwgQvnB2vcvYwpylhLIeADnxThxi9N27hlz2iGX1X3kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m29Hj2RB; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e6afb754fcso6031285b3a.3;
        Wed, 03 Apr 2024 06:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712150403; x=1712755203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acDD7oYfD3QQ420QQJRR06Qs6MsGb4dTYH+kiSwK7vU=;
        b=m29Hj2RBkW/LjIZdIKgQhdwrUyWs6MfyIy+8NbvE1nSCTInzwEabdKT16xdV/BwZIu
         gl3vysGr9JiWhHk0v6hIW8XRc0uEqo+7KRIkQGVb9Pt7iPNnLQe9cWMiC+tKMYPxNyXM
         aj5/jlsj1TlOlTn9fZW7yYgdenHhxeiaPbY+RT7udygA5RLYXOoD5mqHb1enZP8f13Ta
         DrbMSk+dLiC+Ut93SO3Xi1YcqpWFycPAixEGrJl5v3ErhZafeum9Riuxc2CcQhK9zosd
         T1YjFskLFdpOCp9vQN+HNhsxEnCcIG8VLeUMh8RnPRLjw5p5gXaylIpo8EUQfev+YW+R
         Bl8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712150403; x=1712755203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=acDD7oYfD3QQ420QQJRR06Qs6MsGb4dTYH+kiSwK7vU=;
        b=lnPfYoZxhReFDxTPhOP3MjC/rf3ap5/Sd6YLCv+oV1Xy7/VtGuYiD3mlaSnsftxfyM
         CpAPUgKdWd++7ONLKCzra1vXY5dCJxbPi/yJ6kLGtwyVlat+KeRQCkpIkGWgembdaWlX
         alSA3fdGlBhpyX9KlSQb/GqgLsxAz89Wz0v2ViLvAxwOSEzOv22DYiYxbt5A/DXKIAHA
         /zwuxMgdNg1QzLTgNDNSDvkiukr25ztF2SHLqu9j8xc48lDcqRPF0cF34CU8q0eHqrI+
         QmxsuNDVKq0Ut6rnURqJ14AVc67w5q/fjqIszU/zI5wA9BLE0fy0FOP580PFMvj3Zqtr
         4zQQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0v8VRDulOQI2kAOvNPfart7k/B/5kru2Q1/2qviHcY5tHqSytv3wAiYqk/fk9bfilc2Wu7kETK2ILQG5QUDFQQey69uUwzLJmUmTT5yNXjaQQv2imD/MUOJ0bDDF+6oN8o2q4SVlGrmVvT+0RVi0hCnTuFGbpPPyFLeNUzldycwkty6pygocIkINcrxPnNPuNacgatUygDZSOhLNMtRkcP/Ip5tjLWDpGsrcAACU/TctlVutMkXf0J67DZT20Ft8G8f3j+2jjhLSKSUsZFhW9JVA0XnOJeYnF75Qe+3sty/C/lFUhniMs5AHQaUpc9A==
X-Gm-Message-State: AOJu0Yz5n1URdzF6OmsfLAXt7ZKx78NyZr9MdTcbc4Fct0NGwXEkCsV9
	p5RBxPwwB3gD81E+va5I2rwCM204cQjYlah5fGrsXlp1zUpCdawC7BXFV45i
X-Google-Smtp-Source: AGHT+IH8rm/3VYkllAG+Ph/J3KijfrTneW29i0jWUjHAEJZozpI7yZ7ux/mQaa8T08FdPB1wOfWR4w==
X-Received: by 2002:a05:6a00:21cf:b0:6ea:c9c3:94a5 with SMTP id t15-20020a056a0021cf00b006eac9c394a5mr19496685pfj.0.1712150402646;
        Wed, 03 Apr 2024 06:20:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u32-20020a634720000000b005e838955bc4sm11440044pga.58.2024.04.03.06.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 06:20:02 -0700 (PDT)
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
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: [PATCH v3 12/15] sh: Add support for suppressing warning backtraces
Date: Wed,  3 Apr 2024 06:19:33 -0700
Message-Id: <20240403131936.787234-13-linux@roeck-us.net>
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2:
- Rebased to v6.9-rc1
- Added Tested-by:, Acked-by:, and Reviewed-by: tags
- Introduced KUNIT_SUPPRESS_BACKTRACE configuration option
v3:
- Rebased to v6.9-rc2

 arch/sh/include/asm/bug.h | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/sh/include/asm/bug.h b/arch/sh/include/asm/bug.h
index 05a485c4fabc..470ce6567d20 100644
--- a/arch/sh/include/asm/bug.h
+++ b/arch/sh/include/asm/bug.h
@@ -24,21 +24,36 @@
  * The offending file and line are encoded in the __bug_table section.
  */
 #ifdef CONFIG_DEBUG_BUGVERBOSE
+
+#ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
+# define HAVE_BUG_FUNCTION
+# define __BUG_FUNC_PTR	"\t.long %O2\n"
+#else
+# define __BUG_FUNC_PTR
+#endif /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
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


