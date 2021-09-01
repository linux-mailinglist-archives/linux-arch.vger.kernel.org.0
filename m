Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A812B3FD569
	for <lists+linux-arch@lfdr.de>; Wed,  1 Sep 2021 10:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243243AbhIAIaw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Sep 2021 04:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243104AbhIAIav (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Sep 2021 04:30:51 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D69BC061575;
        Wed,  1 Sep 2021 01:29:55 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id mw10-20020a17090b4d0a00b0017b59213831so4089706pjb.0;
        Wed, 01 Sep 2021 01:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uEF7gvqwfbmwW2Wlh9BZzPOgxlqZXBD1tP6d5gmOMzA=;
        b=sSDUcl7oLVlDkyo52pdEZM1V1Xl0bBb9tDAJ4/PMbqIS1gy5t9mc+pT3LQuiDrycda
         60S67vEHa81Jq1BdakqxN8cxJgp5Xy8HjHz66se03Uj52cyu8DETsx9noSVwdgTm2iaY
         ERzqhXKGtK+XVO5jjh6AudunXd87z/gA5d15bbIeClz0Ey8MyImTInsEvogqkC3nADkk
         ZFzg8JMG8Sa60ydadlxjH0Gfpsq5wXtGAo8mWwj5C05ouUkQ+GHeKS1klvUYQYlH2Bji
         npaS0ePftf8kMH7YjtNAcN4WMFOL8XEQ4SqHoDp1cWQCZA5zqJ4matQ92HBqmV04MWoR
         hLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uEF7gvqwfbmwW2Wlh9BZzPOgxlqZXBD1tP6d5gmOMzA=;
        b=nDI895MzFTCFgJqg9dURN4Jw3RxyDfPOfjbNUNzfvhGnyEqUgtI1K+1F8aSPAYycUI
         c3Ur7dustcniQK8u2dNkUADlRKur1/Z1PKEWjZnXEB2Ip+euxpLXJgYJ7EFCAwiSLtA6
         3f+xXK33h1Q1CvvNW3BP324I1EC3mU7xa/Qb3reqHFcnvAwnBK63jHU2dd+ETCCixjD6
         BU6HFyx81IOeOPa0BWHfz9JbBzPItpOism6S3OpaTmLfqaSzDAlpymGjDjU7bFSsjgC4
         SO4xbQI+2pBj3HmASb2dVVIjQ7YjmNjkc/uz/ebgPr1nJF5jJB1CUwgDQdBkt61J2vHu
         CWKA==
X-Gm-Message-State: AOAM531NTBDKk5oWJ0LXUCS8YUMoMTk8thGwn9lYX0OVgHiYXnXvImBx
        dP4KmY8FnSJ2FQY/Y71S9LVDTcKZlCLWPHhmC8U=
X-Google-Smtp-Source: ABdhPJx5if/okyK4OD2r1W9Kp91JPxGpTqwgPma1p/eDWUd9raCWGQpTPLtztEVZPRUznt5kWHNcoQ==
X-Received: by 2002:a17:90a:6503:: with SMTP id i3mr10299929pjj.42.1630484994939;
        Wed, 01 Sep 2021 01:29:54 -0700 (PDT)
Received: from ownia.. ([173.248.225.217])
        by smtp.gmail.com with ESMTPSA id d20sm19509159pfu.36.2021.09.01.01.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 01:29:54 -0700 (PDT)
From:   Weizhao Ouyang <o451686892@gmail.com>
To:     arnd@arndb.de, akpm@linux-foundation.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Weizhao Ouyang <o451686892@gmail.com>
Subject: [PATCH 1/1] mm/early_ioremap.c: remove redundant early_ioremap_shutdown()
Date:   Wed,  1 Sep 2021 16:29:17 +0800
Message-Id: <20210901082917.399953-1-o451686892@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

early_ioremap_reset() reserved a weak function so that architectures can
provide a specific cleanup. Now no architectures use it, remove this
redundant function.

Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
---
 include/asm-generic/early_ioremap.h | 6 ------
 mm/early_ioremap.c                  | 5 -----
 2 files changed, 11 deletions(-)

diff --git a/include/asm-generic/early_ioremap.h b/include/asm-generic/early_ioremap.h
index 9def22e6e2b3..9d0479f50f97 100644
--- a/include/asm-generic/early_ioremap.h
+++ b/include/asm-generic/early_ioremap.h
@@ -19,12 +19,6 @@ extern void *early_memremap_prot(resource_size_t phys_addr,
 extern void early_iounmap(void __iomem *addr, unsigned long size);
 extern void early_memunmap(void *addr, unsigned long size);
 
-/*
- * Weak function called by early_ioremap_reset(). It does nothing, but
- * architectures may provide their own version to do any needed cleanups.
- */
-extern void early_ioremap_shutdown(void);
-
 #if defined(CONFIG_GENERIC_EARLY_IOREMAP) && defined(CONFIG_MMU)
 /* Arch-specific initialization */
 extern void early_ioremap_init(void);
diff --git a/mm/early_ioremap.c b/mm/early_ioremap.c
index 164607c7cdf1..74984c23a87e 100644
--- a/mm/early_ioremap.c
+++ b/mm/early_ioremap.c
@@ -38,13 +38,8 @@ pgprot_t __init __weak early_memremap_pgprot_adjust(resource_size_t phys_addr,
 	return prot;
 }
 
-void __init __weak early_ioremap_shutdown(void)
-{
-}
-
 void __init early_ioremap_reset(void)
 {
-	early_ioremap_shutdown();
 	after_paging_init = 1;
 }
 
-- 
2.30.2

