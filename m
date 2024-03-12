Return-Path: <linux-arch+bounces-2953-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DAA879A1D
	for <lists+linux-arch@lfdr.de>; Tue, 12 Mar 2024 18:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 193AC28497D
	for <lists+linux-arch@lfdr.de>; Tue, 12 Mar 2024 17:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5F713F42D;
	Tue, 12 Mar 2024 17:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVGfBPsp"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387D513F00A;
	Tue, 12 Mar 2024 17:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710263026; cv=none; b=RgfAkFOgn5bgaCJyxHET3XRbOAD2cdjEbAmqXu1IkCpeVh1l0oEWeQt3yL6E9axB9NLL/uczFRg80dhTzUAO2LxNnYYQwhahLaJFzDGvmFsmX8c2gmDQHRgKHHI9BR+aawDK4GI9AybDmOaklmjxaNgEgOhVl8jWOPWSay8B6i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710263026; c=relaxed/simple;
	bh=M3fGFgI9yuthQJkxiEtVWLMsbx99o2Y7sxqWKVQ8z74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F1bn0m3Th8BoChBjbxty+VA1hOenEwIlD6aAkadhYc3r9oOoEYD600MSsmtFrDdW9rB86MqLj+JaCt/1038xVNehHDiI89+cfgKpwRRnnw+etvX/QvsZNVyG7Hm3KIX8d2KcBeCkG8DvScIsRzXjBvh2hgWVxjVS3+9k7f/5zxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVGfBPsp; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dd97fd66cdso19995905ad.1;
        Tue, 12 Mar 2024 10:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710263024; x=1710867824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mb4FmIopiSO+/3QwXjaWJkazatuyJXVbnhhdOwFBf/s=;
        b=VVGfBPsp3BEGYJsCa5NCbgQBQDFd5jatjIgVlWqkD6ZWIV7w58STxRohrPLcnLYbSZ
         nSh7CU/4CJ2h/SofVs0yZg/G6tu8mCSw6b72sIKndtCJZCzZ2bcL/UqkRXKON2GOj/aI
         y42cETY2mlMtDvTOw81GyogwABtpNg/UepvHN17FrlHTEBtMr/Gx5K5qSX+NqG2UPN1v
         4iWPq1neaYmoNrCsw0oMNo0DOVkokbqjE7L0AjMGiK1XdeaN91HZSPBRisF57/iRpAJ6
         +puMXHE1vOzYOKdOIlIHUf3w9s9pDskN/wgI7C++ahkI1RConDeagXgHIn+40rFtwFUQ
         Cd0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710263024; x=1710867824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mb4FmIopiSO+/3QwXjaWJkazatuyJXVbnhhdOwFBf/s=;
        b=C9VgUDJSjKMWaYc7dqpeKe6VMBBm3RskavMnF2KMo2/+bYiw484uAjtgDjDCTjo3f8
         0dgIbPN7zbUjOnMK6rb/W32dOu4PUuqDdbdg55ZuU4TEOVZ/yqvbGKmqCCP2MhtEOyM1
         peF2L18HgaJyRjgJSTgKJp2Zc3Fx6Ig0V8q67Id8keTbLOP2xcQnyJyOxDaeQlxHtF8P
         8Q0G7y/cblbg61d1PvLgoVwP6FNKo+lepfOfThDfofoWYjqwHKwvzb3sJ+3rNNt0rKN0
         X5b+NxBiObp6asyRJ6E7ImTn9OLydF0jFZ2TAc/H4kfzjAO+podt3+b0p6RgWGb0XGh0
         e8RA==
X-Forwarded-Encrypted: i=1; AJvYcCWMCvrBsxZbmet6Krq6XU/AUry238XQ6RQRiBZVAM6um3zCpaZyEPNiql+Q+nLV+nJezi7zf3CVV1l/HiVQI2qg0o97DREJnd3fzyYGb8aXUkANHFyLu9QAEfustfnVyeHhDAcruUW+esPWBjap94GECLlCVO79veZfqDjZJdRNCpvl5U28USBT/StH/4Q8jN20R9QfaXI9RF5cQrZ/WaipPD+F+RxzABc/5yNHMfpK07dlyXu2f1UXoE7B7CMZTm3IwH1m5bjucNZD3kz9jKUrcx4L1qS1/g==
X-Gm-Message-State: AOJu0YzpTMqqZ4Zl8c0rUMt5LyA35HdHzJZSTAgZ4D2tP+8u8NwQT2Ui
	3d+Yn0J8oZrhJH1wzCDFB8WkJdn/u+cngp6F+SYwGbyHC8IEjSkeVZJMd79J
X-Google-Smtp-Source: AGHT+IESK+W76sbv32507e8vr+AETbi9zHy7dM6LrGga9gr4qnmj+9kyX8nY1a/g+A7cAY64N5ru0w==
X-Received: by 2002:a17:902:edd0:b0:1dc:a8aa:3c86 with SMTP id q16-20020a170902edd000b001dca8aa3c86mr9530991plk.5.1710263023689;
        Tue, 12 Mar 2024 10:03:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902d11100b001dca68b97d3sm6991774plw.44.2024.03.12.10.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 10:03:43 -0700 (PDT)
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
Subject: [PATCH 13/14] riscv: Add support for suppressing warning backtraces
Date: Tue, 12 Mar 2024 10:03:08 -0700
Message-Id: <20240312170309.2546362-14-linux@roeck-us.net>
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

To simplify the implementation, unify the __BUG_ENTRY_ADDR and
__BUG_ENTRY_FILE macros into a single macro named __BUG_REL() which takes
the address, file, or function reference as parameter.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/riscv/include/asm/bug.h | 38 ++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/include/asm/bug.h b/arch/riscv/include/asm/bug.h
index 1aaea81fb141..8955ee5c1c27 100644
--- a/arch/riscv/include/asm/bug.h
+++ b/arch/riscv/include/asm/bug.h
@@ -30,26 +30,39 @@
 typedef u32 bug_insn_t;
 
 #ifdef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
-#define __BUG_ENTRY_ADDR	RISCV_INT " 1b - ."
-#define __BUG_ENTRY_FILE	RISCV_INT " %0 - ."
+#define __BUG_REL(val)	RISCV_INT " " __stringify(val) " - ."
 #else
-#define __BUG_ENTRY_ADDR	RISCV_PTR " 1b"
-#define __BUG_ENTRY_FILE	RISCV_PTR " %0"
+#define __BUG_REL(val)	RISCV_PTR " " __stringify(val)
 #endif
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
+
+#if IS_ENABLED(CONFIG_KUNIT)
+# define HAVE_BUG_FUNCTION
+# define __BUG_FUNC_PTR	__BUG_REL(%1)
+#else
+# define __BUG_FUNC_PTR
+#endif /* IS_ENABLED(CONFIG_KUNIT) */
+
 #define __BUG_ENTRY			\
-	__BUG_ENTRY_ADDR "\n\t"		\
-	__BUG_ENTRY_FILE "\n\t"		\
-	RISCV_SHORT " %1\n\t"		\
-	RISCV_SHORT " %2"
+	__BUG_REL(1b) "\n\t"		\
+	__BUG_REL(%0) "\n\t"		\
+	__BUG_FUNC_PTR "\n\t"		\
+	RISCV_SHORT " %2\n\t"		\
+	RISCV_SHORT " %3"
 #else
 #define __BUG_ENTRY			\
-	__BUG_ENTRY_ADDR "\n\t"		\
-	RISCV_SHORT " %2"
+	__BUG_REL(1b) "\n\t"		\
+	RISCV_SHORT " %3"
 #endif
 
 #ifdef CONFIG_GENERIC_BUG
+#ifdef HAVE_BUG_FUNCTION
+# define __BUG_FUNC	__func__
+#else
+# define __BUG_FUNC	NULL
+#endif
+
 #define __BUG_FLAGS(flags)					\
 do {								\
 	__asm__ __volatile__ (					\
@@ -58,10 +71,11 @@ do {								\
 			".pushsection __bug_table,\"aw\"\n\t"	\
 		"2:\n\t"					\
 			__BUG_ENTRY "\n\t"			\
-			".org 2b + %3\n\t"                      \
+			".org 2b + %4\n\t"                      \
 			".popsection"				\
 		:						\
-		: "i" (__FILE__), "i" (__LINE__),		\
+		: "i" (__FILE__), "i" (__BUG_FUNC),		\
+		  "i" (__LINE__),				\
 		  "i" (flags),					\
 		  "i" (sizeof(struct bug_entry)));              \
 } while (0)
-- 
2.39.2


