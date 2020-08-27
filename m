Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607DE254383
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 12:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbgH0KSc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 06:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbgH0KOl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 06:14:41 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1E2C061232;
        Thu, 27 Aug 2020 03:14:41 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id k15so3114377pfc.12;
        Thu, 27 Aug 2020 03:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=AwSKx0TgO4C3I9JM+zj5BSKrknZ5jIrpWa5oeID6Yjk=;
        b=gK8+W+U9CznVijqXypIbrCu7uDeKkuKGGkgVDvaoa9jfsOJ5bLCL0Tqecjik9W8wZ+
         7/4aFNPqEalVhU0/1UPUsU8uV8W44IJC56z9IP3rzl1dutwrDB2bLCj/7oZlVRGZdT+3
         HRj8zZjMweWtzXoEWukiCIn0hqzyiAMQuGumf7alKUHHgQKW3KeGMvbVYrboqGdEp0G+
         DHJdsB6Fgc+2DeRnl7DjVl2eyqAyYHdPGBbPXtdfcNQfafTL5V3iRcceM6HxP0aQj3G/
         n3/jbwSxsuE4CLBfy7j5PpgZ+u+8e/gatUbs2Gt1z3+JUzSBOOFeLb4QXo5WLz7iwchE
         U+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=AwSKx0TgO4C3I9JM+zj5BSKrknZ5jIrpWa5oeID6Yjk=;
        b=WQ+PPQySxK92+TvwUILk/opLq3QDvZfSTrgRD2NktwteGrJ8o4Yq49a6bsClfE9eF9
         aTxisOtI57QDyfLxzEeZ/Ve2Y8yoKqafYd9RL5fRjn0RJzVVe2+KQ87gkSprvGw1tFAn
         vp7Zdk7jyQUWmDu1uIIIkiQ5t6Z7wUxBSIeJVEdcyRy4LBoAtreF6tvS+GQDZfIGlNCc
         ivMt+n9mV7ieCht2uj1hGrcFWfD1PIY1/kOaJtmd+kc9SwpsW2J111kD9gqUNYX6Zcl2
         IjuQHkeWownI9PAQXvLCVCvER8huJiml8QeyLJJEJ9eincwy/7GKD6BQ5aeYAhLGLw9X
         uBeQ==
X-Gm-Message-State: AOAM5321DWWye2A8UFr/sBQGXnWLVhG+Y+4rv7wjF+02QpK5k8zZLA8i
        WqOwV7Q4Av3GmGVYz9NVr5E=
X-Google-Smtp-Source: ABdhPJyCs0iIRfSQGXJLXOwERH3i0/nXrJHftvsVrWWgbIIv93O7bNk24e3wUqJufo3T/OdwYVFJ2A==
X-Received: by 2002:a63:2485:: with SMTP id k127mr3712200pgk.232.1598523280984;
        Thu, 27 Aug 2020 03:14:40 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id t10sm2333434pfq.52.2020.08.27.03.14.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 03:14:40 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     arnd@arndb.de
Cc:     rppt@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/23] lib/mpi: use ASSERT_FAIL()/ASSERT_WARN() to cleanup some code
Date:   Thu, 27 Aug 2020 18:14:12 +0800
Message-Id: <797de95a1830b3b1775dad4ae47b9522ded99ebb.1598518912.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1598518912.git.brookxu@tencent.com>
References: <cover.1598518912.git.brookxu@tencent.com>
In-Reply-To: <cover.1598518912.git.brookxu@tencent.com>
References: <cover.1598518912.git.brookxu@tencent.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since ASSERT_FAIL() and ASSERT_WARN() have been provided, ASSERT()
may be realized through them, thus reducing code redundancy and
facilitating problem analysis.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 lib/mpi/mpi-internal.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/lib/mpi/mpi-internal.h b/lib/mpi/mpi-internal.h
index 91df5f0..ee35a69 100644
--- a/lib/mpi/mpi-internal.h
+++ b/lib/mpi/mpi-internal.h
@@ -25,13 +25,8 @@
 #include <linux/errno.h>
 
 #define log_debug printk
-#define log_bug printk
 
-#define assert(x) \
-	do { \
-		if (!x) \
-			log_bug("failed assertion\n"); \
-	} while (0);
+#define assert(x) ASSERT_WARN(x)
 
 /* If KARATSUBA_THRESHOLD is not already defined, define it to a
  * value which is good on most machines.  */
-- 
1.8.3.1

