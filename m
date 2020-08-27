Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60EAA25438B
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 12:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbgH0KSu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 06:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728594AbgH0KOe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 06:14:34 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74138C06121B;
        Thu, 27 Aug 2020 03:14:34 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ds1so2374176pjb.1;
        Thu, 27 Aug 2020 03:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=hrftI+TQY3BCyjvYX8clZw8H0tJAk+80/vXHms6y9CA=;
        b=M7A7WkzCQcVg/GGhHmxYZcIy+RN/B/9qjTxm5m5+XBmLPSV/y0c0InzrUl3+VbcSRA
         IB/IgJI5NkfjGLqXNKb4nG6tOE4rAsSeiiLSNl4pv+yvP0KPCJpgjsXsl8oPZBBJJSMH
         OzIoaATB2lZ4hZBoUPr3BHzodWYqeu8f+eSrTYLm1DZBY48h/bcYKIQ+UybB0M/W96x8
         AZY14KSFu2Q7vzS2Q0oVF0INPs3tgBa7Ppnt9WGUuj1NQIf5svIoUuSUGukotsoRuCSt
         xd52pdSVx+Hq8JtaucS70nHtUaf8aNW0Rd1w2FJsQ3EMgCi5k1O4MXzSyHeHnmrmyBcP
         CRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=hrftI+TQY3BCyjvYX8clZw8H0tJAk+80/vXHms6y9CA=;
        b=jthk83aTqGR6I7jFlslc1LhTLbEOjeMfaGC3FiTYTm6AOBLlXyF1ba3X7n4vg2tNpw
         oAQG6QGVD92wj46xQ5/eOyR9zdVnTSGNgOY3HKG2nZkXkTmf59OAkrVwX2A/jS52UjwL
         6qo2FSJ270n4yx/L7hWB+vNVTAP+6RkLbozhchH4A6QTjSaONw+odN0Bsw88Ex10aNOF
         I+7EsN4UM2qsX3BkNEPengCXItjVLEHx8b0OmTnqQSiXXfakhAEaQOTe8C/7armBiJEp
         s+nADZeDheoTV9BDDWh4LXqx2E2gI1MYoTt4owV6mp/TRXqBm2nSUfg6sMfauTLr6ST/
         LeHA==
X-Gm-Message-State: AOAM531uWeXnvHb3QMGX8zRqj06eaavcYJevmhFAcgL0DOYFPgdt+o3X
        YhUOhW6D/GrT3lqyPmiVUa0=
X-Google-Smtp-Source: ABdhPJw9U4CjyHuq/wnj1EIt7+3PVAz+0j1BNU4DP9GXim1rn1yivbp9bMGniGiZm5wEfM5TwRbv+g==
X-Received: by 2002:a17:90a:2c06:: with SMTP id m6mr10328110pjd.129.1598523274050;
        Thu, 27 Aug 2020 03:14:34 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id t10sm2333434pfq.52.2020.08.27.03.14.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 03:14:33 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     arnd@arndb.de
Cc:     rppt@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/23] ia64: use ASSERT_FAIL()/ASSERT_WARN() to cleanup some code
Date:   Thu, 27 Aug 2020 18:14:07 +0800
Message-Id: <e9bb45969e2975c3e4632ce84168711667f5126f.1598518912.git.brookxu@tencent.com>
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
 arch/ia64/hp/common/sba_iommu.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/ia64/hp/common/sba_iommu.c b/arch/ia64/hp/common/sba_iommu.c
index 656a488..335bf4a 100644
--- a/arch/ia64/hp/common/sba_iommu.c
+++ b/arch/ia64/hp/common/sba_iommu.c
@@ -138,11 +138,7 @@
 #endif
 
 #ifdef ASSERT_PDIR_SANITY
-#define ASSERT(expr) \
-        if(!(expr)) { \
-                printk( "\n" __FILE__ ":%d: Assertion " #expr " failed!\n",__LINE__); \
-                panic(#expr); \
-        }
+#define ASSERT(expr) ASSERT_FAIL(expr)
 #else
 #define ASSERT(expr)
 #endif
-- 
1.8.3.1

