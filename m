Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6CD254371
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 12:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgH0KQw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 06:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbgH0KOs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 06:14:48 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099B1C06121B;
        Thu, 27 Aug 2020 03:14:47 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p37so3029268pgl.3;
        Thu, 27 Aug 2020 03:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=7JxoSvMc+RW02sQ/p5xnykFpDMa/i2s+16/ntahA338=;
        b=SFiCcwuKvcDTOAt03SdOLHB0exIP1SVwyCci88D9C+oiMdIBrzmV9EpIFGz1Ueuwrj
         0L6ZeBxdCibLr01PbCfTYwKabUW3djlg7TIRtMybsQ+WYOYv5rzh6KLe5Hfn1MO0IqRT
         tXcBC2B/lESWf8wQ2HX2d4j1vHTH/sIqvLsuDlYKBH+6zI3+8UKtqSI5SDU+vCNRQJL1
         59Em2PNR6EKKnMcMTNpoT+tv19KElefTTl5bK1+J0aqXsTpwKsy+XxAZVVtKE2DCqOOz
         YhtyA0jmgiY+IN6CkeeuVU3vpJMdQxpXaabe2JLJLjBe+O6yVr0ZQiKMTGcH+LT+4tWv
         6X4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=7JxoSvMc+RW02sQ/p5xnykFpDMa/i2s+16/ntahA338=;
        b=rc+AP/OCmu5VQJ1hg/oBrOE7ZyRDJM9e0SBWNKDnDudG/f4z6rYae2/p84gbR76BOw
         voNzTVr6Lt5Z85SbRWm7H4tR2j3T/hfypVHKU7mJhhCwU6MxYq/YuDOUFeffiHDPSQa1
         9kdcsjJqAwAftzxtFa7vGd728RU65mKZ5P+9Jp3CpOi2pNgBnotdttAzjHnl3Z0406lE
         hTolaSj6gk1kk7ebM9U45el9c5eui4ZbObqMrZ1oL8OzMdFJUC0mTZdj0Fjotj1Tmfqd
         P0XDJ8TygBYgwGzLbCvrjeHdpJvqniouw2MRBJEOlbH6Ii/cs3Y4kWUNguA5Uzq0Ij01
         eXZw==
X-Gm-Message-State: AOAM532iTZZVIp/klD/Vx100paGVVEcCJ8fTniGU0GwjeVP3+lpEGwAM
        I6CiqbDjrojuckxzmwWngo8=
X-Google-Smtp-Source: ABdhPJzsx/8/MYuMPl1CYDlgMi+5oM5/GqCorfJWRGHh2xYdASmM1T/ESCC4ugRowlTfLWEmguvLWA==
X-Received: by 2002:aa7:9f9b:: with SMTP id z27mr3431514pfr.236.1598523286632;
        Thu, 27 Aug 2020 03:14:46 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id t10sm2333434pfq.52.2020.08.27.03.14.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 03:14:46 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     arnd@arndb.de
Cc:     rppt@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/23] afs: use ASSERT_FAIL()/ASSERT_WARN() to cleanup some code
Date:   Thu, 27 Aug 2020 18:14:16 +0800
Message-Id: <8e6ebee6b664259579296b66a9668e4b301c7030.1598518912.git.brookxu@tencent.com>
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
 fs/afs/internal.h | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 792ac71..72594e5 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1580,14 +1580,7 @@ static inline int afs_bad(struct afs_vnode *vnode, enum afs_file_error where)
  */
 #if 1 // defined(__KDEBUGALL)
 
-#define ASSERT(X)						\
-do {								\
-	if (unlikely(!(X))) {					\
-		printk(KERN_ERR "\n");				\
-		printk(KERN_ERR "AFS: Assertion failed\n");	\
-		BUG();						\
-	}							\
-} while(0)
+#define ASSERT(X) ASSERT_FAIL(x)
 
 #define ASSERTCMP(X, OP, Y)						\
 do {									\
-- 
1.8.3.1

