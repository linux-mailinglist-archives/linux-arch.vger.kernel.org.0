Return-Path: <linux-arch+bounces-2946-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3218799E0
	for <lists+linux-arch@lfdr.de>; Tue, 12 Mar 2024 18:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D25EBB21CAD
	for <lists+linux-arch@lfdr.de>; Tue, 12 Mar 2024 17:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F7013AA31;
	Tue, 12 Mar 2024 17:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvJNnX0A"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA16113A877;
	Tue, 12 Mar 2024 17:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710263009; cv=none; b=ia2ZhYc6zO737w4LHz+oUHfop16SEr39wKyqzeVX7Q03/2daxSxXEiFBKordF8sKeHiFofeqJ+Mf9iqroI6h/dblwbEREOxL8JKuKZ/CQV+54bsZi079QdZ8Qw3H/7vtvzRw4Vfhl3+Om5c2KUUxVDGJDilOip1ypbP9cm0EkHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710263009; c=relaxed/simple;
	bh=knS+qppVrCuENhoPuTL59QYimH+PsuApCzIRiQQv0SM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C0nRMmUntkNqQFBvIu2dmk3PctnHjcYQr7fpcgLFtNZiZCnf7kHO3Y3c3V/feH6C8OhAhDHVfXSajfyGuZeuFYnnLZVNdldFwXhjswUvD/ewJ9mJr/tRy5ELSQMuB1uV4lr/k/171VcWbYex/cojDhwOwfN1U+NpzJC0cmPykDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HvJNnX0A; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dd611d5645so285015ad.1;
        Tue, 12 Mar 2024 10:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710263006; x=1710867806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFp+F6/qbMDKwppN9CX4ZWrh/15b9XKC6E4V4vAKNpU=;
        b=HvJNnX0An1/a+qhgTMfDvZQxoVK/L/dv4oLBdteu6CYZuaRoowarKOiFKXD7v7zySR
         BUOjj3dIYmat3PyLZG6lltN/Cw07431yC+1LVP9TxshLsLqInkLPzt0Sxpz9G9MCBOa1
         9UuOj5JUi7MnQ5j8qY9uBs2JjpzZPEM61S4dC6UfAWMme9XUOJ/MTYIUjjFXlw8XB0N8
         bZA9K+gKDqBcBiwx2UeTeEPctuhuCuKrVViisZORt/9fqqPci7A2kz22KnmKtqX1prx5
         +QLUUWfCBhxVeARG61JMeD3OLkomYQQnr5ORO7XhJqMpVYvKXWhNVKOxc7O2q7QC+C3l
         p4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710263006; x=1710867806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mFp+F6/qbMDKwppN9CX4ZWrh/15b9XKC6E4V4vAKNpU=;
        b=X/CsjMAlXoI+yGlx+sLUlGgU+8U6TPWMqanZ2da/jHFWAz+/t7eFfAe9J5L5JfIpsz
         Jt2YqEq/nUy3A1eLCkEMeUMC5jXTvfmwx2s5BusanMTZd1dyomu71h7IvFKPWO8RrNOg
         4ZEk+BvrsBpwZBAt45rTXZJIX6wobFPOUHLMfkLkxBoWhCx3515CFx8GUfwtjFDko95Y
         bxakCXjgzIKCxxYt7C/OTjKmmZvPyvrUmWvZ319imcgizh0aINcSUhVPr7hj8+eQ2wXh
         WEIMstssmGdLM5NtatFe7pADyPMwZc4v8bNa/MGmnJDMrer41VoMNFcaHyVOT329eha6
         C66A==
X-Forwarded-Encrypted: i=1; AJvYcCXW7Xf1IeOZqAuxfvkbk0gGcgFK/dVdHeZW0RoDv9aDPnINtAq4ICuc6X7yoSw4ib6KK/ZScFaY/Z14V/4MjTDHD55IJmS0Kz5MlAxxL9zoWxv7BDI97Q3w3pRNClG4UXdCWsYzvX5fGjThbs7SY7S4m5q0jj1a8JWiHW88CAkOW/HotpNsRM9nmJBgpXBEws+Y/9/mf8adagfN97o8KT+qUeywEDeKi3xjfQOXe9FzoQMyAM84O8AJqzDexv0LveljieUa3GajDLFiOdKiEB7Rn34zK2pYFA==
X-Gm-Message-State: AOJu0Yx3zHqOcmsWapTc14rt4uU5hk02DiH96LU9RGdwG74qVH2ptMmI
	hQJUd79NdC7jDv80iQ42MbL8aQjKDAIJgicpJr2eF8nsW2RswyLFWXwuPDbm
X-Google-Smtp-Source: AGHT+IFHgAu4TIvnFI5COGYb5tswxOQ5AvbfbseYntF0tu2SzSXjMyu1g4BetZFgaKzrp5WqY1rOuQ==
X-Received: by 2002:a17:902:db10:b0:1dd:8ed0:59d0 with SMTP id m16-20020a170902db1000b001dd8ed059d0mr179469plx.17.1710263006272;
        Tue, 12 Mar 2024 10:03:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b21-20020a170902ed1500b001d9a42f6183sm6958740pld.45.2024.03.12.10.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 10:03:25 -0700 (PDT)
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
	Guenter Roeck <linux@roeck-us.net>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 06/14] net: kunit: Suppress lock warning noise at end of dev_addr_lists tests
Date: Tue, 12 Mar 2024 10:03:01 -0700
Message-Id: <20240312170309.2546362-7-linux@roeck-us.net>
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

dev_addr_lists_test generates lock warning noise at the end of tests
if lock debugging is enabled. There are two sets of warnings.

WARNING: CPU: 0 PID: 689 at kernel/locking/mutex.c:923 __mutex_unlock_slowpath.constprop.0+0x13c/0x368
DEBUG_LOCKS_WARN_ON(__owner_task(owner) != __get_current())

WARNING: kunit_try_catch/1336 still has locks held!

KUnit test cleanup is not guaranteed to run in the same thread as the test
itself. For this test, this means that rtnl_lock() and rtnl_unlock() may
be called from different threads. This triggers the warnings.
Suppress the warnings because they are irrelevant for the test and just
confusing.

The first warning can be suppressed by using START_SUPPRESSED_WARNING()
and END_SUPPRESSED_WARNING() around the call to rtnl_unlock(). To suppress
the second warning, it is necessary to set debug_locks_silent while the
rtnl lock is held.

Cc: David Gow <davidgow@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
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


