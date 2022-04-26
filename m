Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190FE50EF27
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 05:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiDZDZq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Apr 2022 23:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243294AbiDZDXf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Apr 2022 23:23:35 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4A5C2E;
        Mon, 25 Apr 2022 20:20:23 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id p6so1720982pjm.1;
        Mon, 25 Apr 2022 20:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vZCPCkNI/7Si5Odq1S7dwZOGeQzdpNIUvjGR2/U9O6k=;
        b=EyziaLk8OVei83W5M78PKIhU/PuJ7eWuZgXv9ndgkj+28nTsRvYu4mH/cg2+hnc1Zm
         DYNTRPt1jDPhTKdZaUK4ZBOSRlYlEuLLJpqW6q1qnxjNtxRDhonELX5T0TXfKCS1hdlY
         Jk5RoDwLAOBzf8DxcXt/auBQyKDjG4upu5zMi5AZN+AcvcR90CbYu6l95a5q0mmVM4DG
         3hU/CgnDqCzyw2G0U78esXLeY2B4EnfVcsubdxLAW4kkKyo4bGPLcEj4N38Ju+HNP7QW
         D1VlYGRaOycj4dyiuKk6e0PZCCbA/qSdxA1NSWKAIHQ64AyKQlOp+/s3RSsMRz+v/NFq
         LMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vZCPCkNI/7Si5Odq1S7dwZOGeQzdpNIUvjGR2/U9O6k=;
        b=PCj478KZKwKHlBqVEyIXwYAdsx378E0RxdebAzGF9561EbCjZWM2Kyw1cRwwnltuiF
         4mAd2lA1QHxPxHVvSxDvi7laN6RfrOADe3J3XyEa0jq5ME2owfpeItdhWqORy+wf+Z8x
         QN8bB7lt9hzWoMzB10mQpHST2rr9DDZYrUEYDXH3xFFN6vKB7VtbPDUeEl71kciG2YOh
         Jpabwvz+o/yVEwGoU8mHkUwO3BDnsEi3sQBTaU7WGU272Sgb1KKaJYMcL/t1yvpOc6kF
         Q28yygPpGdi5cCZxFzAddW5viM3lHwUte+SjhjEPNkYiTR7GQN1AGwrIXIeP2FTnm3Pf
         JHyg==
X-Gm-Message-State: AOAM530V0mPL54o/Ij/vtUPQM3v5naghAhig6H97QNPDCl2clNSKPn0n
        lASkTR+Sahe3s6UMyXWfg2E=
X-Google-Smtp-Source: ABdhPJy9YujCptf6I2+wmYcnwU5YO1zX3cvcZOqdocY3xrI9olbP2K8JXKu22uUVTGX8Xeek4wrgZA==
X-Received: by 2002:a17:902:a501:b0:153:f956:29f0 with SMTP id s1-20020a170902a50100b00153f95629f0mr21347301plq.120.1650943223130;
        Mon, 25 Apr 2022 20:20:23 -0700 (PDT)
Received: from localhost.localdomain ([103.197.71.140])
        by smtp.gmail.com with ESMTPSA id bo3-20020a17090b090300b001cd4989fecesm790354pjb.26.2022.04.25.20.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 20:20:22 -0700 (PDT)
From:   Stephen Zhang <starzhangzsd@gmail.com>
To:     arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org
Cc:     hpa@zytor.com, peterz@infradead.org, laijs@linux.alibaba.com,
        lihuafei1@huawei.com, fenghua.yu@intel.com,
        chang.seok.bae@intel.com, zhangshida@kylinos.cn,
        starzhangzsd@gmail.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] bug: make __warn unconditionally defined
Date:   Tue, 26 Apr 2022 11:20:07 +0800
Message-Id: <20220426032007.510245-1-starzhangzsd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Shida Zhang <zhangshida@kylinos.cn>

__warn() was defined when CONFIG_BUG gets defined originally, but
it was used unconditonally by traps.c. So the idea is to have the
__warn unconditional.

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 Changelog in v1 -> v2:
 - To have the __warn() unconditional instead.

 include/asm-generic/bug.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index edb0e2a602a8..ba1f860af38b 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -21,6 +21,12 @@
 #include <linux/panic.h>
 #include <linux/printk.h>
 
+struct warn_args;
+struct pt_regs;
+
+void __warn(const char *file, int line, void *caller, unsigned taint,
+	    struct pt_regs *regs, struct warn_args *args);
+
 #ifdef CONFIG_BUG
 
 #ifdef CONFIG_GENERIC_BUG
@@ -110,11 +116,6 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 #endif
 
 /* used internally by panic.c */
-struct warn_args;
-struct pt_regs;
-
-void __warn(const char *file, int line, void *caller, unsigned taint,
-	    struct pt_regs *regs, struct warn_args *args);
 
 #ifndef WARN_ON
 #define WARN_ON(condition) ({						\
-- 
2.30.2

