Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFEC2254384
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 12:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbgH0KSc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 06:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728582AbgH0KOl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 06:14:41 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85B5C061264;
        Thu, 27 Aug 2020 03:14:40 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id m71so3136765pfd.1;
        Thu, 27 Aug 2020 03:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=0S/3MaYnQwLIQMpiagM/QFgRQQwPKockiXBo5QwKFoI=;
        b=ta3iUX/dw32LH0N6YHqGZZCS2CRdezoqLOrHQ2EXetuOBco/I5knIshHJQDG6tYUb9
         G8AHTJg4JR7dDAnXJ6veYetBlajIpFvHe1ZdZK6XBqN3iiXUZQXKe0KoNI8oiHMno2dK
         C8fRCrpmC5t42boBm+6+fONLn7IamA4WX5HHp01FVheBgH21Cuy8YfZsQSZUcPmCk3II
         f/276jGX7TYzzECmZLCJNI7P/IyYIE6+i4CXE2I0ay41M9bvYq3y/r6BcncF2XRMMJCz
         iYv7xr5V10Q0DaZZ6SnpmQOm6z46zrMyJgsXk0HVJDM+aWNz5pphZeH2432UmXmqDBSr
         rNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=0S/3MaYnQwLIQMpiagM/QFgRQQwPKockiXBo5QwKFoI=;
        b=j0Ud6D1hUAVEEaUrMx3HGsqzh+XGJMvvCRFYJR7IKQl4AkZkvNkAjpBG1Ed75HKwH8
         eB9yEAUQ5CEOpEIHyRg5uVJXMcun8UKND4scGwkaEne9yFP2NgpfUAQ7PiwJH7N8z4oA
         KGQTYoF5XhN7isU6HuFA6sffRS8+IK+4EGro994HdrjCFqtKSbIa80Hsf4Xgtu2J9L8A
         idq6neHJrA97fzQctKsbgyJSTDciy28bX4NGewUbO1PM9rWRbR1vBzpZeHUnj6+NnM3o
         TotQu8DTY4F6gCS1CWAQyAmhnISXMMdQ8BXpuDqutmJ/k/6MLTerXBsptLZipIdbLlL2
         KH5Q==
X-Gm-Message-State: AOAM533IGqOK9ev9m5zoIXLEmWYraZErF2Pe+QN6cpcBmqcGWl6xJ8kH
        22UaWmihwfG3GaIEo4C9l4l2PMfLdUZtBQ==
X-Google-Smtp-Source: ABdhPJy8AE0jxoRUgey07BcE4gIQYCZsnsaKfuyVPlicu94oXm1WyorwtRWeNsMEP+RGAbaEeDklsQ==
X-Received: by 2002:a17:902:b686:: with SMTP id c6mr15807695pls.133.1598523279570;
        Thu, 27 Aug 2020 03:14:39 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id t10sm2333434pfq.52.2020.08.27.03.14.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 03:14:39 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     arnd@arndb.de
Cc:     rppt@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/23] rxrpc: use ASSERT_FAIL()/ASSERT_WARN() to cleanup some code
Date:   Thu, 27 Aug 2020 18:14:11 +0800
Message-Id: <5e7c145a8b5a57c78b9228806738ccb0cfc2ac98.1598518912.git.brookxu@tencent.com>
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
 net/rxrpc/ar-internal.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 6d29a36..b428dc7 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -1181,13 +1181,7 @@ static inline bool after_eq(u32 seq1, u32 seq2)
  */
 #if 1 // defined(__KDEBUGALL)
 
-#define ASSERT(X)						\
-do {								\
-	if (unlikely(!(X))) {					\
-		pr_err("Assertion failed\n");			\
-		BUG();						\
-	}							\
-} while (0)
+#define ASSERT(X)	ASSERT_FAIL(x)
 
 #define ASSERTCMP(X, OP, Y)						\
 do {									\
-- 
1.8.3.1

