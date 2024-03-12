Return-Path: <linux-arch+bounces-2950-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF4E8799FB
	for <lists+linux-arch@lfdr.de>; Tue, 12 Mar 2024 18:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C09351F22C6A
	for <lists+linux-arch@lfdr.de>; Tue, 12 Mar 2024 17:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695E213C9FD;
	Tue, 12 Mar 2024 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQqGip5L"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97C413C9E5;
	Tue, 12 Mar 2024 17:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710263019; cv=none; b=G3RmhYdHnT56VmbeMGLBufHUzf9CJ7kZsh2cxF+8MiK6LOFALaRUxbP9UnyuErz423BBAmp43RPeZ4fVe7Xtw/cxM18w0hZv+/dxZ0/REDIS/lEWWfenPpQs6VSGOzynnth+mQro4knnr2sjp0CXFT/rOnRyR3rOh/NAloxeZ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710263019; c=relaxed/simple;
	bh=f0M5fc11HYIWKzmWkt7Ao2+081OZJPK9Hnp8Pgby/bA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=arZx3lIwZ7LVdwzMjQSNfpKBNmpIoFggs47HAbwCVVthwP7KlHmO2Qae9F2hctz7zM/XJbE3QbdVdHd1JnQG7IGQs9dLomrxaYKXseDqkmVeY1fdBEZnJsFVpxTPsY4vtUaS+a2d+pvieqUsIGw1e3A8/6ukPjxmH0YMb5d64oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQqGip5L; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dc49b00bdbso34340115ad.3;
        Tue, 12 Mar 2024 10:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710263016; x=1710867816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yPqiFdiMaUo8CT/x9a2ZlbShLK74ZzL6qnaxWOIrD0=;
        b=NQqGip5L6qpSjIyg0i6WDde/VoNj+WxxxiOkcLyrfDb+s8hCN4nsR/CsKpwqykYHYQ
         rsN1xozkX0w5k47rNB4sd1im+Vay70TeOyHMJxH/0MUI8VANAP2wBPXDI6jc9irUDOx4
         P/vNSeGvOIdodmRWlsuUrcXyAgIM7UK0JjWDnDQHbTE0jztCVrRP7tALnOnnm6cjoROK
         exHEobP8niTbWzS6fgAeVLhzJD0T09TggUUQj+wQZi7yt/XnRbqxAp5vFkn2rutqMJiO
         fOa2Gj4lqeKClr0manY2nir1RiKwjpSJS8LTX+ISx7Wzvtl32Zb1O44Mmls8snR4bNTs
         LG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710263016; x=1710867816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8yPqiFdiMaUo8CT/x9a2ZlbShLK74ZzL6qnaxWOIrD0=;
        b=RkF1zJZTW5Upo17fYAlHjhEvvQSzSWH7TW3tkSt6ZiXy44AR3SIeLKujIHAv6acrv0
         8+F1IvQwep/MfZ6Y+f3XoEk/QQHQfcUAbaC2va9PTBEMXvOLjrQj5GoW/MgX5QkAkRzA
         PZfN4cpby3HBtz+sO6eUORqMzReIIO0HWnKllJp+I/OlKuH3rrb97dttgCM9UGjFydvk
         uV6YGu9/+SX7dJtV2dWFZo3hMhAuZqEHwbzZnntVXu35IGkfqJkLbejpkSMggxzvRMvJ
         CwXrJYL3ba4vRexYMqcOAi2LgAH46am/6DB4a1u5zm+6wblSvVzZ+ecaANVgXdRSA00a
         kjfw==
X-Forwarded-Encrypted: i=1; AJvYcCWVS45q/EAfBJVTRP0unz9GUcHkpvHY2N/4p0C2ejvABuFlLmNahm8Ct58fp1d0YCf+yKWpVaYEZvuhBvlrXkXuiLhBRlHzmcAPoF6SwTTVUpCSdvPabCYnfK2lExZTE5pRW/abry3YT/x5dJg8rC8qTAItVA3PBHaP/T61avxkzZVFLuDO0rMX/Ifsw7YlpqQS/OBpl7p0tXBctI7gfM9jVlY9psOazYzwXf13dvlujH+Rd9OKr43R5PHQpiuJvUE7IZzD2MtcgTAW7GhhPbpFegyUf0ntkw==
X-Gm-Message-State: AOJu0YyznalQ/Zc+BT38jtjxb+OGC1hYHlIGMkrD0jLbFuKB6r4gYWHz
	vRsjgZxM1kRwVWTtIzsGRvNSC+oMiWg2db1MIjJQm347bqr4I9ElbAgUiXpQ
X-Google-Smtp-Source: AGHT+IFoEsNPPrMLHPvnKMDpnnejQqa8I+dYMyPxL8EBJ4sDwkePMFxEwmxbDBpOVTaOpj6jJj/c1w==
X-Received: by 2002:a17:903:2349:b0:1dd:afc9:a34f with SMTP id c9-20020a170903234900b001ddafc9a34fmr4471610plh.50.1710263016146;
        Tue, 12 Mar 2024 10:03:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b21-20020a170902ed1500b001d9a42f6183sm6958877pld.45.2024.03.12.10.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 10:03:35 -0700 (PDT)
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
Subject: [PATCH 10/14] parisc: Add support for suppressing warning backtraces
Date: Tue, 12 Mar 2024 10:03:05 -0700
Message-Id: <20240312170309.2546362-11-linux@roeck-us.net>
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

While at it, declare assembler parameters as constants where possible.
Refine .blockz instructions to calculate the necessary padding instead
of using fixed values.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/parisc/include/asm/bug.h | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/arch/parisc/include/asm/bug.h b/arch/parisc/include/asm/bug.h
index 833555f74ffa..792dacc2a653 100644
--- a/arch/parisc/include/asm/bug.h
+++ b/arch/parisc/include/asm/bug.h
@@ -23,8 +23,17 @@
 # define __BUG_REL(val) ".word " __stringify(val)
 #endif
 
-
 #ifdef CONFIG_DEBUG_BUGVERBOSE
+
+#if IS_ENABLED(CONFIG_KUNIT)
+# define HAVE_BUG_FUNCTION
+# define __BUG_FUNC_PTR	__BUG_REL(%c1)
+# define __BUG_FUNC	__func__
+#else
+# define __BUG_FUNC_PTR
+# define __BUG_FUNC	NULL
+#endif /* IS_ENABLED(CONFIG_KUNIT) */
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


