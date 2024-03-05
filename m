Return-Path: <linux-arch+bounces-2814-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D19668726CF
	for <lists+linux-arch@lfdr.de>; Tue,  5 Mar 2024 19:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37595B278A3
	for <lists+linux-arch@lfdr.de>; Tue,  5 Mar 2024 18:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2024F58128;
	Tue,  5 Mar 2024 18:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7SbqmmT"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762C3286A2;
	Tue,  5 Mar 2024 18:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709664049; cv=none; b=BMjG4AIskz3ZapQKBtHx71M/Wb3LduLTBCVEZ++ogrP6CUXbK936eKs5RXhd7HD0+u6GfrCuYFfdNuhV5hlesSSYX0SAtxIMDEL43MjkOPCS2b2vYTFcFHU8zDq2JGY8r2LT6IMY0IfO62OUDLvWerz113jZjk0J7IvY6pJqRrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709664049; c=relaxed/simple;
	bh=7ZLoBvvMZN5nHFLQodd7RHkGnRgqDxj4isv7dHQGKbo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rOV6sBIYpWj63pBYX599/CpwfG8rm4Q/4lyTjCF9cta9bP+xtZhnUJibVElN9ml99qTOvwNSASoT4bIJ2tVzkOktNRveF/X1kkcvQ9rJxOyvcZOj8HMP9sK5B0umABmW6fbnDAWDoaTDpHGfwg4JJ6VYq88TM/M/R13XTE+HY54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7SbqmmT; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso21081a12.2;
        Tue, 05 Mar 2024 10:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709664047; x=1710268847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4kJHu3fBz5LPQvfwmucSB/iYHSk7Pg2H6338a3feOI=;
        b=U7SbqmmTJ2s6b3FBXlVUfVkyUEng1XhmEcUjdaDsc3lXbWDBMQqkx3TyKIz6tdS7FX
         m3Ef5leSOgCwX/lVlubpP1ebuIbylU0uIaHLVl65HDLVW0L5HWuqiXZLooxzlKr0X5i7
         FNgjxZj5r9nj8CJmLRAavH9Sy2zly5h5VwkySKujvec6sL9TRKOECNyXOARr7/K5/GqM
         wHZYjx0qfigCCWfHPCf3BFeCIe8+YVHRC6f0ar4YaULedtuNGxYYVWcl/MlQumBeH3go
         VMisBNUBa1LkXhCNur51iCMJjBb9zNBkLoxQt2HQtXp80v6fejo2RlTtQqEhDFnp1xmx
         zbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709664047; x=1710268847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y4kJHu3fBz5LPQvfwmucSB/iYHSk7Pg2H6338a3feOI=;
        b=uTUaCNvBxhZA6m/HM3Zy0iMCvkeprHupCQNRGyGpq8AbpiC7rFmZX3ooNOm0lyZ41A
         SO3jk3UytPsc6KETPL/HLGWHISKHmrH03yDVLVrs1CxWHLPp0uS8pa3RUmQUp7CyKYIb
         bwQ5gKgMCW3lMOnoz2nLGYJBikbJAtVkjqrUNcuu0ralP2nO7iy8C/TBHOnfGHadakAx
         fiV7Dp+jI4U854B6G2jBCcV9MOQGPIHXWakeN/dJljd+DpbPlTKkndDRWlg1dCgSBapS
         Fqq7De8ZCjfZpUS1pm3znnlleB1fJon+omaAivmkWoASQUY5K+L7xfpaIppL3Bpws71L
         7low==
X-Forwarded-Encrypted: i=1; AJvYcCVieoxbdoLpXr/JfSDjvmg6YY7p61KokQPWEE0nIQLGYBTXa+CQfzxthKYRRWWWesJsN4s+HDzua+dqF5fMGq2z9RIvS3eCv4qNbVLq/0Oc+Um43vQRO/2OGaWYUjsA25+Ua1brvoOfrg==
X-Gm-Message-State: AOJu0Yxdy12Q2RV9hOA4Ysu5twbewS5bjKf+zVp/+cfi+NQGbG4BcgcJ
	baua84KStHqcUcvhxX/1be/Mk0HBn27XOQOBAa2RuMxTh851pBTTQUMlbpps
X-Google-Smtp-Source: AGHT+IGTfVPApclyxUmAiyfZJFqyRfWQG5YrbUAWT/3uN8yhUmW/yeT/8jOIW+3RMo740Xw+nhtrew==
X-Received: by 2002:a17:90a:fb81:b0:29a:f0eb:221f with SMTP id cp1-20020a17090afb8100b0029af0eb221fmr10745887pjb.10.1709664047094;
        Tue, 05 Mar 2024 10:40:47 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h8-20020a17090a3d0800b00299be0e00c1sm13136391pjc.33.2024.03.05.10.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 10:40:46 -0800 (PST)
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
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	kunit-dev@googlegroups.com,
	linux-arch@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH 3/5] x86: Add support for suppressing warning tracebacks
Date: Tue,  5 Mar 2024 10:40:31 -0800
Message-Id: <20240305184033.425294-4-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240305184033.425294-1-linux@roeck-us.net>
References: <20240305184033.425294-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for selectively suppressing WARNING tracebacks to x86.
This requires adding the function triggering tracebacks to the __bug_table
object section.

To limit image size impact, the pointer to the function name is only added
to the __bug_table section if both CONFIG_KUNIT and CONFIG_DEBUG_BUGVERBOSE
are enabled. Otherwise, the __func__ assembly parameter is replaced with a
(dummy) NULL parameter to avoid an image size increase due to unused
__func__ entries (this is necessary because __func__ is not a define but a
virtual variable).

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/x86/include/asm/bug.h | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index a3ec87d198ac..8e45143fa676 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -21,6 +21,15 @@
 # define __BUG_REL(val)	".long " __stringify(val) " - ."
 #endif
 
+#if IS_ENABLED(CONFIG_KUNIT)
+# define HAVE_BUG_FUNCTION
+# define __BUG_FUNC_PTR	__BUG_REL(%c1)
+# define __BUG_FUNC	__func__
+#else
+# define __BUG_FUNC_PTR
+# define __BUG_FUNC	NULL
+#endif /* IS_ENABLED(CONFIG_KUNIT) */
+
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 
 #define _BUG_FLAGS(ins, flags, extra)					\
@@ -29,12 +38,13 @@ do {									\
 		     ".pushsection __bug_table,\"aw\"\n"		\
 		     "2:\t" __BUG_REL(1b) "\t# bug_entry::bug_addr\n"	\
 		     "\t"  __BUG_REL(%c0) "\t# bug_entry::file\n"	\
-		     "\t.word %c1"        "\t# bug_entry::line\n"	\
-		     "\t.word %c2"        "\t# bug_entry::flags\n"	\
-		     "\t.org 2b+%c3\n"					\
+		     "\t"  __BUG_FUNC_PTR "\t# bug_entry::function\n"	\
+		     "\t.word %c2"        "\t# bug_entry::line\n"	\
+		     "\t.word %c3"        "\t# bug_entry::flags\n"	\
+		     "\t.org 2b+%c4\n"					\
 		     ".popsection\n"					\
 		     extra						\
-		     : : "i" (__FILE__), "i" (__LINE__),		\
+		     : : "i" (__FILE__), "i" (__BUG_FUNC), "i" (__LINE__),\
 			 "i" (flags),					\
 			 "i" (sizeof(struct bug_entry)));		\
 } while (0)
@@ -80,7 +90,8 @@ do {								\
 do {								\
 	__auto_type __flags = BUGFLAG_WARNING|(flags);		\
 	instrumentation_begin();				\
-	_BUG_FLAGS(ASM_UD2, __flags, ASM_REACHABLE);		\
+	if (!IS_SUPPRESSED_WARNING(__func__))			\
+		_BUG_FLAGS(ASM_UD2, __flags, ASM_REACHABLE);	\
 	instrumentation_end();					\
 } while (0)
 
-- 
2.39.2


