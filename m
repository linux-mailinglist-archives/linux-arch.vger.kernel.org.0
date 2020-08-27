Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A35A254366
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 12:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgH0KQA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 06:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728473AbgH0KOs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 06:14:48 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6231FC061233;
        Thu, 27 Aug 2020 03:14:48 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id kx11so2344938pjb.5;
        Thu, 27 Aug 2020 03:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=/kimB1f/4/A5yYV5xm0X/9TghrX0JSWNrajPc7XT9rI=;
        b=gh3oGZp+f8o/QF+vsAJV/vk9O3Urp7kPs1TJdJMiKFZzoaqAF0dvN729Po4NF6cgan
         AKQEShrF87dSlVlojebT1M1IGtIR6SdrqfDNAq4AzHCGSXpQcLiPcJkE7FMBhpaBE7aY
         ZFisI5N1ee+IVdxJoSLxyPdWAsre3qvLaE3Byamoq/zgkfg+XuDzBcnpHiQ0uwqo/2FH
         j7iflZC7gcuKCJg48qNViqmpn9sfj6cxALC7g9/6HuXH+WutvAw3MkUMsnMqwCAT5X/I
         0nGTAP2dBoMM2EqWFFPZcpYyLjBSykNb1MwaJF1CdpSr8m+QJvAy4092rmVOXwr+LHVj
         rohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=/kimB1f/4/A5yYV5xm0X/9TghrX0JSWNrajPc7XT9rI=;
        b=Sa3B77koNdIzy72H/VigcrpkldsWj5AwS6LCzSVfytiOrTzuea/msyhEIz1L5AX6qG
         1YLDyKDMOmqtHz5eHNY+Cb4d+cczeSEx41VFx0hRzwj4pPtmx8/KlYuyjQh9tQKB8Ktn
         w2dtNsE46suqtYIQJcjI9bQ644h2gNuGa/8hCeP1xTRVjuLM4CiSWpHnAL+EkbLl0s9G
         tCwdv3rzlCYdqvgAE9AS+gwLan+D3wOt9SuH6+6oifzTTGdhOix+P+s1aZjl57Axv94n
         Gu00WWZs4rs1Qrguqv8DdZWJijU6JneO4L+0J60gs0Jgc1ZEQXKDkKGRujsIPiReTaCO
         b6DA==
X-Gm-Message-State: AOAM5314Tc2IEw/1L1Dxz4mUk7P59S0e+5pm5JseF2zHY/jgzPUhxIc6
        dtOt6Cb+s2kGrWN9SC8LSpU=
X-Google-Smtp-Source: ABdhPJzmbapTwGtdXDdcjazJg/DtrHbGu1TN6g8CVZfLYoqrO8aKTQjX4sGn73DP4oS485ggIi3NSw==
X-Received: by 2002:a17:90b:4ac7:: with SMTP id mh7mr9346454pjb.99.1598523288016;
        Thu, 27 Aug 2020 03:14:48 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id t10sm2333434pfq.52.2020.08.27.03.14.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 03:14:47 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     arnd@arndb.de
Cc:     rppt@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/23] rivafb: use ASSERT_FAIL()/ASSERT_WARN() to cleanup some code
Date:   Thu, 27 Aug 2020 18:14:17 +0800
Message-Id: <5dff71c1e206d7e55d13092aa233482bb0e156a8.1598518912.git.brookxu@tencent.com>
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
 drivers/video/fbdev/riva/fbdev.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/riva/fbdev.c b/drivers/video/fbdev/riva/fbdev.c
index 9b34938..8a2e768 100644
--- a/drivers/video/fbdev/riva/fbdev.c
+++ b/drivers/video/fbdev/riva/fbdev.c
@@ -67,12 +67,7 @@
 #define NVTRACE_LEAVE(...)  NVTRACE("%s END\n", __func__)
 
 #ifdef CONFIG_FB_RIVA_DEBUG
-#define assert(expr) \
-	if(!(expr)) { \
-	printk( "Assertion failed! %s,%s,%s,line=%d\n",\
-	#expr,__FILE__,__func__,__LINE__); \
-	BUG(); \
-	}
+#define assert(expr) ASSERT_FAIL(expr)
 #else
 #define assert(expr)
 #endif
-- 
1.8.3.1

