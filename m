Return-Path: <linux-arch+bounces-3164-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8686888ADEC
	for <lists+linux-arch@lfdr.de>; Mon, 25 Mar 2024 19:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C1A830653D
	for <lists+linux-arch@lfdr.de>; Mon, 25 Mar 2024 18:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E45B137743;
	Mon, 25 Mar 2024 17:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0JWh8VF"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754BB136E05;
	Mon, 25 Mar 2024 17:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389194; cv=none; b=EeRVRvbBuDrlDRxP7MxW3I6hUPh0oGZAIw0jvW/Zacz1QfIBl/5JtukdKGQwVFXQeN4NKWIcbNsHb/kvCVbbKK8Iaad0Vc2IYsU6mmNnsC9oVA72zohNjP/YBUYWsl/x1F7dAsAOyCs1DrswxZbD84fAZtJZ2o+ioCJYoGUndmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389194; c=relaxed/simple;
	bh=YAKHougynNfwqGMi4/MjS3GlrbEhqsqnDH26+cm5nFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QNWWJFb4qFIImk0QI6WkhcOnUwXyfmmh9MgiY7zO5gBV0PvS+zsbK+chCABqt/PxZ72U7i3cD0LLp57RrCx1+yvkv+qvXGbrX1kOYPZy+G0UBRQ3oBMUi9xRgPCSCyNBdVM3KgWbl9nS+PtUdK1EeO4JmCq8lQtN5x00ovXa7oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0JWh8VF; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1de0f92e649so32341225ad.0;
        Mon, 25 Mar 2024 10:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711389191; x=1711993991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtwUXE+IqNuorT54j0aaEA4aHeW6X4Zjm5IQoCcbGI8=;
        b=V0JWh8VF4gxuq2NuB7k6Uy1c4Aqts3f45IYMMURGaqfcNHAU+rSyokBOKcC1YZIRLK
         tuPklJLRe++uxpb0EHzumDE49yowK7Op6PLTuoJZu/g9701APIu8db2ZSGtIdEoy1AY2
         5SZF//Q8WFu+szvAAgBR02/qM8MUDmI7yo59+l1W/Uk0DPVvIib+/uOQCQyJmJkj6RqJ
         K7UAYpMnX3Mu67VWw2K3hbfakFPzbbUC8Yoq58M0g/2tDO92G6Cp/AdfAdOQL7ZQgctI
         QJ1x0Oguz3LnH4C03d1M9CRuvj0gs2vvHW4uVkATWMqRFNZ9hdJ9lRAF1dgzUFPsmjRo
         nfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711389191; x=1711993991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dtwUXE+IqNuorT54j0aaEA4aHeW6X4Zjm5IQoCcbGI8=;
        b=DSep/drpZtHl9CXxwL4lqhZI1WzPjQuCHIJQBhS8jwGmnMspVifJEyPMeQZA+SXToF
         cuMASPLTrMFWYl8qakjKiCBQiemMiEQsAe/C4V8dmtrsUZU6NDmDG/2MajqMGfgg6Djb
         txY+F8UmQFYaYH/9+W/doVIuX7wER/wf7GYYHdnPhg+9iYsbbmsqnqMEdVI2+l7TMoVl
         llwPVZ6NDsrd7wPlP0hYE2rQiNxsDHBbbWNJqHmTZzfns58sMzy1WmSBD2vpEcvD9Dpv
         Zl3mIi8b7/YxTIq+97zIpbkkf9BD9ChWEin/ULPGi72ZfFbDnpUciKn23eqGYO+rvdDa
         Sr5g==
X-Forwarded-Encrypted: i=1; AJvYcCUeHarzO0gHSIpUVW7T5LDO1d9w+Bfd5vAbZtvNi8RIuSixIUlZW6CardSu1VfZBZAritdOXnFxL8iqbdKFl6O00zGmdRTSNpCuZGmCfwMWCiddf6f9QUqJLGApfK2TKlBvhIVyHHvmAoFFWdR86gAUzHtF9xWifBHQwxWXaiDGLmqnQIVc81bFhUIw98HGsT4ETalQYUMur3rkX2BX5lU50hcQ0whqKXsm1gfZDL5wgWQtSIo7iMWJ6HSccmwNERqH3ixySbbEMNTr+vysimmr8Q+dVOlDszG/fo3HiYFm5Et3aAENht3Gw4me6crtzg==
X-Gm-Message-State: AOJu0YxPh6UdToWy4TxAMJunYdpFgrMlHHHq1q0g7Uv1xhmIVSsLrV4B
	jltnSsYJsCqCqmX4KdcTwIGoO5g3hizdNrKzw6KarbvoBlI4E9dR4obQNMuA
X-Google-Smtp-Source: AGHT+IFgb86jAL+eLx1VucoqIZk09YlvJLM+FeVnRGQ5UPNHQryATu5Oxjm2FFfuTD/AWoK6+BajtA==
X-Received: by 2002:a17:902:f548:b0:1e0:94a1:95c1 with SMTP id h8-20020a170902f54800b001e094a195c1mr530124plf.29.1711389191372;
        Mon, 25 Mar 2024 10:53:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l5-20020a170902f68500b001dda64281a9sm4953716plg.85.2024.03.25.10.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 10:53:10 -0700 (PDT)
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
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH v2 10/14] parisc: Add support for suppressing warning backtraces
Date: Mon, 25 Mar 2024 10:52:44 -0700
Message-Id: <20240325175248.1499046-11-linux@roeck-us.net>
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

While at it, declare assembler parameters as constants where possible.
Refine .blockz instructions to calculate the necessary padding instead
of using fixed values.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
Acked-by: Helge Deller <deller@gmx.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
- Rebased to v6.9-rc1
- Added Tested-by:, Acked-by:, and Reviewed-by: tags
- Introduced KUNIT_SUPPRESS_BACKTRACE configuration option

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


