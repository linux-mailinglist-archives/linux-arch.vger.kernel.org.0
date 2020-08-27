Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F111925437E
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 12:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgH0KOm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 06:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbgH0KOh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 06:14:37 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519F0C061233;
        Thu, 27 Aug 2020 03:14:37 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mw10so2350014pjb.2;
        Thu, 27 Aug 2020 03:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Rz4ryX0AMxAkIMgQI5I1yCNb3HoLILhZhjQ00rbjtJY=;
        b=N0J5F50z/STIBf+k6ASzGjD6I3UkwlsYUJjLWuiCCjEzN1DAntFnkY87cnP6qDQ/JK
         RAcUB/f3x+/Zl9mnnCh7Mcj7nKRR36RhK4NFZIwUvOZkPwOwb35dN/v/VrKAloqV77Hx
         +pIBtdLjjSZnCNRUUmi5OpaO4fsFBywdzLPm0mTNxdJMcJYq4RzV47hc7twFR64KRgn+
         g6NMFWwcqSaHAqpavP7YgUbEnSIUONji2M7uJh+O4FO4Pm8DBeJ/YsUCoyeQmoxiMkKF
         pRsA53BuUhYLfow1mX80TJ6a42j5n7F7p1hP3/DLh2L5nu7Sd+0bSEqz+s9dw/Z5hrQn
         ZcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Rz4ryX0AMxAkIMgQI5I1yCNb3HoLILhZhjQ00rbjtJY=;
        b=e55D34Nih+yOhJxgpJ8kgsYCY2ybh5e6SNeEiN7AnnfMm4Xy+0075LCdUd1iwAD6A+
         2hZPGMEhgtlnlERnjGV8vR1dX4i91Iz0OClpxqg0wMgidXG3nvpfgAoaMgTxxs1dc8nG
         VZreJddJWai9Aigr6N+tN/eq7ru1oa+mXuPjlfuKorH9DWhNkQ/mUFcGBUF58oPyQIrW
         W9bebU+HU28DjAGgmmCSc8DlYmpaf0izdz00wekE+Ubo8/9eiMByWREiOQUfb4Aiau02
         Yr2IJKslOWiXRJ91TnXfl35YXd8W2r+apoc9ef5eB0lSEk+CJp6zWCysyHwlaIykBJGo
         HAaA==
X-Gm-Message-State: AOAM5325FYEdfF/ATxv3KYEAxzdQGxcQOrpXgZNwyeJZxXX7xcEzDtr8
        vnpenUIfJoR3vfn6eB3gsQ0=
X-Google-Smtp-Source: ABdhPJz+IG0Jrr1ijpeIHBxbdt+cj7XdgQ5SkdJp+WjLbqRWiCfi13cVTc7OhKskz9OljtBT1tmUDw==
X-Received: by 2002:a17:90a:a787:: with SMTP id f7mr10038606pjq.103.1598523276803;
        Thu, 27 Aug 2020 03:14:36 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id t10sm2333434pfq.52.2020.08.27.03.14.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 03:14:36 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     arnd@arndb.de
Cc:     rppt@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/23] fore200e: use ASSERT_FAIL()/ASSERT_WARN() to cleanup some code
Date:   Thu, 27 Aug 2020 18:14:09 +0800
Message-Id: <4fd1c0a89043ba696f8653cc721557ff6a5b86aa.1598518912.git.brookxu@tencent.com>
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
 drivers/atm/fore200e.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
index a81bc49..04f121b 100644
--- a/drivers/atm/fore200e.c
+++ b/drivers/atm/fore200e.c
@@ -83,11 +83,7 @@
 #define FORE200E_NEXT_ENTRY(index, modulo)         (index = ((index) + 1) % (modulo))
 
 #if 1
-#define ASSERT(expr)     if (!(expr)) { \
-			     printk(FORE200E "assertion failed! %s[%d]: %s\n", \
-				    __func__, __LINE__, #expr); \
-			     panic(FORE200E "%s", __func__); \
-			 }
+#define ASSERT(expr)     ASSERT_FAIL(expr)
 #else
 #define ASSERT(expr)     do {} while (0)
 #endif
-- 
1.8.3.1

