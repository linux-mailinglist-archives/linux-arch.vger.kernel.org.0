Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C63025434F
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 12:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgH0KO5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 06:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728431AbgH0KOz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 06:14:55 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3BEC061232;
        Thu, 27 Aug 2020 03:14:55 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id z18so2377556pjr.2;
        Thu, 27 Aug 2020 03:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=jtdwsdyuX5DaI09HztVOY1VeTL/pY3XIKKaqUbaX5io=;
        b=Pou7CnLEQ9kGNfVVCMPFOt7wIY2H1/zqaxYyYEQVIj95haCxtytOECd86AGfaCcTCC
         cvepuBH2acKPMzWDvMPrAgmI0K8xrZUTR9IzlCd8xOyH/GNw+HQtYZo4bD4sgsnglC5f
         GWNoDrlNHpz0uA3bqdnwiTMYeAqeEAMB8IdDHIhORRCJ4TpXPgW9iUoc1CNPkpAQawL1
         saY10qdjet+V1AfK7g7EkwvBoQrgWpzIcOotRgEIXUNdEqJoVIRCKzW7RSDMWKySPyQf
         A1I0o/Efjg73KsMxWUYZwcKvhky5/jTAQ26jIAU1J+/LNueoDtVtX7RJ1phsHzAVVyro
         WUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=jtdwsdyuX5DaI09HztVOY1VeTL/pY3XIKKaqUbaX5io=;
        b=sTfL1UICuGYZr1l6uk2RfprvvaL0QfelLwRTw2R85HxjB3+s+jJmth8K03KYQA48eN
         JsAMMceU15VLzcvpAkf2H09v/WVIazz9tTr67AQn9vittG6gGjBRbbtyll/KVV67Nh4p
         1oqWd5LUyk9+uBPwMMMC+ox/V4cQWYjwuK66giUErkgZJpDjx+MQrZybVLbRtj0nhm1G
         4k3sWelkjFoMU55cmwYsnwOgySMTddnqRFYgf0cBwF87r7XfKdaXox7AWUbYStTIbZmz
         matc8a/3ARJNQHpxKO9HKyAKJ62LAWhxnW2MTmm3bGuTI/HwQCGZ89YuK0xh6Po0YlXd
         zFHA==
X-Gm-Message-State: AOAM531d0xbcfxTI0jreVyMA73fvC5vWaXtM+dB7bXCEth0UWQnQgs74
        fAF9COCcTsajzecM4tp5MAJyt0u0wtOJ4g==
X-Google-Smtp-Source: ABdhPJyBSbs90f9EMaszDl3s5ReTsxwhMQMKS+30KQFiWH1a8o866i7xSeB9PHFqkcx5pKDxFQEH3A==
X-Received: by 2002:a17:90a:f48e:: with SMTP id bx14mr9552430pjb.233.1598523295332;
        Thu, 27 Aug 2020 03:14:55 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id t10sm2333434pfq.52.2020.08.27.03.14.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 03:14:54 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     arnd@arndb.de
Cc:     rppt@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/23] 8139too: use ASSERT_FAIL()/ASSERT_WARN() to cleanup some code
Date:   Thu, 27 Aug 2020 18:14:22 +0800
Message-Id: <e4e21a2eee3a27d9083be1896db1fcb143aa1199.1598518912.git.brookxu@tencent.com>
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
 drivers/net/ethernet/realtek/8139too.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/realtek/8139too.c b/drivers/net/ethernet/realtek/8139too.c
index 227139d..0973d1e 100644
--- a/drivers/net/ethernet/realtek/8139too.c
+++ b/drivers/net/ethernet/realtek/8139too.c
@@ -133,11 +133,7 @@
 #ifdef RTL8139_NDEBUG
 #  define assert(expr) do {} while (0)
 #else
-#  define assert(expr) \
-        if (unlikely(!(expr))) {				\
-		pr_err("Assertion failed! %s,%s,%s,line=%d\n",	\
-		       #expr, __FILE__, __func__, __LINE__);	\
-        }
+#  define assert(expr) ASSERT_WARN(expr)
 #endif
 
 
-- 
1.8.3.1

