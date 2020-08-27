Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC0325435B
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 12:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbgH0KPa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 06:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728222AbgH0KPB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 06:15:01 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D6FC061232;
        Thu, 27 Aug 2020 03:14:59 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q1so2354017pjd.1;
        Thu, 27 Aug 2020 03:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=16Eyp0WUeGxgEgDzl6osefVw61lLx2uQeSbS//HG21U=;
        b=dZPQLNikejmt1LPaatUnCQ+gegeKPLRxnHa7A0xTDRCbaUmPipN95K1rBYLzrWpfjX
         mI8UGmT9pBExqDTqSMz8GFpd8FlwjYqVdIR0Y9i54oQl/Q35V03oHDERX8d7RH7dtjOo
         Fu10RTm6JL0KIz3b0FetLiEzysqwMGJ3uQ9vYwQ4Bkf2plaqMN61M1YDoEtfY53E3bGp
         gS12QijlR3Cf4jcqfPzRceie057GFRXYzi6hrkK2O3/4IAQm1V4XnHPE+GXvxQQ/19eA
         GL05GeTbieJMXoiMIa+rWi94uHoIiTPHMfiozC+K5yx46DbLfYhOrMhHZF5ka5bFWLcv
         GbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=16Eyp0WUeGxgEgDzl6osefVw61lLx2uQeSbS//HG21U=;
        b=jJgitKD8XHBQRplbZGLENPUTmTrnQHsvSmNtkYtMDcPY7zyH6diWtVhRuGkxWjTVdk
         nkP0yPNAjywtOsKilomMFwFW4rEIa/Ra7/0bAslHPsS7R1iHyCSdVrKiJiARC04NzBx6
         O3/vtVCJ4M/U0cSk30eDOnKyaV64GOFQx1FVHt/hQggdmQw+59KKdpmHazX8rP8iU1jA
         Ay+2zArLAOs3JuICzLY5hUCEB4PkuMEEhiRe+uusc0Ss8qIurajOLbIFqWuclBL0qtuG
         scWuQgZnSpk5D5/uWQV5FCQv3pLtyRFZnNyzkpaWBL6t/Sj7QcuWAXhGr/0GinWsFGMy
         uq1g==
X-Gm-Message-State: AOAM531KgNs49BBpPgBmcq72ncRlSMJTrszUEyE7wcYwJUQyKlGG30o1
        Pf2jE2MMnHQcO5BJUEjHtlo=
X-Google-Smtp-Source: ABdhPJxshqdudXHw+1+ZpzBNfnfxFm7wiLpU2PZNgibZ7YsKsckSD/GDkUzFM7VDjJ2p1+kKikvh9g==
X-Received: by 2002:a17:90a:a10c:: with SMTP id s12mr10080617pjp.32.1598523299559;
        Thu, 27 Aug 2020 03:14:59 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id t10sm2333434pfq.52.2020.08.27.03.14.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 03:14:59 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     arnd@arndb.de
Cc:     rppt@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 20/23] skb: use ASSERT_FAIL()/ASSERT_WARN() to cleanup some code
Date:   Thu, 27 Aug 2020 18:14:25 +0800
Message-Id: <70bd0bea9aaab57dd1cf9291d04f0f07246e0d95.1598518912.git.brookxu@tencent.com>
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
 drivers/block/skd_main.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index 3a476dc..b5b51e0 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -41,13 +41,7 @@
 static int skd_dbg_level;
 static int skd_isr_comp_limit = 4;
 
-#define SKD_ASSERT(expr) \
-	do { \
-		if (unlikely(!(expr))) { \
-			pr_err("Assertion failed! %s,%s,%s,line=%d\n",	\
-			       # expr, __FILE__, __func__, __LINE__); \
-		} \
-	} while (0)
+#define SKD_ASSERT(expr) ASSERT_WARN(expr)
 
 #define DRV_NAME "skd"
 #define PFX DRV_NAME ": "
-- 
1.8.3.1

