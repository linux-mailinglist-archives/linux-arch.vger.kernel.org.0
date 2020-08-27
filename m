Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA4D254351
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 12:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbgH0KPG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 06:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728721AbgH0KO7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 06:14:59 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B689C06121B;
        Thu, 27 Aug 2020 03:14:58 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mw10so2350415pjb.2;
        Thu, 27 Aug 2020 03:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=pVkshBVjru+jwnl25mInBn3emKjmOPj9kIJ5soiLJq4=;
        b=fDvfXkl3qBZh+GRy9gkHxdVHI+A29OIYLZRu0s7NE5ntV4b3sZoa7P9HddWFoCSMon
         XWbJi5TMGnyz3I07HCYbyPDQ6HtGi8ZTFenDi1awKxSKUEKuN3gClbYzdRk+cUU+A9i2
         zF/FQA+FXpGVJ3Lkonpm7EHBLOJOvCVyjoWJxdAe7wMJEvP9ocPkMphyhlFpBdrx2Kar
         9Qj96EE25EDxQVB/GFi3hx6gObwZkdkr/wMCShnRrLF4Q0/8leHpO7T7wc94KGCnoVeB
         H97jooXd7eurH4aIWtQKPH8GcqzoVytQaN/pNdR3Yj5mHoIaCpBY2bfMWOo05PHWNhm1
         dnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=pVkshBVjru+jwnl25mInBn3emKjmOPj9kIJ5soiLJq4=;
        b=JuMp05kq5l+GMW4LjiNOoIRX/HOcF98MIzNeqYTCrWAUDLDU8NDgcORel6GdS6i16P
         ARnrkkOBHliPtzDDH/IR2wW7tZsZdhwKSlkcb8nzq1bZna/+JgIO9BT/7t8RdMphRAjk
         KuQsIptOexTtTcV94cwseXQfIUpUx9RAxulVdq4N8rQs+cG7QDC8O7j7sDioUau7/Kk+
         N3A0dfyiisoY18GlXGxCHc/6x7Z40sI/TJ9pnS+E7pxRPy8oBjys2Ofg0xqZbIXLUIx9
         IA9Yo8f6esIvbSIu5e7LwRK/pHRNgcW3IuyRGqzXEeYhXftWnewbadYvFH6Ct/c/EpBY
         kWow==
X-Gm-Message-State: AOAM531eVS3rZugdGm45c/qIMOL4hn6OgyC6e3KQnNwr+JOIxptCyNrB
        zCnx0jD18IZMEBtrpU4WYcQ=
X-Google-Smtp-Source: ABdhPJwhw1FMbEMsT9brXiHzIuFX/K3AfR0jBCp8Kq/fqfOTIm3s5orogvoa/idkoreNMTNDvg0B9Q==
X-Received: by 2002:a17:90b:4c03:: with SMTP id na3mr10321475pjb.29.1598523298194;
        Thu, 27 Aug 2020 03:14:58 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id t10sm2333434pfq.52.2020.08.27.03.14.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 03:14:57 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     arnd@arndb.de
Cc:     rppt@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 19/23] block/sx8: use ASSERT_FAIL()/ASSERT_WARN() to cleanup some code
Date:   Thu, 27 Aug 2020 18:14:24 +0800
Message-Id: <c0016667db5c6c9d5c0c98853ce3db2b2ef2f851.1598518912.git.brookxu@tencent.com>
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
 drivers/block/sx8.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/block/sx8.c b/drivers/block/sx8.c
index 4478eb7..d9adcf3 100644
--- a/drivers/block/sx8.c
+++ b/drivers/block/sx8.c
@@ -93,11 +93,7 @@
 #ifdef CARM_NDEBUG
 #define assert(expr)
 #else
-#define assert(expr) \
-        if(unlikely(!(expr))) {                                   \
-        printk(KERN_ERR "Assertion failed! %s,%s,%s,line=%d\n", \
-	#expr, __FILE__, __func__, __LINE__);          \
-        }
+#define assert(expr) ASSERT_WARN(expr)
 #endif
 
 /* defines only for the constants which don't work well as enums */
-- 
1.8.3.1

