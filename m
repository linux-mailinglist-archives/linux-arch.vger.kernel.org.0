Return-Path: <linux-arch+bounces-3161-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD3088ADD3
	for <lists+linux-arch@lfdr.de>; Mon, 25 Mar 2024 19:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB03F3241A0
	for <lists+linux-arch@lfdr.de>; Mon, 25 Mar 2024 18:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D3A12E1C2;
	Mon, 25 Mar 2024 17:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1BOgREj"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A94712B14F;
	Mon, 25 Mar 2024 17:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389187; cv=none; b=Z2zn0L+Z4uvLdmLDw1bdBdeCHia15SMpZr1gPC6DXHPyluBjv+I91aCotLWpgUrkQPWZ39mKglbhprmd6+EyYQUbGbfLLCTYkUpR1nKKs6BbSU8KxsrTtRCywqeYTgVRFsScpO7fAFKbXhNxAQ8sA/GmzdqIggqkNOHa3sh3Z0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389187; c=relaxed/simple;
	bh=8c3ps6bNPJo2RXqaRvl4Cf61H5GinAXtOitgA1RAlXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PWz0VcV3pyAklXAi04YpOxSWRHh8UXpF0yoSDeTQIC64fp61UPTToSPMTXd4MkzPTrdBqmYFvzOFuQZ4X7K8bIEL1uJKnt2NlzXK/riqZFoL4u03i9HIH5r1yUOUiWPlTNFyLlIa7bHVmfztrG5vjDmaER85VGB+dg8RYLKbSGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1BOgREj; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1def89f0cfdso41149175ad.0;
        Mon, 25 Mar 2024 10:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711389185; x=1711993985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZNhbleKNla2Ie/ZEatm6EVk1jlCAGbsmm+zF41MFkk=;
        b=k1BOgREjh0AV4f9E5DuKUuEvq3d93iSpmWB1wppIn16NRC9SYtL4Wqr5E0/KUYpNNo
         tt/6InzCFtRpFa2r1eZFKxNmM3GGcoZjesmh51nZtVOd/P+WDaO1vL1q396/I7hs3Lwi
         U7Ir2pewq63mlmO2kDEbXhRACoIBOlYCR6/uhn59lB6u2Nj49wu8C1q31HvZCvRMXeJT
         AfAvP9V+Os4cAzejQCkIEvaJkwKRypLLOcYeryCWTHOUUkkRw7NdCHh3GpxirbmrtCDK
         +8vKG+zU4vy8/bk1hGEH199PvqxxyIapHROK40aLkL2pntkrRGTZTWJdoV3TJkl/4oxD
         qdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711389185; x=1711993985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yZNhbleKNla2Ie/ZEatm6EVk1jlCAGbsmm+zF41MFkk=;
        b=JB4Reyyn7EqQxAh40PNX8uL7l3gxF6Q9lBlJUB7AS2WJPSNjB/1AXce/heO3YSW6LH
         DRIe5P22wwZ1238Bud3cd7sITTm7ZDFni7ztXTDfb5DOgoXWC2TvcOrDYmGcjVJShHTM
         jyJHxq7vPBhQWaVsv7wIZz9M4sGjlIrxhnAxiZU3c3/h4EkosG7fUmyz2bRFqgAr5A3I
         P5GZA362eb3ybbmTEbc/uPPdHemr/ptCoyfD/ypjjUNSiUZDlYcmAZYBSnDxfBQKiBEr
         JRABWzdYgawfS2wrqS14/WUcra1zYxXDiC3f0V4LXhHgUY7Lju99iQ202zLdO+7rIpMG
         64OQ==
X-Forwarded-Encrypted: i=1; AJvYcCWf6r7IMgM2zEBSJjyelBQCgXDeCCEeL4ydVgD8hpB+PLZNEaeBghPaC1FsHfsCa3ljEDSLXXkq9E+53LleebYFYf/3leyChQxaTrwzgCROjjI0dn5AkGgqh0M/RHTw9sv3FxS3p13tBiyeM63ulnvrFkCtobD8ITmVX7xOBt9mH4Et/iK9W16GBwX4ET7r6eCOL3fJ7ZqDUx2IXCLkgtd1kunJIxVSfmb2ImVQMk/8V4M8iBYLU7sZA8dMBXhuInjMtkMn9GbcGn8Sp1PcoR+VcBAPo4i/hpdOzFrRDNhf4rExzdQY7nB94JgZXBCF8g==
X-Gm-Message-State: AOJu0Yz9pmrNAR0caZVltLtNFSseuBK5SFVo4QZ7p/0wg7zSd8ViFN7p
	e1VBbh2oSN1gRm56+qUgPjQxivCv4UzL1iG6637F1xLIRQ7i7keOK3r/tlk9
X-Google-Smtp-Source: AGHT+IEKWGuzpihfez0cIj5Jcw9QuULSWV5Y1XxkrBzCrtkepZtfQa7QDls+G+yzQdtdIaLpfh3muA==
X-Received: by 2002:a17:902:e810:b0:1e0:960b:f395 with SMTP id u16-20020a170902e81000b001e0960bf395mr11373029plg.25.1711389185110;
        Mon, 25 Mar 2024 10:53:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902da8500b001e0c568ae8fsm1586519plx.192.2024.03.25.10.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 10:53:04 -0700 (PDT)
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
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH v2 06/14] net: kunit: Suppress lock warning noise at end of dev_addr_lists tests
Date: Mon, 25 Mar 2024 10:52:40 -0700
Message-Id: <20240325175248.1499046-7-linux@roeck-us.net>
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

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Cc: David Gow <davidgow@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
- Rebased to v6.9-rc1
- Added Tested-by:, Acked-by:, and Reviewed-by: tags

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


