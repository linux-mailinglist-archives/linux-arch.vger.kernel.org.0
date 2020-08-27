Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B7825434E
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 12:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbgH0KO4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 06:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728691AbgH0KOw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 06:14:52 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18A1C06121B;
        Thu, 27 Aug 2020 03:14:52 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id w186so3016270pgb.8;
        Thu, 27 Aug 2020 03:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=gjyW2qqE4Pe2ReoUx1g++a1XGfKUY9MPSN9SsMfU6a4=;
        b=lJuNJQhLz2fF3DY2tVw7HZrZnlbl1XlLPNDOEnVh9iJisS2Sg5++jo9gg59NgQNR8F
         NH7h/0MCDWs3xCBVP4KC5m9BDeIYPpgjuySahxFL9s3gKL1PZBnbsKu16eMa5wjWiNez
         llB6cr7EOIpA4Ki12D9yTMI/LTGfotkDG0sCDgOYdbFqHHAUO5bS4Sslt3aKR0F+ODna
         pm3iJZ+jelvL9abBk8FgBaG+jtdaRyAjF5c9+kxAAStrCKdvEcAJT8fiYhJQpPfw5xXz
         HPzkB68n4fnk5sDUNQApPpNn5T5Ke56k0OUdLuzPZsxpyDlml5T1Ul7Whd0AqsYH+4pU
         aclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=gjyW2qqE4Pe2ReoUx1g++a1XGfKUY9MPSN9SsMfU6a4=;
        b=BEkMuL6cvz3SG6RjSxkEP5AqItxGdXPK3I/9+4zmWO0kfBrqD6XbbFe63rvmxsdZAe
         UKkqqL8lYSw5DF46TVabltxYfSKrRCY1GxWPzcibeHQzSdFKcg0XBJXr8btdS3HXDxQB
         pC6DE4hgDup0S27twErQyhjXxsOt7lAHS2Z/lnRt50VE3OvBTlzoIvJ6L+E/Ng5qX54N
         aePolRFIWZCWDWeVPpm+ZKeZ3hA5Q3q+aMW/z9elmGYa1yISeFbELxaASnL2M93YJalr
         auV7zCAmQXfB8Jkzz3V2G3rroUg5Quxz9RS2kV1K1hBA9mSRymEgyI2MTFIectgCuEbm
         sOyQ==
X-Gm-Message-State: AOAM533Teuz4rx/BlpahNGpuUnF3sDFfOkakS7+/i+ePBq3AFj4Oca7Y
        g2D4RPwtpwoaOCubnJRvNgcFNZKKDdISaA==
X-Google-Smtp-Source: ABdhPJzKBKjuhgJSg3+0vVEE8jKJtuPeNegxQum4qY0IztAr1oWgjBQ9FgfxL+UBC5VMB5yqXZzjVw==
X-Received: by 2002:a63:9d82:: with SMTP id i124mr13768582pgd.336.1598523292274;
        Thu, 27 Aug 2020 03:14:52 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id t10sm2333434pfq.52.2020.08.27.03.14.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 03:14:51 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     arnd@arndb.de
Cc:     rppt@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 15/23] media/staging: use ASSERT_FAIL()/ASSERT_WARN() to cleanup some code
Date:   Thu, 27 Aug 2020 18:14:20 +0800
Message-Id: <9c473950331710b8ca837dbdaf14c12e62fabac2.1598518912.git.brookxu@tencent.com>
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
 .../staging/media/atomisp/pci/hive_isp_css_include/assert_support.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/hive_isp_css_include/assert_support.h b/drivers/staging/media/atomisp/pci/hive_isp_css_include/assert_support.h
index 7382c0b..c7e65e3 100644
--- a/drivers/staging/media/atomisp/pci/hive_isp_css_include/assert_support.h
+++ b/drivers/staging/media/atomisp/pci/hive_isp_css_include/assert_support.h
@@ -51,11 +51,7 @@
  * but that causes many compiler warnings (==errors) under Android
  * because it seems that the BUG_ON() macro is not seen as a check by
  * gcc like the BUG() macro is. */
-#define assert(cnd) \
-	do { \
-		if (!(cnd)) \
-			BUG(); \
-	} while (0)
+#define assert(cnd) ASSERT_FAIL(cnd)
 
 #ifndef PIPE_GENERATION
 /* Deprecated OP___assert, this is still used in ~1000 places
-- 
1.8.3.1

