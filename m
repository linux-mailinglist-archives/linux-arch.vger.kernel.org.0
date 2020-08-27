Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC31254360
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 12:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbgH0KPo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 06:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728708AbgH0KO5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 06:14:57 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5769EC061264;
        Thu, 27 Aug 2020 03:14:57 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id l191so3022335pgd.5;
        Thu, 27 Aug 2020 03:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=U2pLMlURzmGqBGphG5X7qdWIHdS8OqboLK4Ve/cfEZs=;
        b=CwWiFHIpEmQejEoTrptvUkAjWSFPkxz4WSp+YrZEVnR9YkUD8pGhPrcWxbEmgcWz4M
         CZFQWd8YlV1FUNxIrRuRsuJFne6v9A2Hswry3BydndqaWXIeJ5Awo22TIJTcCrQg5qik
         ItMBnrx02yFDPbQSDkw5txOAlY/jHhDoHQ3LXIhmknxLTkWqFmPa9nlOXYAGe3S4y2+y
         ZfIhV5RBm6DttKysKVD2PBkp8MsZVC15EyjYNejyrcyW0oyDxU4MfPm1GQMNd5LUCAFQ
         35jFw4EOUWESR60ljYYSPt4w/ZzStJkSvXzIq7ajM0mV4HK4qbpNg9WtU3b/KnV88WE0
         TIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=U2pLMlURzmGqBGphG5X7qdWIHdS8OqboLK4Ve/cfEZs=;
        b=RDMHemx42ugUqkUtrIXB3kGWu89sRBwI1cZ6xhDRxCb7xzwp4/9+RG3Rgoa/bgwcE2
         kz+KgbjaKgkWmrz/dyWKMKStJ0YO00+2L1A1Q2eFsZ7sNYgDvAVQIxlQr6kW44WMRyWc
         d1UBmtGoS0xDH2gx4rNwffDHKP0btHtOupwhXMw5K51f8+AEfNvoFPOVx57paJzR4shs
         KE15wQeYlbeabQWlm/GorxH4kv/LWTdb8Uzcjbg8VYJZIRhKXhud5lfXdjkym+hpOOox
         VnEcC6BFpQPYKjsUyEwsZPt/O8EoP2HntZYZQjoFd9LI1LAo0KuL7nLPLRdkfpqiwMpU
         yUZA==
X-Gm-Message-State: AOAM5322pEJRhWkEx6GTviU4oOc7EBVGPbUH4vO/yDBNDc6kI24bN8BW
        ZgmStqct7s1IVtRNGiWb3L0=
X-Google-Smtp-Source: ABdhPJwTQVvfC4ioaLQrHeEdUzLQy3bvsL+d5B7zfHyMQHobnBISJB+KCXk7NqbqrBwobOm7ApKfXg==
X-Received: by 2002:a62:7bca:: with SMTP id w193mr714350pfc.152.1598523296763;
        Thu, 27 Aug 2020 03:14:56 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id t10sm2333434pfq.52.2020.08.27.03.14.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 03:14:56 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     arnd@arndb.de
Cc:     rppt@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 18/23] net:hns: use ASSERT_FAIL()/ASSERT_WARN() to cleanup some code
Date:   Thu, 27 Aug 2020 18:14:23 +0800
Message-Id: <613c5b2b5e24602ea4d84831966a543bd4240e00.1598518912.git.brookxu@tencent.com>
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
 drivers/net/ethernet/hisilicon/hns/hnae.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hnae.h b/drivers/net/ethernet/hisilicon/hns/hnae.h
index 6ab9458..55710f4 100644
--- a/drivers/net/ethernet/hisilicon/hns/hnae.h
+++ b/drivers/net/ethernet/hisilicon/hns/hnae.h
@@ -41,13 +41,7 @@
 #ifdef DEBUG
 
 #ifndef assert
-#define assert(expr) \
-do { \
-	if (!(expr)) { \
-		pr_err("Assertion failed! %s, %s, %s, line %d\n", \
-			   #expr, __FILE__, __func__, __LINE__); \
-	} \
-} while (0)
+#define assert(expr) ASSERT_WARN(expr)
 #endif
 
 #else
-- 
1.8.3.1

