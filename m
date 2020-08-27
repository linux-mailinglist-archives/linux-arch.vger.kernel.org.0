Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7995C254372
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 12:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbgH0KQx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 06:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbgH0KOq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 06:14:46 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1450C061264;
        Thu, 27 Aug 2020 03:14:45 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g29so2003121pgl.2;
        Thu, 27 Aug 2020 03:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=HZGm0oXcyUeZY6L8W+dSwUofViF+kTxFMzUB/D8ZFAM=;
        b=ANPJzFdN8kjfNXtQxOMLBA22mHOKLWBBCBVZg7qIV+f6tHORlUxSlOXNIdI/ab0jXE
         EC57zjRwF8+aPIaz+y4ZhMJ+oxbezSBvEyn9T/IwuhSdzcJIWC3FQGBt294Up+XvlWr0
         veffF2qvQKp1rFI29ulOXGOcRMuT0tX4ShR4mEdztLPrAe2Pl2pSKZ9f2vqcXdltClE/
         TsNA8XgEmZpaEfs+8s+0mWOSMXZwqFq++aYwFzGr+p3TTQ00/sDcY0SUCrLOFwtmVia/
         tNNrwkYY/2rWHHmiVkJcgjuJjYS7QbAy1INVzDRUbZbHfBpNVz/Dr3w40tVArsvNnOqK
         IPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=HZGm0oXcyUeZY6L8W+dSwUofViF+kTxFMzUB/D8ZFAM=;
        b=lH3Udd4q8EsGW5pi/8OAmaOPLqE6Ai1Ujj2rHwHzY+F164XsqJpX+XyPwIyrlXWumR
         SBV+SHPe7Tse6o9ygqJgSaXT7JBeGKeXkFOgfr/mRFVajSccPzrjuDgWYcSkuY/32/54
         fTnIwPkP6d6t0nrITDxpXp5M2109Y0LhOIA1naBfH0T2EPUsSy9qiR+y+Vlg6Csq4nxW
         /3wHLXk+QfEZcz+jSgmTvCjvFYq7d5u0bUF/mJnBw5NbZKoZjz4yD83yoejQ5AFy14H1
         2iDYEIDW+Juj6DYUFIUdkptY2nbSt3noPBwfmQuJq2OaR5CbBAgkg+XFX90H1rcvAVY1
         NAbQ==
X-Gm-Message-State: AOAM533JOJaWa9jlX9LD2XpWTDfk/Wn+RZx6IqIBv0B4hx6f0je8twnG
        Tek1YTok9uQVOoWecxrE7gi9Q/KAR33Raw==
X-Google-Smtp-Source: ABdhPJzTG3bN4gpahNny/4xg9AnJ4k/CAerjJ60Meuyw9Gqe8D4p8VQB3S/ZcsE8VOZfEy0wiKuinQ==
X-Received: by 2002:a62:7687:: with SMTP id r129mr15999101pfc.308.1598523285129;
        Thu, 27 Aug 2020 03:14:45 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id t10sm2333434pfq.52.2020.08.27.03.14.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 03:14:44 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     arnd@arndb.de
Cc:     rppt@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/23] btrfs: use ASSERT_FAIL()/ASSERT_WARN() to cleanup some code
Date:   Thu, 27 Aug 2020 18:14:15 +0800
Message-Id: <03e19096206bd199e6e42289da5c8da537faaeea.1598518912.git.brookxu@tencent.com>
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
 fs/btrfs/ctree.h | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 9c7e466..9254dc6 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3226,18 +3226,8 @@ void btrfs_no_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...)
 } while (0)
 
 #ifdef CONFIG_BTRFS_ASSERT
-__cold __noreturn
-static inline void assertfail(const char *expr, const char *file, int line)
-{
-	pr_err("assertion failed: %s, in %s:%d\n", expr, file, line);
-	BUG();
-}
-
-#define ASSERT(expr)						\
-	(likely(expr) ? (void)0 : assertfail(#expr, __FILE__, __LINE__))
-
+#define ASSERT(expr)	ASSERT_FAIL(expr)
 #else
-static inline void assertfail(const char *expr, const char* file, int line) { }
 #define ASSERT(expr)	(void)(expr)
 #endif
 
-- 
1.8.3.1

