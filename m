Return-Path: <linux-arch+bounces-3162-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD95E88ADDC
	for <lists+linux-arch@lfdr.de>; Mon, 25 Mar 2024 19:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 733C0324EAE
	for <lists+linux-arch@lfdr.de>; Mon, 25 Mar 2024 18:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFE2130496;
	Mon, 25 Mar 2024 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUsU/fmX"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359A312EBC4;
	Mon, 25 Mar 2024 17:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389189; cv=none; b=LXlG0mlgm6j4w96P6VtLNeSCwZUXINVAcvn9NTU7PuU1bkjN/0gDKtfjWUdvewbAadHeAZEDQfcCSWREI8heIKh6FnVY2GTT3vcKqZV/RzrxDGMlOHenDfbB3VQ7zYkngoqghquuFwJ2A16JvLjZvaBj7aJxVrLI1hev0BoBp5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389189; c=relaxed/simple;
	bh=ujryoIXyOtMv7CZgaU8c13DgnsRbrFmRRwvyIDKligc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rjVN9FsK4tIvftWNJHcqumGXZOV0nFVAp55qoi9J+wNN6/uQIv5qwzSX8DZlBxVaJYoRDIs2eIo+CTs4ZV77O6l/FM8K7kL5Xp0a5z3MNDGlZpujb96cOe4JE5aX5YHfyexWZ/WQ4940ipCRt35KP3WPkTDWk/1Hi+JcZUGi82U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUsU/fmX; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-29fa10274e5so3094472a91.3;
        Mon, 25 Mar 2024 10:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711389187; x=1711993987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkFivhI5ysBM/6se13ha6YOC4kb+BKpi8rjyyPjulPM=;
        b=QUsU/fmXqkeE48JmgN7bBk1mlaaOOgWTJFbKp7ddi9iTR/OJ0SAdgxctZFrNI3UThH
         wuymsClvLGzIZQXI91lU+mwFBTQy1fUuFt3QR2aio4l1cZIY5DALrpwPx2Y7xESC1a/g
         EdmV69CgtcRaxl79iBGpvoY0m0qj3GKshVAos9yUd+FD5FPv2X6wHPdBHpsjULYYK9C7
         AhwRj7SjiBEnLk4imHWS8WTXTjTseKPLGExvo2Zt5/d7OiA0HnheQEB18ELgE7ySC3UA
         a2fsrBbWnChsyKNei8dYMytyG3ql1kbfOpDZg0tlOEjikuxEruxZzeAMnceuWGzCWJxJ
         RLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711389187; x=1711993987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NkFivhI5ysBM/6se13ha6YOC4kb+BKpi8rjyyPjulPM=;
        b=u2Lquax49rcZljD9dhz4RPXvMoaxD7ZFvjH9hQlTEwQJu3AKJGSls+DR+3B9qzoCaq
         ObY8Xp5NxWH0U9NWw3FL0Oq/amridwq/xdtT1r3EKP/uLw/lnWbBQ+ZNrkwnwlNFsYNh
         Iq0sakHp8Cl/Si2HsFocTUdaQ+5i+3Gf4vW1zzFnW0Ou9Tn7FZSJr2+a3tG0yIcqEoAN
         I9tYZxWwfa62hhGhItHn5hZuYVlVFvsSqZ8SAwKvz0JnoGwsDQ+spvN5ZFaZdJ6sVOOs
         zElX8UZ6JL/Bg6SI+WWQa5WNr3uzHtc0Kde6eFZosLXsMD1hgPKS0Wo62TSAYUXI3JdW
         pVkA==
X-Forwarded-Encrypted: i=1; AJvYcCU9O3qzTRwfYPXh8qMJXZwI0gHFoUSifzdoC1QAEO2O9dlGPECucxsNHFxKLFkPmEv5E1P8tHpalP7vf4Bf+0LOGENmWI86toqxT1zXlgz4RMy+c1el+olAMY1X0tW/GFLKycSxaibBgytiZ7pPJjaWfTXOE9t7XhA+U0orp7yifNUU4KZpIsDQBFYzo+iSemVG4Dt1Ar0RK0mtPJIhhFXWqDqRlT8DdgZ8aVf4wboF4YLRR9CKmtpDbJCkVB+TuRdnlBRoI+IbUQOqsGlpwmRRPD4GjtYVyAXh6k6xxY3NSBnYnXuwjBjjvSxPSGoSoA==
X-Gm-Message-State: AOJu0YxnS5QPk9BMLP0akjdnWKJJjRLPvhQ2fNgWMZkFui5oUKKW/E31
	Mca24Lf+R5Z9BdytOyCoNolx0uTzFpp/FlJ+Kk6FefPyaMgibrB2jqGUEENK
X-Google-Smtp-Source: AGHT+IGbs92c//BGiqmdUL4T55P2X9QmdN/SfOH2hxAjReRZ1Fd5UIZ7am79FuHHvN6tgafQ9jOuwg==
X-Received: by 2002:a17:90b:3005:b0:29d:fe93:52ac with SMTP id hg5-20020a17090b300500b0029dfe9352acmr5131747pjb.13.1711389186749;
        Mon, 25 Mar 2024 10:53:06 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u2-20020a17090ae00200b0029c693a1e6dsm6784603pjy.17.2024.03.25.10.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 10:53:06 -0700 (PDT)
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
Subject: [PATCH v2 07/14] x86: Add support for suppressing warning backtraces
Date: Mon, 25 Mar 2024 10:52:41 -0700
Message-Id: <20240325175248.1499046-8-linux@roeck-us.net>
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
increase due to unused __func__ entries (this is necessary because __func__
is not a define but a virtual variable).

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
- Rebased to v6.9-rc1
- Added Tested-by:, Acked-by:, and Reviewed-by: tags
- Introduced KUNIT_SUPPRESS_BACKTRACE configuration option

 arch/x86/include/asm/bug.h | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index a3ec87d198ac..7698dfa74c98 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -23,18 +23,28 @@
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 
+#ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
+# define HAVE_BUG_FUNCTION
+# define __BUG_FUNC_PTR	__BUG_REL(%c1)
+# define __BUG_FUNC	__func__
+#else
+# define __BUG_FUNC_PTR
+# define __BUG_FUNC	NULL
+#endif /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
+
 #define _BUG_FLAGS(ins, flags, extra)					\
 do {									\
 	asm_inline volatile("1:\t" ins "\n"				\
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


