Return-Path: <linux-arch+bounces-2942-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8838799B9
	for <lists+linux-arch@lfdr.de>; Tue, 12 Mar 2024 18:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 899A01F227C9
	for <lists+linux-arch@lfdr.de>; Tue, 12 Mar 2024 17:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61681386CB;
	Tue, 12 Mar 2024 17:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GA/0s7SR"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1CE1384AC;
	Tue, 12 Mar 2024 17:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710263001; cv=none; b=EqjzEHlAY2ynA/h+8qUQGDTN2XgJUjnsZNvsGoHulAmgVARm+Wd1xDhO5PL+yRC4i4KBjVtI/71yI+FBp1ON69+5yEprx1nVfu2xo+ieyOmKF5psKpZ7clULXe5ggdpMTwfoZDgcw6khDIo1vtzOiPli/L8EakG8JbNQTCfeEdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710263001; c=relaxed/simple;
	bh=Xkzz7frE9nvSTNzSTAYavYlAajmFMh+XRJNWZiXH5+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NNhQmGWo89gMWNj/QUs2aauGIvcmyQiLADRQ4tdv7Z9m18VYTtxPJcX1BsdIghafgZQFhZyf/pK9TE5jXVoDdVK/XqzMq1HKZrT42u+Iihy8oOIe31Ks5iy6InowoAo0FVHNY3+nPYqMWXwzCzZVjUQ3xi/irBwPh+WQUS3PLwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GA/0s7SR; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dc5d0162bcso33490385ad.0;
        Tue, 12 Mar 2024 10:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710262999; x=1710867799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3Kc+Yh+XQ4llosDDGAwX/2k1FGi6g14GWlRJRORANM=;
        b=GA/0s7SRT36z2jQRgwBg2/AKRMucGj4NPaEITfEX9DpHpZQqkK57TpbQ3I1bd7jcbL
         biEMUXVpdMdzOy7KvzvRLRP4dxAbzb5dMjV9X8oiyxfGnX1zKH0lRkOdgfG1cicmGTnE
         GrRRIuLWWWoRgSlGp+B0P2tCNSWoxUM9M3fn/xbpZMKuiblHkHZMbPuxppUq7tv8LuW/
         6o+e7ert3ZI/7AQPvxg3fkm4bAzie3uEL7YUIxaKBNhe/Tl+gi6RQcZ8P+1iA6wTkjrU
         BymQNohWv8XnPNISncitpiZUmAlbJtYexeP9UCYwxTJyW7bhXGpCHMW6PFvLnHtXfcbG
         NaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710262999; x=1710867799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R3Kc+Yh+XQ4llosDDGAwX/2k1FGi6g14GWlRJRORANM=;
        b=Df3LZsYmn9N75di3xgLXmatD0OcyP4ATqUYhImgYfi4t1VBDK6wjoFj3faInSgoXbQ
         sKwf6hG1R+3/cPtFPcC7O4/fYIIEwKRpbI2MzukwN56QUBr7YcriKy/ulwaihIPOKcA6
         pNnYpotZLy8UrPhhfJKcIWHowxrxz1RIf+bzWYB1WG/wFiRpOEfFl7vhmJLD2x03fgqK
         C619oajhCl5KIN9+5XLfesVVvXYYZIhvioxaZPK/zys6tGqHqYvn507fdSAKgAGcCUD1
         tf92t8WuvDadVa0eh6RS6AVTC7b7fHNpWFu2xqN6aDkaHlTItdMv9kpcd5LaYQ1oHd3h
         sn1A==
X-Forwarded-Encrypted: i=1; AJvYcCUH+KC8RvdLRv+TeUVIIaJ1bIwZOevo5jbWONGntdL7LycleS2UnAcn1uE7cypkiVr38gyba7eJ+R9yr0RxTPd/Zhisuo03bIJ7HKxxhGNdjHw+WWFe+MkSN35jmOsGcJ/LsCtgqa4TrESai7VJGxorMLONH++vQanALZUbV5I41AaDieMpt5ZeDdArxqSOkUw+VIYrAMmQF2YHsPvn3/wnUuw70vfec9bmbWw62zm6NJXI/LK8CUy1mnGU3u0YIbjdttKf/T2dkmb+ByPsK8Ify7yvcOtzgQ==
X-Gm-Message-State: AOJu0YxbwBfSC6Enj6+1h1T7/Tx9TwckrroP3l74gO+Z7YzmifVab0rG
	s0tDR+bz7ltbbzQBlaXXPkD7LbPk7y305PVolCgGtkVeP+LEQabfs/mCXPta
X-Google-Smtp-Source: AGHT+IEtMqO0igDV/OJPl9l/q0X7vf8EgJ9VbKv7ARIuPeUFcb0gEvMyJN5DQCEgr2SoDMnFKNIL1A==
X-Received: by 2002:a17:902:7b95:b0:1dc:418f:890b with SMTP id w21-20020a1709027b9500b001dc418f890bmr8936395pll.40.1710262998624;
        Tue, 12 Mar 2024 10:03:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902b78400b001dcc3a46a6bsm6883069pls.262.2024.03.12.10.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 10:03:18 -0700 (PDT)
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
Subject: [PATCH 02/14] kunit: bug: Count suppressed warning backtraces
Date: Tue, 12 Mar 2024 10:02:57 -0700
Message-Id: <20240312170309.2546362-3-linux@roeck-us.net>
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

Count suppressed warning backtraces to enable code which suppresses
warning backtraces to check if the expected backtrace(s) have been
observed.

Using atomics for the backtrace count resulted in build errors on some
architectures due to include file recursion, so use a plain integer
for now.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 include/kunit/bug.h | 7 ++++++-
 lib/kunit/bug.c     | 4 +++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/kunit/bug.h b/include/kunit/bug.h
index 1e34da961599..2097a854ac8c 100644
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
 #else /* CONFIG_KUNIT */
 
 #define DEFINE_SUPPRESSED_WARNING(func)
 #define START_SUPPRESSED_WARNING(func)
 #define END_SUPPRESSED_WARNING(func)
 #define IS_SUPPRESSED_WARNING(func) (false)
+#define SUPPRESSED_WARNING_COUNT(func) (0)
 
 #endif /* CONFIG_KUNIT */
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


