Return-Path: <linux-arch+bounces-3157-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3B088ADB3
	for <lists+linux-arch@lfdr.de>; Mon, 25 Mar 2024 19:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8A972891FE
	for <lists+linux-arch@lfdr.de>; Mon, 25 Mar 2024 18:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F154E7F48F;
	Mon, 25 Mar 2024 17:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVPhXjD+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86A882876;
	Mon, 25 Mar 2024 17:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389182; cv=none; b=NN37nIhVc6z/e2DQxVAYfGVymr8ltxkC5zNheNd1bt1rPjUxwAha+bhhEIsVYMdRQBH4UIWP02+Ir/TE2SB+S3EVHU8tpPazVc9qL1+yaUe0fS1mz6+yuVk/6qlely5vw6Lgsuc3uLbPs3RrF93gMcSkm3R6FL2WuANKXyfbn9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389182; c=relaxed/simple;
	bh=15e2EytmBJtDwmxM7xihax47wGX3x8ja++Giz6T9SSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UtgN+4QNWhXHW5joxbs3HxHWf/jBbIV6gm2X0zrac3jmINYuTmjQ7NIuCAciDqK2qZ3Lxf006IiVPsgYtQ6zPoOYPVfYsuuQaU2goDwFN6c00uSHLQTuaGF7DWGwqxjEyPWx16sX/L6pvKjiyQ4W6aNfXJxCN9jvJPuF6yCtXTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVPhXjD+; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e6ce174d45so3240128b3a.3;
        Mon, 25 Mar 2024 10:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711389178; x=1711993978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTOeGU6FQqXFkFqXhTXI5f43XSJm9vhCGcg9SgmVgjc=;
        b=JVPhXjD+WjmIEZDY7tblSZ9k35aE7xFyI6Y41Bv82/4Zsiq0FndjMlOdE79HtCvWn9
         vdG5ZQYNoupztbObvX3fO86oIy/Mpucg2FeGrxcrkQNgzBlY1SaFMBTxOzaxvmmCY2s3
         icUry+bcw+QVvM6lnMdObQgUfGTPY9CIsa499yzByb9SDNN7PmzsyyNG/oAbJV04MU92
         DSuSfrypDITWDQWY04lyNaet0F8c0feDAFLez+X+Ce0DpAy89dhpZ5ppgCypLJzLuGT5
         SOsFe39D1iGA2sU2zVPKALyanpiBIkG94xJ7E+okr1ko3uj2dRUzshClOM+pGcvS5UTV
         YogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711389178; x=1711993978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FTOeGU6FQqXFkFqXhTXI5f43XSJm9vhCGcg9SgmVgjc=;
        b=kO7D4u++LTg76cPqd0/TxBrIHIwhdJjolYg6EBBv8TciBUIEYE0M2mXXdCHWSDRNTk
         Ji/KnsKPMSWOl807lzwFScnMPYgYE3rkh9o2qJFCZpeMlPX8nARRb94HGIbiycR9ivPy
         Hx/sNqnirELvGcyL9QPimQKCF0eVdTPKPakhXp7M/tnNs+T1JvUwGdb+TWiuLaviVuRX
         A1shZlW0b/5gM85dIZ+RYQHdjCtY0Z2zJ1tEwOnl8DtHGNyvH/ghiM6TDdDnllHApQ/Z
         5bc2LEJPhqvq5wNkkwD/7Tk9oBCyJkGphLdAFQlHD8NKiJLFI1nHoZyHyeUzi1WW9Szf
         6yJg==
X-Forwarded-Encrypted: i=1; AJvYcCXMkoc2XI61xunovtLB8Luc23B+Ir1i/mEUEWYRUMTsL1HuN1J0z10oFd8ehCxwHSBXmqQXTqcLHQkwuptkhIwjGZZRhtO4ApmI5/of+Tsmyjz3jPaXX7XPASNmzRwJb4j0FPNkLU/u9E6waYyxsHS3igzUHrG1kVesk71YUayOHYZ4YCL/8U3BdqTzqz89hBeCQ1v5gNs1JdXuB7YbC3ckStlSnYP9NTKerhLP9CHEVUN10HpW3b9ld0pjIaR3EQZ3xDb4egSeauPNS8jC1ZkvpKBD/PaErt5ewuhGRrCqpmbMufb6sigdLV15N/Dbhg==
X-Gm-Message-State: AOJu0Yye6SjchqZslJnxHCStMOofgChKOM0jq+keoS7Sr+PB6crQrQZS
	k1Ydu/omTWeGHihe9b3rsw3Hm8phetvtV1Pw0bBjgd66ex6WezrHhY6QGdzC
X-Google-Smtp-Source: AGHT+IHUF5/gztmPtcgdfhPMYdq4be7TA0gGRpEdurcbuiSF4hiBELhPQZ43z3ayY8PxmvtmmRl6tQ==
X-Received: by 2002:a05:6a00:990:b0:6e7:b3c4:43a4 with SMTP id u16-20020a056a00099000b006e7b3c443a4mr8121119pfg.25.1711389178489;
        Mon, 25 Mar 2024 10:52:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r6-20020aa78b86000000b006ea92de360esm4522577pfd.93.2024.03.25.10.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 10:52:58 -0700 (PDT)
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
Subject: [PATCH v2 02/14] kunit: bug: Count suppressed warning backtraces
Date: Mon, 25 Mar 2024 10:52:36 -0700
Message-Id: <20240325175248.1499046-3-linux@roeck-us.net>
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

Count suppressed warning backtraces to enable code which suppresses
warning backtraces to check if the expected backtrace(s) have been
observed.

Using atomics for the backtrace count resulted in build errors on some
architectures due to include file recursion, so use a plain integer
for now.

Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
- Rebased to v6.9-rc1
- Added Tested-by:, Acked-by:, and Reviewed-by: tags
- Introduced KUNIT_SUPPRESS_BACKTRACE configuration option

 include/kunit/bug.h | 7 ++++++-
 lib/kunit/bug.c     | 4 +++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/kunit/bug.h b/include/kunit/bug.h
index bd0fe047572b..72e9fb23bbd5 100644
--- a/include/kunit/bug.h
+++ b/include/kunit/bug.h
@@ -20,6 +20,7 @@
 struct __suppressed_warning {
 	struct list_head node;
 	const char *function;
+	int counter;
 };
 
 void __start_suppress_warning(struct __suppressed_warning *warning);
@@ -28,7 +29,7 @@ bool __is_suppressed_warning(const char *function);
 
 #define DEFINE_SUPPRESSED_WARNING(func)	\
 	struct __suppressed_warning __kunit_suppress_##func = \
-		{ .function = __stringify(func) }
+		{ .function = __stringify(func), .counter = 0 }
 
 #define START_SUPPRESSED_WARNING(func) \
 	__start_suppress_warning(&__kunit_suppress_##func)
@@ -39,12 +40,16 @@ bool __is_suppressed_warning(const char *function);
 #define IS_SUPPRESSED_WARNING(func) \
 	__is_suppressed_warning(func)
 
+#define SUPPRESSED_WARNING_COUNT(func) \
+	(__kunit_suppress_##func.counter)
+
 #else /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
 
 #define DEFINE_SUPPRESSED_WARNING(func)
 #define START_SUPPRESSED_WARNING(func)
 #define END_SUPPRESSED_WARNING(func)
 #define IS_SUPPRESSED_WARNING(func) (false)
+#define SUPPRESSED_WARNING_COUNT(func) (0)
 
 #endif /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
 #endif /* __ASSEMBLY__ */
diff --git a/lib/kunit/bug.c b/lib/kunit/bug.c
index f93544d7a9d1..13b3d896c114 100644
--- a/lib/kunit/bug.c
+++ b/lib/kunit/bug.c
@@ -32,8 +32,10 @@ bool __is_suppressed_warning(const char *function)
 		return false;
 
 	list_for_each_entry(warning, &suppressed_warnings, node) {
-		if (!strcmp(function, warning->function))
+		if (!strcmp(function, warning->function)) {
+			warning->counter++;
 			return true;
+		}
 	}
 	return false;
 }
-- 
2.39.2


