Return-Path: <linux-arch+bounces-3389-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2D289708C
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 15:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFB611F24C82
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 13:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EA714BFA4;
	Wed,  3 Apr 2024 13:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7C8F9AR"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A1514B070;
	Wed,  3 Apr 2024 13:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150404; cv=none; b=BVTLUzPDmuMMdkd+M8SYNIHtT2wz0eBKnHd0xwgqhYetdT2pV6Km3HSMcU/yglgKDsE2Sq2eYxp5TZnlXjWmOY1qaC91X/M8VrTt17J5RYCK037j10/ZPE2ASFJZPww7AX+CxkgR38L0AasO6J1BUpmggDUv47CohcrD84ocFuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150404; c=relaxed/simple;
	bh=sRCoD7CA4VHB2FMUeBuju4gSTZ7VzEchcpaWHda2dww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ckmX0n19xHAPsPfsbElNzDJUaoTqkF2ySdMXHSPJFLqLBlhhC7l3CHuTOhxGqQ5xRnHtYLagFpXcGBPBCBQaO8HFzPqf9IYciXHKkVQaReOnFPA3vIsbFHeW6Qh/OfRH6TM1ZsGgZixX+XyIKsFLvZtGI5T36iVo689tgSDSzlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7C8F9AR; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e2232e30f4so48584165ad.2;
        Wed, 03 Apr 2024 06:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712150401; x=1712755201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=klYg8xMT6MjrhYgIxkpLnDg0Lyaa6cQfR4UsA0LeN2U=;
        b=S7C8F9ARAqqkqiRMHkFMWEvmUcQHdnDPy0r9jq/Zs9aT8wV/Fqpa2du/cqwxSq5gUu
         U5WqCJDXjTs1iksXAyr8jdbdxW2mp3siXOu5+DJ8CGhZw7DV0lOfBUzHgav0dalhDIOt
         UiHh5/vup2R0waShyCcd44OrqdgyLk3Hv5K74kZE24HMdtOJbFoI03wfFSuMBUxvK58M
         Wvv9t/bqIe++nLH8nljNKovakHfxuR4q9rW7NqVQV5na5nU5cY7TnNpvSCkvSLmcki+0
         +a1hgZj4nMxE9qKT7j/mWPXSfCTcqk79eleRDYNaY7dtWpzWwLv1MKCOvuPhMjQ1qoBD
         7Q1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712150401; x=1712755201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=klYg8xMT6MjrhYgIxkpLnDg0Lyaa6cQfR4UsA0LeN2U=;
        b=pa7NI++45hSzgryiDx4VsL7YbcztTlEJdxRG/awZFIsY+gmBvpKjxPxJPMVff0DA+o
         96ylb5Xm4lTuXwLg/2Dvo/ck8xe+h+yO4/vtKWKnZB6x8aHSZ20/S8NzoKy+komahO14
         PoFtQmd7JjXpkGD2cC0nXF79uwJCRoLLpvjj0Mld+VoK05CrLAPaO1nDjnR2azRJp/Dh
         u5XiOPWOzvfnEKR7z98onWwG9gRR6a1Oh/C4KoX4TtSnwiXbUViVaVEl9iVBKj09tu11
         HJGKtr9F78N+nHF1Uub57QGFPj6Fwki2iPAA8E8zyfWXaBDfbUPc6Y2OpHaLqiVltrqi
         LX+g==
X-Forwarded-Encrypted: i=1; AJvYcCUTcKlWUT4NmFo0jtTEF4UgbSlQ0y2Mw3ad25UxQC0RnXkArR9xnHKUtna6hJ9IIFQc1jcV/3El38FFFD2SxsCsPlDchkJ4GDTooJHbarL7OnPLqxJQfFI8thJI4rpsUiONGpONs6VGoVoPX9Yoryqrd+FVDrcViCZ69ZyRmSLmtNAzFDf848VPiM8kgDbtHMbP0rsjnj0/Mk/kSJiXBPRG8uIPzE5WBBQoUtWL3dlua3K0/VxXpkOs/T1AZquZOWOq9TSqyw9SMfnfwp4Rwq0vhkcZ2Jh/jlvtqSf/Aay4nkuB28FzUU9zc7cD4rBKlA==
X-Gm-Message-State: AOJu0YyROf0VLnl5C5VS+cbATZdefkieaK/3GdNkJxqpdDGDejEOY6xh
	vlU9nE9fdTu9KGeLvodqN4BgdzPp2tdx2Afq96wy8Nq+dzRwx6M2RUWU+J4s
X-Google-Smtp-Source: AGHT+IEMqe589WW9yt5k/lfzrxxoDYVpXeSOxtyZyHF9LDTCjhOnJNt1j89G1vs1iICWdJ7uWy226Q==
X-Received: by 2002:a17:902:bb16:b0:1e0:b871:53f1 with SMTP id im22-20020a170902bb1600b001e0b87153f1mr12301982plb.31.1712150401114;
        Wed, 03 Apr 2024 06:20:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x3-20020a170902a38300b001e2461c52c6sm9309915pla.149.2024.04.03.06.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 06:20:00 -0700 (PDT)
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
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v3 11/15] s390: Add support for suppressing warning backtraces
Date: Wed,  3 Apr 2024 06:19:32 -0700
Message-Id: <20240403131936.787234-12-linux@roeck-us.net>
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
increase due to unused __func__ entries (this is necessary because
__func__ is not a define but a virtual variable).

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2:
- Rebased to v6.9-rc1 (simplified assembler changes after upstream commit
  3938490e78f4 ("s390/bug: remove entry size from __bug_table section")
- Added Tested-by:, Acked-by:, and Reviewed-by: tags
- Introduced KUNIT_SUPPRESS_BACKTRACE configuration option
v3:
- Rebased to v6.9-rc2

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


