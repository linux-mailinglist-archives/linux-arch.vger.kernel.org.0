Return-Path: <linux-arch+bounces-3393-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B138970AB
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 15:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB05B28998B
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 13:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BBB14F119;
	Wed,  3 Apr 2024 13:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMfafsMs"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3310914E2DA;
	Wed,  3 Apr 2024 13:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150410; cv=none; b=QFLqO2hJQUpl+LwXu2UUjB7vmb63QHXmDLuwEazRtrvHhzS5UlK6ZDHzqnO82sBoUv848Fy5MTIjX9GG+2D+dyN3Ow8o9ll9falBLrwvJDWJosChXujMvgJ72SyQYmg2OYmTpXjofY7GRs1/dPQLrL1EROn815x7vZoJAl651+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150410; c=relaxed/simple;
	bh=fEOGTP44ht/ZhSieHBOxh1TKRJM2QPU3A8FjedSkZo4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cAs8z/4I1YJe8czr0u3qB5xokbINSu9uNTOkIxuWnUuWNpAZVEDT2/f3F/2irR0cpXwV+8K6isbO1kTk9m6nEJhAm1OrQgRRC7KtU/jMMFGy6GMWbBN4rTLI8GcVr3P+DtkOpEoFfNostj/UG+DpckL0dBTBLh1wnwiSEn5Ugyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMfafsMs; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e27c303573so13523555ad.3;
        Wed, 03 Apr 2024 06:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712150407; x=1712755207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wn5Y6haDMX+KFeDZiuG3bLreTNkdvF0hb2IVOihuo/Q=;
        b=LMfafsMsnVCLJvAyLc/fI3aGiQpHUzPkwdjpXDSRK7GwuJEP2pChmNhUwLZIgdgiqq
         t35PWXnlEeCdPi/VuDeOWkuhtCeDqKwA96QB4wLtqb4Igqs7jlFs8aJTkZU45PQVTWA8
         YA+KioJca5uZoP8ZXtbkS8iV0x4cc9vurQkXAol3dURtE0H3Z+7uarf5MnE7yb6aNKHJ
         mZNFuVX5dv74BL6eL4VDgTXJIP7b3bZLPbl1OxsngNJqRuqBqy6V8SqGKVITMc0im8oJ
         OG5XSTUJvQN1f71PEsAIiUYutsr6WFqx6ElCWqw+7vXRa8CVk0YIs/xF5eUKCNNO9xtg
         WY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712150407; x=1712755207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wn5Y6haDMX+KFeDZiuG3bLreTNkdvF0hb2IVOihuo/Q=;
        b=WNjuHhgRDUG+Qy02C4q4AKg3PfgBT67BBoROAaW85+yJL6pBNDzqPAevHnlKbUwBuL
         Rzh6iADH5WMdVDdqfjVJ3BTT6mLfyDh6vf5Yy9pUQX0X2gn4Gnt+3TDAFMmWwDsUiRsm
         n0K5ZGzzRcg3g/ZA7pFY/AJxlYAbDYQYtR/mOJAZqeWte71vRzGGBvVrs7Sby8Z4HYhv
         0W3FEOPdgw4irHiFRpkvNkcynbnc1t2ClbWUcXaW6/vQIDQ+2tIBTOLLfNzobewRfZT6
         gkfznRTr38ptxG4Hxte3Uql40CepZ/nKpYHM/NngcEq3fAaREv3HL6V0MGLRxw46HjRQ
         zIJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDSjDTqC33iH8rfS5sgmZppAqUKyzdGMI03wGBl11g2DXQyYUkXlACnm0JTJ7uvh1BiddRUvpryx7Lt6HXuXsh3LmnohwJSXNJ9rzvh25+DuJzNSIs/TA4VvNICF0BPbJP+VOzKP8wiY3qJmz2pMqT7xkFxkRegmIyJSp+aD1nTy8yPUV2QfwvqpAMNLWSYJS1b7fitx+4xsId2vONHdVxSFF5gIT+ROSqkUspXRgTMibZTIwu/Y+oIaPtoL1dgithT31ssk55vSXf1SkYtmvbzsKuMQ3GrZNRFV8KnKiF4kfOBU3vYfuPCIGiicJ2lg==
X-Gm-Message-State: AOJu0Yww/iQKLc7NNFNMVdA6G4l+fOXDc7xpi7QwbWj/JsdV9ZtpvSl7
	6qsZjKukWujUXCW8YMxqM8oSd/+50FLeBksQM4vi8P2K6fuAv2ZNv0RWrMgh
X-Google-Smtp-Source: AGHT+IHWmvXbtJ9fAm6MAldmvpyAC7gyMYuUNuumU3VUQ5OUfg6iZFWTqXY0l/Y7ponpfkrN4lhaag==
X-Received: by 2002:a17:902:e74f:b0:1e0:d630:f054 with SMTP id p15-20020a170902e74f00b001e0d630f054mr18958233plf.7.1712150407580;
        Wed, 03 Apr 2024 06:20:07 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k12-20020a170902c40c00b001e0b3a87dbbsm1705074plk.177.2024.04.03.06.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 06:20:07 -0700 (PDT)
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
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v3 15/15] powerpc: Add support for suppressing warning backtraces
Date: Wed,  3 Apr 2024 06:19:36 -0700
Message-Id: <20240403131936.787234-16-linux@roeck-us.net>
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
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2:
- Rebased to v6.9-rc1
- Added Tested-by:, Acked-by:, and Reviewed-by: tags
- Introduced KUNIT_SUPPRESS_BACKTRACE configuration option
v3:
- Rebased to v6.9-rc2

 arch/powerpc/include/asm/bug.h | 37 +++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
index 1db485aacbd9..5b06745d20aa 100644
--- a/arch/powerpc/include/asm/bug.h
+++ b/arch/powerpc/include/asm/bug.h
@@ -14,6 +14,9 @@
 	 .section __bug_table,"aw"
 5001:	 .4byte \addr - .
 	 .4byte 5002f - .
+#ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
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
+#ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
+# define HAVE_BUG_FUNCTION
+# define __BUG_FUNC_PTR	"	.4byte %1 - .\n"
+#else
+# define __BUG_FUNC_PTR
+#endif /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
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


