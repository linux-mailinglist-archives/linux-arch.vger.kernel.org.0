Return-Path: <linux-arch+bounces-3384-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1630897062
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 15:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30DE91F26E12
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 13:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795A414A093;
	Wed,  3 Apr 2024 13:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvRJZeCF"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF84E149DF0;
	Wed,  3 Apr 2024 13:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150396; cv=none; b=qWlIowxBoqOuezImpoLHVo+fSI/xDOr/Vy8/huzvu3qEwp9/pVmKcUuyY3QYwxI4hE1fF8ARxapdG1nC/95fvFy3MjDfKc8WfJsUX66CYEkZkZlirYWaIjXYlw93UCaLsiMkQtZd6U77GMrWNHrOj6chFxreYaqkerUgBoK7iQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150396; c=relaxed/simple;
	bh=euFd9pdOgYqNo0qCqbH/AlBY7kEWMpZ/eka8k6xSTcg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dXiGtk2nK/mI/RyVojDhtGictCYYAKmIaQjSo6PVETvEQ2/G+UR7IuPhW3d5zRci8lhj1q7kpAJcvnzh8APtBQCvn5dy13wcgjy8gzf4FCEVDnpHKjxCd2ogbw4gkZ+A8DdE3DoGzOQnOD8nxXMSEHd9KgWl/SgIPPM4stbR8JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvRJZeCF; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e7425a6714so5222870b3a.0;
        Wed, 03 Apr 2024 06:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712150393; x=1712755193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvARuQ+3VmnrmzgmqFSmVu3cd4NVfa8l1fZDGFIcUBg=;
        b=mvRJZeCFy9RLfkzM9y8eEZ8gItsE9HDRAx+h9xFN7H3l+GfAHEDNc+qF35554bL4Un
         alxC7DfUTWnv9XbZqlLOTgvwtq50/UjxD0cBYbw2H4jBWAw7Gh5ahqtZDt3go7Rj4+tz
         vb1+2Lux6DUhvbqDyGv6g+66/OTZyS2U8EEtt5E10/SakY15lUH/JPeZJRGu1cp0hU8A
         7Q2ucuS5qaKEKNETcf2qBimyYSLxjLmMPsvrkvSqA83/69UAXgifDPemQyszJ+XA/Tel
         8JMLvTN72RPEBHopkPgPenYBMQ8SotfYVt32Ol6P8uFCEfeI99LgpxXAQKKI3p/NhFl9
         XPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712150393; x=1712755193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MvARuQ+3VmnrmzgmqFSmVu3cd4NVfa8l1fZDGFIcUBg=;
        b=SbOK7RQSC3r7MgKcTJGVYH99Soqr0xqd+rF07CMB7tNdDUIM6hGxWIRPy3zemVdkIJ
         zReb4tPVHg2JrxQ/PZnzetvvL0q+VDqVM42NYUadIK5cm/wX8gx/u06t8awlWkpIAh34
         kNU3+oqSjB2JUt/OcCHFJPFwlOLcQtxeQ9/r9vco7QA6FxEJpgFMU46ZTd8UQ9vKTh4c
         7LdO26cJt42R2Wv+6chWIaiQBjE3Pa08I2c5BEVTWyg7Em4YUDmyt/W7qoBxc39i0LnK
         qt+Xu/wj9ECDSzHAZx0TwkHiBuRxVG5oUF+epm3bnR5v03Odro4oFQG8ESvw+5UpmD2k
         y6NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPzjHzsNHmOKxgo3yYmgGxlt/sc0cUPco5YYtWrUeO6x/3mjXxRkG8z7/z9URuzZLxahpd3zfkSHvVI3paF1oVm6b64sBVlFeR+OxU0plXQ0YNPSPYNL13Ta6g8h8RTVXcw1y26MriqLd/3x6v8vG5ZGHXEOenWNrMclsH+L3Nrp7NFbVjgfwzW6EToWGpE+F89kVntFQcy3vsJNPijb9BwcqQvONgdtSuHc1Zr99W2sIikwPOuMSjjV+Hpahwchu5Hf5X7aPzvkYwpWXYBCVhQTGZ3/Gc0g20aet48uZBGDsuBC0NNi5c2xeI3aV1lA==
X-Gm-Message-State: AOJu0YyUF2iwUlnH4UuNaDJJKtlgZrOYGusd+he0mEr60LKPca/fOLAB
	R5WO6yjgg/PTjw+g6pztc15E1CoghS7tIccgYHLiAsGXiyKpn9KLdha/h427
X-Google-Smtp-Source: AGHT+IFzkfgfwanXAd82f8i8ef5Fjpgbc/yneRFMHGOwV59qDNS3Awm153uRnJZYSeIbwOl4zm4JYA==
X-Received: by 2002:a05:6a00:190b:b0:6ea:73d3:d3a with SMTP id y11-20020a056a00190b00b006ea73d30d3amr17312402pfi.22.1712150393007;
        Wed, 03 Apr 2024 06:19:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j3-20020a62b603000000b006e56bf07483sm11720837pff.77.2024.04.03.06.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 06:19:52 -0700 (PDT)
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
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH v3 06/15] net: kunit: Suppress lock warning noise at end of dev_addr_lists tests
Date: Wed,  3 Apr 2024 06:19:27 -0700
Message-Id: <20240403131936.787234-7-linux@roeck-us.net>
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

dev_addr_lists_test generates lock warning noise at the end of tests
if lock debugging is enabled. There are two sets of warnings.

WARNING: CPU: 0 PID: 689 at kernel/locking/mutex.c:923 __mutex_unlock_slowpath.constprop.0+0x13c/0x368
DEBUG_LOCKS_WARN_ON(__owner_task(owner) != __get_current())

WARNING: kunit_try_catch/1336 still has locks held!

KUnit test cleanup is not guaranteed to run in the same thread as the test
itself. For this test, this means that rtnl_lock() and rtnl_unlock() may
be called from different threads. This triggers the warnings.
Suppress the warnings because they are irrelevant for the test and just
confusing and distracting.

The first warning can be suppressed by using START_SUPPRESSED_WARNING()
and END_SUPPRESSED_WARNING() around the call to rtnl_unlock(). To suppress
the second warning, it is necessary to set debug_locks_silent while the
rtnl lock is held.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Cc: David Gow <davidgow@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2:
- Rebased to v6.9-rc1
- Added Tested-by:, Acked-by:, and Reviewed-by: tags
v3:
- Rebased to v6.9-rc2

 net/core/dev_addr_lists_test.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/dev_addr_lists_test.c b/net/core/dev_addr_lists_test.c
index 4dbd0dc6aea2..b427dd1a3c93 100644
--- a/net/core/dev_addr_lists_test.c
+++ b/net/core/dev_addr_lists_test.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 #include <kunit/test.h>
+#include <linux/debug_locks.h>
 #include <linux/etherdevice.h>
 #include <linux/netdevice.h>
 #include <linux/rtnetlink.h>
@@ -49,6 +50,7 @@ static int dev_addr_test_init(struct kunit *test)
 		KUNIT_FAIL(test, "Can't register netdev %d", err);
 	}
 
+	debug_locks_silent = 1;
 	rtnl_lock();
 	return 0;
 }
@@ -56,8 +58,12 @@ static int dev_addr_test_init(struct kunit *test)
 static void dev_addr_test_exit(struct kunit *test)
 {
 	struct net_device *netdev = test->priv;
+	DEFINE_SUPPRESSED_WARNING(__mutex_unlock_slowpath);
 
+	START_SUPPRESSED_WARNING(__mutex_unlock_slowpath);
 	rtnl_unlock();
+	END_SUPPRESSED_WARNING(__mutex_unlock_slowpath);
+	debug_locks_silent = 0;
 	unregister_netdev(netdev);
 	free_netdev(netdev);
 }
-- 
2.39.2


