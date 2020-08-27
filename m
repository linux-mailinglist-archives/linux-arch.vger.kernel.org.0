Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E93D5254359
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 12:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgH0KPa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 06:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbgH0KPE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 06:15:04 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5022EC061264;
        Thu, 27 Aug 2020 03:15:04 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mt12so2368948pjb.4;
        Thu, 27 Aug 2020 03:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ligckTORXYSrSmKLcHqQzSKW2gKfGktzSGPREcOvEO8=;
        b=sADfUrTeNU+ykSRFQKQ5ZZpU1xPWKf5O6zpFRUNhjYRo3gjWZGwdM9WD2q+DeaqWS3
         /LKNgVm3QYNyrthSB5u5+97fTI90AXnAEziGodo0z5nZr7uUCuCkLmE4CSjR4fWqBET6
         ylWVynwZyOtlOpR8SRVCXXeyza1lAxHTb86G1C+jj8aVQ1TKTZawFYtnH0EDICSqQ806
         LO4CBY1o1ZxfqmBW0IrHJgpRsqDsvgkwMPDq2mePGiqGvHvYcp//Z12XwbPVZUrtyODJ
         RzfVrx5CyC/r87+cr9BiRWjxcOtT7CJBj0z1NPQWNvG1dmvPGKotgVygyMf8+AoxVUze
         oGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ligckTORXYSrSmKLcHqQzSKW2gKfGktzSGPREcOvEO8=;
        b=oDm+4sKAYiG7JYozZNBBNX2ax+4N0LQMN0sUBiUn0a2DFAYOjvi1TWHM1VPel4ohSl
         Mze5ixYitSfEpdqwVqxf9oQfaUTy7ClF5hbObJNIJHbdMQWBLdhV5+wPRm5v+p3JSLBs
         4PQYEhaGWFTliOjBYIKsv/w/01CdDhGW6qEHCbJTYUtku/n7Cl62H0SgZIMl+bjayWyS
         jbXMmPr2c03nro7YvH2UOJoVsXPPwGchgzWHdt6k5RYiCg6Wg0JMtse0oFg/Kr6dU1A+
         StxgHkAWTwH7UEBKAhsXSHMP7y+yhk27qNHFZf+ylf9bBRLRxIQ/zaQ4lIbWtyjv6zLZ
         HfZQ==
X-Gm-Message-State: AOAM531O+O7ia2ocV3uX1RPBEheOeWSuEOc0GiUDkGPfa1mV2I+1aYIR
        F6490FORMX0if102u0Om3uadTZMamU9QaQ==
X-Google-Smtp-Source: ABdhPJyrIfvr0HBhvHG+N7ppCWW85jxfQ9DTbR4JO3iyfjjNJVtHaK4E4Bj10N7CPdQR6A5DBQAnCw==
X-Received: by 2002:a17:90a:d90a:: with SMTP id c10mr6632235pjv.31.1598523303963;
        Thu, 27 Aug 2020 03:15:03 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id t10sm2333434pfq.52.2020.08.27.03.15.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 03:15:03 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     arnd@arndb.de
Cc:     rppt@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 23/23] ALSA: asihpi: use ASSERT_FAIL()/ASSERT_WARN() to cleanup some code
Date:   Thu, 27 Aug 2020 18:14:28 +0800
Message-Id: <1f104cd576b71f53f01e0cd4ae5c57143231dd58.1598518912.git.brookxu@tencent.com>
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
 sound/pci/asihpi/hpidebug.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/sound/pci/asihpi/hpidebug.h b/sound/pci/asihpi/hpidebug.h
index c24ed69..b65c8dc 100644
--- a/sound/pci/asihpi/hpidebug.h
+++ b/sound/pci/asihpi/hpidebug.h
@@ -34,13 +34,7 @@ enum { HPI_DEBUG_LEVEL_ERROR = 0,	/* always log errors */
 #define FILE_LINE  __FILE__ ":" __stringify(__LINE__) " "
 #endif
 
-#define HPI_DEBUG_ASSERT(expression) \
-	do { \
-		if (!(expression)) { \
-			printk(KERN_ERR  FILE_LINE \
-				"ASSERT " __stringify(expression)); \
-		} \
-	} while (0)
+#define HPI_DEBUG_ASSERT(expression) ASSERT_WARN(expression)
 
 #define HPI_DEBUG_LOG(level, ...) \
 	do { \
-- 
1.8.3.1

